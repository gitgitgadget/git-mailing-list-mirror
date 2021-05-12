Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC7C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39795611CE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhELIda (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhELIdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 04:33:25 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72987C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:32:16 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so19872263otf.12
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=v36yIFaE8OE729I+yNsKoUveNGrQYieX2gf0RKKKGNo=;
        b=B3zgEw1GFOvqF1NTGffPrvOweWAOJSO48nqq5dR/KICC2BWCL6GogKM39C7lfe2pjg
         /RI3kRua5WQauwfskiYQaAnJQ36wGuZ3NrY8jaF2TA7vnWLJfFk3FQHzMZxopwODTQFY
         LQF7ZjwBa2WxDWfKVLptq88p+1GqbiDpVxYRzMKrNaB02Cy80V44NPCFFnhQbdwfiqSQ
         6ULD7IwWtmibLCEw/cXs2uqpNbGTvGursGpjW8ews2PgTUED8SmGcK2qgJuPqOBhSIXu
         /QKYp3WeqJ5hZrrza0yllczbt1JxP4kXRotg0KmBiZhFpSIHJj9nTxA4lTzH1YhhmVp+
         PFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=v36yIFaE8OE729I+yNsKoUveNGrQYieX2gf0RKKKGNo=;
        b=oEJuQtkt19IXPdpS3shRKYxCxzRMtp+l+DEwKMHQxanU7+RrKgacMBwv769YIk8eCJ
         UjILMhVyWx1BjRBINZ2opMFJqoaOh4YeFvCaBEADnGLIfWVy/TWe4iCtNhGFWTi8SIao
         +U7SYiEfQNNDK0qZN1hZjmDrybNKwcqbTQLpNBnt/k+M32WgTp+LaBxDnjjFbaD6NjW0
         gTu+3IlEciY//eK0wxt9Bc5FgIMjeEqnEB18McrcV266wZS/IIx82SqNCxTeNDBTWm6n
         GiYuiS5/UMHG7o0T9Ym5W30OHMsnC71NnItKe2uAiljd68c8jttXeM/GGcFRVlho7ehg
         6cRg==
X-Gm-Message-State: AOAM532g0z9zMA5lp4nuZcUhgTr9WRkt/Y2o9ASu5SAEroUZObZLQ05g
        vb4uS4i9Q+qDe40XXzLQMUo=
X-Google-Smtp-Source: ABdhPJzj9ci0ndyWDZvL8FjcvkssTS27smKnTiBKg21kmjWyulgkXHCJeCKKF1qATkTuR0EWswzY0Q==
X-Received: by 2002:a9d:7049:: with SMTP id x9mr3964837otj.20.1620808335807;
        Wed, 12 May 2021 01:32:15 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z6sm2807098oiz.39.2021.05.12.01.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:32:15 -0700 (PDT)
Date:   Wed, 12 May 2021 03:32:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, stefanmoch@mail.de
Message-ID: <609b928aeb66e_6e4e9208b7@natae.notmuch>
In-Reply-To: <CAPig+cQvnsRe0fdPaBe9hJ4LbPFmHmGVNdiGYLqi2JM7A5GmjA@mail.gmail.com>
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <80e0215a-cd00-57f9-afb6-b85b33dba91d@gmail.com>
 <609b797a818bb_6d897208ce@natae.notmuch>
 <CAPig+cQvnsRe0fdPaBe9hJ4LbPFmHmGVNdiGYLqi2JM7A5GmjA@mail.gmail.com>
Subject: Re: [PATCH v2] Writing down mail list etiquette.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Wed, May 12, 2021 at 2:45 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Bagas Sanjaya wrote:
> > > In practice, the maintainer could instead merged v5 (without having me to
> > > send v6 [final]), because v5 is merge-ready in absence of maintainer's
> > > email address in either To: or Cc:.
> >
> > Generally you don't need to worry about this, that's Junio's job. If
> > your patch is ready, Junio will merge it... But not always.
> >
> > So no, you don't need to send v6, Junio will pick v5. If he doesn't,
> > it's most likely because it slipped through the cracks, and you can see
> > that in the next "What's cooking in git.git".
> >
> > If you don't see your merge-ready patch series in "what's cooking", then
> > by all means send it again as v6, or reply to the "what's cooking" or
> > something. But generally there's no point in sending a v6 identical to a
> > v5.
> >
> > But if you already sent a v5 that is is merge-ready, there's no need
> > to send an identical v6.
> >
> > All these suggestions are of course based on my own experience. Others
> > might have different experiences.
> 
> This has been my experience, as well. I've never sent a v6 with Junio
> as an explicit recipient, but which was otherwise identical to v5.
> 
> Another reason to avoid sending v6 which is identical to v5 is that it
> potentially wastes reviewer bandwidth.
> 
> The advice which seems to have triggered this particular discussion
> comes from Documentation/SubmittingPatches:
> 
>     After the list reached a consensus that it is a good idea to
>     apply the patch, re-send it with "To:" set to the
>     maintainer{current-maintainer} and "cc:" the list{git-ml} for
>     inclusion.  This is especially relevant when the maintainer did
>     not heavily participate in the discussion and instead left the
>     review to trusted others.
> 
> It's not the first time this advice has resulted in confusion. Perhaps
> now would a good time to retire it altogether, or at least rewrite it
> to mention the points you gave above about responding to "What's
> Cooking" or by sending a "ping" to the original patch email (which may
> result in Junio either picking up the patch or responding with an
> explanation as to why he didn't).

Agreed.

(Although sometimes a patch series of mine has actually received
consensus, and yet for some reason Junio does not pick it up. Except
in that case sending a v6 certainly would not improve the situation. Not
sure if that's specific to me though.)

> Following the above SubmittingPatches paragraph is another which also
> seems to mislead people frequently:
> 
>     Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:`
>     and `Tested-by:` lines as necessary to credit people who helped
>     your patch, and "cc:" them when sending such a final version for
>     inclusion.
> 
> In fact, a submitter should almost never add a Reviewed-by: trailer
> because Reviewed-by: is explicitly given by a reviewer only when the
> reviewer is satisfied that the patch is merge-ready, in which case no
> more re-rolls are expected. Instead, these particular trailers are
> almost always added by Junio based upon reviewer responses he sees
> when picking up a patch.

I don't fully agree with that comment.

At least me personally if I see people acking v5, I add them to v6 as
Reviewed-By.

I'm not sure if that makes any difference to Junio, but that's what I've
historically done.

Cheers.

-- 
Felipe Contreras
