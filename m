From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 22:00:59 -0700
Message-ID: <7vodyyb1mc.fsf@assigned-by-dhcp.cox.net>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de>
	<Pine.LNX.4.64.0604180822470.3701@g5.osdl.org>
	<20060418175853.GA25688@wohnheim.fh-wedel.de>
	<Pine.LNX.4.64.0604181104420.3701@g5.osdl.org>
	<20060418182650.GB25688@wohnheim.fh-wedel.de>
	<4445C1D6.3070504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 07:01:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW4oP-0005IC-Dn
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 07:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDSFBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 19 Apr 2006 01:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDSFBE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 01:01:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43261 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750813AbWDSFBC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 01:01:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419050101.LWZC24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 01:01:01 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4445C1D6.3070504@zytor.com> (H. Peter Anvin's message of "Tue,
	18 Apr 2006 21:51:34 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18909>

"H. Peter Anvin" <hpa@zytor.com> writes:

> J=F6rn Engel wrote:
>>
>> Excellent!  I have a faint memory of hpa recently saying that the gi=
t
>> daemon would be too resource-hungry.  One of the cases where being
>> wrong is a Good Thing.
>
> Well, we ended up making some tweaks to the git daemon, and it hasn't
> been a problem since.

Ah, I am glad the daemon expert was listening...  Do you have
comments on recent patch from Serge E. Hallyn?  It looks OK to
me, but that standalone daemon part is not something I run
myself, so...

-- >8 --
[PATCH] socksetup: don't return on set_reuse_addr() error

The set_reuse_addr() error case was the only error case in
socklist() where we returned rather than continued.  Not sure
why.  Either we must free the socklist, or continue.  This patch
continues on error.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0032d548db56eac9ea09b4ba05843365f6325b85
diff --git a/daemon.c b/daemon.c
index a1ccda3..776749e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -535,7 +535,7 @@ #endif
=20
 		if (set_reuse_addr(sockfd)) {
 			close(sockfd);
-			return 0;	/* not fatal */
+			continue;
 		}
=20
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
--=20
1.3.0.rc4.g5247-dirty
