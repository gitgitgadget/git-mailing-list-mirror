Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64BC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 17:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiF0RKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbiF0RKf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 13:10:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810E18E16
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:10:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x20so3132095plx.6
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrHmg+KfmJOWCkb8a7JmIe7QuCwUcCbApoh2QBJ0Drc=;
        b=pgJJA9lnf1hpKozEkwFGzHW9P6ZzxjAtx+cYHxcHnTOUFdmI1oemFaleMG4ReewpCX
         M0ZyubkfxF62khGIFOM+T0dgyR+FY0zF4GH1Mt/yqilgLq60VyxbfQOGO7/9HPBSnM7M
         4mY0chHk2Q0ZCHFrAbIqHj7SSjBeR4gdcAojSyhOXNqxd8mSGK7RM7m7ggcY5l4TKB9c
         PPjxl/DsK9Ke+joeiZOmtweZ7wtMec1WqAzu29nNohZpxdlrFt/+Lt/KHyoPcjZovYiG
         EySg5CwrI3EA7t9mU/H0zKeLh2ypsnibHZhUfzitsslnN5KTSP9vc1iAk97wnSdITrl4
         rs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrHmg+KfmJOWCkb8a7JmIe7QuCwUcCbApoh2QBJ0Drc=;
        b=oCwTWhm6xNWPUrLBVhSskLKuSMAQ64TSTWyDsJ2OcM3f2km5RXMsqKG8VANFXEz8oi
         DtZZqMr7RyGXPr88CbhXqS9q6jzXxrk6Je1Mzb+3jGMR+T3UjBKZPju7B3G4efhtiCNV
         WqtlCHSCyFkWZzsvgIzZooycSZEzWcqk866OfXh5MconFf1hajwra1XNqgc/2h+YxRlU
         vQaVglLrpzUFJ5i8IPspDccEO/8jOc0SzdQNNub2YYqEXxS7Ii13NXqqSW6tmmgGnQ/G
         aLJeVY9G+fsMdqUSjHNgC/MIPFn5eRABqVylTVpcRhRObSdm5bDhint1/zuElwEOK1sd
         h0Iw==
X-Gm-Message-State: AJIora+lpZgFpK60G+13+fM39L/o8MZ2sS4sSS8UWuuh5TXF8h109vbc
        fOw7bE1ou1yX0fTRtKTJIaYuU9UFYRw=
X-Google-Smtp-Source: AGRyM1uwhA9EM2JOf9ewYFfqRH+FO8Kv2MVF3ug8zQxJ+mgGJAFjk9Fq3iXREUKNxoywwVGosTXIYg==
X-Received: by 2002:a17:90b:1d0c:b0:1ed:54c3:dcaf with SMTP id on12-20020a17090b1d0c00b001ed54c3dcafmr11242013pjb.217.1656349833631;
        Mon, 27 Jun 2022 10:10:33 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.81])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a12c100b001ec71258838sm9869538pjg.27.2022.06.27.10.10.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 10:10:33 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/6] pack-bitmap-write.c: write lookup table extension
Date:   Mon, 27 Jun 2022 22:40:08 +0530
Message-Id: <20220627171008.16213-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <560d1802-8565-04eb-9faf-0f821861d321@github.com>
References: <560d1802-8565-04eb-9faf-0f821861d321@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> Which means that if "k = table[i] - xor_offset" that the xor base is the kth
> bitmap. table_inv[k] gets us the position in this table of that bitmap's
> commit.
>
> (It's also strange to me that the offset is being _subtracted_, but I guess
> the bitmap format requires the xor base to appear first so the offset does
> not need to be a negative number ever.)
>
> This last line is a bit complex.
>
> 	uint32_t xor_offset = selected->xor_offset;
> 	uint32_t xor_row = 0xffffffff;
>
>	if (xor_offset) {
>		uint32_t xor_order = table[i] - xor_offset;
>		xor_row = table_inf[xor_order];
>	}
>
> ...then we can "hashwrite_be32(f, xor_row);" when necessary. I'm not sure
> that we need the "uint32_t xor_order" inside the "if (xor_offset)" block,
> but splitting it helps add clarity to the multi-step computation.

Got it. Will add comments too.

Thanks :)
