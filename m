From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 03/11] gitweb.js: Provide default values for padding in padLeftStr and padLeft
Date: Fri, 15 Apr 2011 16:43:57 +0200
Message-ID: <1302878645-458-4-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGx-0002aV-3D
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab1DOOon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:43 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64042 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab1DOOog (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:36 -0400
Received: by wwk4 with SMTP id 4so7176707wwk.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Ny/N1CHE90/2UpGkGY0R1sCS/tWiPx69HK/TrhZlnWs=;
        b=QdoWG3T9oJoPrkHtl8JiJPzJVCZkfuJ0aDb+ODB6VsoZBNaahSrWjezbrwEi17AAPS
         0Qk01rN9GooxD5d16q0eHVVwVM59Fs2W5+diY26D5lb7ExYbo0Yw0oGPpRcUYTKfOJt8
         05hM1oTrO9pX2jlgZA5SaR7EfRF9v1JkSq8Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B68GXgNSnE9wJhp+5ztqiL7q6jIssIzlUvz92Kr7TivJmbxzHB6/tDZCfzMA9la0Jq
         LfUzlUYpn+5HdxxoWi9Nj+0zP46cnn92+7YeKvzB7Q+WE67ox5UP9uP+heIPFNwyH/J1
         gcV43E7dLRHE/C36bEBBFTVCuBfQ7xLEfIVFc=
Received: by 10.227.178.14 with SMTP id bk14mr2150004wbb.102.1302878675107;
        Fri, 15 Apr 2011 07:44:35 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.33
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171606>

This means that one can use padLeft(4, 2) and it would be equivalent
to runing padLeft(4, 2, '0'), and it would return '04' i.e. '4' padded
with '0' to width 2, to be used e.g. in formatting date and time.

This should make those functions easier to use.  Current code doesn't
yet make use of this feature.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from v1 version.

This patch is not strictly necessary, but it makes those functions
easier to use, I guess.  Removing this patch would require though some
trivially resolvable changes to subsequent commits in this series.

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
