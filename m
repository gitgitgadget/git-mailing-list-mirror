From: David Reiss <dreiss@facebook.com>
Subject: [PATCH] Round-down years in "years+months" relative date view
Date: Thu, 27 Aug 2009 16:39:38 -0700
Message-ID: <4A97193A.8090502@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 03:58:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgqjn-00059m-UX
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 03:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbZH1B6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 21:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbZH1B6i
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 21:58:38 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:40960 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbZH1B6i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 21:58:38 -0400
X-Greylist: delayed 8341 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2009 21:58:38 EDT
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.16] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7RNdY7i026268
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 16:39:34 -0700
Received: from [172.24.132.111] (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.1.393.1; Thu, 27 Aug
 2009 16:39:39 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-27_08:2009-08-26,2009-08-27,2009-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908270203
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127242>

Previously, a commit from 1 year and 7 months ago would display as
"2 years, 7 months ago".

Signed-off-by: David Reiss <dreiss@facebook.com>
---

Here's my test script.  Let me know if you'd rather have it as part
of the test suite.


#!/bin/sh
set -e
REPO="git-relative-dates-test"
rm -rf "$REPO"
mkdir "$REPO"
cd "$REPO"
git init
NOW=`date +%s`
env GIT_AUTHOR_DATE=`expr $NOW - \( 365 + 220 \) \* 24 \* 60 \* 60` git commit --allow-empty -m old-commit
git log --date=relative


 date.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 1de1845..e848d96 100644
--- a/date.c
+++ b/date.c
@@ -137,7 +137,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		}
 		/* Give years and months for 5 years or so */
 		if (diff < 1825) {
-			unsigned long years = (diff + 183) / 365;
+			unsigned long years = diff / 365;
 			unsigned long months = (diff % 365 + 15) / 30;
 			int n;
 			n = snprintf(timebuf, sizeof(timebuf), "%lu year%s",
-- 
1.6.0.4
