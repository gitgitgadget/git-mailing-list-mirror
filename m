From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Sun,  5 Sep 2010 16:47:27 +1000
Message-ID: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:48:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os91h-0007mC-WF
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892Ab0IEGsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:48:15 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35696 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab0IEGsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:48:14 -0400
Received: by pvg2 with SMTP id 2so1071512pvg.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=NcvSeVn0vWgC+++WeEczzRtBwSMyzjsOmAwkMprMvZA=;
        b=ILeDHr6zdWskp2RG6elFK8qWQkYl01SeEKftcWIAZyYYGjxJ3+7K85xF+KcrdTHeit
         PjqVVaDtTXRPJPjn6uWQxUgOXkWbsfDdbMn5SPO6FUke/P5UjoNDV7P18VYWFWgf/SoG
         qCwsKnVFA/M+6gd7ZqbKsFrhwK0NXQ71IFGs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=wQO5De4khHzLqunZxzZRWee4zW4C7IGDa5uR7R0Mzu24ZOXz/cJn0ctBKSG2KMEAHY
         fMV+lACLdQbdJCAtGrrGJsbiKhmuavBRNKqrcAxo1S96S9VAWIPibRiO9VTeXpdb6Qxb
         8J78dTIIwWBBOTco8ZryfJ24M6dANg7QNZgFw=
Received: by 10.143.166.14 with SMTP id t14mr1124638wfo.193.1283669293997;
        Sat, 04 Sep 2010 23:48:13 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id s34sm1971708wfc.8.2010.09.04.23.48.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:48:13 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:47:51 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155427>

I'll describe differences between this series and Elijah's one [1].
I think it's more interesting. Changes from v2 [2] will follow later.

In short I think the two series are converging. The outstanding
difference is Elijah drops shallow clone in favor of more flexible
history cutting while I only focus on tree cutting.

Two other differences are tree traversal and tree generating. I admit
that changing traverse_trees() the way Elijah does is more flexible
and is probably the only way to support negative pathspec. And I think
his sparse clone supports even cloning a single file. Mine does not
support that. I'm going to steal some of his patches at some point.

Tree generating from index, Elijah merges the base tree inside
write_cache_as_tree() while it does it inside commit_tree(). Again the
principle is pretty much the same. I'll see if I can resist from
stealing some more :)

OK, changes from v2:

 - Require en/object-list-with-pathspec
 - Use lower-case index extension instead of stepping index version to =
4
 - Support cloning multiple tree
 - Remote merge is dropped. It may be resurrected at some point if
   people like to merge so much.

Things that won't work:

 - fsck/prune/...
 - Shell scripts that use "git write-tree"

What's next:
 - stealing
 - fsck (will probably make fsck use rev-list in narrow repo)
 - only send commits that have changes in narrow area and graft it at
   client side

[1] http://mid.gmane.org/1283645647-1891-1-git-send-email-newren@gmail.=
com
[2] http://mid.gmane.org/1282688422-7738-1-git-send-email-pclouds@gmail=
=2Ecom=20

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (17):
  rev-list: do not do commit simplification if simplify_history =3D 0
  tree.c: add path_to_sha1()
  Introduce $GIT_DIR/narrow
  index: make narrow index incompatible with older git
  pack-objects: support narrow packs with pathspecs
  {fetch,upload}-pack: support narrow repository
  unpack-trees: split traverse_trees() code into a separate function
  unpack-trees: support unpack trees in narrow repository
  cache-tree: only cache tree within narrow area
  get_pathspec(): support narrow pathspec rewriting
  pathspec retrieval fix
  clone: support --narrow option
  commit: add narrow's commit_tree version
  commit: use commit_narrow_tree() to support narrow repo
  write-tree: requires --narrow-base in narrow repository
  merge: try to do local merge if possible in narrow repo
  Add narrow clone demonstration test

 .gitignore                                |    1 +
 Documentation/git-clone.txt               |   14 ++-
 Documentation/git-fetch-pack.txt          |    3 +
 Documentation/git-merge.txt               |   16 ++
 Documentation/git-pack-objects.txt        |    2 +-
 Documentation/git-rev-parse.txt           |    3 +
 Documentation/gitrepository-layout.txt    |    5 +
 Documentation/technical/pack-protocol.txt |    3 +
 Makefile                                  |    3 +
 builtin/clone.c                           |   43 +++++
 builtin/commit.c                          |   16 +-
 builtin/fetch-pack.c                      |    9 +
 builtin/grep.c                            |    5 +-
 builtin/ls-files.c                        |    2 +-
 builtin/ls-tree.c                         |    2 +-
 builtin/merge.c                           |   60 ++++++-
 builtin/pack-objects.c                    |   19 ++-
 builtin/reset.c                           |    3 +-
 builtin/rev-parse.c                       |    8 +
 builtin/write-tree.c                      |   25 +++
 cache-tree.c                              |   41 ++++-
 cache.h                                   |    5 +
 commit.c                                  |   16 ++
 commit.h                                  |    5 +
 environment.c                             |    2 +
 git-am.sh                                 |    2 +-
 narrow-tree.c                             |  285 +++++++++++++++++++++=
++++++++
 narrow-tree.h                             |    8 +
 read-cache.c                              |   32 +++-
 revision.c                                |    7 +-
 setup.c                                   |  172 +++++++++++++++++-
 t/t0062-narrow-pathspec.sh                |  150 +++++++++++++++
 t/t0063-narrow-repo.sh                    |   74 ++++++++
 t/t1013-read-tree-narrow.sh               |   72 ++++++++
 t/t6000-rev-list-misc.sh                  |    9 +
 t/t7510-commit-narrow.sh                  |   30 +++
 t/t9999-narrow.sh                         |   87 +++++++++
 test-get-pathspec.c                       |   17 ++
 tree.c                                    |   35 ++++
 tree.h                                    |    2 +
 unpack-trees.c                            |  153 +++++++++++++---
 upload-pack.c                             |   39 ++++-
 42 files changed, 1420 insertions(+), 65 deletions(-)
 create mode 100644 narrow-tree.c
 create mode 100644 narrow-tree.h
 create mode 100755 t/t0062-narrow-pathspec.sh
 create mode 100755 t/t0063-narrow-repo.sh
 create mode 100755 t/t1013-read-tree-narrow.sh
 create mode 100755 t/t7510-commit-narrow.sh
 create mode 100755 t/t9999-narrow.sh
 create mode 100644 test-get-pathspec.c
