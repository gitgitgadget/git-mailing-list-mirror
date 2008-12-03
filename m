From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv3 2/2] gitweb: links to patch action in commitdiff and shortlog view
Date: Wed,  3 Dec 2008 23:59:48 +0100
Message-ID: <1228345188-15125-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 00:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80id-0007E3-RH
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbYLCW7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 17:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbYLCW7v
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:59:51 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:13864 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYLCW7v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 17:59:51 -0500
Received: by ik-out-1112.google.com with SMTP id c29so3124742ika.5
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 14:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CmH3nZ7dqONqMokQ4dP8rqrKNof/GPSGLFRSDh6P5RE=;
        b=v7bsJ/mq/51WKuKPWzliK1h/bu+CC2vGSX1GBMFus52SnKUUB2m6X4shVCtRVxjBEZ
         ZVv9tJ8O5icwT6FmbWqTjlzo5tD4G8d6AiT4ViHcFw/DJR/T0VJhFUcDR5vo6wMPn0p1
         BeZwy9IfeIHbHmJLq3ZnNv4Zvew8gh4qNSwgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wwu8zHaPW5SSuqVWLIXNYmHb6nX8ICTqOimaMRNGFnrqdv0vlkp2rcma2Vfk1Ge3yK
         bG8X5FgkZyooZONOD+DqbHg7L8WJYRghKXb3CEeheU0gM9KOm1ZXPy6RJ2GJtyl6P9fH
         VXjQ5SsoPrl3mSQCv2NhhqJWTV8eQjgAGaj24=
Received: by 10.103.92.8 with SMTP id u8mr6514252mul.34.1228345188068;
        Wed, 03 Dec 2008 14:59:48 -0800 (PST)
Received: from localhost ([94.37.11.168])
        by mx.google.com with ESMTPS id 28sm3256986fkx.22.2008.12.03.14.59.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 14:59:47 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102302>

In shortlog view, a link to the patchset is only offered when the number
of commits shown is less than the allowed maximum number of patches.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c9abfcf..ec8fc7d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5083,6 +5083,11 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
+	if (gitweb_check_feature('patches')) {
+		$formats_nav .= " | " .
+			$cgi->a({-href => href(action=>"patch", -replay=>1)},
+				"patch");
+	}
 
 	if (!defined $parent) {
 		$parent = "--root";
@@ -5415,6 +5420,11 @@ sub git_commitdiff {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
+		if ($patch_max) {
+			$formats_nav .= " | " .
+				$cgi->a({-href => href(action=>"patch", -replay=>1)},
+					"patch");
+		}
 
 		if (defined $hash_parent &&
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
@@ -5949,6 +5959,14 @@ sub git_shortlog {
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
+	my $patch_max = gitweb_check_feature('patches');
+	if ($patch_max) {
+		if ($patch_max < 0 || @commitlist <= $patch_max) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"patch", -replay=>1)},
+					@commitlist > 1 ? "patchset" : "patch");
+		}
+	}
 
 	git_header_html();
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.5.6.5
