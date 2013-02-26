From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Tue, 26 Feb 2013 20:40:23 +0100
Message-ID: <20130226194023.GC22756@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQUc-0005oh-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743Ab3BZTqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:46:49 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:50349 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab3BZTqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:46:48 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UAQO0-0001cH-ED; Tue, 26 Feb 2013 20:40:24 +0100
Content-Disposition: inline
In-Reply-To: <20130226193050.GA22756@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217167>

The only location where cf is set in this file is in do_config_from().
This function has only one callsite which is config_from_file(). In
config_from_file() its ensured that the f member is set to non-zero.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 2c299dc..f55c43d 100644
--- a/config.c
+++ b/config.c
@@ -169,10 +169,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 static int get_next_char(void)
 {
 	int c;
-	FILE *f;
 
 	c = '\n';
-	if (cf && ((f = cf->f) != NULL)) {
+	if (cf) {
+		FILE *f = cf->f;
 		c = fgetc(f);
 		if (c == '\r') {
 			/* DOS like systems */
-- 
1.8.2.rc0.26.gf7384c5
