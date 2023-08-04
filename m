Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBACC04A6A
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 18:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjHDSZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHDSYz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 14:24:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA864C0E
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 11:24:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-586a684e85aso10675937b3.2
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691173492; x=1691778292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5l2nEhUmeJIJlRk54xkbTNJVo4oX6btszgK7fxjg7dc=;
        b=2GYor4mmhAxs+oXOTrAY1XRmyDqDH7EUi4CDu1y6SSsdLUm6965CF6tvElffDfu1dn
         qaO2bls3tIqgRM7tFiAfqDtgK74DDkIhXtmM5t/a1GhDjBv9UrLLmrZ3js0gXj51FqCo
         1zsF8vCtVYEM1kT+C/uTSv2w2kdNzjfFwOpmE8cC2bk2ZlXGulKdratJ9BrbVimnBhrk
         6QKieH8twLkysu49M7ZjtUWVOI/1dnBhFJ4jJp0hMsfX4sq9DL3Ubp2pMTTGz3g8/UXn
         rDL8ZoepJvWzQmo2P/lUar5vQcvj05rX/W8wufD7C8MblAWJTb0Qh3Or8t0Oh04iKRh/
         zdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173492; x=1691778292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l2nEhUmeJIJlRk54xkbTNJVo4oX6btszgK7fxjg7dc=;
        b=hxcg9BxwohCEXsW2ehEZ0Qvk90IESENipTFN6erAnXzPZz7QeiI4Ug1Whf9YNPADfs
         +sQVhfa4xho3si9f+X4YdoSqYTyaQ+Xv9ru076osUJsMWBP+a+IFyo2y77du4FcQJK0K
         iIlpFzQ1b3S0qqjp4moOXbFaUnfF4Io2rP18AG7ImQzhvsgMQKowyd7xcnFNq2nz5uiF
         Do64iNwKPVI+/WxJPWTRvj39+wK+PDOIOGVCM0j3UKQuaM/MUOKyV1qYP0bpxxFPLvUp
         jxTPCqdDnq6tdrisjpIzXi5nw0wcDZ85C2JcxNfvH+cQqJ2OVu8u63bgykcqHFwMJ3+L
         7I0g==
X-Gm-Message-State: AOJu0Ywj7BU0ehN3JRn8NLTBIsxhdc+si7PZ2h6fKrXvoxEtfc2no7uB
        zX1GW9KWTJhyVBR6nuCP4VL/SQ==
X-Google-Smtp-Source: AGHT+IED+JuWNPoM9HNnrfoufp3cPPfijVz3lM+2/qMX+M8GF+XGCBe5VKqz8kaJrbrwHC2QE0U1ng==
X-Received: by 2002:a81:7186:0:b0:583:f5fe:d73e with SMTP id m128-20020a817186000000b00583f5fed73emr2554642ywc.30.1691173492009;
        Fri, 04 Aug 2023 11:24:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m2-20020a0de302000000b0054f50f71834sm872467ywe.124.2023.08.04.11.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:24:51 -0700 (PDT)
Date:   Fri, 4 Aug 2023 14:24:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yucheng Zhou <zhouyucheng98@outlook.com>, git@vger.kernel.org
Subject: Re: Feature request for shorter relative date format in log
Message-ID: <ZM1Ccn766xge31Uo@nand.local>
References: <ME3P282MB2274D11DC15DF1FDBBC36C3DBE0BA@ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM>
 <ZMqciat7tdbYGob8@nand.local>
 <xmqqsf915b54.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf915b54.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2023 at 03:31:51PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But we don't have a way for users to provide custom over relative dates.
>
> Are there existing systems to format time durations in a customized
> way, just like strftime() is a way way to custom-format a timestamp,
> that we can just use, or write our own modelling after them?

I'm not aware of such a utility, no. I had imagined that we would
represent the duration between two timestamps as another timestamp
offset that same amount after the Epoch. Then the caller could specify a
strftime format string and format the "duration" that way.

> The relative-time code decides which points in the time durection
> spectrum are good places to switch the granularity (e.g. up to 90
> seconds we will give "N seconds", and up to 90 minutes we will give
> "N minutes").  You could grep in date.c:show_date_relative() for
> Q_() and _(), and place them in an array and allow them to be
> replaced by strings in the configuration variable, but that will
> cover only one smaller half of the problem (i.e. how the "N seconds"
> are shown) and the other half (i.e. what variants there are, and
> which variant is used for what time duration---you cannot introduce
> a rule that says "up to 500 seconds, show 'N minutes M seconds'").
>
> Even with that solution to the smaller half will also create i18n
> headaches.

Yeah, I think mangling with those translation identifiers is going to be
a giant mess.

> No, I am not interested in working on such a solution myself.  But
> it will be an interesting puzzle.

Ditto ;-).

Thanks,
Taylor
