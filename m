Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23258C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiEZScB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbiEZSb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:31:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B562B2CE14
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:31:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f21so4491980ejh.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NRd7a41+jsY1+BNWtq4KIJA5WJCNZypf1ToTpIbt538=;
        b=GQcocHOP6Uft3k/CaICibS6XGayO95kEFBju6D9ylri5ECzQiQpDzY3vKEAOIw7Ta8
         1TB4CK9iU/B2sB7scMvbVlEs7KA59cc1EgmcWykoCgWdZ+6cVBUgEheAauboSZxQm4Hw
         aT6OOLG2lvZNs7r9Sj+hvCAkZeJW42mH9yqeWaGJ4SaMXHJEQnNdgwKLWYk4h+oJY2CX
         E28Ys8D5m2ePJvWIzpUiIrFJetiMcWMynvF3IpXnkwwiy38wgt4YpmaT9MIq6gUL2N4r
         hwVlK8iJL5F0eXzAM5sxR1xjl9UVFWVCrnTudI1BOX/ZBkxtwaChCcG2SlCAC00d8RBH
         MISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NRd7a41+jsY1+BNWtq4KIJA5WJCNZypf1ToTpIbt538=;
        b=y39jfZ6MTDeU6uHyxPO1mYkkFqCr6PxCA6ZhQTHKRWAQbCirfvgAfX3fcpX1FQDNZy
         V1F2Lik45i9V7lN05DhA6Q2puTIMEXefdf/7vO8b34rZgvkrmqVJnVAqmCgN37DEB4jY
         2mGvJZiXLj7cZyMY7fDnTnCKjR4Jnf8zD3DFc1ry5UrzW0duCrxi7D36158CTiIeT6y+
         ChOfwnzBlrfwD9lJ3X2fLAG7SFEjydr3jW5Bhh1ruE/oK9oXkzCaEolCrXHcqlvGIZIe
         zYd2aF0I1Bd7/du4XkSka/jhMZtwYcWKrnOQn80ESTsYcWqy6uOebgxhdHHSFTH6rijO
         81/w==
X-Gm-Message-State: AOAM531fKNfxJiDh2zjkw7lywFbL+gszDEJsV4Ub9o1mb8s5urC7Eg3e
        S7/ZFYoPhtOosG09OtDfhTfB5yyNKMgsXw==
X-Google-Smtp-Source: ABdhPJxq1OHpODBQma00xGT0JTiyIPiaHw0oIMD+Y07LPKfmwRHmgen2blQn3oQ3zH8p9mlm7Hv/9Q==
X-Received: by 2002:a17:906:99c4:b0:6f4:56d2:4bbd with SMTP id s4-20020a17090699c400b006f456d24bbdmr35932802ejn.754.1653589910101;
        Thu, 26 May 2022 11:31:50 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906378600b006fe921fcb2dsm740647ejc.49.2022.05.26.11.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:31:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIGz-000F5X-0x;
        Thu, 26 May 2022 20:31:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
Date:   Thu, 26 May 2022 20:29:20 +0200
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
 <xmqqpmk15o46.fsf@gitster.g> <xmqqh75d2aif.fsf@gitster.g>
 <220526.86fskw7mbv.gmgdl@evledraar.gmail.com> <xmqqleuo1beq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqleuo1beq.fsf@gitster.g>
Message-ID: <220526.868rqo5enf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I don't think we should do it like that and keep it a BUG() not to call
>> BUG_if_bug() when we hit exit(), because e.g. in the case of
>> parse-options.c once we have the a bad "struct options" we don't want to
>> continue, as we might segfault, or have other bad behavior etc. So we'd
>> like to BUG() out as soon as possible.
>
> Oh, there is no question about that.  When we detect that the
> program is in an inconsistent and unexpected state, we would want to
> bug out instead of continuing at some point, and that is why we would
> want to have BUG_if_bug(), or exit_if_called_bug(), as I called in
> the message you are reponding to.
>
> What I am getting at is that the code often or usually calls
> BUG_if_bug() is not a reason to require it to be called, especially
> if there are conditional calls to bug() near the end of the program.
> Imagine a program, after finishing to respond to the end-user
> request, before the end of the program, performing some self sanity
> checks with a series of "if (condition) bug()", and there is no more
> thing that needs to be done other than exiting after such check.  I
> would have added such a call to sanity_check_refcnt() at the end of
> "git blame", for example, if the facility existed.

But you wouldn't want to just stick BUG_if_bug() at the end of those
sanity checks?

I suppose I can drop the paranoia of requiring it, but since all
existing callers want to act that way, and I couldn't imagine a case
where you didn't want that I made it act that way.
