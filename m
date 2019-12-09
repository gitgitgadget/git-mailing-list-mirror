Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD5DC00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF742073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx0lFbm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfLINKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:10:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42280 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLINKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 08:10:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so7209334pfz.9
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 05:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ipfdo+UXPxR2f8Y3Obo0/L+qz+o3GhaT2oHjHu83tnk=;
        b=Mx0lFbm3lYpE+3qyf9izf6vZmGX0Chxe+rIBeIkP7ZD+GFxy0llQ+CfgBZl1sceOmu
         z5tBMiiXMTTQ8Rq5IDcwvjtiQkWu12jUC6IkSMqog8Q5gx3UlzW3kpAkKnksbJ5rr2/E
         y6wHycIJInk31jRVePoooWEpYd3ev3Dm0Cjml82HUVhvfPwizby9O11/ePiw6gTDaoZG
         OI//q1SuMLrRfg6mOmyOZZaXTL3Kp2sujENN2Fmi5dc25OIuvPO/7CJBofDyfw6TC9c0
         XrgtPUeiGUXALdKgXUh6urjeoeW5AnEw7d9ZiCYgZF1/3R24mcJu4jtWeXafr2MpyySh
         aQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ipfdo+UXPxR2f8Y3Obo0/L+qz+o3GhaT2oHjHu83tnk=;
        b=J96dNltxaNnU6RGxER2w/7v6iH+5RdSJjZAJCMmscm3nfE29f9WWfPLSorsjqoa9wY
         V1hLqQR6BzS2w/GJGSNI1HvUqHbyc2FPcz1wd4SoEKUbrb/LNj9nlVJAvrZPWG5sN59B
         zZ4BAOMa+8UiteGc77cj7U5XLtHVbEmFKwhzDdq8Ebq7mQiQtm69yuw/SgiSu9k3rVMN
         K/XFhIx2nunKjALQwNPXakhHNfpRqxzGVY1U6A+gX42HTqh82gykuvwNTxcTzjvWW0bM
         6m0vPT7WJ8Fhf6kTE4C63/TjIAEdlcsH1CoAwJ2aEJuw6aT6qtTCDP++2x/wiN2omPpN
         jt+w==
X-Gm-Message-State: APjAAAXYOgduNPVmQbnWp1Gd7l6hzoPIIwJ/41Wc3xxefTxMwV4HqT49
        4J2xErXdJWmyrCC64PVMDFQ1PLno
X-Google-Smtp-Source: APXvYqw3U2pj9jsYcvvp3r0PjrGQrnoQdgR8dwaQFmLD4oGRUu3uwmejTbF9G6BTf2xC6FFlreR39g==
X-Received: by 2002:a62:bd08:: with SMTP id a8mr29101226pff.84.1575897048413;
        Mon, 09 Dec 2019 05:10:48 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id r14sm27452280pfh.10.2019.12.09.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:10:48 -0800 (PST)
Date:   Mon, 9 Dec 2019 05:10:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH 4/5] format-patch: use --notes behavior for format.notes
Message-ID: <67c88a37d24c5481ff0fcc314368ad20c5ce65e4.1575896661.git.liu.denton@gmail.com>
References: <cover.1575896661.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575896661.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we had multiple `format.notes` config values where we had `<ref1>`,
`false`, `<ref2>` (in that order), then we would print out the notes for
both `<ref1>` and `<ref2>`. This doesn't make sense, however, since we
parse the config in a top-down manner and a `false` should be able to
override previous configurations, just like how `--no-notes` will
override previous `--notes`.

Duplicate the logic that handles the `--[no-]notes[=]` option to
`format.notes` for consistency. As a result, when parsing the config
from top to bottom, `format.notes = true` will behave like `--notes`,
`format.notes = <ref>` will behave like `--notes=<ref>` and
`format.notes = false` will behave like `--no-notes`.

This change isn't strictly backwards compatible but since it is an edge
case where a sane user would not mix notes refs with `false` and this
feature is relatively new (released only in v2.23.0), this change should
be harmless.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c           | 13 +------------
 t/t4014-format-patch.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 622d6a6cb1..1f0405f72b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -867,19 +867,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "format.notes")) {
-		struct strbuf buf = STRBUF_INIT;
 		int b = git_parse_maybe_bool(value);
-		if (!b)
-			return 0;
-		rev->show_notes = 1;
-		if (b < 0) {
-			strbuf_addstr(&buf, value);
-			expand_notes_ref(&buf);
-			string_list_append(&rev->notes_opt.extra_notes_refs,
-					strbuf_detach(&buf, NULL));
-		} else {
-			rev->notes_opt.use_default_notes = 1;
-		}
+		rev->show_notes = set_display_notes(&rev->notes_opt, b, b < 0 ? value : NULL);
 		return 0;
 	}
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 4d5719fe2c..5c40ea4397 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -808,6 +808,38 @@ test_expect_success 'format-patch with multiple notes refs' '
 	! grep "this is note 2" out
 '
 
+test_expect_success 'format-patch with multiple notes refs in config' '
+	test_when_finished "test_unconfig format.notes" &&
+
+	git notes --ref note1 add -m "this is note 1" HEAD &&
+	test_when_finished git notes --ref note1 remove HEAD &&
+	git notes --ref note2 add -m "this is note 2" HEAD &&
+	test_when_finished git notes --ref note2 remove HEAD &&
+
+	git config format.notes note1 &&
+	git format-patch -1 --stdout >out &&
+	grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git config format.notes note2 &&
+	git format-patch -1 --stdout >out &&
+	! grep "this is note 1" out &&
+	grep "this is note 2" out &&
+	git config --add format.notes note1 &&
+	git format-patch -1 --stdout >out &&
+	grep "this is note 1" out &&
+	grep "this is note 2" out &&
+
+	git config --replace-all format.notes note1 &&
+	git config --add format.notes false &&
+	git format-patch -1 --stdout >out &&
+	! grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git config --add format.notes note2 &&
+	git format-patch -1 --stdout >out &&
+	! grep "this is note 1" out &&
+	grep "this is note 2" out
+'
+
 echo "fatal: --name-only does not make sense" > expect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
-- 
2.24.0.627.geba02921db

