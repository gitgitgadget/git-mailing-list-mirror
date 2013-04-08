From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: [PATCH 3/4] gitweb: Don't append ';js=(0|1)' to external links
Date: Mon, 08 Apr 2013 22:09:48 +0200
Message-ID: <m2wqscbx83.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 22:10:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPIOP-0002tT-Ry
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 22:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935965Ab3DHUKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 16:10:07 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:39907 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935939Ab3DHUKE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 16:10:04 -0400
Received: by mail-bk0-f41.google.com with SMTP id i18so3320202bkv.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 13:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=FkyC2sC5mWNAvt3G2J66rKkXkdCIqt1Wg/bjmMsx3Z8=;
        b=PmW+rxSIqiWnMxC8CcICPV06v+hFmO82LRJKIRjpigTRvhnYSuA0IB9c3qtz7Zzn+1
         68+wcrKgc4b7uo44pmIceVrzWkcb5RAQ+L6SLPUCBKzp31ouvPta4+mdfjAynuwFCq4F
         IVjGd5RvszBOPpnG7onLrvg87+/FUwJBjryPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=FkyC2sC5mWNAvt3G2J66rKkXkdCIqt1Wg/bjmMsx3Z8=;
        b=hJv2mNPl0GTZFetgp/z0+OgvClV1gaBN2Nw3XBqhHAsqLiI9zW3qlw1lYwsbnSEztc
         bmaAFRhTIZTtcfTTo+ilvvlJ4CZFZzvwGOWuijqyQdqVE05HDaQfi1pqBv4GaIpN/JO4
         looQ2Hs2P/s3ucgRTi0cU0ep9h5/ETOMIYaI66m3cSOaQcInSRSXDjofuT0qlT4yJGtR
         u/aRyj5v+g7gHweIU8jG4vSzCyts5ZsbySgtd/pABD2jr+W+JlsBpVYAcVFpvldK4v5Q
         HZhYq91kVMNpTKo2M5DoaTEyt4JI/ogzXUful4OnF/Q6mG3hq7kBIXTKh4jlEujO+o+v
         q3gQ==
X-Received: by 10.205.35.13 with SMTP id su13mr5017081bkb.40.1365451802681;
        Mon, 08 Apr 2013 13:10:02 -0700 (PDT)
Received: from zahir.local (p5083D2BC.dip.t-dialin.net. [80.131.210.188])
        by mx.google.com with ESMTPS id gu14sm13107184bkc.1.2013.04.08.13.10.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 13:10:01 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQkEKfy4S8f06Hi7Rq8u4cFTzZ0Kp54347NyjEOIOmmgtSk7AcSOaTHtE0a0yfWoelyLJVaI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220509>

Don't add js parameters to links outside of gitweb itself.

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl                       |    2 +-
 gitweb/static/js/javascript-detection.js |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1309196..f0912d7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4165,7 +4165,7 @@ sub git_footer_html {
 		print qq!<script type=3D"text/javascript">\n!.
 		      qq!window.onload =3D function () {\n!;
 		if (gitweb_check_feature('javascript-actions')) {
-			print qq!	fixLinks();\n!;
+			print qq!	fixLinks('$my_url');\n!;
 		}
 		if ($jstimezone && $tz_cookie && $datetime_class) {
 			print qq!	var tz_cookie =3D { name: '$tz_cookie', expires: 14, path=
: '/' };\n!. # in days
diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static/j=
s/javascript-detection.js
index fa2596f..36964ad 100644
--- a/gitweb/static/js/javascript-detection.js
+++ b/gitweb/static/js/javascript-detection.js
@@ -29,11 +29,11 @@ var jsExceptionsRe =3D /[;?]js=3D[01](#.*)?$/;
  *
  * @globals jsExceptionsRe
  */
-function fixLinks() {
+function fixLinks(baseurl) {
 	var allLinks =3D document.getElementsByTagName("a") || document.links=
;
 	for (var i =3D 0, len =3D allLinks.length; i < len; i++) {
 		var link =3D allLinks[i];
-		if (!jsExceptionsRe.test(link)) {
+		if (!jsExceptionsRe.test(link) && !link.href.indexOf(baseurl)) {
 			link.href =3D link.href.replace(/(#|$)/,
 				(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D1$1');
 		}
--=20
1.7.10.4
