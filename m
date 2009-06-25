From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 8/8] gitweb: add avatar in signoff lines
Date: Thu, 25 Jun 2009 12:43:07 +0200
Message-ID: <1245926587-25074-9-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQz-0008IK-Or
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484AbZFYKnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbZFYKnl
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:41 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:57638 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267AbZFYKn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:27 -0400
Received: by bwz9 with SMTP id 9so1301738bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+17p1cbasiq2p3/QJpDxYwqSLNzlnJnS4aRHfHA00J0=;
        b=rrAiBhbyF8dCu9+ryoK6CYfCvy4IzI3ykl3feJVHncy5DQTzxY9qUwZXB+VLjOMYum
         DPikbA5Vxk0+4qwlwzJu9RXy81QNkpWBkUkB8fisiGZdudMxaYnpRFPfHe6o861jsP+Y
         wRANTWa2Sw+wa8rnuoO0NJ66LHpDJgKzTqWiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MDASweckr3GP9UYk8TU23o1QQvsbA0K9ECuW/YXIemcyQXwFjQOULKn9OpcB2K2O6U
         7Wmy0p1v/Ihl6NBpbzIrmIljgKLpt32KN8IhFGva42VG6N5Nvu8lEJxtPEGhFQu7gh/N
         eARDFpqW4H+CafyWUGBrA+0MyHrfyUA3sojBw=
Received: by 10.204.112.1 with SMTP id u1mr2383391bkp.37.1245926607997;
        Thu, 25 Jun 2009 03:43:27 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id b17sm324485fka.6.2009.06.25.03.43.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122201>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

I can't say I'm really satisfied with the layout given by this patch.
A significant improvement could be obtained by turning the signoff
line block into a table with three/four columns (signoff, name,
email/avatar). But we cannot guarantee that signoff lines come all
together in a block, so this would be more complex to implement.

 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7ca115f..d385f55 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3407,7 +3407,10 @@ sub git_print_log {
 			$signoff = 1;
 			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
-				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
+				my ($email) = $line =~ /<(\S+@\S+)>/;
+				print "<span class=\"signoff\">" . esc_html($line) . "</span>";
+				print git_get_avatar($email, 'pad_before' => 1) if $email;
+				print "<br/>\n";
 				next;
 			} else {
 				# remove signoff lines
-- 
1.6.3.rc1.192.gdbfcb
