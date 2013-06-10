From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] config: refactor management of color.ui's default value
Date: Mon, 10 Jun 2013 16:26:08 +0200
Message-ID: <1370874369-30248-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 10 16:26:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um336-0005mF-0c
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab3FJO0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:26:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32779 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3FJO0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:26:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEQ9Rc016604
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:26:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Um32x-0001zR-6x; Mon, 10 Jun 2013 16:26:11 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Um32w-0007tE-PR; Mon, 10 Jun 2013 16:26:10 +0200
X-Mailer: git-send-email 1.8.3.rc3.8.g5e49f30
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 16:26:09 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227287>

The meaning of get_colorbool_found and get_diff_color_found is "the
config value if found, and -1 otherwise", but get_color_ui_found had a
slightly different meaning, as it has the value 0 (which corresponds to
the default value from the user point of view) when color.ui is unset.

Make get_color_ui_found default to -1, and make it explicit that 0 is the
default value when nothing else is found.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
This one is just a resend of what's already in pu.

 builtin/config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index 33c9bf9..057bb61 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -329,6 +329,7 @@ static int get_colorbool(int print)
 {
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
+	get_color_ui_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
 				given_config_file, respect_includes);
 
@@ -339,6 +340,10 @@ static int get_colorbool(int print)
 			get_colorbool_found = get_color_ui_found;
 	}
 
+	if (get_colorbool_found < 0)
+		/* default value if none found in config */
+		get_colorbool_found = 0;
+
 	get_colorbool_found = want_color(get_colorbool_found);
 
 	if (print) {
-- 
1.8.3.rc3.8.g5e49f30
