Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF0C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 22:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCFWiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCFWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 17:38:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FF2311DE
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 14:38:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w192-20020a25dfc9000000b009fe14931caaso12054239ybg.7
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142286;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ETjqA3ffoX9iUFr4nYH+y9OxRMsNhnp2L3jE5QtpO8=;
        b=tBY6RELty+9HMHvJ5nIx9Y33PD/pSItgOqGYP0Ao9Go8fa5mhF+h3LPFLL2E90DTOU
         lYdraMgW+I65/XkVG+/WfU2piSn+HVQTugZw5Y8i/LDI8v99RvAQO3/O3pNmv0HW7WBr
         jYn83NbfazJxOedq5Fvwdr3GTnt5UcT0KyTqjB/fLE9uL1iWZxUBf17AoaOPpKh/RT9a
         4aoV4PZU9Arxovqpve/WD1qSpHMs3Zn4+ORdpAEhjON9wjOxAxTZryOajUj7vRIIG9/f
         w+cyI+KhBCB4Ur8iX5TwslnAstzRdCMkGywdKVfbK1O1+l5G9ngIPUNKdh8RgdKrgFxD
         ORIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142286;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ETjqA3ffoX9iUFr4nYH+y9OxRMsNhnp2L3jE5QtpO8=;
        b=4SxOQ/aJHWev5Gr/UMjwC3MPsuHqJDu+pE1TiAEXsKW+edanmr9Z50V6IMhdx6uspC
         iyVnw6a4WeIkRNpQ6whA4jnlm9fxii6wMKpUh5nsiRf31v2PxxPNn1fllqV5cIdnNUlI
         aAZGs8w3wUT+J78S2nUez6hNwMVensrCh/SqsOur9d8/HBJ4Hox/duGcA+jeKWC6C53U
         CoCFhnVwZYreF2KD9r6mxa/zt/QNY3rYwzDvhbqj/wrPgm6ZFEN4OjutPU1t6xygxlGy
         tqc+r1kbwgWeMjCQ2J5l73g1/QiTUsoxWphK4x+Zq20gTvAQUVZsdVJ9L3JOOCw3OOlK
         lVBw==
X-Gm-Message-State: AO0yUKVbf6mYeEO4GtLqbt2u95eP3PfoqjpR7NG0FDGRdGsVexZYn9oN
        hTFG3EDZXcVoMY3zFfmGGct0G2GI5tNlLDkaR+0t
X-Google-Smtp-Source: AK7set+snEl6bFmBoeii99DJNKQoE0yuOMIS+yPBKsHc+0nQJKRPvbECRdQ//4VrB69AaC0HsaSWllCwrs1xs2mOp8Q1
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:ca0:bbfc:553e:f3c])
 (user=jonathantanmy job=sendgmr) by 2002:a81:1252:0:b0:521:daa4:d687 with
 SMTP id 79-20020a811252000000b00521daa4d687mr10144288yws.0.1678142286539;
 Mon, 06 Mar 2023 14:38:06 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:38:04 -0800
In-Reply-To: <kl6l356heeqb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306223804.3414251-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> By configset interface, I believe you mean the O(1) lookup functions
> like git_config_get_int() (which rely on the value being cached, but
> don't necessarily accept "struct config_set" as an arg)? I think that
> makes sense both from a performance and maintenance perspective.

Ah, yes. (More precisely, not the one where you call something like
repo_config(), passing a callback function that.)

> Given how painful it is to change the config_fn_t signature, I think it
> is important to get as right as possible the first time. After I sent
> this out, I thought of yet another possible config_fn_t signature
> (since most callbacks only need diagnostic information, we could pass
> "struct key_value_info" instead of the more privileged "struct
> config_reader"), but given how many functions we'd have to change, it
> seemed extremely difficult to even begin experimenting with this
> different signature.

Yeah, the first change is the hardest. I think passing it a single
struct (so, instead of key, value, data, reader, and then any future
fields we would need) to which we can add fields later would mean that
we wouldn't need any changes beyond the first, though.
