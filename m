From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] For release tarballs, include the proper version
Date: Mon, 09 Jan 2006 18:07:01 -0800
Message-ID: <43C316C5.9060007@zytor.com>
References: <7vpsn1f1lb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020102010304070709000405"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 03:07:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew8uz-00075v-FU
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 03:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWAJCHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 21:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWAJCHT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 21:07:19 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54756 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932250AbWAJCHR
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 21:07:17 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0A276eE017648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Jan 2006 18:07:07 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsn1f1lb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,UPPERCASE_25_50 
	autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14396>

This is a multi-part message in MIME format.
--------------020102010304070709000405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When producing a release tarball, include a "version" file, which 
GIT-VERSION-GEN can then use to do the right thing when building from a 
tarball.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------020102010304070709000405
Content-Type: text/plain;
 name="gitver"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitver"

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 845b9dc..7763639 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,9 +1,15 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
+DEF_VER=v1.1.GIT
 
-VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
-VN=$(expr "$VN" : v'\(.*\)')
+# First try git-describe, then see if there is a version file
+# (included in release tarballs), then default
+VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) ||
+VN=$(cat version) ||
+VN="$DEF_VER"
+
+VN=$(expr "$VN" : v*'\(.*\)')
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
diff --git a/Makefile b/Makefile
index c9c15b5..fa0cd83 100644
--- a/Makefile
+++ b/Makefile
@@ -489,7 +489,9 @@ dist: git.spec git-tar-tree
 	./git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
 	@cp git.spec $(GIT_TARNAME)
-	$(TAR) rf $(GIT_TARNAME).tar $(GIT_TARNAME)/git.spec
+	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
+	$(TAR) rf $(GIT_TARNAME).tar \
+		$(GIT_TARNAME)/git.spec $(GIT_TARNAME)/version
 	@rm -rf $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 

--------------020102010304070709000405--
