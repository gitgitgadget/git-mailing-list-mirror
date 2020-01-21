Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76816C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476E521569
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfp+RbCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAUQ5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:57:04 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36163 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQ5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 11:57:04 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so1842872pjb.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Meauu3WNUUR2a+uruKM7Q3ZWnrqsAvwh+jHH/8uy3T4=;
        b=tfp+RbCASnsgjMow9mTxt75Y/NEPtcxJr0Z8cu5qc5Gjbm3T0JMemIPu3AiaP2E58S
         llf6da4K2ntT8nq2/6WzoB7SAdWgitQ24Hs+uIq3IPvYeA7ROIvN3cqwUYAQat303Z3s
         FHK+6NaSYmKfwDHgmDuW4z+n1AwOUwSPxWyo+Mmc8+cGbuJ3cQyWRFyB5VUz8W+mhl3F
         5V2wwj1xvpg9jEsMKQbg8KxT/YiN+uqP41GD+4TfqgGBhrrBy/EQKTi+vEAdGTarV0H4
         JjG41cpmBIFEic4KmS7V3cXvLWx5VoMYhYqbGTmGelPVmFPnco3JiJ/ciXgDjfkw6joz
         0bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Meauu3WNUUR2a+uruKM7Q3ZWnrqsAvwh+jHH/8uy3T4=;
        b=N0GV+Gh5Px6MQdwTfEpmlGH0gI23Enkm+Az4quVoUZAw8HjAlua5UYmxrsjaCW82Ja
         np72FUgJQFPP0G6Be5E4Oe0vCUYm3/hM+4XJB+Ygz+BDJPdUhc2SG07NgtvKAEO4tfoN
         WArLs/g5TtsGqhZCfwSrJZFoiFxKIEzAy91OyGsD/yC/RR+eSesOS0sOSMdtWFmUq23R
         UfLPorIrThlhNuy+6XXaIbx520MEkzg2OHJCHpFRteLZgZs8kKhTZEo0486P7FDxoiSP
         EYCJvPHBmUqjAxm28kWkCTIkUMvy6CgOyLmRUpcfzqcx0x9h47/o/ToFcoXYl8BIoFov
         6FTg==
X-Gm-Message-State: APjAAAX2J2AcXRhZrJJ5w401D5BbtdtgZ8ykPu0Z2SIjTwQwEQOcyse5
        83lzwDHFxaTRaYQ5LcuYYMQ=
X-Google-Smtp-Source: APXvYqw/K2kd93sAjfVEu7asIhKgEArXn3Q7g/PN27inva3bRaNr62jN7PVqOotZDneqywtYw7B7sg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr5887221plp.252.1579625823362;
        Tue, 21 Jan 2020 08:57:03 -0800 (PST)
Received: from eyalsoha.corp.google.com ([2620:0:1000:5e10:e008:c42d:32e0:39dc])
        by smtp.gmail.com with ESMTPSA id r66sm45688491pfc.74.2020.01.21.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:57:02 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 3/3] color.c: alias RGB colors 8-15 to aixterm colors
Date:   Tue, 21 Jan 2020 08:56:23 -0800
Message-Id: <20200121165623.151880-3-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.25.0.rc2.3.g8712c6e7f0
In-Reply-To: <20200121165623.151880-1-shawarmakarma@gmail.com>
References: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
 <20200121165623.151880-1-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This results in shorter output, and is _probably_ more portable. There
is at least one environment (GitHub Actions) which supports 16-color
mode but not 256-color mode. It's possible there are environments
which go the other way, but it seems unlikely.

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
---
 color.c          | 7 ++++++-
 t/t4026-color.sh | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/color.c b/color.c
index 66d32e1191..ba067ed97a 100644
--- a/color.c
+++ b/color.c
@@ -136,11 +136,16 @@ static int parse_color(struct color *out, const char *name, int len)
 		else if (val < 0) {
 			out->type = COLOR_NORMAL;
 			return 0;
-		/* Rewrite low numbers as more-portable standard colors. */
+		/* Rewrite 0-7 as more-portable standard colors. */
 		} else if (val < 8) {
 			out->type = COLOR_ANSI;
 			out->value = val + COLOR_FOREGROUND_ANSI;
 			return 0;
+		/* Rewrite 8-15 as more-portable aixterm colors. */
+		} else if (val < 16) {
+			out->type = COLOR_ANSI;
+			out->value = val - 8 + COLOR_FOREGROUND_BRIGHT_ANSI;
+			return 0;
 		} else if (val < 256) {
 			out->type = COLOR_256;
 			out->value = val;
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 78c69de90a..c0b642c1ab 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -82,6 +82,10 @@ test_expect_success '0-7 are aliases for basic ANSI color names' '
 	color "0 7" "[30;47m"
 '
 
+test_expect_success '8-15 are aliases for aixterm color names' '
+	color "12 13" "[94;105m"
+'
+
 test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
-- 
2.25.0.rc2.3.g8712c6e7f0

