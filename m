From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 09/49] builtin/apply: move 'state' init into init_apply_state()
Date: Tue, 24 May 2016 10:10:46 +0200
Message-ID: <20160524081126.16973-10-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:16:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Vm-0002Hd-6T
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbcEXIQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:16:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33067 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbcEXIMA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so3638710wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AzOQUVE84rabkWCO6832UGa5oL9D624+/tbrH36IQ3I=;
        b=YoLxeCIlmOqxuJs0AqonK9VU7tfoU5gFZBOXIrMKKK3GZWs6itzYkfO5QmW1BV/HRm
         LtFfwK3qHbiieB7vny660jTPKCKLQ1aWXkxTNpxukJqW+N/yM5a8sf5GOFbZlhXmQVii
         4af8Imx4/drJ/X3JaLwmA6UtfK2feNYAjEC3xttLsSRrjdwijctzlr4Dj/x1z7JqAqyd
         5akFazBGhcU/PW5ZZ7Fxcj8jy/7mPM6kOj0lZhu1ll5/KYTR47ZG702m/ydRH9bqJ42j
         5P+OLfx5z3s/ykA0Xvz+R0ZgBMOHZ2K2YNy1m9TroiBjPgkiirl9tRh0gTblrxlZNOXm
         9p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AzOQUVE84rabkWCO6832UGa5oL9D624+/tbrH36IQ3I=;
        b=JDzC6ajRD4gznNLEbVNMnw/mwHiuvYj5cjxzr7fT10keByqENfS7mGZpmhJ61BxoQL
         JGkVNu2mxeQngVkiaxZSacqj0z+aincsZRsztzFJgkpQtHbXx1y/3bJdnpPYBG8/a05W
         uOhjJ3FY7aJk+NRbEfgtOqbvv1+fC9SSj+vsAFxk1wJ4IIOIGSw1X2Brw2zZlI6Qw2GB
         IKwOBzc37uvoA2OSHReAFwjLgiKWQLPNwYSoWdb048klMRMEwsgIt2EnNYwTvKn7DMuB
         HtatoJXjmM/h+Uo8wt8G177RpEMTgPLEpng/rrX3z+BDs/7rpzjCvsbdcFYLHsupHD9A
         vwpg==
X-Gm-Message-State: AOPr4FUjxo4lSlzCcnbN/mTsYaqEX1i7zGaIWtLvqC2XRizo2IAr2CQEEVk5W0gfuYxpRw==
X-Received: by 10.28.11.143 with SMTP id 137mr20295586wml.92.1464077518951;
        Tue, 24 May 2016 01:11:58 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:57 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295473>

When the apply functionality will be libified, the 'struct apply_state'
will be used by different pieces of code.

To properly initialize a 'struct apply_state', let's provide a nice
and easy to use init_apply_state() function.

Let's also provide clear_apply_state() to release memory used by
'struct apply_state' members, so that a 'struct apply_state' instance
can be easily reused without leaking memory.

Note that clear_apply_state() does nothing for now, but it will later.

While at it, let's rename 'prefix_' parameter to 'prefix'.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ae068e7..52b5d3e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4522,7 +4522,25 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-int cmd_apply(int argc, const char **argv, const char *prefix_)
+static void init_apply_state(struct apply_state *state, const char *prefix)
+{
+	memset(state, 0, sizeof(*state));
+	state->prefix = prefix;
+	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+
+	git_apply_config();
+	if (apply_default_whitespace)
+		parse_whitespace_option(apply_default_whitespace);
+	if (apply_default_ignorewhitespace)
+		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
+}
+
+static void clear_apply_state(struct apply_state *state)
+{
+	/* empty for now */
+}
+
+int cmd_apply(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int errs = 0;
@@ -4603,15 +4621,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_END()
 	};
 
-	memset(&state, 0, sizeof(state));
-	state.prefix = prefix_;
-	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
-
-	git_apply_config();
-	if (apply_default_whitespace)
-		parse_whitespace_option(apply_default_whitespace);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
+	init_apply_state(&state, prefix);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
@@ -4695,5 +4705,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			die(_("Unable to write new index file"));
 	}
 
+	clear_apply_state(&state);
+
 	return !!errs;
 }
-- 
2.8.3.443.gaeee61e
