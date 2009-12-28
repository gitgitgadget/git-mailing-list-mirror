From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Documentation: always respect core.worktree if set
Date: Mon, 28 Dec 2009 12:55:04 +0700
Message-ID: <1261979704-30074-1-git-send-email-pclouds@gmail.com>
References: <fcaeb9bf0912272141j1def76e7v6f581636188e65f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 06:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP8aD-0003Ma-QR
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 06:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbZL1Fzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 00:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZL1Fzx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 00:55:53 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:64100 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZL1Fzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 00:55:52 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so10185133ywh.4
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 21:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Xx99FuwJpcKZ1kq+DBZdKH7JZZw1OGNyy8/5mCluvvg=;
        b=iYKY3qEa8Q3afy8PTLUsqNqkFzxG5b3l59QBpaB4ugH1BgmGMYRf3ZGeR/4nhKYoM+
         K4DPu5SQ8dlBVdufUbkBSd8Isj97pzbE2a/G7POITjYw4Fd9dMbFeDBnvUwkVJWO5dYc
         4IR6luBR9nMoOhIkG8E+A1xqbhleYzmhW5OVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xsUCawv1tyVhfV3bpQw1sNuWakK3XjJfwF0e+Xsg1HCfuigIK/ydl6HCb04PvTvjuo
         vs/YGi+mJ+BsXZ0QdhIprw/F9qAnbN3Ria2UonKiXX77Ml7d0BzI/iNmGOAlcidlRmN0
         3eFJIie5KFHJw+s4NdHhkfrsYqcoMdI1OKUns=
Received: by 10.150.176.15 with SMTP id y15mr21958675ybe.242.1261979751801;
        Sun, 27 Dec 2009 21:55:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.211.127])
        by mx.google.com with ESMTPS id 23sm4002384ywh.33.2009.12.27.21.55.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Dec 2009 21:55:51 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 Dec 2009 12:55:05 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <fcaeb9bf0912272141j1def76e7v6f581636188e65f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135730>

In the beginning, there was GIT_DIR environment variable.  We had a ver=
y
simple semantics:

 - When there is no GIT_DIR environment variable:

   - if "." is a "git directory", i.e. it has the set of git things lik=
e
     refs/, objects/ and HEAD, then you are working in a bare repositor=
y.

   - if ./.git exists and it is a "git directory", then "." is the top =
of
     the work tree;

   - otherwise, try the parent directory of "." for the second rule
     repeatedly to find the git directory and the top of the work tree.

 - When there is GIT_DIR environment variable:

   - $GIT_DIR is (and must be) the "git directory" and "." is the top o=
f
     the work tree.

People wanted to have a work tree that is at a location totally unrelat=
ed
to where the "git directory" and setting $GIT_DIR at runtime was the on=
ly
way to do so, but that restricted them to work only at the top of the w=
ork
tree.  $GIT_WORK_TREE was invented as a way to say "this is the top of =
the
work tree".  So that people can do something like:

    $ GIT_DIR=3D/srv/git/proj.git GIT_WORK_TREE=3D/scratch/proj
    $ export GIT_DIR GIT_WORK_TREE
    $ cd $GIT_WORK_TREE/Documentation
    $ edit; git diff; git commit -a; ...

Because the facility was meant to allow separation of "git directory" a=
nd
its associated work tree, and not meant to allow more than one work tre=
es
sharing the same "git directory" (which does not make any sense, as the=
re
is only one index in "git directory" that describes the state of the wo=
rk
tree), it was an unnecessary nuisanse that you had to set two environme=
nt
variables.  core.worktree was invented---by recording the location of t=
he
work tree in the config file in the "git directory", the above can be m=
ade
into this:

    $ GIT_DIR=3D/srv/git/proj.git
    $ cd /scratch/proj/Documentation
    $ edit; git diff; git commit -a; ...

According to the current documentation, if GIT_DIR is not set,
core.worktree is not respected, and the parent directory of the "git
directory" may be used as worktree. This case, unless core.worktree
matches the parent directory of the "git directory" in question, seems
a misconfiguration and nothing else. So remove this part of the
documentation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Junio may find the description highly familiar :) only slightly modifi=
ed
 at the end

 Documentation/config.txt |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7d10a21..4b3d568 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -297,9 +297,7 @@ false), while all other repositories are assumed to=
 be bare (bare
 =3D true).
=20
 core.worktree::
-	Set the path to the working tree.  The value will not be
-	used in combination with repositories found automatically in
-	a .git directory (i.e. $GIT_DIR is not set).
+	Set the path to the working tree.
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command line option. It can be
 	a absolute path or relative path to the directory specified by
--=20
1.6.5.2.216.g9c1ec
