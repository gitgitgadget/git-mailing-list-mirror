Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B612C761A6
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 07:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDIHnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Apr 2023 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIHnM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2023 03:43:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396249CD
        for <git@vger.kernel.org>; Sun,  9 Apr 2023 00:43:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j1so6095127wrb.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2023 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681026190; x=1683618190;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2L0pMxVpR90tKfhvqMGlQ0vpuBIz/ppXxv5vY0PJct0=;
        b=QCMlx2H36j5pi1pGz4u7Ee7p06ua/cjO+knvkZTbdrJlr79nVUZ9Hu3mHX9HKI53Pm
         L0WaeNFAvl4COvNWjAu7cYHqoWk40lxLaEhXy+mw8+8RoSxJFhBLldhC5mHdS3pz6NhY
         Jcu9yQP0zb3AfttNMluI47UZ+cP08amxXzoRN4N/88qq9qpoRNDkSRt20/hu1zOR7Stp
         ECgnLR/aBIH8dQo1yWwKPSzxSg1mHKH7zYiTayYA0yKVxIxg7nBwr2CSugT9uN5FV2u1
         k2OVC0J15p149TnFNePY+d56IZAKyfWsf8G/NMQwFg3BlxvgUlmYox+8tXhG7Vm/S8hE
         g6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681026190; x=1683618190;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2L0pMxVpR90tKfhvqMGlQ0vpuBIz/ppXxv5vY0PJct0=;
        b=tFnmdx5GlqME24zR6u2gJeAKyf0F09wqq6R6mAeTX0alW3TkjpjQiPsGPthHoA48yH
         dN6R5f8CVWF1sZoysbHpKNLogelN75JgAX48SnkHCgesVmcz384Tw8QRpOmNIUU0po3f
         Js1NZFaP38XD8PYRfc67DOiZ+vvwPBoTMWT6vqpPLBwUfjLNSsRTz0WeMyXnEoV8maZA
         Kq4uUOfNagjbIx55B7KQFGtgWvHdv8bGAj1a0gbAfiFe74ibeLtsn165imS6ToALNYx+
         DWHAazNUa6E+pMDms8dlTpJ8UV9vdVSHVyRkkGEwQc8+nFEB61KaeyVJ9lCkhL5JaTmy
         iRGg==
X-Gm-Message-State: AAQBX9dsp4ioV3I4YmqR7/PunVGzLzf7VjFAGnZ7V5Y65LsiIpBBK2is
        rT1Vi28ImwfZMq0Plxt/A4ynS3vJZBU=
X-Google-Smtp-Source: AKy350bzwKXfI87ahP1XbK+2nAllKsWHBszi8y/mgjS39Y+uGMQyxXBlz9qM1Lar2BU3+x+nZ6BPLg==
X-Received: by 2002:a5d:4610:0:b0:2dc:cad4:87b9 with SMTP id t16-20020a5d4610000000b002dccad487b9mr4465657wrq.68.1681026189598;
        Sun, 09 Apr 2023 00:43:09 -0700 (PDT)
Received: from [192.168.2.52] (123.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.123])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003ee6aa4e6a9sm13940907wmp.5.2023.04.09.00.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 00:43:09 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: add and apply branch_get() rules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
 <xmqqjzynlm9i.fsf@gitster.g> <376aca6d-1b09-9bf9-c258-81e8ed2443c2@gmail.com>
 <xmqqjzymf0wt.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <d01d9fc8-0112-eae3-0792-1e75912720e2@gmail.com>
Date:   Sun, 9 Apr 2023 09:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqjzymf0wt.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08-abr-2023 15:45:54, Junio C Hamano wrote:

> I do not know why you are
> arguing against my suggestion to improve your proposed log message.

Sorry, that's not my intention.  The recommendation still stands and the
message was not clear about it.

> >> Stepping back a bit.  What is the ultimate goal for this change?
> >
> > Of course, as you pointed out, there are usages where a computed value
> > is used, perhaps coming from the user, which might end up specifying
> > "HEAD".  Those usages of branch_get() are not considered here.  Not even
> > indirect ones.
> 
> That is what I found problematic, because I do not think this
> particular change will get us closer to the endgame of not feedling
> "" or "HEAD", if ...

The objective in this patch is to avoid having in the codebase
branch_get("HEAD") in favor of branch_get(NULL).  Because that's what we
recommend and, anyway, a smart compiler is going to optimize out that
strcmp with two literals.  Therefore, we follow the recommendations and
save some compiler effort in the way.

But, branch_get() cannot stop supporting a computed value that ends
being "HEAD", as a way to refer to the current branch.  However, maybe
you are suggesting so...
