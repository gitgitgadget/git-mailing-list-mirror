Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6610020802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbdFVWXq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:23:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34431 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbdFVWXp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:23:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so4845874pfe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PZpOWc4X4RCIJJX4zDtSmC5VT47FwcUq67UW7nK79IY=;
        b=IkS85gZoWwIcEwnIPUk4ttdXSy9QRUcVey0ReCpb1Bae//5br9nimkPUXV0gY11A0d
         2l8kAqaEPp3qzElcBYieR4vBUEM1HpCxwBwzhUOJMH22yA9hkvyBW60uXBE2tFxerbDV
         QHa8Hy4c4bb+sN8ciXy48OkwRzqWet5rP/FCwtMsokD9ILSCun5WirIdsJUg9oavMV4g
         IBXHDBrtD2KJDbyJAT2oARSII8DIMdhQOOR2wZo0wGSQ4guiM0UGWeVvEteRNwRJWtU9
         r/VEkOx2k3X93UeiiwCefetWiQ1nIyD0FaYP8dIx2i/jnLzoNISzd/tfPbAWO0Lw7nqc
         zwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PZpOWc4X4RCIJJX4zDtSmC5VT47FwcUq67UW7nK79IY=;
        b=jn1YVUwd12RxII7cXwBPwa4ggf7KQeTtwtBVqmWg2kDgLx2IdlKaKaBrwRe7qzdMbP
         hLq5gU1TKp3H2rC4+oGB/ajrbI6J81x2NdUCWimeMp5sE0+cST+iG06/ogx2vEbO5gIZ
         L3ovjJNS8D3UjcWtVmLDe72q5ExJjZLb9ndtKdBOeVmtWWrbF86WDWeAMiszUTP9YXEk
         FmGF8lcJLp1CITajEjCepbq/mmZ0sCl5O1nTgldDI96nTightC+mzVGxAdcwLVjbBDue
         YOu+J19N4scq4EIp9U0+mDV0ee2KMhigvX0T5ewxSfCVbopDqs/1uCLMp3pSQ80n992H
         hyWg==
X-Gm-Message-State: AKS2vOz3A92hPuo+rnokeuRiqR8/nV60OmSUlrybqcwAQJDBYF150quz
        NilIpoz0ZYCiNJReqvc=
X-Received: by 10.99.99.195 with SMTP id x186mr4755661pgb.200.1498170224396;
        Thu, 22 Jun 2017 15:23:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id p23sm6303102pfk.67.2017.06.22.15.23.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 15:23:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCHv5 1/2] clone: respect additional configured fetch refspecs during initial fetch
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
        <20170616173849.8071-1-szeder.dev@gmail.com>
        <20170616173849.8071-2-szeder.dev@gmail.com>
        <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
Date:   Thu, 22 Jun 2017 15:23:42 -0700
In-Reply-To: <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 17 Jun 2017 07:22:28 -0400")
Message-ID: <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd still prefer this to have:
>
>   if (!remote->fetch && remote->fetch_refspec_nr)
> 	BUG("attempt to add refspec to uninitialized list");
>
> at the top, as otherwise this case writes garbage into remote->fetch[0].
>
> I see you have another series dealing with the lazy parsing, but I
> haven't looked at it yet (hopefully this danger would just go away after
> that).
>
> Other than that, the patch looks fine to me.

SZEDER?  As long as the end result together with two series are
safe, I do not have a strong preference, but given that the other
one is a lot more invasive change [*1*], I think it is nicer to have
this two-patch series already safe without the other one.

What's your take on Peff's point?


[Footnote]

*1* Especially the other branch does not merge cleanly into 'pu' and
    I haven't managed to include it in my tree yet.
