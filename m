From: Junio C Hamano <junkio@cox.net>
Subject: Re: git send-email woes
Date: Mon, 25 Sep 2006 12:58:21 -0700
Message-ID: <7v7izrzpk2.fsf@assigned-by-dhcp.cox.net>
References: <20060924224316.GA28051@uranus.ravnborg.org>
	<20060925183221.GE2490@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 21:59:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRwbX-0006VG-Ri
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 21:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWIYT60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 15:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWIYT60
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 15:58:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:44796 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750782AbWIYT6X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 15:58:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060925195822.GNWA6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Sep 2006 15:58:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SjyK1V00b1kojtg0000000
	Mon, 25 Sep 2006 15:58:20 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060925183221.GE2490@uranus.ravnborg.org> (Sam Ravnborg's
	message of "Mon, 25 Sep 2006 20:32:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27751>

Sam Ravnborg <sam@ravnborg.org> writes:

> The patches in quistion did not have a "Signed-off-by: tag so
> that mail address has been from the author instead.
> And this mail address was still invalid as per RFC2822.

I do not think it takes Signed-off-by: as author in any case
(and I do not think it should -- if it did so it is a bug).

Maybe something like this?

diff --git a/git-send-email.perl b/git-send-email.perl
index 746c525..b4a34f4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -431,6 +431,11 @@ sub send_message
 	    $gitversion =~ s/^.* //;
 	}
 
+	my ($author_name) = ($from =~ /^(.*?)\s+</);
+	if ($author_name =~ /\./ && $author_name !~ /^".*"$/) {
+		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
+		$from = "\"$name\"$addr";
+	}
 	my $header = "From: $from
 To: $to
 Cc: $cc
