Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E52320899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdHNVbV (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:31:21 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36275 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdHNVbT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:31:19 -0400
Received: by mail-pg0-f43.google.com with SMTP id i12so4032133pgr.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VSxurodUKrct9oajmcrb/ADgbGkXeTEq4j6YCSVl7IM=;
        b=LpN3lvj0Kz6r/rzymNdPM5CZEHkcQ8wa6vmPQkgGMhVoHkKDlGbE8nqxnWzLCc4VaA
         UBhQx/LeavDQWyzA+c8dXVfuf9MFVT+9lKJOq2syNY31j4bT83QA9Llvfyrq8iCNhL3e
         IL/p1/6qTvFtp30dqRq/+I7qv7k3PL9E6fj+kgt41BxULqudf6qqiqDfFWz67ndslGMf
         F/fQOUWFhdA+Fdbd4UCtxSWC1kuswLcUyjkycbT1tuEObMa7E1HhGBRyHpSlNLM/W4n/
         bCEoT1PJq2eR9xGTaRtpq6rdRgMuiwX4GboBeGjIBsSGY9GPHx+EdpldqmoRnA1WsTIk
         SCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VSxurodUKrct9oajmcrb/ADgbGkXeTEq4j6YCSVl7IM=;
        b=mgTBnqF7/xVlLtsij2QRplVZ5RkVvNMdC93osd2jOiJfAm+c7PVgwDwFkUKOjTFYU+
         C36AnfHQOES+R9Y3lQ3H7IvQMkj2JUrENwxEdNNOyoKUDDvyeEPYVDmUdSgdV3kFF5MT
         GYd22m4dPJ0u7MPGz1RtJ5gXhP0bqg2wmaWsI787hWDa5UpVeNSdsXqKqsJk4f/ClFeR
         yfUf1ubUtjNHEbDSuSVEcWM6U7AebZ6E61ORcC0stjgJ3TL0Nn1s7F4mQCBxJMeTpHtQ
         7gxIHbuEnkiDNsDa1Uw9NGp/Y+NBM1aNvSPDXogvxbDJPKvKnS4J4ngIYOSd1vY0QgB6
         MWNg==
X-Gm-Message-State: AHYfb5jp5p/sPdC2DgipXVU582aqwlc3H7eIhrdLC/EB6oi9piQdo+J2
        z5eCmaCQROcasIHCDlWtWQ==
X-Received: by 10.99.6.87 with SMTP id 84mr24933681pgg.426.1502746278589;
        Mon, 14 Aug 2017 14:31:18 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e63sm5570016pfc.24.2017.08.14.14.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 14:31:17 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 1/3] diff: avoid redundantly clearing a flag
Date:   Mon, 14 Aug 2017 14:31:10 -0700
Message-Id: <d199b62322a29e55a8ae21636aa7076231352ad7.1502745892.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502745892.git.jonathantanmy@google.com>
References: <cover.1502745892.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502745892.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502745892.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No code in diff.c sets DIFF_SYMBOL_MOVED_LINE except in
mark_color_as_moved(), so it is redundant to clear it for the current
line. Therefore, clear it only for previous lines.

This makes a refactoring in a subsequent patch easier.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 4af73a7e0..23311f9c0 100644
--- a/diff.c
+++ b/diff.c
@@ -898,7 +898,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (!match) {
 			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
 			    o->color_moved != COLOR_MOVED_PLAIN) {
-				for (i = 0; i < block_length + 1; i++) {
+				for (i = 1; i < block_length + 1; i++) {
 					l = &o->emitted_symbols->buf[n - i];
 					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
 				}
-- 
2.14.1.480.gb18f417b89-goog

