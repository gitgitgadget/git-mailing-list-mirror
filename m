Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D0C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEF16101A
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhIKDd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 23:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbhIKDd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 23:33:58 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FD9C061766
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b200so4876868iof.13
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fvAbbtx+C+ejpKOhyDhGT239iSdShPZs0EhgwvBNIk=;
        b=UBeFgLMKV17ic1XhTwAsnoI4Mc5OOWuM84ij187uJ/xMj40ddhh9FvRXM9wYVsZnlY
         cvGmWel811urwXq85c5Fdq0kFerhEaObYQBpwMy1+a9UJJ28D3yPOH8nubYWq5o9YDXc
         jT9uhKX1YUnlQ/BDhf19wo5q+g+Q+NSX56u5OOdvuttiSjQx2KcL2BsekxhFwltISUOs
         zUA2JvivUFyi6HUAyZkp7kLw3/VfJs1rBUaY8mM7eWWBxRAY8UHJM5VrZ34VAx55brDl
         vX8eimlLtWRqA07rjuoqc6L8lawcOg+HkkJluNV1ap0xKNRJb3snEy6s8RK1zzETIJgt
         Lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fvAbbtx+C+ejpKOhyDhGT239iSdShPZs0EhgwvBNIk=;
        b=OjF0j1oyjyqzGCsnXuqF0Z5nsQfNEk3EZrJ2ZnePOi++75XmmvhaL9CCISnV0Vl5S9
         q99EpjKDEAPRsn+U/5d2MnIwgCQd2K2MENxyeyWE9/ZJ//ciEChawd78Hk72S32fY1R1
         Zm9NU8FSx85MC8gMji9YQV3YAKN5vXIqUujCTXbAE0+DxlPUGmysscChgN0Dg3hOez5t
         MSQduAz4+5NgCZIuL2COtdXnrTl5i2M/tFwORqhTPlBvfPUnweK+Vv+LPPgaD1b16IsP
         RZNGFRE2pQ97mzAYZY3uQABgIPXWtN638e9AEhzQ6iRljSKJuqk90TjTLOf+LA+Fc4pw
         /tKA==
X-Gm-Message-State: AOAM532sTkuMk0ma3NSUTRjcGo6+HyNIuPWdV/ArzimTj7HDBBbVbBVT
        B44jOhp7q4abCYWxHGYzJ41Z7apia4Y/34+N
X-Google-Smtp-Source: ABdhPJzRRFRhwyXV9bXYqHwivMWn8UKGi6MD0t8eG3q3FYkpJxk51YA286bBHutS2nVU+q33IAiCuA==
X-Received: by 2002:a05:6638:34a6:: with SMTP id t38mr793685jal.19.1631331163181;
        Fri, 10 Sep 2021 20:32:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x12sm298491ilm.56.2021.09.10.20.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:32:42 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:32:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 5/8] builtin/repack.c: extract showing progress to a variable
Message-ID: <aceb443ea966162309d4dd40651e4d5c48959b46.1631331139.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631331139.git.me@ttaylorr.com>
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

