From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 03/11] gitweb.js: Provide default values for padding in padLeftStr and padLeft
Date: Sun, 10 Apr 2011 00:49:18 +0200
Message-ID: <1302389366-21515-4-git-send-email-jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 00:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gyk-00058j-TX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab1DIWt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:49:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60231 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab1DIWtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:49:52 -0400
Received: by fxm17 with SMTP id 17so2942671fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=N6JsurB3BNaBCbrNeRXAS53SGDZCDLjQXSME5mRX5o0=;
        b=pTOfz5jV7eK6pMJ58gk1oW5zOMbVKS8x9voBNj/0qQ4syjKpHA5bmIVMcmKC//Gk/6
         Krsi9lGQIwM9OoFA2qB0OHEzf+3RJQpDfPQgSudmqHoE74b9cSO63zV7NohaIsKqVS07
         2qfGH0zUCme3M+DlitpzsfE/IpcU2MBFogHts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jTfo99iyF8IjCg3DfUnDdVWr+FunA+oT4twZG/voRYgBbwOMoAMaS/4O393QV+BR7z
         HnlRjxff+YvTClAQ2JLNuzI5McCKAwbbAw/V5ucE7ScM0o7HHClJZR543B22fUffVRwK
         cT8LBZ9dTPBGsgN8Eb8/sTJdt2i5EVfwDF/pI=
Received: by 10.223.24.72 with SMTP id u8mr1593864fab.10.1302389391520;
        Sat, 09 Apr 2011 15:49:51 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.49.49
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171214>

This means that one can use padLeft(4, 2) and it would be equivalent
to runing padLeft(4, 2, '0'), and it would return '04' i.e. '4' padded
with '0' to width 2, to be used e.g. in formatting date and time.

This should make those functions easier to use.  Current code doesn't
yet make use of this feature.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is not strictly necessary, but it makes those functions
easier to use, I guess.

Removing this patch would require some trivially resolvable changes
to next commits in this series.

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
