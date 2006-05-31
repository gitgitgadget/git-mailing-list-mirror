From: Junio C Hamano <junkio@cox.net>
Subject: Re: t9001 fails because Net::SMTP is missing
Date: Tue, 30 May 2006 17:34:44 -0700
Message-ID: <7v8xojyqu3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605302125310.11586@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 02:34:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlEfh-0000NA-Rl
	for gcvg-git@gmane.org; Wed, 31 May 2006 02:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWEaAer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 20:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWEaAer
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 20:34:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:59821 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964834AbWEaAeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 20:34:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531003445.SBYP15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 20:34:45 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605302125310.11586@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 30 May 2006 21:26:55 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21050>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> is it unexpected that there are setups which come without Net::SMTP?
>
> -- snip --
> * expecting success: git format-patch -n HEAD^1
>      git send-email -from="Example <nobody@example.com>" 
> --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" ./0001*txt
> 0001-Second.txt
> Can't locate Net/SMTP.pm in @INC (@INC contains: 

Hmm.  Something like this?

-- >8 --

diff --git a/git-send-email.perl b/git-send-email.perl
index 0e368ff..f7af8eb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -21,7 +21,6 @@ use warnings;
 use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
-use Net::SMTP;
 
 # most mail servers generate the Date: header, but not all...
 $ENV{LC_ALL} = 'C';
@@ -394,6 +393,7 @@ X-Mailer: git-send-email $gitversion
 		print $sm "$header\n$message";
 		close $sm or die $?;
 	} else {
+		use Net::SMTP;
 		$smtp ||= Net::SMTP->new( $smtp_server );
 		$smtp->mail( $from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
