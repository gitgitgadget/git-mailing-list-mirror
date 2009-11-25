From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/2] gitweb.js: fix padLeftStr() and its usage
Date: Tue, 24 Nov 2009 19:51:40 -0800
Message-ID: <1259121100-4178-1-git-send-email-bebarino@gmail.com>
References: <1258659887-5244-3-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 04:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND8vA-00019M-QS
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 04:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933823AbZKYDvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 22:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933645AbZKYDvj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 22:51:39 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41344 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933372AbZKYDvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 22:51:38 -0500
Received: by yxe17 with SMTP id 17so6263594yxe.33
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 19:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=dcd0/ivcNkziXPHZZnTVz0/NdJ8j4YZYcst6RUatsMc=;
        b=GqxbHMyt875At89You9lUx7gvZEnBySTbOq6eRVEcde7ulx1wNFankWyefodfD+mI2
         A5HwGp8C0o91e6v3v8WLer/reQaP5tGlT1yqb4WtREBVTzfOF5/PGNZmuf9chUrDN0gp
         NUbW97HdVb9CEN4xsKq68MWJv7cKX/lS2H2cE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eiB7mRgunf3h/X5KJGuUMLvLaetpvwoCfM+ikGSQfmZUSiNa68rcD6qcPIWEMWy/fT
         2EWUMYKWqdhqAUlIeUUOFd2/0Hk0g1XjomYQJK6aW12gjOSwJwAdCIygmhE8pFIuiTWq
         SumWuSEjDaDRnBFc7EzRc+DF6MFAUXwnQhKqE=
Received: by 10.91.14.10 with SMTP id r10mr9579400agi.5.1259121104851;
        Tue, 24 Nov 2009 19:51:44 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 22sm30522yxe.3.2009.11.24.19.51.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 19:51:44 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Tue, 24 Nov 2009 19:51:40 -0800
X-Mailer: git-send-email 1.6.6.rc0
In-Reply-To: <1258659887-5244-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133611>

It seems that in Firefox-3.5 inserting &nbsp; with javascript inserts the
literal &nbsp; instead of a space. Fix this by inserting the unicode
representation for &nbsp; instead.

Also fix the off-by-one error in the padding calculation that was
causing one less space to be inserted than was requested by the caller.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
---

Fixed the commit message and squashed in the off-by-one bug.

 gitweb/gitweb.js |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 02454d8..9214497 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -31,19 +31,19 @@
 
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
 	var prefix = '';
 
 	width -= input.toString().length;
-	while (width > 1) {
+	while (width > 0) {
 		prefix += str;
 		width--;
 	}
@@ -158,7 +158,7 @@ function updateProgressInfo() {
 
 	if (div_progress_info) {
 		div_progress_info.firstChild.data  = blamedLines + ' / ' + totalLines +
-			' (' + padLeftStr(percentage, 3, '&nbsp;') + '%)';
+			' (' + padLeftStr(percentage, 3, '\u00A0') + '%)';
 	}
 
 	if (div_progress_bar) {
-- 
1.6.6.rc0
