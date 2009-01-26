From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 4/6] gitweb: rss channel date
Date: Mon, 26 Jan 2009 12:50:14 +0100
Message-ID: <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ1B-0004CT-Ns
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbZAZLuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbZAZLuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:50:16 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:62083 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbZAZLuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:50:09 -0500
Received: by mail-ew0-f21.google.com with SMTP id 14so329621ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5arRxrfCLPb4wE89aHp0smktiFBcUWS4HsBX19rSrn8=;
        b=CUYkvFaKtFebIV4zs1JqpWsTYmZrLbNmK5t4vkKcBrjprKIt+iCIRRhwsp6U8FL+Jb
         kX3LnzN/3UyK/slqX43EmCzJLwRkOYaQM4TwVKuLpx23d2TjcAlBBhX2V3KdurmWv2Y6
         KX0Mxgsx3I6MobNSDH3N1Mc4QCSmB+YyaFoZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s15H9Pz0I5cXxDRvAyo+ENl0/gTUB96cTHYYbLrDepv8efBzv9IneciEg5xwv064XV
         DpATWhbiA5fVzKsQr10g1MbSV1j5OnmWD3tU+Jfg1svy9hsRQLNkJZ44lWPs2vOz92Mz
         5kXWI5OGIKSDlCGi9Kd4TyhVWxtqfKmVdlSVM=
Received: by 10.103.226.10 with SMTP id d10mr3460611mur.84.1232970608514;
        Mon, 26 Jan 2009 03:50:08 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id y6sm23616551mug.32.2009.01.26.03.50.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 03:50:07 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107200>

The RSS 2.0 specifications defines not one but _two_ dates for its
channel element! Woohoo! Luckily, it seems that consensus seems to be
that if both are present they should be equal, except for some very
obscure and discouraged cases. Since lastBuildDate would make more sense
for us and pubDate seems to be the most commonly used, we defined both
and make them equal.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc6d0fb..756868a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6087,6 +6087,10 @@ XML
 			      "<link>$alt_url</link>\n" .
 			      "</image>\n";
 		}
+		if (%latest_date) {
+			print "<pubDate>$latest_date{'rfc2822'}</pubDate>\n";
+			print "<lastBuildDate>$latest_date{'rfc2822'}</lastBuildDate>\n";
+		}
 		print "<generator>gitweb v.$version/$git_version</generator>\n";
 	} elsif ($format eq 'atom') {
 		print <<XML;
-- 
1.5.6.5
