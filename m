From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/4] gitweb: channel image in rss feed
Date: Fri, 23 Jan 2009 05:48:38 +0100
Message-ID: <1232686121-1800-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 05:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQDzN-00044x-Vd
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 05:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbZAWEsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 23:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755596AbZAWEsb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 23:48:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:61810 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562AbZAWEs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 23:48:29 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2404923fgg.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 20:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=crW534e0UJ4JMsUjtrAfdZBRgRM1+Uq1q9G4haCa6Jg=;
        b=bIpZkqNih2VbSyRCriQNkbXbip8nthkk42l/co7ZfUo3reA7cl0JoUKOVz/oYa+jxO
         rToR7YFeFy7ZxuTf+Xfv5dmYHAzMp0v+34R7hwFmsS2A//b7o7jU/BmrHhMJUYzO8LnW
         ezhK8y7JsePLDFI//y/P7L/vvsV+ufp5b4gDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Bctnwz2qmNrVs+rKsTbpJp6iwRYhhxrxVuw4SrSPXnIAzIq8679uPiFGpx+sLMOxPJ
         jXTuiEDBiKTFDihUGeSG9bQ+jndduQiac4Dv5t6WrRiLjDZEMY9QhGly/uQFx00+e+54
         88dY3udM09aaxmATxjJVNq37SfeRMefF/HOhs=
Received: by 10.86.94.11 with SMTP id r11mr1542191fgb.11.1232686108648;
        Thu, 22 Jan 2009 20:48:28 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id d4sm3285380fga.51.2009.01.22.20.48.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 20:48:28 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106831>

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
