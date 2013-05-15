From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] config: refactor management of color.ui's default value
Date: Wed, 15 May 2013 19:00:55 +0200
Message-ID: <1368637256-22622-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq61ykfang.fsf@grenoble-inp.fr>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 15 19:02:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucf5c-0002mF-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543Ab3EORB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:01:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60670 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759570Ab3EORB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:01:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4FH19es017627
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 19:01:10 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Ucf4i-0000Jj-5y; Wed, 15 May 2013 19:01:12 +0200
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Ucf4i-0005ta-2h; Wed, 15 May 2013 19:01:12 +0200
X-Mailer: git-send-email 1.8.3.rc1.315.g4602f33
In-Reply-To: <vpq61ykfang.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 15 May 2013 19:01:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FH19es017627
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1369242071.70935@1K/MLLUC5aVSg9VvZzZCmQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224425>

The meaning of get_colorbool_found and get_diff_color_found is "the
config value if found, and -1 otherwise", but get_color_ui_found had a
slightly different meaning, as it has the value 0 (which corresponds to
the default value from the user point of view) when color.ui is unset.

Make get_color_ui_found default to -1, and make it explicit that 0 is the
default value when nothing else is found.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
So, this is new, as suggested by Junio.

 builtin/config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index 000d27c..171bad7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -333,6 +333,7 @@ static int get_colorbool(int print)
 {
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
+	get_color_ui_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
 				given_config_file, given_config_blob,
 				respect_includes);
@@ -344,6 +345,10 @@ static int get_colorbool(int print)
 			get_colorbool_found = get_color_ui_found;
 	}
 
+	if (get_colorbool_found < 0)
+		/* default value if none found in config */
+		get_colorbool_found = 0;
+
 	get_colorbool_found = want_color(get_colorbool_found);
 
 	if (print) {
-- 
1.8.3.rc1.315.g4602f33
