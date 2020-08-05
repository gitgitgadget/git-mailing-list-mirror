Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5833DC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D412250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrVgzxob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHEWM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHEWMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:12:54 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32ABC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:12:54 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j10so14831262qvo.13
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D9njdVuWpI7kXleBMcwojyLIxGNr6lYEA4USEZhzL3Q=;
        b=TrVgzxobg7IfiSZBph5rmAIi8Ny1/wjPRM1UWGmKgvQTGfXfWzcK0ttQ1ZvztZZHk1
         pM/VM2megcY3FOTpjmpg81T3loCKAVXQwt1+IA2pk2N1ckSTm24E/rg8aoJaCOF3NlSZ
         rZbr2WwAjH3ahw5eVA+fh1W2ENHy7bP9lqcg32YDktBLnbnj6WrYLYpBK+AWMGQscquD
         8jErfYXkcvOEmWjI8qqP8Comgl8LdDoBd99Dnnn/YS03cQk+kyWZ6NDCdSUhsOX5PWH7
         M/ub3Kie9EM+a4EeuaroGS0eeK/VOmcZ5vGVK2hehlXXc+FHQbN4nu2JZlnyA/glSlyt
         /+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D9njdVuWpI7kXleBMcwojyLIxGNr6lYEA4USEZhzL3Q=;
        b=lpE4GQJdhpf6rJ83af42JzwwgsEwtjJz977Wbc9GyRqe6BvYj54B86Er1R0RyOGFst
         vix65GYEhr4h403aBBJq8ah6rQ8xScNcMRMG3856qnVJh+vRrRr58ouj5FJPsFx9coIz
         xWcYpCwytFZPU76INsCH9xV5E7MeEYL8JlVMsjSqIte/wmiYxmV8WqqJAtgSOSBsChHs
         MZUSz9H8WjbqdVZowAJJyrjQ193y54z0ttYBNn+SYiSNiOrVfxCZIbxtX00h8oJRFkxQ
         0ZXpR3+gAevfhJUMAnOQG6eIikXtPe4ZhdURBMzmXqWhvX5qbKv/Ac2tdnxpXYm1xfex
         TL2Q==
X-Gm-Message-State: AOAM530+YIe4s9q1zaoZIsusDV1Tkk92Fwo+qtmBRZrkWxjpsCShalYU
        01x6O6czKJK1lmeJhOodXVM=
X-Google-Smtp-Source: ABdhPJxLTj0WmhNAs9u0xLOXpQXF3wfhR647eBP0vS6VDHnqsKEqQvDJ2gBHwo5LXpFF1id8l5CRwg==
X-Received: by 2002:ad4:5425:: with SMTP id g5mr5921480qvt.198.1596665569084;
        Wed, 05 Aug 2020 15:12:49 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g55sm3101782qta.94.2020.08.05.15.12.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 05 Aug 2020 15:12:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: avoiding fetching specific refs from a remote
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200805063704.GA2690083@coredump.intra.peff.net>
Date:   Wed, 5 Aug 2020 18:12:42 -0400
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE29FA64-5281-4D9E-B509-CA2C2B7BB87D@gmail.com>
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com> <20200805063704.GA2690083@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

> Le 5 ao=C3=BBt 2020 =C3=A0 02:37, Jeff King <peff@peff.net> a =C3=A9crit=
 :
>=20
> On Tue, Aug 04, 2020 at 02:53:30PM -0700, Jacob Keller wrote:
>=20
>> something like adding a remote.<name>.excludeRefs which would allow
>> specifying a set of references to exclude from matching the refspec..
>>=20
>> I realize I could customize the refspec to list the set of things I
>> want, but then I would miss any potential future branches until I
>> updated my remote config again.
>=20
> This is definitely a reasonable thing to want, and it has come up off
> and on over the years. One search term for the list archive is =
"negative
> refspecs", though it turns up a lot of useless hits when the two words
> are not directly adjacent.

I tried searching "negative refspecs" (*with* the double quotes) and I =
get 20 results so it=20
seems to work. Although interestingly it doesn't find this message you =
wrote I'm responding to=20
because "negative" and "refspec" are on separate lines... I'm CC-ing =
Eric in case he knows more
about this limitation.

Philippe.


