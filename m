Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920361F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbcHXSmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:42:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35029 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754899AbcHXSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:42:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id q11so906871qtb.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcaQ3wTzJm5cunabf/JR4Esgx4AEzLLnTNP5jMMQwk4=;
        b=AQYLzO8qO/BK3CtItheN++8FKmYNpUnN5Ophrl964004ya5MJaZM8WUAs+QJehHULk
         AKCHgw4lbp9LFp0yISxz5QbMf4KNJN8a24goX0+dFsoRhF6L+YV7jJgGG3Co0y+g4nC1
         IzSlBNxpZZ5C3lIkNDFtTm1yRpaq2MBqzkT8hV9xf1cYBTp49dAdrGjjYqambBPRTp2E
         AM+9LbpZED/6RPccQJdjgxk19QiHbvtjfdER0DqWgI6p1POfLxpKl6fDnBPc1mmFKxxd
         NJKqDc3krvsVVaDKSsNpYvQYwiFVFUQhjBn7FEFJnteGxtBhPe7iwGyfx9k0yjSGIvMf
         CV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fcaQ3wTzJm5cunabf/JR4Esgx4AEzLLnTNP5jMMQwk4=;
        b=MoAFxplWe3oItZH0rygekmWsxMLN5ix6M5EEaq8BCRTfXau4/yI4a2vispFszo4AZl
         a6QbkH5tabuxYBiDWv6H0CJJHgwOaUIII4eU13nVoRkcslEQRr1788SDDLDgzjoSrZEa
         4ul/ioUw/DzNesX1nb7p4DR1PH9ltYdlQ+LZiIAineHBo4z5/2TEW1+Ym7IttzLBFBGn
         amy4oIQDJcypJqVw6FfpMZDpH8FotxpGZbvbvVCEmOAeY1gCBYrsXPY+I0bgQFA+KD36
         w//iveE4j4mmkNq56B8jUH/+A9h+MxIkv3aHVVpzyrTXsfvK2CXCi8xedGD+jmQzQVWC
         dQSg==
X-Gm-Message-State: AE9vXwOYhPOTzcKsk65xeECc4ADnCovnlGRFrZRn7aTQDMqMYjpy7mict+2ppupeFo2PNA==
X-Received: by 10.200.46.122 with SMTP id s55mr5423059qta.80.1472064132873;
        Wed, 24 Aug 2016 11:42:12 -0700 (PDT)
Received: from christian-Latitude-E6330.event.rightround.com ([75.98.193.200])
        by smtp.gmail.com with ESMTPSA id k20sm5412874qkl.2.2016.08.24.11.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Aug 2016 11:42:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/3] index-pack: add --max-input-size=<size> option
Date:   Wed, 24 Aug 2016 20:41:55 +0200
Message-Id: <20160824184157.19264-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc1.3.g93be2b9
In-Reply-To: <20160824184157.19264-1-chriscool@tuxfamily.org>
References: <20160824184157.19264-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When receiving a pack-file, it can be useful to abort the
`git index-pack`, if the pack-file is too big.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-index-pack.txt | 2 ++
 builtin/index-pack.c             | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7a4e055..1b4b65d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -87,6 +87,8 @@ OPTIONS
 	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and use maximum 3 threads.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
 
 Note
 ----
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1d2ea58..4a8b4ae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -87,6 +87,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
@@ -297,6 +298,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die(_("pack too large for current definition of off_t"));
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die(_("pack exceeds maximum allowed size"));
 }
 
 static const char *open_pack_file(const char *pack_name)
@@ -1714,6 +1717,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					opts.off32_limit = strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
+			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
+				max_input_size = strtoumax(arg, NULL, 10);
 			} else
 				usage(index_pack_usage);
 			continue;
-- 
2.10.0.rc1.3.g93be2b9

