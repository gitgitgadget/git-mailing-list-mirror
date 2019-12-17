Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0B0C2D0D1
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AF8207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIMnsFHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfLQMBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:49 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38358 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfLQMBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:49 -0500
Received: by mail-pf1-f173.google.com with SMTP id x185so7429579pfc.5
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nKs31bKPqqpEQn/St9HoqdzIChP8ZAjPesmnkKK5QN4=;
        b=FIMnsFHlpUq+uONkRdwyVVk/jpf6YT7Mj+FrIVXoLk1R6k6L7cbb0AzmL0bPs/NF0c
         ibL0PmrMYuq5KakZgssszunMdU/b0uEa9lITY2x+VFH6XPpnGZ4GGJfLVB6LiYYgmmaR
         0COt8V9pyp0bcRp2iZvLiVu19Pn8/ivCJP45ASRWO/NN3YSS1FrU1bCOA2ChoE1OlOJK
         BiFNB9KZcyGXlPVadKXneny/e9tmtZN2fbq1T3cz1txDVk/tjsUQwj04QPFviAEKljCn
         H20sS5NOcZcNoBHhDPJLidWHf61Ry+07P/ogvLHe36mmXKJpWFT7mHNtVUcVt8KpLCIE
         6uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKs31bKPqqpEQn/St9HoqdzIChP8ZAjPesmnkKK5QN4=;
        b=WRSr1wWrPCIqRgnluKQZd7VCb0s6j89WBPiaVQ1ZzMQ1ANQPD8CIKJCLeNwvRTOwUK
         XvQNYFCvN5IjBfcHIwjhtzFsCaOGJN/xoLovhW5yScQzJ8Ojm7Xuy4ovc0dwXZccuuIS
         lv/jc3YLlJs6J4mvmiVZ/+aOfcDQkxyg0D0tOPitO5IDzYs3Q05msyskktACPqbA5T4o
         wnF+wYCsA73IfeAvtpRz4F+PWAiKVHT6quJx1z+MSICsfCqNnC9p17J7NaifYHgbgfqi
         0aKmexVOFJLUvk4W3WU97e/nsOB6mKvIU5hNN6K8WaJLWaZHxPUHTiYSlQpgBKolPoba
         AWHw==
X-Gm-Message-State: APjAAAX1YjIJhiK9jYa4lDrEPOQCE6FiZxloyRPSKD9yI/6l1270EE2O
        Fk1VMWOURKIcgTJy9stfz/Lv1Mll
X-Google-Smtp-Source: APXvYqx9HDaPPnKVZJaAOb9l+Bo5Pw0JTvVKiwpkkbiwkOjvAbJiRT6Or+L4loVYFt8q3DOz7+fB9g==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr24868272pgl.246.1576584108240;
        Tue, 17 Dec 2019 04:01:48 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:47 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 07/15] t0020: drop redirections to /dev/null
Date:   Tue, 17 Dec 2019 04:01:32 -0800
Message-Id: <d228dcfdc7d3f41c53a3813c52e56638cd8dd95e.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since output is silenced when running without `-v` and debugging output
is useful with `-v`, remove redirections to /dev/null as it is not
useful.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0020-crlf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 854da0ae16..8281babde0 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -5,7 +5,7 @@ test_description='CRLF conversion'
 . ./test-lib.sh
 
 has_cr() {
-	tr '\015' Q <"$1" | grep Q >/dev/null
+	tr '\015' Q <"$1" | grep Q
 }
 
 # add or remove CRs to disk file in-place
-- 
2.24.0.627.geba02921db

