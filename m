From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 00/19] Sparse checkout
Date: Thu, 20 Aug 2009 20:46:54 +0700
Message-ID: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me7zQ-0006kO-Ck
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbZHTNrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 09:47:22 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754365AbZHTNrV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:21 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:54197 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbZHTNrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:20 -0400
Received: by pxi34 with SMTP id 34so3268834pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=vMJQRXpSdDZRchsnAwaldVuyV8DqaUFij+uVZiGMklw=;
        b=oF2QjqXOJLYXUMyxsUwQkKL2vm7Lt0On36M+2QqH/HGSep7Kv6yLr+sL4JiVUfBoH4
         EJcXAIEHJ3FfUQ3+Uy+5HjaNEa2flSuguDsgtUpxASC/CmVkUDrKVsAARYI+7LnOkm0q
         hbiT3JZoTQYlkML9QOn/b9oMEpFrg6t1ppnR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ohSF1ftswEAnYE7urnJK5db3TYpfOkN1C346/jbCfr8E0xfEyTA1p1vh9TSvok9MEb
         H9yCd8ggOu0O5CPFtplKLYnUSTw369Jqh228unK2ohPs7/98+X033pSAzaDL0uFD+I+U
         4jhsfEAJz3ZGAJHiB7SfzZpTN8bsYcbEdwVMU=
Received: by 10.115.103.27 with SMTP id f27mr9160342wam.29.1250776041970;
        Thu, 20 Aug 2009 06:47:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 23sm186359pzk.12.2009.08.20.06.47.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:47:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:14 +0700
X-Mailer: git-send-email 1.6.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126621>

Welcome to the fourth round of sparse checkout this year, dubbed "The
mummy^W^W^W^W^Wno-checkout returns", although the bit now comes under
a new name "skip-worktree" [1]. This series has two parts: sparse
worktree and sparse checkout. Details will be given below.

=46or brave users of this series: I have pushed it to my sparse-checkou=
t
branch [2] so you can just clone it and test away. Visible changes:

 - the spec is now .git/info/sparse-checkout
 - the spec is positive matching, that is it matches what _is_ in
   worktree, not what is out of worktree like the last series
 - you need to set core.sparsecheckout no additional command argument
   is needed.

Except from running tests, I have only used it a little bit, so be
careful, it may burn your trees.


Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  update-index: refactor mark_valid() in preparation for new options
  Add test-index-version
  Introduce "skip-worktree" bit in index, teach Git to get/set this bit
  Teach Git to respect skip-worktree bit (reading part)
  Teach Git to respect skip-worktree bit (writing part)
  Avoid writing to buffer in add_excludes_from_file_1()
  Read .gitignore from index if it is skip-worktree
  unpack-trees(): carry skip-worktree bit over in merged_entry()

The three main patches in this part are 3, 4 and 5, which define how
"skip-worktree" should work (and I'd love to have feedback whether I
get it right) and implement it.

=2Egitignore patches are from last series and do not change much.


Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  excluded_1(): support exclude files in index
  dir.c: export excluded_1() and add_excludes_from_file_1()
  Introduce "sparse checkout"
  unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
  unpack-trees.c: generalize verify_* functions
  unpack-trees(): "enable" sparse checkout and load
    $GIT_DIR/info/sparse-checkout
  unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final
    index
  unpack-trees(): ignore worktree check outside checkout area
  read-tree: add --no-sparse-checkout to disable sparse checkout
    support
  Add tests for sparse checkout
  sparse checkout: inhibit empty worktree

The recent assume-unchanged "breakage" that lets Git overwrite
assume-unchanged files worried me. I sat back, checked and wrote tests
to catch similar situations. As a result, core sparse checkout code
becomes more complicated and is splitted into smaller parts for easier
read.

Interesting patches are 11/19 (OK not that interesting, it's just
boring text), 14/19-16/19. Patch 18/19 also covers "foo" vs "foo/"
matching bug in tests.


[1] There are a few reasons behind this rename:
 - there is nothing about "checkout" in the first part, it's about
   "sparse worktree"
 - the double negation issue with "no-" part of "no-checkout"
 - new name makes cache.h diff align beautifully

[2] http://repo.or.cz/w/git/pclouds.git?a=3Dshortlog;h=3Drefs/heads/spa=
rse-checkout

 .gitignore                                        |    1 +
 Documentation/config.txt                          |    4 +
 Documentation/git-ls-files.txt                    |    1 +
 Documentation/git-read-tree.txt                   |   52 ++++++-
 Documentation/git-update-index.txt                |   29 ++++
 Documentation/technical/api-directory-listing.txt |    3 +
 Makefile                                          |    1 +
 builtin-clean.c                                   |    4 +-
 builtin-commit.c                                  |    5 +
 builtin-grep.c                                    |    2 +-
 builtin-ls-files.c                                |   11 +-
 builtin-read-tree.c                               |    4 +-
 builtin-update-index.c                            |   78 ++++++----
 cache.h                                           |    8 +-
 config.c                                          |    5 +
 diff-lib.c                                        |    5 +-
 diff.c                                            |    2 +-
 dir.c                                             |  100 ++++++++----
 dir.h                                             |    4 +
 environment.c                                     |    1 +
 read-cache.c                                      |    8 +-
 t/t1009-read-tree-sparse-checkout.sh              |  150 +++++++++++++=
+++++
 t/t2104-update-index-skip-worktree.sh             |   57 +++++++
 t/t3001-ls-files-others-exclude.sh                |   22 +++
 t/t7011-skip-worktree-reading.sh                  |  163 +++++++++++++=
++++++
 t/t7012-skip-worktree-writing.sh                  |  146 +++++++++++++=
++++
 t/t7300-clean.sh                                  |   19 +++
 test-index-version.c                              |   14 ++
 unpack-trees.c                                    |  175 +++++++++++++=
++++++--
 unpack-trees.h                                    |    6 +
 30 files changed, 983 insertions(+), 97 deletions(-)
 create mode 100755 t/t1009-read-tree-sparse-checkout.sh
 create mode 100755 t/t2104-update-index-skip-worktree.sh
 create mode 100755 t/t7011-skip-worktree-reading.sh
 create mode 100755 t/t7012-skip-worktree-writing.sh
 create mode 100644 test-index-version.c
