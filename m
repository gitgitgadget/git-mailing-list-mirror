From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] stop t1400 hiding errors in tests
Date: Fri, 9 Nov 2007 00:41:39 +0100
Message-ID: <20071108234139.GD4899@steel.home>
References: <1194541140-3062-1-git-send-email-krh@redhat.com> <20071108232751.GC4899@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 04:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqKlj-0004Y2-V2
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 04:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858AbXKIDmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 22:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758178AbXKIDmj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 22:42:39 -0500
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:11137 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757780AbXKIDmi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 22:42:38 -0500
Received: from mo-p07-ob.rzone.de (mrclete-mo-p07-ob.mail [192.168.63.176])
	by charnel-fb-03.store (RZmta 14.0) with ESMTP id i03708jA8GO8j4
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 00:42:41 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from tigra.home (Fc819.f.strato-dslnet.de [195.4.200.25])
	by post.webmailer.de (mrclete mo49) (RZmta 14.0)
	with ESMTP id Y02739jA8MarCY ; Fri, 9 Nov 2007 00:41:41 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2A425277AE;
	Fri,  9 Nov 2007 00:41:41 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 68F1656D22; Fri,  9 Nov 2007 00:41:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071108232751.GC4899@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWowxOg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64125>

The last rm in the test was lacking an "&&" before it,
which caused the errors in the commands be silently hidden.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Fri, Nov 09, 2007 00:27:52 +0100:
> Kristian H=F8gsberg, Thu, Nov 08, 2007 17:59:00 +0100:
> > This makes git commit a builtin and moves git-commit.sh to
>=20
> Applied instead of 00c8febf563da on Junio's pu it breaks t1400:
>=20
> * FAIL 29: git-commit logged updates
>         diff expect .git/logs/refs/heads/master
>=20
>=20
> Which is not the test actually failed. The failed one is 28, but the
> last "rm -f M" killed the error because of missed "&&" before it.

just separated the fix into a patch of its own. Johannes already took
care of the problem with launch_editor not reading the message file.

 t/t1400-update-ref.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ce045b2..a90824b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -205,7 +205,7 @@ test_expect_success \
 	 echo $h_TEST >.git/MERGE_HEAD &&
 	 GIT_AUTHOR_DATE=3D"2005-05-26 23:45" \
 	 GIT_COMMITTER_DATE=3D"2005-05-26 23:45" git-commit -F M &&
-	 h_MERGED=3D$(git rev-parse --verify HEAD)
+	 h_MERGED=3D$(git rev-parse --verify HEAD) &&
 	 rm -f M'
=20
 cat >expect <<EOF
--=20
1.5.3.5.626.g8f33b
