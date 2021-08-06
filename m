Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26E3C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 21:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3C660EE8
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 21:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhHFVW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhHFVWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 17:22:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50374C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 14:22:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so24598329pjb.2
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Zvs+Yw52TXniGex21RZjzENnTgzS2vP5Sydy9B6CzA=;
        b=cPn8orMmESh+as+wvOXHCK08CkT5mlvqiVwdjuv2qZ2MpQx1ts4JcqDTjhPRVyApTQ
         OcaqXJ5seOss5ZnI41ljyWMw3QNB64bOi1ouJjn2NOpk0cWSybtdwFQkDelsOSykSkku
         hGIrSZoUof+TOda6jR6M3Ak0MuUDiI9Z51xGKXcywZCCapsUoRJKRxLzBIiXt+Rv4tii
         m0LRlnC2dznWoB/5duxsmh26WI0Em2LiTyDMJHctOTv+qwm3LS4ZZdu50CntXuBJWKYS
         uWJnMu2qpERQAHb+u3LFeUB3Z+gGyx5hBT3eAlqWSr8+vHDQteZ5iGPIKeT7Lx3uu0Q1
         qgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/Zvs+Yw52TXniGex21RZjzENnTgzS2vP5Sydy9B6CzA=;
        b=nJ/Oo2clVMskV1e3tdzPW1Asrbcj9sttemx08m9AKjVBKoeBrnIYh/1N6JgtjHMjGp
         4nfyAypMjWyruRkauHSqp6F7IZlleaXheSr08+wD98R1/wCOCutM9WMu/J94Yo5pH+Jf
         IYvjWbz+5BOad/6m8NwtB6uPbPjXYIAaqqWr7SP29RIzXVezhROP2ZnRdOd1EGZWjJKT
         bFFB2H5O6twEkIsby3WIgPk89pwcFgU63xdLCL4O+wP8FQgUJsDBQK7/okdxhpwLDXQt
         Cs6Pd5OKe3FDxFWW/vJIM9YkajgFU0dJIn/Z2RiB1rmFAd+veFJpNDEt9pWv0mKn99Nf
         KaQA==
X-Gm-Message-State: AOAM530pMnqr8ZZHf/VKZKp+xsu4rUtxwa/BrOY1CWU00x7tra1VAT1z
        4yLhLuIIp+7eJfNf/P06xe/VDw==
X-Google-Smtp-Source: ABdhPJyruChoUX/SEsoarwEzVa2c0/u1RiDarImPjJJ7HO80LKkgi8rxNM7VnT367H1Q/Hp/ImUOFA==
X-Received: by 2002:a63:595f:: with SMTP id j31mr1137692pgm.109.1628284958586;
        Fri, 06 Aug 2021 14:22:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:19f7:4e2a:b277:e7cf])
        by smtp.gmail.com with ESMTPSA id lt18sm6761012pjb.18.2021.08.06.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:22:36 -0700 (PDT)
Date:   Fri, 6 Aug 2021 14:22:30 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 2/2] connect, protocol: log negotiated protocol version
Message-ID: <YQ2oFttZBFVZtEHm@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <cover.1628115064.git.steadmon@google.com>
 <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
 <87a6lwn52u.fsf@evledraar.gmail.com>
 <YQs+VQIYDO3pkCNS@nand.local>
 <874kc4mwqc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kc4mwqc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.08.05 04:47, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Aug 04 2021, Taylor Blau wrote:
> 
> > I didn't realize before that the unknown case really is dead code, so
> > we'll never log "<unknown>". And since the mapping from protocol_version
> > to string is identical for known values, we could probably do without
> > it.
> >
> > And I don't much care either way. I think the benefit is really pretty
> > slim, and arguably my code is just adding unnecessary overhead. So I'm
> > happy to go with or without it, but I'd be rather sad to spend much more
> > of our collective time discussing it.
> 
> Yeah, I just think if we can be sure it's an integer *and* a valid
> version when we log it, people writing future log summarizing code will
> thank us, i.e. just 0, 1, 2, and in the future maybe 3, ..., but not -1
> or "<unknown>" or other values we'll trust die() etc. to handle.

Sounds good, in V3 I will switch back to logging the enum value
directly, and will make sure we don't log anything if the version is
unknown. Thanks both for the discussion!
