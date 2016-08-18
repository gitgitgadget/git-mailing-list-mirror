Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041741F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 13:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947171AbcHRNQk (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 09:16:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34701 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946738AbcHRNQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 09:16:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so5574325wma.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 06:16:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/qVP2iD6Su5plj2Vlw2p72T/gI1zUsZZWJuBt23DP4=;
        b=ON7ymfTW/Xn5Lq9pVXgQnRrpmsrY23ZTPNHhveznPHszT2aJQ6t35JisD0dTkHOedX
         Ecx4DGwPQVByA58jJgJaxZSXsoJppKM8CuZCrbpnh6JAID+fF9frkAwf1R3DDtcULrOt
         rqCCgPBeWd0mtpjTFK46KwOrf+99RnQvKapgN749TU3sKiT/sR3cbcZttp06tY6nbfpM
         JppHtEuMt25MxwsP0hyIKGlfmUALN3JxdLbnRm5oDRWm7JWhwxRpMnPSSS19wdNzmIkv
         BVsNQ9nqmI7p55xmcuEuNrD8+QFPxMuvr5tCn5Bx8AUq2tTfXRb/q94KLXE4zkmFHk16
         /R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/qVP2iD6Su5plj2Vlw2p72T/gI1zUsZZWJuBt23DP4=;
        b=BvYDhT6zxNe9M98TSd5tPGwb69oJfuIBcDnclmkb3tzNOZlDR3qbRxp0YUHWJTRzy4
         7+ezcpNipNOq1Hze9C1bnKuGgQ7QaLWM8Rv6dQcFL/yGe5sP8A9j2qxxDV09G+nmGh8m
         Rm816EjvafDApPGP2Vrtg/JW+A5cln/EIL//moB0zvWOBxjcaE0zXnQkErVtB1HDLUmm
         7Wxo9r66C+6jD4T1iuzPHA5KP7rfJIlHRF2Bp/X3R1SSMmqAKTnrJJOPt9/H+dfDizp7
         tvcecSS887gJtW/8yfP5tuA4hsEbPyKVhRTWXU5eREwele7bheO/4xvM+p9a4WOTtghR
         ZFXQ==
X-Gm-Message-State: AEkoouvfd8hN5Qx2eZNEptWU2O/QTJnz1nlibNe3QnutzegcHEPUGiMUvyQ8m/fV7OgvJA==
X-Received: by 10.194.187.134 with SMTP id fs6mr2086932wjc.3.1471526185050;
        Thu, 18 Aug 2016 06:16:25 -0700 (PDT)
Received: from localhost.localdomain ([80.215.38.200])
        by smtp.gmail.com with ESMTPSA id s6sm2225856wjm.25.2016.08.18.06.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 06:16:24 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] unpack-objects: add --max-input-size=<size> option
Date:	Thu, 18 Aug 2016 15:15:52 +0200
Message-Id: <20160818131553.22580-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.geb1f4c9.dirty
In-Reply-To: <20160818131553.22580-1-chriscool@tuxfamily.org>
References: <20160818131553.22580-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When receiving a pack-file, it can be useful to abort the
`git unpack-objects`, if the pack-file is too big.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-unpack-objects.txt | 3 +++
 builtin/unpack-objects.c             | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 3e887d1..b3de50d 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -44,6 +44,9 @@ OPTIONS
 --strict::
 	Don't write objects with broken content or links.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 172470b..4532aa0 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -19,6 +19,7 @@ static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]
 static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static git_SHA_CTX ctx;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
@@ -87,6 +88,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die(_("pack exceeds maximum allowed size"));
 }
 
 static void *get_data(unsigned long size)
@@ -550,6 +553,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				len = sizeof(*hdr);
 				continue;
 			}
+			if (skip_prefix(arg, "--max-input-size=", &arg)) {
+				max_input_size = strtoumax(arg, NULL, 10);
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
-- 
2.10.0.rc0.3.geb1f4c9.dirty

