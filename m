Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853FDC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648E961039
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbhJZVDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbhJZVDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:44 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80369C061220
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:20 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e144so1042548iof.3
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jH1fzBQ+o6N7ARCnMCP2GRXkwznvAiu34mObQxLor3A=;
        b=piQyJ56hShS7i5iGzOzT581L4iO6Bpf6oW4bkkoZcwskAkXOMi4UykTILF4i28Lpgx
         tC3PrETFAgcLd6QVX54bK5i3Uja9vbCHuFysPwaq/k/kp3zbGTntmlas8UM96s1zbSG8
         UFChXN2sKWhbtS11W9TuHU8hp6+HEd7VrEI6RuBY6jkieoW1196yvHPR4ITV2pZvpB/D
         FU+NbO4PgPL+2q/Zz7AiavmEwlSgYLZFny/7SGddJDWu6DQ4gaw4OKw6vaRxqvwkB5yC
         J+jfyyaqtwFuMYdwgiXYCTAYDHI8+Qu74pQzjx1MUB4G3HcVhAMpXpGI0BXHrm8nYvqG
         9Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jH1fzBQ+o6N7ARCnMCP2GRXkwznvAiu34mObQxLor3A=;
        b=HXj3B6IfXx+E4x95s7FXoEN2XMjfiZZXeBrno7bCg4BjKDZT9dhQvLTvgNKAFQDUdw
         4BSxvOOdi27XOZKK8n+D5RXVIUfhAGBrwL51189r9Yp334lNYDrAltKxBYnReRce/kBR
         gNN9DcfbAg4M3e9IlBwWXIx+pm2khRgtpSOSMUzzzDig1CLoJ9X71xvNd3ivWRdBFVBw
         OTXSHHMT1fYFvrDqYc4uAJWJ/bXoC9Ts0pTUkO3QCC7jXxJN2iWiW05sbXuK5pZ/wvCx
         /5bmAx0J1Rb5pZeP/HvWPrWnx7754eXTxzVtwWBn1zKvEIf4e5xQM0Q4eMjBQtWvSfnP
         MMVA==
X-Gm-Message-State: AOAM533Fc+Sn0NNxK5MUxbzXaWvTduPINKyyVZOKwh+FkMLIcVKOiDsq
        4MjfqfTVgFYyt/q7f2Mng+jRf+uEgM25rA==
X-Google-Smtp-Source: ABdhPJzaxAberHzwqGIGBXe9q3bgHoedaShUzPNidmIJhqbgOlLey3pxZ1Y5hqDMvxU2LUZAnFmr1A==
X-Received: by 2002:a05:6602:199:: with SMTP id m25mr16961242ioo.173.1635282079798;
        Tue, 26 Oct 2021 14:01:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z5sm10439606ile.42.2021.10.26.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:19 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 6/9] builtin/multi-pack-index.c: don't leak concatenated
 options
Message-ID: <0d252cd3239b9dca43fda37f7471b924440f6336.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `multi-pack-index` builtin dynamically allocates an array of
command-line option for each of its separate modes by calling
add_common_options() to concatante the common options with sub-command
specific ones.

Because this operation allocates a new array, we have to be careful to
remember to free it. We already do this in the repack and write
sub-commands, but verify and expire don't. Rectify this by calling
FREE_AND_NULL as the other modes do.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 075d15d706..4480ba3982 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -167,6 +167,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 		usage_with_options(builtin_multi_pack_index_verify_usage,
 				   options);
 
+	FREE_AND_NULL(options);
+
 	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
 }
 
@@ -191,6 +193,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 		usage_with_options(builtin_multi_pack_index_expire_usage,
 				   options);
 
+	FREE_AND_NULL(options);
+
 	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
 }
 
-- 
2.33.0.96.g73915697e6

