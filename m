From: Jeff King <peff@peff.net>
Subject: [PATCHv2 7/8] help: use parse_config_key for man config
Date: Wed, 23 Jan 2013 01:27:09 -0500
Message-ID: <20130123062709.GG5036@sigill.intra.peff.net>
References: <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:27:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txto7-0000HQ-U3
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab3AWG1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:27:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44627 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab3AWG1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:27:12 -0500
Received: (qmail 1363 invoked by uid 107); 23 Jan 2013 06:28:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:28:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:27:09 -0500
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214288>

The resulting code ends up about the same length, but it is
a little more self-explanatory. It now explicitly documents
and checks the pre-condition that the incoming var starts
with "man.", and drops the magic offset "4".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/help.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index bd86253..04cb77d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -237,21 +237,21 @@ static int add_man_viewer_info(const char *var, const char *value)
 
 static int add_man_viewer_info(const char *var, const char *value)
 {
-	const char *name = var + 4;
-	const char *subkey = strrchr(name, '.');
+	const char *name, *subkey;
+	int namelen;
 
-	if (!subkey)
+	if (parse_config_key(var, "man", &name, &namelen, &subkey) < 0 || !name)
 		return 0;
 
-	if (!strcmp(subkey, ".path")) {
+	if (!strcmp(subkey, "path")) {
 		if (!value)
 			return config_error_nonbool(var);
-		return add_man_viewer_path(name, subkey - name, value);
+		return add_man_viewer_path(name, namelen, value);
 	}
-	if (!strcmp(subkey, ".cmd")) {
+	if (!strcmp(subkey, "cmd")) {
 		if (!value)
 			return config_error_nonbool(var);
-		return add_man_viewer_cmd(name, subkey - name, value);
+		return add_man_viewer_cmd(name, namelen, value);
 	}
 
 	return 0;
-- 
1.8.0.2.15.g815dc66
