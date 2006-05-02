From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] git-send-email: fix version string to be valid perl
Date: Wed, 03 May 2006 09:44:36 +1200
Message-ID: <11466062762814-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue May 02 23:44:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb2fX-0006PM-Vq
	for gcvg-git@gmane.org; Tue, 02 May 2006 23:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWEBVo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWEBVo3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 17:44:29 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:27541 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964992AbWEBVo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 17:44:28 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Fb2fQ-0001hH-M9; Wed, 03 May 2006 09:44:25 +1200
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.3.0.rc4.ge6bf-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19429>

This makes git-send-email easier to develop and debug, skipping the need
to `make git-send-email` every time.

---

 git-send-email.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

1f6dd44e0c919196f9c3d5d617a64111004f24e5
diff --git a/git-send-email.perl b/git-send-email.perl
index ecfa347..2eb4f6c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -291,6 +291,13 @@ sub send_message
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc);
 	my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime($time++));
+	my $gitversion = '@@GIT_VERSION@@';
+	if ($gitversion =~ m/..GIT_VERSION../) {
+	    $gitversion = `git --version`;
+	    chomp $gitversion;
+	    # keep only what's after the last space
+	    $gitversion =~ s/^.* //; 
+	}
 
 	my $header = "From: $from
 To: $to
@@ -299,7 +306,7 @@ Subject: $subject
 Reply-To: $from
 Date: $date
 Message-Id: $message_id
-X-Mailer: git-send-email @@GIT_VERSION@@
+X-Mailer: git-send-email $gitversion
 ";
 	$header .= "In-Reply-To: $reply_to\n" if $reply_to;
 
-- 
1.3.0.rc4.ge6bf-dirty
