From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] gitweb.js: use unicode encoding for nbsp instead of html entity
Date: Thu, 19 Nov 2009 11:44:47 -0800
Message-ID: <1258659887-5244-3-git-send-email-bebarino@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:45:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCwM-0006Mw-Cg
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbZKSTo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 14:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZKSTo4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:44:56 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46664 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbZKSTo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 14:44:56 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so2739714bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 11:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=tz12jpNowSBT4AW3JVOhnFv/GW8KUxT+uYrvLO8THRw=;
        b=tjDBigLDJlK/xbTlkOrh4QYqg9GJR8gr5tevBZ5m/9MpUM4cj2YGAjuZ7tsRxDKka4
         +PYKmiqsruTXOsq/WHK2h7SUezr4B9/uoZvjvdaXlVj3+3q2Pd/ejXyy+TKwMI8c5Dih
         k5mpM3iwXN+19L698Zoq17NMrtxG+y0HblflU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OmP2jbst45GMlwiKvIT72/KswWF6xPjLfj8l208CbX2KzHr+LCTK/h6SqpPA5h5WHk
         L5uT4kCu7WqoQd7BCLo7JTH7VBDCO9JdMfg2KZTikBn+WS7su3PCPdkd0DtHCYdKz9vr
         YSKrDXqyZil7AkWCbRrIn0GykBFZiztU+DCwI=
Received: by 10.216.87.66 with SMTP id x44mr122916wee.96.1258659901880;
        Thu, 19 Nov 2009 11:45:01 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id t12sm1445474gvd.5.2009.11.19.11.44.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 11:45:01 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Thu, 19 Nov 2009 11:44:56 -0800
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-Reply-To: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133250>

It seems that in Firefox-3.5 inserting nbsp with javascript inserts the
literal nbsp; instead of a space. Fix this by inserting the unicode
representation for nbsp instead.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 gitweb/gitweb.js |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 02454d8..30597dd 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -31,12 +31,12 @@
 
 /**
  * pad number N with nonbreakable spaces on the left, to WIDTH characters
- * example: padLeftStr(12, 3, '&nbsp;') == '&nbsp;12'
- *          ('&nbsp;' is nonbreakable space)
+ * example: padLeftStr(12, 3, '\u00A0') == '\u00A012'
+ *          ('\u00A0' is nonbreakable space)
  *
  * @param {Number|String} input: number to pad
  * @param {Number} width: visible width of output
- * @param {String} str: string to prefix to string, e.g. '&nbsp;'
+ * @param {String} str: string to prefix to string, e.g. '\u00A0'
  * @returns {String} INPUT prefixed with (WIDTH - INPUT.length) x STR
  */
 function padLeftStr(input, width, str) {
@@ -158,7 +158,7 @@ function updateProgressInfo() {
 
 	if (div_progress_info) {
 		div_progress_info.firstChild.data  = blamedLines + ' / ' + totalLines +
-			' (' + padLeftStr(percentage, 3, '&nbsp;') + '%)';
+			' (' + padLeftStr(percentage, 3, '\u00A0') + '%)';
 	}
 
 	if (div_progress_bar) {
-- 
1.6.5.3.433.g11067
