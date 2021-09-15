Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A15C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2347060EFF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhIOS0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhIOS0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:26:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEC2C0613C1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:47 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d11so38163ilc.8
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fvAbbtx+C+ejpKOhyDhGT239iSdShPZs0EhgwvBNIk=;
        b=BrWRa2IrYVvjC8uVU/QNE19cqRCa7R/CM5J7SI+aP5KREreOnnY9OOVq3TNI8rEEAw
         lqE+Mrdg03OvfcDT4r6i1bZVtdpAlZY6hBBwv0q7deABWi4YxZipbOys1Ip9unU/sbeX
         1eluBwDX9k2yqZBpqHIivVe/sTqmMomfl9HMsa0o2BULuVOMgukDJefx82VaEDJ5WLcF
         6b0UQVGvoEa8Hpr50IA609WBwe4YWIPchHeVSwnqSA66+0YYqAvmgPPd5T82LrcWlSCj
         zA/Hjx7n4iYf2ZB2S1FmM5ogS04uOngxVzyScmKhRSRZaWbAZI+rViKtadwDP5WB0Iz7
         NioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fvAbbtx+C+ejpKOhyDhGT239iSdShPZs0EhgwvBNIk=;
        b=8Fw15MR7MBX1FO5brHTNowTr1C+iALaQCKGQWqiVpmRF/qvS83+nerYN0Crs4khzsA
         boVWKjNNSAqXvMYrnzjcYeyZAVkGMiHdCsgRnJKH9Ffm1FvLI9hmGeqizi8dJYdX2YXT
         BobY7Tvbml6H1vNDsCnD6mMkkKhS6MCeKxCEmQ2qwYeSilnA8VOaOzRgdzn0yD4PNYkR
         VD/wR3T7u6gATnvHjgPS4z4Ig7qc1ZvQ6fzZbjL4F01kpL2lQWd5y22oAIlw/QdSd66h
         4EcCCFTL7ADDuFPDR6AQV4y6MRavrTDGl+wlxl5U+lvQw51ShQVFZT9ZCekvjCL+l/mw
         u4Tg==
X-Gm-Message-State: AOAM5334572/ktnLqSnUKUHwbm8sEJ1rSf6Ov2YH8KANd7JmbeMSHTiQ
        guuxBcObW6PReyy+UzQ99jy5r9NJJ2rIqAws
X-Google-Smtp-Source: ABdhPJwZHdMhtL0HGq2uNER1TQPj3whngAVOmCchSmJDF6LHFpgd+MbXRKDBWlmU/kdHEnAVXSt8Hg==
X-Received: by 2002:a05:6e02:13d4:: with SMTP id v20mr1062893ilj.247.1631730286343;
        Wed, 15 Sep 2021 11:24:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i20sm321899ila.62.2021.09.15.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:46 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 5/8] builtin/repack.c: extract showing progress to a
 variable
Message-ID: <09de03de475d9bd38fa1ce500c45df6c40694cbf.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only ask whether stderr is a tty before calling
'prune_packed_objects()', but the subsequent patch will add another use.

Extract this check into a variable so that both can use it without
having to call 'isatty()' twice.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index e55a650de5..be470546e6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -445,6 +445,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct strbuf line = STRBUF_INIT;
 	int i, ext, ret;
 	FILE *out;
+	int show_progress = isatty(2);
 
 	/* variables to be filled by option parsing */
 	int pack_everything = 0;
@@ -718,7 +719,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			}
 			strbuf_release(&buf);
 		}
-		if (!po_args.quiet && isatty(2))
+		if (!po_args.quiet && show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
 
-- 
2.33.0.96.g73915697e6

