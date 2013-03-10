From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Sun, 10 Mar 2013 17:58:57 +0100
Message-ID: <20130310165857.GC1136@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 17:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEjao-0006HS-VA
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 17:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab3CJQ67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 12:58:59 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:37437 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab3CJQ67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 12:58:59 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UEjaM-0002q5-1h; Sun, 10 Mar 2013 17:58:58 +0100
Content-Disposition: inline
In-Reply-To: <20130310165642.GA1136@sandbox-ub.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217813>

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
