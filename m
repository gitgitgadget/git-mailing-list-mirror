From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: Merging on a dirty tree???
Date: Fri, 16 Mar 2007 11:46:09 +0100
Message-ID: <87slc54gb2.fsf@gmail.com>
References: <200703152359.53543.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Dmitry Torokhov <dtor@insightbb.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 11:46:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS9wr-00081i-38
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 11:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbXCPKp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Mar 2007 06:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbXCPKp4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 06:45:56 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:56281 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbXCPKpz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 06:45:55 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l2GAjmq00442;
	Fri, 16 Mar 2007 11:45:49 +0100
In-Reply-To: <200703152359.53543.dtor@insightbb.com> (Dmitry Torokhov's
	message of "Thu, 15 Mar 2007 23:59:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42346>

Dmitry Torokhov <dtor@insightbb.com> writes:

> Hi,
>
> I just tried to pull from Linus' tree into my local tree and it seems
> that fast forward was committed even though the tree was dirty:

[...]

>  19 files changed, 211 insertions(+), 80 deletions(-)
> [dtor@anvil work]$ git --version
> git version 1.5.0.3.438.gc49b2
>
> It used to refuse merge if there were conflicts...

Try with this patch.

Santi

-- >8 --
=46rom: "Santi B=C3=A9jar" <sbejar@gmail.com>
Subject: [PATCH] git-merge: finish when git-read-tree fails

The message formating (commit v1.5.0.3-28-gbe242d5) broke the && chain.

Noticed by Dmitry Torokhov.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-merge.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 6ce62c8..8759c5a 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -292,13 +292,13 @@ f,*)
 	# Again the most common case of merging one remote.
 	echo "Updating $(git-rev-parse --short $head)..$(git-rev-parse --shor=
t $1)"
 	git-update-index --refresh 2>/dev/null
-	new_head=3D$(git-rev-parse --verify "$1^0") &&
-	git-read-tree -v -m -u --exclude-per-directory=3D.gitignore $head "$n=
ew_head" &&
 	msg=3D"Fast forward"
 	if test -n "$have_message"
 	then
 		msg=3D"$msg (no commit created; -m option ignored)"
 	fi
+	new_head=3D$(git-rev-parse --verify "$1^0") &&
+	git-read-tree -v -m -u --exclude-per-directory=3D.gitignore $head "$n=
ew_head" &&
 	finish "$new_head" "$msg" || exit
 	dropsave
 	exit 0
--=20
1.5.0.4.1010.g688e
