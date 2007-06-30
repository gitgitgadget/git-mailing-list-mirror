From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-tag: Fix the main while loop exit condition.
Date: Sat, 30 Jun 2007 18:04:37 +1200
Message-ID: <4685F275.8030508@vilain.net>
References: <11830498172717-git-send-email-alexandre@peadrop.com> <7vy7i3mxw3.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Alexandre Vassalotti <alexandre@peadrop.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 08:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4W68-00029D-9p
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 08:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbXF3GGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 02:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXF3GGK
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 02:06:10 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:44803 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbXF3GGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 02:06:09 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4W5i-0002GZ-Tt; Sat, 30 Jun 2007 18:05:54 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id D87EE5CE00; Sat, 30 Jun 2007 18:05:54 +1200 (NZST)
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7vy7i3mxw3.fsf@assigned-by-dhcp.pobox.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51193>

Junio C Hamano wrote:
> Thanks.
> 
> I think you would need something like this on top if you want to
> really fix it, though.
> 
> I also suspect that we should error out on:
> 
> 	$ git tag -l foo bar
> 
> but that will be left as an exercise to the readers ;-)

More is required...

diff --git a/git-tag.sh b/git-tag.sh
index 48b54a1..480d16d 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -82,7 +82,9 @@ do
 	if test "$#" = "0"; then
 	    die "error: option -m needs an argument"
 	else
+	    message="$1"
 	    message_given=1
+	    shift
 	fi
 	;;
     -F)
@@ -93,13 +95,19 @@ do
 	else
 	    message="$(cat "$1")"
 	    message_given=1
+	    shift
 	fi
 	;;
     -u)
 	annotate=1
 	signed=1
 	shift
-	username="$1"
+	if test "$#" = "0"; then
+	    die "error: option -u needs an argument"
+	else
+	    username="$1"
+	    shift
+	fi
 	;;
     -d)
 	shift
