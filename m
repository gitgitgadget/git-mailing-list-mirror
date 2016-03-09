From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 07/48] builtin/apply: move 'newfd' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:35 +0100
Message-ID: <1457545756-20616-8-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHb-0007Yw-2w
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933684AbcCIRwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:23 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36397 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933251AbcCIRwS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:18 -0500
Received: by mail-wm0-f42.google.com with SMTP id n186so190573756wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/LTfu/21CoVYlvjsCEFBuEsfJL1WjqbpzX1RziQKcsw=;
        b=RlPNqj8XMBgT4E4i2Fl3Q1gKfr0jCEYSUc/ycUtVnpfyEo52YUNIsl0udKf3O6/o9R
         4rFBkED98go3TRatetCSntHa+PXSLKSmTgbIIGmG/jLwCKCis0jUSGgtp1nOHUer8s3n
         yhyaBnTTDnYKeG8Quh56IMPpEByaCgyfOnCkNf4q2UK6ulb3nxlNOIWoF5V7DmyPS7YH
         K6JzXwqSqZrOoS7oelLoTWctIj3fhnETzUVuzhhKZOEXaJsTq8/ruB5vBoyQrQ3+hKbw
         xOF7rRCy/CHozDuyYSTlhDAf2E6VGBRDlEiPjW+CJIPOJGheCiOjTGLKkF8Ly+whj2DG
         Q17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/LTfu/21CoVYlvjsCEFBuEsfJL1WjqbpzX1RziQKcsw=;
        b=PBl166c0Gwmi1sWAPgNtourSrRgp/Hj2GlFHiy7TNt04QKqzsYjQOs/INRf8nY+lA1
         6jSx3p6cnyx6INv+Oe+4qVs4ogo3KZ/Tp2RwgCf8qu22yTJnsPFMBkDploWT5GQFLoaq
         XmsMNuAEy4Hpo/EkKiPd4tyaU7XPqJ8hYbm1NhYIFTPh+zTezpvKYDnxqDOcFh1rK6D3
         8H4HeeWE/abBlGUPNW2AtaMjihvT6HCN41mM5dsC06pryxB/ngdaQ9z4VLNAfCm7yI11
         kAgAK9+L8EoIHOYjwjQwDnGGk/3D4GFEaCGOWX6IILpj2iHrS++SgHDpkMvzNvETwAsM
         K4yw==
X-Gm-Message-State: AD7BkJIdyYvO1b1UP+S4qUi373ZtmZISgbn5e6pP0aIfwC6QEuf0uP9UYodZAJ+YyZn1Dw==
X-Received: by 10.28.105.136 with SMTP id z8mr27332306wmh.71.1457545937320;
        Wed, 09 Mar 2016 09:52:17 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:16 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288496>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 462e28f..d56dd9f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -24,6 +24,7 @@
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
+	int newfd;
 };
 
 /*
@@ -35,7 +36,6 @@ struct apply_state {
  *  --index updates the cache as well.
  *  --cached updates only the cache without ever touching the working tree.
  */
-static int newfd = -1;
 
 static int unidiff_zero;
 static int p_value = 1;
@@ -4425,8 +4425,8 @@ static int apply_patch(struct apply_state *state,
 		apply = 0;
 
 	update_index = check_index && apply;
-	if (update_index && newfd < 0)
-		newfd = hold_locked_index(&lock_file, 1);
+	if (update_index && state->newfd < 0)
+		state->newfd = hold_locked_index(&lock_file, 1);
 
 	if (check_index) {
 		if (read_cache() < 0)
@@ -4605,6 +4605,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	memset(&state, 0, sizeof(state));
 	state.prefix = prefix_;
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
+	state.newfd = -1;
 
 	git_apply_config();
 	if (apply_default_whitespace)
-- 
2.8.0.rc1.49.gca61272
