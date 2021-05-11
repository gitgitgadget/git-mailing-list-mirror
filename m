Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7D7C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893E061628
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhEKTWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKTWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:22:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D8C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:21:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso18468380otg.9
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Hb74ySFp3vjsdeouUNgP5ScCRv0/0xUMZ3gWvuolhvs=;
        b=MCsgjSQz6BRYHieNmzwEfGxwXOZ4HfuxqAqD1oO5ZwxfJ8uqgTo77b5n/ebsdVrxBt
         t6Im5xqHDUug883Qq/AOK140bPMJKp3cik8VA+GFzfsTNy4r7FJMbDncH+ZKwXngmGNR
         x5BhTeNBkWnQ2gNFA9E6ot60Vj9Ayv/x5xO6hGnoL7/nXHDeg/urkEp9qd2kdp6ZC3+d
         ogX+PiRu2k6hOZYmHzl47zvs01g2oQ3vAz3BLRGMuGShXPK646n62gktAG99sUUczqkO
         +7jRtwo88dptQDU7SK9oK1KzXexoSmoeZHud1vPHRyk0jpvU2VVWVZ3re5/R5VCHRhSM
         Ys8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Hb74ySFp3vjsdeouUNgP5ScCRv0/0xUMZ3gWvuolhvs=;
        b=ZAcUHGfa6vyFFVJNvl4D5FfMR1W1vxB4raU+R5rIH1N4I1a7nFjQ2d2z3ZWM+7n+q8
         Zw4yaeu7fmUqs7Lxc+b9tYM9uQ0rSUP51r2qxoznanYM+hpCvmy+fsekm4XWSbziBayH
         meAJKoz54MSyTN/T0H64UGCLh68sRKEbCAFas08VTm9h19DoeDqiZaomuYlLMSWIUcck
         oWHvQOPG76b/nY1k5te6QVEV/QxLMjJxaBhHtAibeqShSjTN1o2ipNNYuqDerpEp+aEp
         N235rAFBzsA3vEXviy+KwJrbCa3GwiCcQOrnxUqp5b8ppue0MWelAyK1XPKnIO5ZBikp
         Qkfw==
X-Gm-Message-State: AOAM533oDKsfy0jAnVeI0SAYRV6LVH32Reod8QY0TrgGXj3aYFa68+hq
        siw/mawuePRU6+A3a5dVG4s=
X-Google-Smtp-Source: ABdhPJzL/fGPeXr7Ro9taCN6WD+tYdzDDmlQcEAeF5KK/2pMnbgp7pDPUgovfhcxpYWPDj+fTH5oxw==
X-Received: by 2002:a9d:7d8d:: with SMTP id j13mr6572069otn.208.1620760905185;
        Tue, 11 May 2021 12:21:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id 129sm1816999ooq.34.2021.05.11.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:21:44 -0700 (PDT)
Date:   Tue, 11 May 2021 14:21:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <609ad9473d535_6011e2082@natae.notmuch>
In-Reply-To: <20210406092440.GZ6564@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Mon, Apr 05, 2021 at 04:48:58PM -0500, Varun Varada wrote:
> > There are a bunch of places in the code/docs which use the word "impa=
ct"
> > incorrectly. This is especially true of places where it says "will no=
t
> > impact", which suggests that it might have an effect, albeit not as
> > strong of a one. This commit replaces all of these with their
> > appropriate alternative so that the docs not only does not use jargon=
,
> > but are also unambiguous.
> =

> Hello,
> =

> while using "will not impact" in an incorrect or unclear way may be a
> problem the word "impact" in itself is not "jargon".

From Merriam-Webster:

  jargon _noun_
  : obscure and often pretentious language marked by circumlocutions and
    long words

> If you are concerned about correctness and clarity of the documentation=
 please
> avoid spreading misinformation.

Under certain definition of "jaron" Varun's statement would be
incorrect, but not under all definitions. If you use the definition
I stated above, "impact" can be considered jargon, because it's a bit
obscure language.

Ultimately it doesn't matter if it's jargon or not, only that we have
better alternatives.

> Thanks
> =

> Michal

Michal, can you please remove quoted lines you are not replying to?
Those 762 extra lines make it harder for some of us to read the thread.
We don't have email guidelines, but if we did, that certain would be one
of the points.

Cheers.

-- =

Felipe Contreras=
