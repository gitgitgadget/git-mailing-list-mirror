From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 1/2] Update the bash prompt from 'applied' instead of the
	obsolete 'current'
Date: Sun, 20 May 2007 23:22:00 +0200
Message-ID: <20070520211103.17468.21373.stgit@lathund.dewire.com>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ydirson@altern.org, git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sun May 20 23:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpsqx-00054O-Ha
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbXETVWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 17:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756748AbXETVWI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:22:08 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15547 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756726AbXETVWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:22:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A3C0C8028AB;
	Sun, 20 May 2007 23:15:47 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25841-07; Sun, 20 May 2007 23:15:47 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 4ABCF800783;
	Sun, 20 May 2007 23:15:47 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B874229238;
	Sun, 20 May 2007 23:22:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 67lODtplZ7CC; Sun, 20 May 2007 23:22:00 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 5823329068;
	Sun, 20 May 2007 23:22:00 +0200 (CEST)
In-Reply-To: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47922>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

s=F6ndag 20 maj 2007 skrev Yann Dirson:
> Note that "tail -1" gives a warning with newer versions, "tail -n 1"
> should be the proper call.
My man page doesn't mention -N being deprecated, but ok since -n 1 seem=
s
to work here too.
=20
> Also I'm not sure it is a good way to look at "applied" file, since
> Karl IIRC has plans to change this.  Better call "stg top" and not
> touch that again :)

Calling stg is too slow to be be used here. I that command in my first =
draft
for this function and people complained (see the thread named "Bash sni=
ppet
to show branch and patch in bash prompt"). It takes ~ 0.15s on here whi=
ch is
very noticable, barely below my pain threshold.=20

We'll update the prompt when and if Karl breaks this.

It'd probably drain my battery too :/

-- robin

 contrib/stgbashprompt.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
index 16bb39b..f4817a1 100755
--- a/contrib/stgbashprompt.sh
+++ b/contrib/stgbashprompt.sh
@@ -8,8 +8,8 @@ if [ "$PS1" ]; then
 		git_dir=3D$(git-rev-parse --git-dir 2> /dev/null) || return
 		ref=3D$(git-symbolic-ref HEAD 2> /dev/null) || return
 		br=3D${ref#refs/heads/}
-		top=3D$(cat $git_dir/patches/$br/current 2>/dev/null) \
-			&& top=3D"/$top"
+		top=3D$(tail -n 1 $git_dir/patches/$br/applied 2>/dev/null) \
+			&& top=3D"/$top";
 		echo "[$br$top]"
 	}
 	PS1=3D'\u@\h:$(__prompt_git)\W\$ '
