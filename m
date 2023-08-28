Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603BC71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjH1WtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjH1WtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:49:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103B11A
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:07 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-591ba8bd094so44269427b3.3
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693262945; x=1693867745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSdw4I7fJJKJgYsOxrr5RSYCOCmBu47Cyk4PipGiC34=;
        b=mid77yEexKir27PkJZJV+4qYm8yxJoYUf+Zf5XtVRjWjUPFPXK/S9Bns0QMaVGWG5U
         ebLS5XoLNiUk9pGIpc0/UbviPKBZ9Phny1J1Gx8OFQGoO0k6IM6nRbhMqYC0rDflmULe
         NpKXjtykz/wKn25GmEsHIHo5XazPIJWs3rrou6/GR1T4/7/BPbpZgoMA3m3w5u/urtNd
         e8D50lQzDxgsB+HoE/ACXe1a31tBzPqWnJ+dNfAUwgV/rZVSPl7N5ZGtMZ8ufBXTBHKP
         nIpinhZAQ1shRH08qiw3MYzpA6hvvrzxopi87k3O3MobVwkamup5rduLUfN902I0P5fo
         6gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262945; x=1693867745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSdw4I7fJJKJgYsOxrr5RSYCOCmBu47Cyk4PipGiC34=;
        b=VYIWGOHkuQdSbOAEQEEyRvuEUrL9bODQk9OKw8d+ak1ORFVCnujIL1eti79IKz/TCc
         Y7BdqNj0f5QNn0s9a0RwlMSTdNHyE909O5MvgFDryd+SvpOcOqHjML4InQolwlm1+l9P
         pX4b14S9KaXJzd2995876Y/ZCvrc3zaAf36+Ejw48mssLdmVdLMy9IpBQ9qB6JIyD8yL
         FHqXTN1urDvpr6Lc2ehFvEFSOBs4kDq6uR1JxJmLic3BdM4dH0x8lFXr3M+TqUgaKrcQ
         hniNi80s20ZlsQVvltBjw13Gmu+yzn6ekia0n3MSatJ134K3m/xn5UVdJvY4jS4d2oxt
         ucIw==
X-Gm-Message-State: AOJu0Yz4+f5WDzOJY702n0JTI2QEjFivm8dqhLLrAySqy/u/GQzmGOzo
        S4iw+9cm9QMhwmapzB43WVyOYiHqkyph/+COPjmjIQ==
X-Google-Smtp-Source: AGHT+IGUP2yJMuJtSzw9VAtZ0xgL56nl2Ayy1wEELm6YGZ5hL9lk2FYM3CNjKskPYka4aCtZlKfpYg==
X-Received: by 2002:a0d:eb10:0:b0:586:c0bc:77a2 with SMTP id u16-20020a0deb10000000b00586c0bc77a2mr28500663ywe.0.1693262945695;
        Mon, 28 Aug 2023 15:49:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j125-20020a0df983000000b005772abf6234sm2430356ywf.11.2023.08.28.15.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:49:05 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:49:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/4] builtin/pack-objects.c: remove unnecessary strbuf_reset()
Message-ID: <921a79c8bd6ab688fb9f403a59eeaed3176b630e.1693262936.git.me@ttaylorr.com>
References: <cover.1693262936.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693262936.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading input with the `--cruft` option, `git pack-objects` reads
each line into a strbuf, and then moves it to either the list of
discarded or fresh packs, depending on whether or not the input line
starts with a '-' character.

At the beginning of each loop iteration, the next line of input is read
with `strbuf_getline()`, which calls `strbuf_reset()` (as a part of
`strbuf_getwholeline()`) before reading the next line of input.

Thus, the call to `strbuf_reset()` (added back in b757353676
(builtin/pack-objects.c: --cruft without expiration, 2022-05-20)) at the
end of the loop is unnecessary, so let's remove it accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d2a162d528..868efe7e0f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3603,7 +3603,6 @@ static void read_cruft_objects(void)
 			string_list_append(&discard_packs, buf.buf + 1);
 		else
 			string_list_append(&fresh_packs, buf.buf);
-		strbuf_reset(&buf);
 	}
 
 	string_list_sort(&discard_packs);
-- 
2.42.0.49.g03c54e21ee

