From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 1/6] gitweb: channel image in rss feed
Date: Mon, 26 Jan 2009 12:50:11 +0100
Message-ID: <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ07-0003vA-Ep
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbZAZLuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbZAZLuI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:50:08 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:62083 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbZAZLuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:50:04 -0500
Received: by ewy14 with SMTP id 14so329621ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=crW534e0UJ4JMsUjtrAfdZBRgRM1+Uq1q9G4haCa6Jg=;
        b=Gng0rxcdLMkFAfPNQXYHt5y9F5aAgxCGQNi0KmDe1YealyE5aF2/o+1pgUwD56Wc7K
         FJVmH6VxE4krpHZoAYt+GwbpfVX2scDSE9H2GsRO9PmvzMt46i6YUj2xISGW9ARGbJZp
         QIUrRKF2LEV/qUnp6zQpPoXv2xCXaRcp6FPws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dx3tk/4U6jeKwj13FdYba8BVW6tkCBDP4HLE2bja0Sz09RlDWN22jn3MMxq9sTNtJC
         mcjyP6ASckj3y1xtOOvtHnAdFRFu09zLkmcSfqAk4JXWd3DHE03oYFwkBR7PJ1Slsyb0
         F0ORryKYDeUCRq+w2l3BNm/S69xNvuI1O03HQ=
Received: by 10.103.160.10 with SMTP id m10mr1254391muo.50.1232970601006;
        Mon, 26 Jan 2009 03:50:01 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id 12sm12005764muq.23.2009.01.26.03.49.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 03:50:00 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107195>

Define the channel image for the rss feed when the logo or favicon are
defined, preferring the former to the latter. As suggested in the RSS
2.0 specifications, the image's title and link as set to the same as the
channel's.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 931db4f..f8a5d2e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6075,6 +6075,16 @@ XML
 		      "<link>$alt_url</link>\n" .
 		      "<description>$descr</description>\n" .
 		      "<language>en</language>\n";
+		if (defined $logo || defined $favicon) {
+			# prefer the logo to the favicon, since RSS
+			# doesn't allow both
+			my $img = esc_url($logo || $favicon);
+			print "<image>\n" .
+			      "<url>$img</url>\n" .
+			      "<title>$title</title>\n" .
+			      "<link>$alt_url</link>\n" .
+			      "</image>\n";
+		}
 	} elsif ($format eq 'atom') {
 		print <<XML;
 <feed xmlns="http://www.w3.org/2005/Atom">
-- 
1.5.6.5
