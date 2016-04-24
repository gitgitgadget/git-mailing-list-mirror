From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 63/83] builtin/apply: make apply_all_patches() return -1 on error
Date: Sun, 24 Apr 2016 15:34:03 +0200
Message-ID: <1461504863-15946-64-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDj-0000Mv-1p
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbcDXNgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:20 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36703 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbcDXNgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:15 -0400
Received: by mail-wm0-f49.google.com with SMTP id v188so69575989wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+kRMptTe7ncW7WCL21/Tltzv7VafWqmsyX/imuFly8A=;
        b=B3g/g1n2MWJIVVsBUtgSQCmfZSzeqUrauchOTIn/ad8jF3Y3Bu4w3wfwkOUimfEQqt
         YUTh6ssaqkGFXh+J6a9rQ8GO2KxECGYt+qLQL37WGqEYAWWoBRREsZQdyORfDD6I9QD0
         Vz736LtxxtINSsl0UNjXoaipXrkYXIH44uR5QyozhNmkXoSAzygZcgDby0IzqTjN/ATF
         yp1GDQA2GSYo5pHSWKhrU1L241nxUEAna0Dqsnk3CbCG2xmKaaeY4AbKGhFnlKhbqLy5
         nJMEypRWccxmT3v2KI7rKRaMizZHY5I/eFCVBSH5kbMbivch9ViO6wfrI8OZOsNa+oJ9
         dNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+kRMptTe7ncW7WCL21/Tltzv7VafWqmsyX/imuFly8A=;
        b=f8MoTDhSlAuIpGu40SbCtl5v3QZMWS0r0W2RZGGPa4FldRqFKr6TUUaU9TC3Ulp9xF
         +E9jRoigk5KJU099mv3+SDEw0SfuiD+pF3+C+EHPzHEwQ5vbAvJdDb31frJ9zdFnSs1Q
         UYuSEtaZz/kXbcyR3cZ6498llp6drYyjs4Sh47pyeNd9ZE4vmv786ZRDvJZLh/FZSMgG
         vVDgwnbkO0NG+FIlpyJbc4wCCo6fRbmxFgNAtzYWA+WiZqfBILfCr7mmNtgTHwfCZcDT
         tCwvBA2Y+3Gc7nH+M1JxTd62i9fTt/+77Wdb1SreOETiLhSX8aaugiJsKmwvuQT1o659
         wjcA==
X-Gm-Message-State: AOPr4FUbI2G6zw6dVWH1/lC/1ZP5t2REyzfghMCSdxuIilRegkB7LS8X2r83/1dzSPWZFw==
X-Received: by 10.28.140.12 with SMTP id o12mr6852101wmd.19.1461504974404;
        Sun, 24 Apr 2016 06:36:14 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:13 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292368>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index eab5ae1..73247c7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4551,7 +4551,7 @@ static int apply_all_patches(struct apply_state *state,
 		if (!strcmp(arg, "-")) {
 			res = apply_patch(state, 0, "<stdin>", options);
 			if (res < 0)
-				exit(1);
+				return -1;
 			errs |= res;
 			read_stdin = 0;
 			continue;
@@ -4562,12 +4562,12 @@ static int apply_all_patches(struct apply_state *state,
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
-			die_errno(_("can't open patch '%s'"), arg);
+			return error(_("can't open patch '%s': %s"), arg, strerror(errno));
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
 		res = apply_patch(state, fd, arg, options);
 		if (res < 0)
-			exit(1);
+			return -1;
 		errs |= res;
 		close(fd);
 	}
@@ -4575,7 +4575,7 @@ static int apply_all_patches(struct apply_state *state,
 	if (read_stdin) {
 		res = apply_patch(state, 0, "<stdin>", options);
 		if (res < 0)
-			exit(1);
+			return -1;
 		errs |= res;
 	}
 
@@ -4590,10 +4590,10 @@ static int apply_all_patches(struct apply_state *state,
 				squelched);
 		}
 		if (state->ws_error_action == die_on_ws_error)
-			die(Q_("%d line adds whitespace errors.",
-			       "%d lines add whitespace errors.",
-			       state->whitespace_error),
-			    state->whitespace_error);
+			return error(Q_("%d line adds whitespace errors.",
+					"%d lines add whitespace errors.",
+					state->whitespace_error),
+				     state->whitespace_error);
 		if (state->applied_after_fixing_ws && state->apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
@@ -4608,7 +4608,7 @@ static int apply_all_patches(struct apply_state *state,
 
 	if (state->update_index) {
 		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+			return error(_("Unable to write new index file"));
 	}
 
 	return !!errs;
@@ -4698,5 +4698,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	if (check_apply_state(&state, force_apply))
 		exit(1);
 
-	return apply_all_patches(&state, argc, argv, options);
+	if (apply_all_patches(&state, argc, argv, options))
+		exit(1);
+
+	return 0;
 }
-- 
2.8.1.300.g5fed0c0
