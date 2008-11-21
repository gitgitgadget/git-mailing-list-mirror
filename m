From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] git-send-email: provide hook to send lines more than 998 symbols
Date: Fri, 21 Nov 2008 11:59:24 +0200
Message-ID: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 11:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Sw2-0001Sr-Jl
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 11:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbYKUKHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 05:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbYKUKHH
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 05:07:07 -0500
Received: from mx01.teleca.com ([212.181.118.58]:57552 "EHLO mx01.teleca.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbYKUKHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 05:07:06 -0500
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Nov 2008 05:07:06 EST
Received: from denuas028.global.ad.teleca.com (denuas028.global.ad.teleca.com [10.20.2.28])
	by mx01.teleca.com (Postfix) with ESMTP id 12D3C103;
	Fri, 21 Nov 2008 10:59:27 +0100 (CET)
Received: from fitfiseimx01.global.ad.teleca.com ([10.118.100.120]) by denuas028.global.ad.teleca.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 10:59:26 +0100
Received: from FITFIESPPC176.gcpr.local ([10.118.34.154]) by fitfiseimx01.global.ad.teleca.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 11:59:25 +0200
Received: from andy by FITFIESPPC176.gcpr.local with local (Exim 4.67)
	(envelope-from <Andy.Shevchenko@teleca.com>)
	id 1L3SnM-0003SZ-PM; Fri, 21 Nov 2008 11:59:24 +0200
X-OriginalArrivalTime: 21 Nov 2008 09:59:25.0524 (UTC) FILETIME=[D5D6F140:01C94BBF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101506>

By default git-send-email does not accept patch which is contain lines longer
than 998 symbols. Sometime it's inconvenient, i.e. you have a long list in one
variable in shell script. So, define environment variable
GIT_SEND_EMAIL_LONGLINE to something to avoid that restriction.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 94ca5c8..29f700d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -981,7 +981,7 @@ sub validate_patch {
 	open(my $fh, '<', $fn)
 		or die "unable to open $fn: $!\n";
 	while (my $line = <$fh>) {
-		if (length($line) > 998) {
+		if (length($line) > 998 and not $ENV{GIT_SEND_EMAIL_LONGLINE}) {
 			return "$.: patch contains a line longer than 998 characters";
 		}
 	}
-- 
1.6.0.2.GIT
