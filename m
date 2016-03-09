From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 21/48] builtin/apply: move 'no-add' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:49 +0100
Message-ID: <1457545756-20616-22-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIE-00080C-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727AbcCIRxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:04 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38193 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699AbcCIRw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:56 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so81989247wml.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4aZckbRzJNcJkI2K7OGMvCJ4pbpd4PtgUCd6uvx0K0=;
        b=Logl2LAZtIHnG2OmIxnpQlp/nd6vB0t+atUsuUadAe66Q9DFsGKZnn9DcnQXLLoG9N
         qubf44d0Btl56T9OHsdbIf3FnXc0F+OBOTwiW2eeCtBtLYJzWxlBp4ER+DMTvbyHZrrz
         XumCecgROxO5CbHvXGNhwxYASNcUEK3ZJ2lqUPaouU2t+kj0+fe8rNeB4Ax1pw9lLbCV
         dYt87Ohl5swXZ2ujKOOOST1l7Jj3EGPQ8DLHtir6TwY6h+wQMiHBKxL/xYpuW4oCbIUL
         tqGMapaZcEsARbP0fPxwkajB5cIjgL6AlyG9qITbKwsnimZTfYLw9bcu7EZWXTE8Mwnk
         vVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u4aZckbRzJNcJkI2K7OGMvCJ4pbpd4PtgUCd6uvx0K0=;
        b=dUwQ9mLuuKb6v7/WOgu3ro/hnIHGSSBG6j+MlNQtKWBmPwDYA2DLKZDyO/DT4yRfdX
         qKn7cADEfBNKW4sdSseeHueYGW59+/jnHJDraJUTUrWl5WbV6Zs5Qn1Xx0wFPOoKVLEW
         +T6etP0KBN9phghS6R7x7kMZGngRpf19Tf+dxbz1HEPe2FtIX+S1cdsaHHcYIGFeA2Kl
         Mj0pkMCaxwYwYRc/8ON6k9r3iUH00gYWjRD04Y5t18f23ydk6FVyye+V/xR5Ly6jDTar
         V1uljiy2lby/mEgo6+KuZkPFI+E8Q9hpnqcW1lh6QnofvE0g1IkleNx2NU/1bin5wUzK
         J5Yw==
X-Gm-Message-State: AD7BkJJzOdI3661Q9fVoNBXmfuA+EIgeMVuJMFYAZKgxzjThsAH/7SoOaURiF93KfCjKig==
X-Received: by 10.194.22.97 with SMTP id c1mr36829436wjf.19.1457545975432;
        Wed, 09 Mar 2016 09:52:55 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:54 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288511>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fab731f..ae734cf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -44,6 +44,8 @@ struct apply_state {
 
 	int threeway;
 
+	int no_add;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -65,7 +67,6 @@ struct apply_state {
 static int p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int no_add;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -2798,7 +2799,7 @@ static int apply_one_fragment(struct apply_state *state,
 		/* Fall-through for ' ' */
 		case '+':
 			/* --no-add does not add new lines */
-			if (first == '+' && no_add)
+			if (first == '+' && state->no_add)
 				break;
 
 			start = newlines.len;
@@ -4593,7 +4594,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
-		OPT_BOOL(0, "no-add", &no_add,
+		OPT_BOOL(0, "no-add", &state.no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
-- 
2.8.0.rc1.49.gca61272
