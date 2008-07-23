From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [RFC PATCH 00/12] Sparse checkout
Date: Wed, 23 Jul 2008 21:55:18 +0700
Message-ID: <20080723145518.GA29035@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfm3-0002E8-O5
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbYGWOzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYGWOzk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:55:40 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYGWOzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:55:39 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=s9SXwEF10LRYqErjpxiArWOhTDGxq/+koKAdkwfb+CM=;
        b=ENrg3xkge11BfUzzmv2X+9s80kaw4nRfN9D+ynvM28vddlcDsMNHRkPuLN6eumPc4Y
         ANo//9KzGumt9oX9Z1Xpoy+2HtANany4pbuteBRqCpc/xBfyM+XaCFBaH6d+7NDnyovK
         YbLtfNA2KcQ4vTDJ8iRL8OXEymCN7eO+dabvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=vGRja5A8vLEmFc9plKDIXI7mWC5GRhuEpQDjXiOZQtVihKFpM2W6KxtKtEpCrb68tI
         ScK7r93QknsaiXHXVd258u721VJ/EPQcJkGOo6T0gWi+8aXWe8soo5rhTATIO3jpeSHR
         GbqEmoIvkxWs0hv94DcnK4Hy444WP+Js4m/dA=
Received: by 10.110.28.15 with SMTP id b15mr115043tib.26.1216824937808;
        Wed, 23 Jul 2008 07:55:37 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id y5sm14761531tia.8.2008.07.23.07.55.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:55:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:55:18 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89670>

I have not looked at non-builtin commands yet, but I think it's not
a big deal. We have several rounds before this series is good enough ;)
So in short, sparse prefix will be stored in config, core.sparsecheckou=
t.
you have three new commands to enter/update/leave sparse checkout:

git clone --path=3Dprefix       # clone with sparse checkout
git checkout --path=3Dprefix    # limit/update checkout paths
git checkout --full           # stop sparse checkout

Other operations should be normal. User attempts to do anything outside
sparse checkout will get flagged. Git itself should not touch anything
outside sparse checkout.

One more thing. As files outside sparse checkout will not be checking
out, .gitignore and .gitattributes from parent directories (outside
sparse checkout) will be gone too. This may lead to surprise.

Comments are welcome.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  git-grep: read config
  git-grep: support --no-external-grep
  Introduce sparse prefix
  Protect index with sparse prefix
  tests for sparse checkout, index protection
  Avoid accessing working directory outside sparse prefix
  tests for sparse checkout, worktree protection
  git-clone: support --path to do sparse clone
  tests for sparse clone
  git-checkout: support --full and --path to manipulate sparse checkout
  tests for checkout [--full|--path]
  git-status: print sparse checkout status

 builtin-add.c                              |    4 +-
 builtin-apply.c                            |    5 +
 builtin-checkout-index.c                   |    2 +
 builtin-checkout.c                         |   46 ++++++-
 builtin-clean.c                            |    3 +
 builtin-clone.c                            |   13 ++
 builtin-commit.c                           |   13 ++-
 builtin-grep.c                             |   36 +++--
 builtin-ls-files.c                         |    6 +-
 builtin-ls-tree.c                          |    2 +-
 builtin-merge-recursive.c                  |    6 +-
 builtin-mv.c                               |    2 +-
 builtin-read-tree.c                        |    5 +
 builtin-rev-parse.c                        |    4 +
 builtin-rm.c                               |    7 +-
 builtin-update-index.c                     |   37 ++++-
 cache.h                                    |   19 +++
 config.c                                   |    7 +
 diff-lib.c                                 |    5 +-
 diff.c                                     |    3 +-
 entry.c                                    |    3 +
 environment.c                              |  221 ++++++++++++++++++++=
++++++
 read-cache.c                               |  112 +++++++++++++-
 setup.c                                    |   90 +++++++++++-
 sha1_file.c                                |    3 +
 t/t2010-checkout-sparse.sh                 |   71 +++++++++
 t/t2300-sparse-index.sh                    |  156 +++++++++++++++++++
 t/t2300/diff-index-sub.expected            |    3 +
 t/t2300/log.expected                       |   64 ++++++++
 t/t2301-sparse-index-merge-recursive.sh    |  226 ++++++++++++++++++++=
+++++++
 t/t2302-sparse-worktree.sh                 |  113 ++++++++++++++
 t/t2302/add-u.expected                     |    1 +
 t/t2302/add.expected                       |    2 +
 t/t2302/commit.expected                    |   14 ++
 t/t2302/diff-1.expected                    |    7 +
 t/t2302/diff-cc.expected                   |    9 +
 t/t2302/grep-work.expected                 |    2 +
 t/t2302/grep.expected                      |    2 +
 t/t2302/ls-files.expected                  |    2 +
 t/t2303-sparse-worktree-apply.sh           |   62 ++++++++
 t/t2303/apply-initial.patch                |   14 ++
 t/t2303/apply-inside.patch                 |    7 +
 t/t2303/apply-leading-dirs.patch           |    3 +
 t/t2303/apply-outside.patch                |    7 +
 t/t2303/apply-remove.patch                 |    7 +
 t/t2303/apply-rename.expected              |   13 ++
 t/t2303/apply-rename.patch                 |    4 +
 t/t2304-sparse-worktree-merge-recursive.sh |  233 ++++++++++++++++++++=
++++++++
 t/t5703-clone-sparse.sh                    |   40 +++++
 unpack-trees.c                             |  152 +++++++++++++++++--
 unpack-trees.h                             |    4 +-
 wt-status.c                                |   12 +-
 52 files changed, 1831 insertions(+), 53 deletions(-)
 create mode 100755 t/t2010-checkout-sparse.sh
 create mode 100755 t/t2300-sparse-index.sh
 create mode 100644 t/t2300/diff-index-sub.expected
 create mode 100644 t/t2300/log.expected
 create mode 100755 t/t2301-sparse-index-merge-recursive.sh
 create mode 100755 t/t2302-sparse-worktree.sh
 create mode 100644 t/t2302/add-u.expected
 create mode 100644 t/t2302/add.expected
 create mode 100644 t/t2302/commit.expected
 create mode 100644 t/t2302/diff-1.expected
 create mode 100644 t/t2302/diff-cc.expected
 create mode 100644 t/t2302/grep-work.expected
 create mode 100644 t/t2302/grep.expected
 create mode 100644 t/t2302/ls-files.expected
 create mode 100755 t/t2303-sparse-worktree-apply.sh
 create mode 100644 t/t2303/apply-initial.patch
 create mode 100644 t/t2303/apply-inside.patch
 create mode 100644 t/t2303/apply-leading-dirs.patch
 create mode 100644 t/t2303/apply-outside.patch
 create mode 100644 t/t2303/apply-remove.patch
 create mode 100644 t/t2303/apply-rename.expected
 create mode 100644 t/t2303/apply-rename.patch
 create mode 100755 t/t2304-sparse-worktree-merge-recursive.sh
 create mode 100755 t/t5703-clone-sparse.sh
