From: Pavel Roskin <proski@gnu.org>
Subject: [COGITO PATCH] value too great for base (error token is "-0800")
Date: Thu, 09 Jun 2005 17:40:30 -0400
Message-ID: <1118353230.2825.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 09 23:37:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgUhc-00021k-4g
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 23:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVFIVkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVFIVkn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 17:40:43 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:3531 "EHLO
	dv.roinet.com") by vger.kernel.org with ESMTP id S262471AbVFIVkg
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 17:40:36 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j59LeW3b015219
	for <git@vger.kernel.org>; Thu, 9 Jun 2005 17:40:32 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j59LeUsp015216
	for git@vger.kernel.org; Thu, 9 Jun 2005 17:40:30 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

The current cogito has problems with timezones that are too far from the
Greenwich meridian :-)

Bash interprets numbers beginning with 0 as octals.  Therefore, we need
to strip leading zeroes or zeroes following "-".  But if we get too
zealous and strip all digits, we'll need to restore one 0.  I tried to
write for sed portably, so I avoided some optimizations, such as
s/^-\?$/0/

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -65,7 +65,7 @@ showdate () {
 	[ "$format" ] || format=-R
 	sec=${date[0]}; tz=${date[1]}
 	if [ "$has_gnudate" ]; then
-	        dtz=${tz/+/}
+	        dtz=$(echo $tz | sed 's/^+//;s/^0*//;s/^-0*/-/;s/^$/0/;s/^-$/0/')
 		lsec=$(($dtz / 100 * 3600 + $dtz % 100 * 60 + $sec))
 	        pdate="$(date -ud "1970-01-01 UTC + $lsec sec" "$format" 2>/dev/null)"
 	else

-- 
Regards,
Pavel Roskin

