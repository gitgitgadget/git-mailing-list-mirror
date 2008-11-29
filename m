From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] gitweb: links to patch action in commitdiff and shortlog view
Date: Sat, 29 Nov 2008 14:41:11 +0100
Message-ID: <1227966071-11104-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 14:42:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Q5f-0003L3-9L
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 14:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYK2NlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 08:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbYK2NlG
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 08:41:06 -0500
Received: from ik-out-1112.google.com ([66.249.90.178]:13773 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbYK2NlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 08:41:04 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1470897ika.5
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 05:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ITNL3EJBJc2gjPjJhXB6jlSFWsiPPWTY7dgBEQEIZUc=;
        b=l+vc6Zhze/pvJRZ4Almf9IrF8kulqreVx41NuO8v3VmBKMPAx0OV1Q+VIMq7vuTLKW
         R0H/474z3dabXeEk+WJk23aGvEf66fO2x5TJwnhHku2FJDhuRZj5Ar3CF+sssrIj6Ig3
         aw816LEsCzIltVw45VINVi+4wJzlHbsXmeMNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DxcNsHRe/5dU8oSRSfYvXc+j142bh0w6L+j2CaWPw+lN6fECmhiis4568Whqo04a+7
         +LECEzNFPa6zfXX/kx0CLra81lvyxEyhaE46NrbEHglbDbjz0JbDcwt24SIXuiAEHs0f
         dI/9RtOnTOmaEL0T/4INYW4fDJx55VA3Qp+aU=
Received: by 10.103.247.14 with SMTP id z14mr3616895mur.70.1227966061020;
        Sat, 29 Nov 2008 05:41:01 -0800 (PST)
Received: from localhost ([78.13.52.113])
        by mx.google.com with ESMTPS id y6sm2613772mug.2.2008.11.29.05.40.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 05:41:00 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101911>

The link from commitdiff view is an obviously needed one, but we also
offer the option to link to the patchset in shortlog view, when there
are less than 15 commits being shown.
---
 gitweb/gitweb.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index befe6b6..5b18fdf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5382,7 +5382,9 @@ sub git_commitdiff {
 	if ($format eq 'html') {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
-			        "raw");
+			        "raw") . " | " .
+			$cgi->a({-href => href(action=>"patch", -replay=>1)},
+			        "patch");
 
 		if (defined $hash_parent &&
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
@@ -5915,6 +5917,12 @@ sub git_shortlog {
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
+	# TODO this should be configurable
+	if ($#commitlist <= 15) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => href(action=>"patch", -replay=>1)},
+			        $#commitlist > 1 ? "patchset" : "patch");
+	}
 
 	git_header_html();
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.5.6.5
