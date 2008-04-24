From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] bash completion only provides revs, not paths
Date: Wed, 23 Apr 2008 21:21:29 -0400
Message-ID: <20080424012129.GU29771@spearce.org>
References: <20080422112129.GA30923@digi.com> <20080423015236.GM29771@spearce.org> <20080423055637.GA25446@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 03:22:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoqAT-0006tw-Mc
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 03:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbYDXBVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Apr 2008 21:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYDXBVf
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 21:21:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35405 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbYDXBVe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 21:21:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Joq9I-0004WA-6O; Wed, 23 Apr 2008 21:21:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A06B20FBAE; Wed, 23 Apr 2008 21:21:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080423055637.GA25446@digi.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80280>

Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com> wrote:
> > How is this?
>
> I like it and have already applied it.
=2E..
> > Suggested-by: Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com>
>
> There is a letter missing in my name.  I wonder why it's always the o=
nly
> non-ascii one :-)

Damn.  I'm sorry.  My mailer seems to be dropping it when I
quote you, and I copied your name from the "... wrote:" line
at the top of my message.  I should have copied from the
To: header, where it hasn't been munged.

=46ixed commit message below.

--8<--
bash completion: Completely only path names after -- in options

If the user has inserted a -- before the current argument we are
being asked to complete they are most likely trying to force Git into
treating this argument as a path name, and not as a ref.  We should
allow bash to complete it as a path from the local working directory.

Tested-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0f5d30c..8d8405e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -308,7 +308,20 @@ __git_complete_file ()
=20
 __git_complete_revlist ()
 {
-	local pfx cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local c=3D1 pfx cur
+
+	while [ $c -lt $COMP_CWORD ]; do
+		cur=3D"${COMP_WORDS[c]}"
+		case "$cur" in
+		--)
+			COMPREPLY=3D()
+			return
+			;;
+		esac
+		c=3D$((++c))
+	done
+
+	cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	*...*)
 		pfx=3D"${cur%...*}..."
--=20
1.5.5.1.141.gd55b


--=20
Shawn.
