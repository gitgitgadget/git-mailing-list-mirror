From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/7] parse-options: add parse_options_concat() to concat
	options
Date: Sat, 06 Mar 2010 21:34:40 +0100
Message-ID: <20100306203447.2960.38015.chriscool@tuxfamily.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:28:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No6EA-0003Eu-Dr
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0CGC1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:27:54 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45468 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374Ab0CGC1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:27:47 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CC84C81808C;
	Sun,  7 Mar 2010 03:27:38 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 90638818047;
	Sun,  7 Mar 2010 03:27:35 +0100 (CET)
X-git-sha1: b3936b2836ba6d3ca2821e106359d1d63736291b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141641>

From: Junio C Hamano <gitster@pobox.com>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 parse-options.c |   15 +++++++++++++++
 parse-options.h |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c83035d..8546d85 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -659,3 +659,18 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 	*target = unset ? 2 : 1;
 	return 0;
 }
+
+int parse_options_concat(struct option *dst, size_t dst_size, struct option *src)
+{
+	int i, j;
+
+	for (i = 0; i < dst_size; i++)
+		if (dst[i].type == OPTION_END)
+			break;
+	for (j = 0; i < dst_size; i++, j++) {
+		dst[i] = src[j];
+		if (src[j].type == OPTION_END)
+			return 0;
+	}
+	return -1;
+}
diff --git a/parse-options.h b/parse-options.h
index 9429f7e..7581e93 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -187,6 +187,7 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
+extern int parse_options_concat(struct option *dst, size_t, struct option *src);
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
-- 
1.7.0.1.307.g861f4
