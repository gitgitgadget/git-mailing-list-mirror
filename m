From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv2 2/2] gitweb: links to patch action in commitdiff and shortlog view
Date: Wed,  3 Dec 2008 11:07:42 +0100
Message-ID: <1228298862-28191-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228298862-28191-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 11:09:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ofP-0002AJ-KQ
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 11:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYLCKHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 05:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYLCKHo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 05:07:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:63894 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYLCKHn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 05:07:43 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3342470ugf.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 02:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YnESGaAA1k0HW+NQhh9UKdbm5LaJuKVqtwj3eAvphrg=;
        b=dPRfD6UrKSaIilPwvCR5obEMDcOqy9FNxAmrepEp9LmYZPn1pTtvYItAJYF4wpG9wI
         fE9renu5SQJ2D1gJw4S8/b9i3Nh8VQfZt6QPjTNq2Agu/MaPO10i4ijY1wkxjhNUrVCH
         lvyBYQpTao4tsNyA/SxspWpCBCRPSjy6EBeVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m4JWYzL0NhBNS0BhHX52eIR5n85ZtNDdcFf0Pvt6QRZXnJhmub6Gx5AHiOha+IaUc6
         KtlKM6zvwn3cLT2wEV5wq3dee3+kqH7eaKlqDG/TBohlQslzWYe6tqePmhPZjsl2h7WK
         IgbVo1p5uSbJ7IIkdf9dkBKfSuj3Bsg96oDwE=
Received: by 10.102.247.4 with SMTP id u4mr5839620muh.104.1228298862316;
        Wed, 03 Dec 2008 02:07:42 -0800 (PST)
Received: from localhost ([94.37.11.168])
        by mx.google.com with ESMTPS id 13sm8195809fks.3.2008.12.03.02.07.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 02:07:41 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1228298862-28191-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102236>

In shortlog view, a link to the patchset is only offered when the number
of commits shown is less than the allowed maximum number of patches.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10cbe93..aea0e07 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5403,7 +5403,9 @@ sub git_commitdiff {
 	if ($format eq 'html') {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
-			        "raw");
+			        "raw") . " | " .
+			$cgi->a({-href => href(action=>"patch", -replay=>1)},
+			        "patch");
 
 		if (defined $hash_parent &&
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
@@ -5938,6 +5940,11 @@ sub git_shortlog {
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
+	if ($#commitlist <= $patch_max) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => href(action=>"patch", -replay=>1)},
+			        $#commitlist > 1 ? "patchset" : "patch");
+	}
 
 	git_header_html();
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.5.6.5
