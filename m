From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 05/13] gitweb.js: Provide default values for padding in padLeftStr and padLeft
Date: Thu, 28 Apr 2011 21:04:03 +0200
Message-ID: <1304017451-12283-6-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWX0-0003fO-MQ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933110Ab1D1TFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:05:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62309 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933411Ab1D1TEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:46 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3481029wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=FP4qkvMKcur+U3Zd7c7+KGBST3jOBtcKdr8ZnSG0xNI=;
        b=VcXHUZTtMQJTnfg68iJoidp5rsrH1i/hfZNT4PinSc08+nZ2YltGskVaeE5vC+sxSJ
         Hbd0sNFW50sNm1tNdIiiSaGpRw1vmKK/QhDg7PwlvNuk/9zWLmJDuEEPtlfst7QuxmrE
         e4dL/e3haACBlJXXO9FmV7ZP2BztxhNgkudnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nBkp2hZTmG0wy5qb4+M1J/ymbVbvCt6afANECxb7AzZA+lijQIxrnTyhER3TK8rWRF
         VwmCkCNpa3aTJ2lLR8Y9m4LpTaOnHT3fGtkivScPodWlnuLxzBv2YjlGRLyadpnxtEPi
         4aPxzdLAkyqVa8bArapa+7itq+hpJXBr+HaD0=
Received: by 10.227.150.130 with SMTP id y2mr3938872wbv.62.1304017486352;
        Thu, 28 Apr 2011 12:04:46 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.44
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172394>

This means that one can use padLeft(4, 2) and it would be equivalent
to runing padLeft(4, 2, '0'), and it would return '04' i.e. '4' padded
with '0' to width 2, to be used e.g. in formatting date and time.

This should make those functions easier to use.  Current code doesn't
yet make use of this feature.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from first version of this series (though it
is no longer marked as RFC).  It doesn't have equivalent in original
patch by J.H.


This patch is not strictly necessary, but it makes those functions
easier to use, I guess.

Removing this patch would require some trivially resolvable changes
to some of subsequent commits in this series.

 gitweb/static/js/lib/common-lib.js |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index 6a6d200..c45454e 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -22,11 +22,14 @@
  *
  * @param {Number|String} input: number to pad
  * @param {Number} width: visible width of output
- * @param {String} str: string to prefix to string, e.g. '\u00A0'
+ * @param {String} str: string to prefix to string, defaults to '\u00A0'
  * @returns {String} INPUT prefixed with STR x (WIDTH - INPUT.length)
  */
 function padLeftStr(input, width, str) {
 	var prefix = '';
+	if (typeof str === 'undefined') {
+		ch = '\u00A0'; // using '&nbsp;' doesn't work in all browsers
+	}
 
 	width -= input.toString().length;
 	while (width > 0) {
@@ -38,16 +41,21 @@ function padLeftStr(input, width, str) {
 
 /**
  * Pad INPUT on the left to WIDTH, using given padding character CH,
- * for example padLeft('a', 3, '_') is '__a'.
+ * for example padLeft('a', 3, '_') is '__a'
+ *             padLeft(4, 2) is '04' (same as padLeft(4, 2, '0'))
  *
  * @param {String} input: input value converted to string.
  * @param {Number} width: desired length of output.
- * @param {String} ch: single character to prefix to string.
+ * @param {String} ch: single character to prefix to string, defaults to '0'.
  *
  * @returns {String} Modified string, at least SIZE length.
  */
 function padLeft(input, width, ch) {
 	var s = input + "";
+	if (typeof ch === 'undefined') {
+		ch = '0';
+	}
+
 	while (s.length < width) {
 		s = ch + s;
 	}
-- 
1.7.3
