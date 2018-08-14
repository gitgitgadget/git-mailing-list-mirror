Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE051F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeHNE0h (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:37 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:41409 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE0h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:37 -0400
Received: by mail-qk0-f201.google.com with SMTP id w8-v6so18678497qkf.8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yb0WRLIFyu/I5F9V2PV1stGFbE+KKEMfWmcZ/S92L1g=;
        b=fHiFv2Uu7gmouF9PPOTgZxzGOTCu8nH2p3RyMpNJg4TMS+nS7Ppbxzh1Ude6UOy2L/
         Rkzq0iW41KfOHDOV8UnnG7VXQe82gpED+JajoQueNWe0C8zq28rgzG58mp4Utf+5zjWR
         EAKwLHU0B1owDwlikE3pqONHFe2q9zoImMjOZNzjM9VgiqjkTlcFZegelzvmSq7eC6/W
         QfTvmjcf83sKi+BatSnqQnWrkRB2Gc7iKyI8wEV72e+F0EUYi8zNuImRu4vMj7qRJHZq
         0OXln9ut37o3IOvto/U22hdi8fTfXcxRaFieR9NpkXtOjCTFo1QlXy8aAudX3Orue1yk
         Nlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yb0WRLIFyu/I5F9V2PV1stGFbE+KKEMfWmcZ/S92L1g=;
        b=ebAt9BvUC+E6dJI3REgLJmKgvb7y9hatTGgBankE8ottI2V41D52Rl6eWn5ts8WUhX
         JbdWSK03VAF6wcilCBCmvnN68uRYsA9zXaYtsrUzdLksHhefjmWSa84LabcdllYhRyBM
         Vh75p5Aoc6DqVEMjQt7eYagrBBsM6locRnUtfE6zRJU3BH46k3SdDhcscqNMDD8n4zxq
         J3ai4k3ctfOXkVujLJv1GP+Er1B47SQcxnLl8jdF+k7wJBkmxVecvWGEIdkdc+6kBWJ3
         EiBIx6XyUV/l56W34Dw4WgS0CTehSa/m4tEP+eS2mowurSvfRSSV0Uod9QECJJnuacgq
         6HWw==
X-Gm-Message-State: AOUpUlGAuz6n0uaV4mKkXsKaeSsJu3j0Dq/ZiJp4CEwYRO9jz+F76isj
        EPv1sfdw8hJw7QOrl0fyo+nrU9wF0nmC
X-Google-Smtp-Source: AA+uWPyyVMzRciUs1W5yVPYapSA7R7WDzRfv+fvbcaVQYghglWYWENTqHobCyMdccGYYkvAurSSd69WSkrRe
X-Received: by 2002:ac8:738a:: with SMTP id t10-v6mr11228066qtp.38.1534210905704;
 Mon, 13 Aug 2018 18:41:45 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:20 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 6/8] diff: use emit_line_0 once per line
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All lines that use emit_line_0 multiple times per line, are combined
into a single call to emit_line_0, making use of the 'set' argument.

We gain a little efficiency here, as we can omit emission of color and
accompanying reset if 'len == 0'.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                | 16 ++++++++--------
 t/t3206-range-diff.sh |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 4ef66389282..4f430f44e64 100644
--- a/diff.c
+++ b/diff.c
@@ -656,12 +656,14 @@ static void emit_line_0(struct diff_options *o,
 			fputs(set_sign, file);
 		if (first && !nofirst)
 			fputc(first, file);
-		if (set && set != set_sign) {
-			if (set_sign)
-				fputs(reset, file);
-			fputs(set, file);
+		if (len) {
+			if (set && set != set_sign) {
+				if (set_sign)
+					fputs(reset, file);
+				fputs(set, file);
+			}
+			fwrite(line, len, 1, file);
 		}
-		fwrite(line, len, 1, file);
 		fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
@@ -1207,9 +1209,7 @@ static void emit_line_ws_markup(struct diff_options *o,
 	if (!ws && !set_sign)
 		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
 	else if (!ws) {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
-		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 31f6458f961..7dc7c80a1de 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -151,7 +151,7 @@ test_expect_success 'dual-coloring' '
 	:         s/4/A/<RESET>
 	:     <RESET>
 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
-	:    <REVERSE><GREEN>+<RESET><BOLD><RESET>
+	:    <REVERSE><GREEN>+<RESET>
 	:     diff --git a/file b/file<RESET>
 	:    <RED> --- a/file<RESET>
 	:    <GREEN> +++ b/file<RESET>
-- 
2.18.0.865.gffc8e1a3cd6-goog

