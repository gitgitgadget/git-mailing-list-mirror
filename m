Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829A7C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1A660F4B
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhHBVL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhHBVL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:11:57 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F82C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 14:11:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x7so14404263ilh.10
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=geAAeL66nsq29YJyKvDhIre/eG/GlToETDCmkWLTp/I=;
        b=EKROg1TK5yFpJuNwoiA3bf7Q6JAmL7dZGjEpXNiAttENWzpmd/fu/BbjRMNlM1CWxd
         nhikIcNT9kCm435SnInUxp6gfuK3CjQAu5W063WWz8KtGiW/6V6u2U8c/9VzXhrr8joi
         pwBWvKQwHtj+bRHnJ4fyd6RUmTPqNwFMKFKGboKinszTKgBkoUzM8yOlQK/w1av+eRMc
         GWdBRdQo1LeNaraojBfrFe27f3COoNUpS2cmBV1C1qTZl4zW5NA1p7Y4VxdaTZ25I18t
         mrF/bqzkxegD5EUd1wPxm9uy4khiFD8878MkcQMPWsjfsQEqQH+E3w8eoJGE/WG2QNDX
         fmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=geAAeL66nsq29YJyKvDhIre/eG/GlToETDCmkWLTp/I=;
        b=uddYuxolWuXuwxOWWS/iZtERCUP0TMqlQLGwOSFrgAkad+6IkulfRDD/D+WP6QStTj
         3TIoEmFQvGg/qc2ZxvTB9Om+4gc3jY6kw+kAnTtVPX5J65fSaNNkQtXrqjNbh2YEZQuJ
         ksVt4iYghHb4PEhjD3bK50wKjdZU8GLbqUmsWzYKig6QGBsNOlub+C0D/NlxKnlpR02/
         fuxId9LBPqu4VmzUjEx6MT9xg944Cxj8BfdcWOLGVmkJKgCaB2c4dkNB5FNrqT22yupu
         wcW+ma0briFrIKO6cItMIlnCTLs9yJGQw5YRomo6wRKTPpRkIi1v6aSiqmKV3Lm0bCnG
         l29A==
X-Gm-Message-State: AOAM530vsZZPr82ibpNTGQ+DMdobBPOdyxV3u6SDl23W32Cmfy8MtN2u
        EmEXOHEeP4IAZ6Uq6dwarVCTuA==
X-Google-Smtp-Source: ABdhPJxdhy1G8GSm9dE3vihGNKTkVV6fxTlBIG0Z6n5nTgbOEhTfO4VuCCKayaC3c68KaH7Jw1edPg==
X-Received: by 2002:a92:ced0:: with SMTP id z16mr501677ilq.0.1627938706657;
        Mon, 02 Aug 2021 14:11:46 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:7d0f:79d3:4a41:12d8])
        by smtp.gmail.com with ESMTPSA id z22sm4568346ioe.52.2021.08.02.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:11:46 -0700 (PDT)
Date:   Mon, 2 Aug 2021 17:11:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #01; Sun, 1)
Message-ID: <YQhfkScjUBu7o/fp@nand.local>
References: <xmqqk0l4xuvo.fsf@gitster.g>
 <87wnp4p4xo.fsf@evledraar.gmail.com>
 <xmqq5ywnyg7f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5ywnyg7f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 02, 2021 at 09:16:52AM -0700, Junio C Hamano wrote:
> >> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
> >> ...
> > As noted in
> > https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/ let's
> > take Taylor's https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/
> > as that Ack (he was also CC'd on my reply to the last WC...)>
>
> Thanks.

Sorry if my lack of response caused any confusion. I thought that [1]
and [2] made it clear enough that I was OK with the series moving
forward.

I'm not overly excited about the outcome, since I thought taking my
suggestions would have made the tests easier, not harder, to write, but
I don't feel strongly enough to advocate for it further.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/
[2]: https://lore.kernel.org/git/YPl90eSyuovU3CvT@nand.local/
