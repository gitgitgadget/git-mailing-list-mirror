From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv1 3/5] gitweb: Colorize 'blame_incremental' view during processing
Date: Tue,  1 Sep 2009 13:39:18 +0200
Message-ID: <1251805160-5303-4-git-send-email-jnareb@gmail.com>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
 <1251805160-5303-2-git-send-email-jnareb@gmail.com>
 <1251805160-5303-3-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 13:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiRbP-0001Kk-7i
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 13:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZIALcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 07:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZIALcM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 07:32:12 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:36393 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbZIALcC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 07:32:02 -0400
Received: by mail-fx0-f217.google.com with SMTP id 17so3435900fxm.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IpTaQlbdhcy9sFAFTL+lFsjQwAQmND7bfNqVZtkJkfU=;
        b=xUVAM8D8y3w1jrKydeoPPfeJ9m0BwHJSM+pJnBoWi/qTntkjrSb21yMv9IuE+bVPNM
         oeIpYq2EwyW1xkzMnyZWy0JaIol+w9uM9WAXqp6NzYVEoX2VCVxZk2p6EfEUKymq2kO/
         uwYGAfLrDBPwzz0ECYpabWSkJ6hdg2eNqC6IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=frB3vBNVVtJRvCIiHc3MdODdccuU838eXPyp4gis0rBFxoyMlF56MBNAwItsHuA8A0
         pTQJfKruG/qajw0FUDy/Fk+DT0bIZP6He6VLDXXklwffAsfdCeZuNXWfrX19wFKenLf7
         ymS4mN/B/0Vr5o7ZgxmyHyRkaUrmaodA3Mglw=
Received: by 10.102.236.11 with SMTP id j11mr2826815muh.3.1251804724788;
        Tue, 01 Sep 2009 04:32:04 -0700 (PDT)
Received: from localhost.localdomain (abwl209.neoplus.adsl.tpnet.pl [83.8.235.209])
        by mx.google.com with ESMTPS id j10sm4029382mue.45.2009.09.01.04.32.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 04:32:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n81BdWdu005345;
	Tue, 1 Sep 2009 13:39:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n81BdVJe005344;
	Tue, 1 Sep 2009 13:39:31 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1251805160-5303-3-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127534>

This requires using 3 colors, not only two, to be able to choose color
different from colors of up to 2 neigbours.

gitweb.js select least used color, if more than one color is possible.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was earlier part of previous commit (adding 'blame_incremental'
view).

 gitweb/gitweb.css |    5 ++
 gitweb/gitweb.js  |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 69ef119..977a013 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -262,6 +262,11 @@ tr.no-previous td.linenr {
 	font-weight: bold;
 }
 
+/* for 'blame_incremental', during processing */
+tr.color1 { background-color: #f6fff6; }
+tr.color2 { background-color: #f6f6ff; }
+tr.color3 { background-color: #fff6f6; }
+
 td {
 	padding: 2px 5px;
 	font-size: 100%;
diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index c8411e7..bf38216 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -211,6 +211,101 @@ function errorInfo(str) {
 }
 
 /* ............................................................ */
+/* coloring rows during blame_data (git blame --incremental) run */
+
+/**
+ * used to extract N from 'colorN', where N is a number,
+ * @constant
+ */
+var colorRe = /\bcolor([0-9]*)\b/;
+
+/**
+ * return N if <tr class="colorN">, otherwise return null
+ * (some browsers require CSS class names to begin with letter)
+ *
+ * @param {HTMLElement} tr: table row element to check
+ * @param {String} tr.className: 'class' attribute of tr element
+ * @returns {Number|null} N if tr.className == 'colorN', otherwise null
+ *
+ * @globals colorRe
+ */
+function getColorNo(tr) {
+	if (!tr) {
+		return null;
+	}
+	var className = tr.className;
+	if (className) {
+		var match = colorRe.exec(className);
+		if (match) {
+			return parseInt(match[1], 10);
+		}
+	}
+	return null;
+}
+
+var colorsFreq = [0, 0, 0];
+/**
+ * return one of given possible colors (curently least used one)
+ * example: chooseColorNoFrom(2, 3) returns 2 or 3
+ *
+ * @param {Number[]} arguments: one or more numbers
+ *        assumes that  1 <= arguments[i] <= colorsFreq.length
+ * @returns {Number} Least used color number from arguments
+ * @globals colorsFreq
+ */
+function chooseColorNoFrom() {
+	// choose the color which is least used
+	var colorNo = arguments[0];
+	for (var i = 1; i < arguments.length; i++) {
+		if (colorsFreq[arguments[i]-1] < colorsFreq[colorNo-1]) {
+			colorNo = arguments[i];
+		}
+	}
+	colorsFreq[colorNo-1]++;
+	return colorNo;
+}
+
+/**
+ * given two neigbour <tr> elements, find color which would be different
+ * from color of both of neighbours; used to 3-color blame table
+ *
+ * @param {HTMLElement} tr_prev
+ * @param {HTMLElement} tr_next
+ * @returns {Number} color number N such that
+ * colorN != tr_prev.className && colorN != tr_next.className
+ */
+function findColorNo(tr_prev, tr_next) {
+	var color_prev = getColorNo(tr_prev);
+	var color_next = getColorNo(tr_next);
+
+
+	// neither of neighbours has color set
+	// THEN we can use any of 3 possible colors
+	if (!color_prev && !color_next) {
+		return chooseColorNoFrom(1,2,3);
+	}
+
+	// either both neighbours have the same color,
+	// or only one of neighbours have color set
+	// THEN we can use any color except given
+	var color;
+	if (color_prev === color_next) {
+		color = color_prev; // = color_next;
+	} else if (!color_prev) {
+		color = color_next;
+	} else if (!color_next) {
+		color = color_prev;
+	}
+	if (color) {
+		return chooseColorNoFrom((color % 3) + 1, ((color+1) % 3) + 1);
+	}
+
+	// neighbours have different colors
+	// THEN there is only one color left
+	return (3 - ((color_prev + color_next) % 3));
+}
+
+/* ............................................................ */
 /* coloring rows like 'blame' after 'blame_data' finishes */
 
 /**
@@ -224,8 +319,6 @@ function isStartOfGroup(tr) {
 	return tr.firstChild.className === 'sha1';
 }
 
-var colorRe = /(?:light|dark)/;
-
 /**
  * change colors to use zebra coloring (2 colors) instead of 3 colors
  * concatenate neighbour commit groups belonging to the same commit
@@ -391,6 +484,12 @@ function handleLine(commit, group) {
 			formatDateISOLocal(commit.authorTime, commit.authorTimezone);
 	}
 
+	// color depends on group of lines, not only on blamed commit
+	var colorNo = findColorNo(
+		document.getElementById('l'+(resline-1)),
+		document.getElementById('l'+(resline+group.numlines))
+	);
+
 	// loop over lines in commit group
 	for (var i = 0; i < group.numlines; i++, resline++) {
 		var tr = document.getElementById('l'+resline);
@@ -409,7 +508,10 @@ function handleLine(commit, group) {
 		var a_linenr = td_sha1.nextSibling.firstChild;
 
 		/* <tr id="l123" class=""> */
-		var tr_class = 'light'; // or tr.className
+		var tr_class = '';
+		if (colorNo !== null) {
+			tr_class = 'color'+colorNo;
+		}
 		if (commit.boundary) {
 			tr_class += ' boundary';
 		}
-- 
1.6.3.3
