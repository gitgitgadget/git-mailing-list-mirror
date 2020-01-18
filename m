Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105FAC33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA49324699
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+WvMkvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAROzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:55:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43743 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgAROzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 09:55:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so25752061qke.10
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Meauu3WNUUR2a+uruKM7Q3ZWnrqsAvwh+jHH/8uy3T4=;
        b=o+WvMkvMBR+pGy9b2JUV6vmW+2P7f6WTohsqPxgmS54c/nXzSi8yn1bTWa82F3LzHJ
         JKkZwWvy3liF7wmQFyiVg8CLSivRzWxtahAnCcrTwhutj76cLsSDNoUpcCuQ5lxS5hD6
         Mu3u5SKMCBbopvG8lBcH5fIU0sn5R/N4Bf5TS+F966OjDt5gMHCZUOJXs8/RI2QHfB9Y
         PXvZTmvq+2thjw+2rsSX3KrUrD1baT9EGDNEUAgHPoZH9BqSVFPLNnB0f5MCuPJgrn6g
         AqIdHUdi/KMMqwyrvq2UHwP5NyhiwuIYO9PrEas3rsLIkEpvqH7iUMfv/E2/vLneGA51
         DL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Meauu3WNUUR2a+uruKM7Q3ZWnrqsAvwh+jHH/8uy3T4=;
        b=Q4ReYv47f9T3gm2zJeQ/7WijasEv82AJEixApIK8NLsU/J21y11HezKx+baqXkLRSX
         EfZq37pfY6a7YqgiO8UfIm6I7B4GugItZjbwqLC8wPLeVQa7oI8141ptfPR1FnWWENXX
         qeXR/GBbdIGp+oEZ1U+BG2byDJQ6eC1PVFeReaoFArMZAQyOSU/cxBtJ80HrP9AIPpbM
         LsmS3dMWHkIsT3I2h95k1PXGFQbGCUFs78Llu+QNxHCOvMQvGisOnEoDW/ClCv0bhAxs
         41xCqKVJ1X1BVWlaRcNEdyijfSvj74uX7kEQud+amizr8/nF/qo/9mWucUkqhZIfK60T
         M1Jw==
X-Gm-Message-State: APjAAAX/GfSAmlpeXyqDPtp2R1BkstCNYxkPuSYQkmBai66up+iiUQfi
        70nnyWy/gZ9pO+sMzfN0L+k=
X-Google-Smtp-Source: APXvYqx36ZclptkBrUsFClqHVlmvIQkN+1+MhzyM/dVM2SFUbbA1NX6I20v1aDXG+nmQjVzBnEzn/g==
X-Received: by 2002:a37:de16:: with SMTP id h22mr38407977qkj.400.1579359315566;
        Sat, 18 Jan 2020 06:55:15 -0800 (PST)
Received: from eyalsoha.fios-router.home (pool-173-54-220-250.nwrknj.fios.verizon.net. [173.54.220.250])
        by smtp.gmail.com with ESMTPSA id i28sm15122250qtc.57.2020.01.18.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 06:55:14 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 3/3] color.c: Alias RGB colors 8-15 to aixterm colors
Date:   Sat, 18 Jan 2020 09:53:18 -0500
Message-Id: <20200118145318.5177-3-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.25.0.rc2.3.g8712c6e7f0
In-Reply-To: <20200118145318.5177-1-shawarmakarma@gmail.com>
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
 <20200118145318.5177-1-shawarmakarma@gmail.com>
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

