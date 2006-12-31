From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 22:30:41 -0800
Message-ID: <7vlkkoinla.fsf@assigned-by-dhcp.cox.net>
References: <20061231031305.GA5620@spearce.org>
	<7vy7ooip6y.fsf@assigned-by-dhcp.cox.net>
	<20061231061232.GC6106@spearce.org>
	<7vpsa0inwr.fsf@assigned-by-dhcp.cox.net>
	<20061231062618.GD6106@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 31 07:30:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0uDW-0005IW-HR
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 07:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbWLaGan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 01:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933036AbWLaGan
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 01:30:43 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54540 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933035AbWLaGan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 01:30:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231063042.SMJX7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 01:30:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5JVw1W00A1kojtg0000000; Sun, 31 Dec 2006 01:29:56 -0500
To: git@vger.kernel.org
In-Reply-To: <20061231062618.GD6106@spearce.org> (Shawn O. Pearce's message of
	"Sun, 31 Dec 2006 01:26:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35682>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > Junio C Hamano <junkio@cox.net> wrote:
>> >
>> >> Why?  Are you allowing "1024 k"?  Do we want to?
>> >
>> > Yes.  Why not?
>> 
>> Stricter input checking.  Allowing extra things later is far
>> easier than later finding problems with a looser way we started
>> from and having to tighten it.
>
> Good point.  I'm currently writing tests for this btw.

I have this already in the private 'master' I am prepareing for
pushout:

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index e48a4ec..a29caa0 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -391,5 +391,15 @@ EOF
 
 test_expect_success "rename succeeded" "diff -u expect .git/config"
 
+test_expect_success numbers '
+
+	git-repo-config kilo.gram 1k &&
+	git-repo-config mega.ton 1m &&
+	k=$(git-repo-config --int --get kilo.gram) &&
+	test z1024 = "z$k" &&
+	m=$(git-repo-config --int --get mega.ton) &&
+	test z1048576 = "z$m"
+'
+
 test_done
 
-- 
1.5.0.rc0.g81760
