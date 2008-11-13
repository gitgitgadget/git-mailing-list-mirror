From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 04/11] gitweb: optional custom name for refs in git_heads_body
Date: Thu, 13 Nov 2008 23:49:10 +0100
Message-ID: <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1U-0004iw-9R
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYKMWtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbYKMWtK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:37802 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbYKMWtG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:49:06 -0500
Received: by fg-out-1718.google.com with SMTP id 19so912917fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mI+mAMoNx8c5FHb/VYLjngRwQpm/gc54Vt1VyQzrwK0=;
        b=PqPJzO83H/5VBkmBmX14SF1sP03UGLb/rai4XxZGNLioclnFgZpeb3PdE8LurT/63/
         PjQ9i0QBFDpwaHXqSl/Yv4Rsp9HTnc8v0w3WYuOVKi+HIeBLnecKiJLPlVS7IMXgZsxD
         7mxxeaOwE03PLYoCQcITTeQEeug9CDDrAnEdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jnIFHOJlU9iEyxqucaleTcN6aXJVipfmOegLF+izuue140D9rz8bQYFf4H3XctoJ04
         fa/lW8mDRcFeahi/IdP82jxI5oAdi8XcPjD8wDv44fdpPX7fSdltL3u4MRTNc/Q9dwpU
         9mLcr5D+SWtqPHMrS0Z0hw+lV3j2744maput0=
Received: by 10.181.204.4 with SMTP id g4mr70551bkq.114.1226616544060;
        Thu, 13 Nov 2008 14:49:04 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id k29sm5916014fkk.2.2008.11.13.14.49.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:49:03 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We make a clear separation between the hash reference and the displayed
name for refs displayed by git_heads_body. This can be used e.g. to
group them and display only the distinct part of the name.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ab29aec..a736f2a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4288,16 +4288,18 @@ sub git_heads_body {
 		} else {
 			print "<tr class=\"light\">\n";
 		}
+		my $hname = $ref{'hname'} || $ref{'fullname'} || $ref{'name'};
+		my $name = $ref{'name'};
 		$alternate ^= 1;
 		print "<td><i>$ref{'age'}</i></td>\n" .
 		      ($curr ? "<td class=\"current_head\">" : "<td>") .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'}),
-		               -class => "list name"},esc_html($ref{'name'})) .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$hname),
+		               -class => "list name"},esc_html($name)) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
-		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$hname)}, "shortlog") . " | " .
+		      $cgi->a({-href => href(action=>"log", hash=>$hname)}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$hname, hash_base=>$hname)}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
-- 
1.5.6.5
