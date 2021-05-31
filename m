Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED66C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B870611EE
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEaHwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 03:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 03:52:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751DC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:50:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id a21so639626oiw.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=5P1QJWvrGboqV06A8L/10YFhcRf6CQj8r/T3/sXmLSw=;
        b=MILYv5PjuTU25JM8MC0nvskM9gnQxbKczs4ZJGlm4RKhiL6+G6BKWXMdds1HFZSl3N
         iZ8w8Lcnub3mMcnXCJxUynryJT+qR/ttrXZKqJNaVtmeUPyl07iYiMsZDngQ79GHwGEv
         UbdPvlwpOdkDlxLWBqd1LW9IDHU3gd+o60W2Zxct1Oswlk3LQHv/QLl/M5/P742hs62V
         Wv3uB/jMJBOycQaPb5oW/7LDb0M1PtE113aO/NdVWlCCRio8JvooQuWa/R5r+Tyb5llD
         hbgD7u9sgZNNttwpFLHOHkf+K/Ss4BIKpakx63l8bR6C7dI7Xu/oSAXXercuMj4Ij4gB
         reQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=5P1QJWvrGboqV06A8L/10YFhcRf6CQj8r/T3/sXmLSw=;
        b=YqBlaOf+dr84GbNkdPkppZ+SP5z2Dyx1fo/1rsHKKX4W8asTtUB/uyACgerBWvmz6S
         9/RCJfQng/L3pMCb603vRb2fjdvq4iJmd9xUkKzOVr7gxg/dBHuWLEXSQKBBO5YxtIpy
         sWYjho/1v8ifyyTv/DBpo6kvPn1NCM0vlfirI6c49eDAkOOmNnxEIfqrBaGQnCWjr+UA
         yOUrGKoSDJc1vUx35LfPR0QMFTnJqeoiYX/wwsUSAfbGzz7tQq8+2tGPRsVj5GsbXfO5
         KMR1Jv91Rn80zqzY6/aZa+FvTBrJOS22/WmSNjyumKwyHuCuYNBhbvmcpBx4R3FnBJhc
         EUFw==
X-Gm-Message-State: AOAM530ldLwB8s2g1BrsfFG/uTYHU3MHUJ3NffmV47+EbxauT6/ttbQm
        Nw1JGC9FEUovYQOEaRYXcaM=
X-Google-Smtp-Source: ABdhPJylYxqbW7ki/WSMDKbOEW8RZCwNpH7pmV5HmlPZD+EkMb0QyZKMBrea+OP0m8UQG7fW/D0LBQ==
X-Received: by 2002:a54:4113:: with SMTP id l19mr16037106oic.38.1622447430105;
        Mon, 31 May 2021 00:50:30 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x3sm1251144oov.7.2021.05.31.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:50:29 -0700 (PDT)
Date:   Mon, 31 May 2021 02:50:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Message-ID: <60b495442d1a0_24d2820857@natae.notmuch>
In-Reply-To: <xmqqim2zy0jg.fsf@gitster.g>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-2-felipe.contreras@gmail.com>
 <xmqqim2zy0jg.fsf@gitster.g>
Subject: Re: [PATCH v2 1/6] push: hedge code of default=simple
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > `simple` is the most important mode so move the relevant code to its own
> > function to make it easier to see what it's doing.
> 
> The change and the above description makes sense to me.
> 
> I didn't, and still don't, understand the use of verb "to hedge" in
> the title, though.

> Apparently it isn't "to evade the risk of
> commitment", "to protect oneself finantially", and of course not "to
> plant, form, or trim a hedge".

Those appear to be the intransitive verb definitions of Merriam-Webster
[1], there's an object in the sentence (code), so it's the transitive
ones that are applicable:

 * to enclose or protect with or as if with a dense row of shrubs or low
   trees: ENCIRCLE
 * to confine so as to prevent freedom of movement or action

Some synonyms: block, border, cage, confine, coop, corral, edge, fence,
restrict, ring, surround.

I think it fits.

> > Reviewed-by: Elijah Newren <newren@gmail.com>
> 
> I trust Elijah would complain and/or clarify if this footer is
> inappropriate (I didn't see an explicit "You can have my
> Reviewed-by", but only "this looks good to me", and didn't know
> what he meant).

But he did review the entire series. So I think it's safe to say he
reviewed this patch.

> I do like the change of the phrasing from triangular to same-remote
> at the end of the extended series, by the way.  It makes the code
> simpler to read and much easier to reason about, and it would be
> nice to have it even before this step ;-)

All right, I'll keep in mind for the next round.

Cheers.

[1] https://www.merriam-webster.com/dictionary/hedge

-- 
Felipe Contreras
