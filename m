From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 0/8] Sparse checkout
Date: Tue, 11 Aug 2009 22:43:58 +0700
Message-ID: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatWW-0006kj-4b
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbZHKPoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 11:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZHKPoP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:28529 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbZHKPoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so995628rvb.5
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=TCEwoiKYHZUhz2J/vzjdEYCZDPjfiIp/aFnv62PQeqs=;
        b=cTwouu3Go7JgHnN9Y+HYfdk00IDsP3i8uJgWReAFG5AJdl+GheOhZ41KKOw5WfBucK
         fIVSrXc/F5bXU+Zm10j6QXbgWkvDizu0Eapgq0vcVydOkmrnRVWbPTT19jx2nCA1G1G2
         aanQXXaQUVwnjZ8Phdh4x5rxs/6Ab1+R/Olvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JpjoZR5BF641pmr6daeyONnuDxVTMK+YPYQWohAaxlAs4M92vdHt6pUD2gxRJLGeA7
         zs+ireXEiKBakMucXlHq9s9JkjsSsmvxq2U0RYQkC0OwNNa/bHm0zwRWADLjmPQ17Ej0
         l2Jywyr4FqMLDRH3C+9/N9qMC2/M/YX2x5Sgw=
Received: by 10.141.29.16 with SMTP id g16mr1612039rvj.81.1250005454936;
        Tue, 11 Aug 2009 08:44:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id k37sm30252600rvb.2.2009.08.11.08.44.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:07 +0700
X-Mailer: git-send-email 1.6.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125575>

Continuing the endless RFCs of sparse checkout, this series drops the sparse hook
in favor of .git/info/sparse. Changes from the last version


  Prevent diff machinery from examining assume-unchanged entries on worktree

    "if (ce_uptodate(ce) || CE_VALID)" is updated, as well as the corresponding test


  Avoid writing to buffer in add_excludes_from_file_1()

    Splitted out from the old second patch, as suggested by Johannes


  Read .gitignore from index if it is assume-unchanged

    read_index_data() is renamed. Commit message mentions add_excludes_from_file()


  excluded_1(): support exclude "directories" in index

    This one is new because index does not have "directory", more comments in the patch


  dir.c: export excluded_1() and add_excludes_from_file_1()

    New too, exported for use in unpack-trees.c


  unpack-trees.c: generalize verify_* functions

    Splitted out of the old third patch for easier review


  Support sparse checkout in unpack_trees() and read-tree

    Read .git/info/sparse instead of .git/hooks/sparse

    
  --sparse for porcelains
    RFC patch

 Documentation/technical/api-directory-listing.txt |    3 +
 builtin-checkout.c                                |    4 +
 builtin-clean.c                                   |    5 +-
 builtin-ls-files.c                                |    4 +-
 builtin-merge.c                                   |    5 +-
 builtin-read-tree.c                               |    4 +-
 cache.h                                           |    3 +
 diff-lib.c                                        |    6 +-
 dir.c                                             |  101 +++++++++++------
 dir.h                                             |    4 +
 git-pull.sh                                       |    6 +-
 t/t1009-read-tree-sparse.sh                       |   47 ++++++++
 t/t3001-ls-files-others-exclude.sh                |   22 ++++
 t/t4039-diff-assume-unchanged.sh                  |   31 ++++++
 t/t7300-clean.sh                                  |   19 ++++
 unpack-trees.c                                    |  121 ++++++++++++++++++++-
 unpack-trees.h                                    |    3 +
 17 files changed, 340 insertions(+), 48 deletions(-)
 create mode 100755 t/t1009-read-tree-sparse.sh
 create mode 100755 t/t4039-diff-assume-unchanged.sh
