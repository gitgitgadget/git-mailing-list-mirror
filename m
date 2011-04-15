From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 05/11] gitweb.js: Introduce gitweb/static/js/lib/cookies.js
Date: Fri, 15 Apr 2011 16:43:59 +0200
Message-ID: <1302878645-458-6-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGV-0002G9-Vt
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab1DOOop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:45 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64042 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab1DOOok (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:40 -0400
Received: by mail-ww0-f42.google.com with SMTP id 4so7176707wwk.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=I6Ku+HvCL+tnROcCg0PG31N5pWwfToSuUbteYX+djEs=;
        b=AKb7ROI998gmLEFo+ezrZNvqQDbLr/bsrnuqvp4cYa6+8VHKLnICaXWF7SviaFfAF8
         BZvM3HlaDauh01SMSjXSUjYbZd5wgz7Tskf0A1yS0ekuJVMr0OhkLi0g2VlPOs69hPRj
         Y1cbf4jMwOM07IN1mh59CdC6D78rlBULKrx3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NH/2lcSNWFx+sgWPwLqtashr4VvQa+UpG7aEPkpvOUSyxTFjnPv4UcJAs0VF1HZYcT
         VROOIkIvJnV91Nw1sthEy+MUfyuS5V6q59q1GtGO9uIbyfPsa4U4mEDt05rOFCFcqEDO
         qR+QFbGXc/xbPkOZ79flfja1YI1nwPcGhQ/xg=
Received: by 10.227.53.73 with SMTP id l9mr2100985wbg.19.1302878679590;
        Fri, 15 Apr 2011 07:44:39 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.37
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171603>

This file provides functions for setting, getting and deleting
cookies.

Code taken from subsection "Cookies in JavaScript" of "Professional
JavaScript for Web Developers" by Nicholas C. Zakas and from cookie
plugin for jQuery (dual licensed under the MIT and GPL licenses).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Unchanged from v1 version... 

Again, the summary line (subject) for this commit could be better.
For example:

  gitweb.js: Library for handling cookies

 gitweb/Makefile                 |    1 +
 gitweb/static/js/lib/cookies.js |  114 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/static/js/lib/cookies.js

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 403265a..7dd1dee 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -118,6 +118,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 # then the rest of files; js/gitweb.js should be last (if it exists)
 GITWEB_JSLIB_FILES += static/js/lib/common-lib.js
 GITWEB_JSLIB_FILES += static/js/lib/datetime.js
+GITWEB_JSLIB_FILES += static/js/lib/cookies.js
 GITWEB_JSLIB_FILES += static/js/javascript-detection.js
 GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 
diff --git a/gitweb/static/js/lib/cookies.js b/gitweb/static/js/lib/cookies.js
new file mode 100644
index 0000000..72b51cd
--- /dev/null
+++ b/gitweb/static/js/lib/cookies.js
@@ -0,0 +1,114 @@
+/**
+ * @fileOverview Accessing cookies from JavaScript
+ * @license GPLv2 or later
+ */
+
+/*
+ * Based on subsection "Cookies in JavaScript" of "Professional
+ * JavaScript for Web Developers" by Nicholas C. Zakas and cookie
+ * plugin from jQuery (dual licensed under the MIT and GPL licenses)
+ */
+
+
+/**
+ * Create a cookie with the given name and value,
+ * and other optional parameters.
+ *
+ * @example
+ *   setCookie('foo', 'bar'); // will be deleted when browser exits
+ *   setCookie('foo', 'bar', { expires: new Date(Date.parse('Jan 1, 2012')) });
+ *   setCookie('foo', 'bar', { expires: 7 }); // 7 days = 1 week
+ *   setCookie('foo', 'bar', { expires: 14, path: '/' });
+ *
+ * @param {String} sName:    Unique name of a cookie (letters, numbers, underscores).
+ * @param {String} sValue:   The string value stored in a cookie.
+ * @param {Object} [options] An object literal containing key/value pairs
+ *                           to provide optional cookie attributes.
+ * @param {String|Number|Date} [options.expires] Either literal string to be used as cookie expires,
+ *                            or an integer specifying the expiration date from now on in days,
+ *                            or a Date object to be used as cookie expiration date.
+ *                            If a negative value is specified or a date in the past),
+ *                            the cookie will be deleted.
+ *                            If set to null or omitted, the cookie will be a session cookie
+ *                            and will not be retained when the the browser exits.
+ * @param {String} [options.path] Restrict access of a cookie to particular directory
+ *                               (default: path of page that created the cookie).
+ * @param {String} [options.domain] Override what web sites are allowed to access cookie
+ *                                  (default: domain of page that created the cookie).
+ * @param {Boolean} [options.secure] If true, the secure attribute of the cookie will be set
+ *                                   and the cookie would be accessible only from secure sites
+ *                                   (cookie transmission will require secure protocol like HTTPS).
+ */
+function setCookie(sName, sValue, options) {
+	options = options || {};
+	if (sValue === null) {
+		sValue = '';
+		option.expires = 'delete';
+	}
+
+	var sCookie = sName + '=' + encodeURIComponent(sValue);
+
+	if (options.expires) {
+		var oExpires = options.expires, sDate;
+		if (oExpires === 'delete') {
+			sDate = 'Thu, 01 Jan 1970 00:00:00 GMT';
+		} else if (typeof oExpires === 'string') {
+			sDate = oExpires;
+		} else {
+			var oDate;
+			if (typeof oExpires === 'number') {
+				oDate = new Date();
+				oDate.setTime(oDate.getTime() + (oExpires * 24 * 60 * 60 * 1000)); // days to ms
+			} else {
+				oDate = oExpires;
+			}
+			sDate = oDate.toGMTString();
+		}
+		sCookie += '; expires=' + sDate;
+	}
+
+	if (options.path) {
+		sCookie += '; path=' + (options.path);
+	}
+	if (options.domain) {
+		sCookie += '; domain=' + (options.domain);
+	}
+	if (options.secure) {
+		sCookie += '; secure';
+	}
+	document.cookie = sCookie;
+}
+
+/**
+ * Get the value of a cookie with the given name.
+ *
+ * @param {String} sName: Unique name of a cookie (letters, numbers, underscores)
+ * @returns {String|null} The string value stored in a cookie
+ */
+function getCookie(sName) {
+	var sRE = '(?:; )?' + sName + '=([^;]*);?';
+	var oRE = new RegExp(sRE);
+	if (oRE.test(document.cookie)) {
+		return decodeURIComponent(RegExp['$1']);
+	} else {
+		return null;
+	}
+}
+
+/**
+ * Delete cookie with given name
+ *
+ * @param {String} sName:    Unique name of a cookie (letters, numbers, underscores)
+ * @param {Object} [options] An object literal containing key/value pairs
+ *                           to provide optional cookie attributes.
+ * @param {String} [options.path]   Must be the same as when setting a cookie
+ * @param {String} [options.domain] Must be the same as when setting a cookie
+ */
+function deleteCookie(sName, options) {
+	options = options || {};
+	options.expires = 'delete';
+
+	setCookie(sName, '', options);
+}
+
+/* end of cookies.js */
-- 
1.7.3
