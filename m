Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3521EC43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 02:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiKHCus (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 21:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiKHCud (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 21:50:33 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD06F2F028
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 18:50:32 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y6so10481216iof.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 18:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jv+mgQEQeG0wiH6kG0fC6yXhOs4oonK+Kvz2sGn3pDE=;
        b=NyJRLE1J008oTA4gyatWrno7+Gbslx59xOiuhphsKxnKVi8FDEKxnTT0GO+CNXXEW3
         hEUmvJsfRKWc3Q6FElDVnvpXr5qei1pvUA2pkGSLe8QoObCnByCzBtNnGbRqttXXPgb6
         uACHhRWnWXPdY1FvrzJx5HpbkP/sJ8VUmfceV9r8R/FRmRqmJ4E945Dg1ht/JJFLhogl
         0O9xrdW8AITabp9xsKGHz386JuFa5YhIg1fED53d/PeXRoCb0WD1H6W9i/3Tldp9SLT/
         uy8B20WQqsGq9IQf313QM3HcOYNVn24I1JngTujdo0LVGRI3O5iD2H0jlvHb5avcPxpM
         HGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv+mgQEQeG0wiH6kG0fC6yXhOs4oonK+Kvz2sGn3pDE=;
        b=JCxgWIRDW81gEhPZmNK6yyNZ9kp9SV0RllZ1sw8/9UnPdCrKxRlMixraawqXM5nRD7
         D8Nd0jTHl8ja5Ett3z89Alrp3NfFOLLEJwYh2YK7YZgtXVx6OnfgLJcovlgFSdS2aayJ
         wxxVASj7iKCm+tb0rXNDeQ2eo1ZaafvBH1OfxUhrJbd9+9zGGPl2K+lny3Qth3oJjqC+
         DV8OQ58cR6cyb2KXfmHYGjSLbChAdb5kUu0hrc3YL9UBJVXWvPEC4q1WpVo7kdbd04BO
         BhdgvQc5ijwwUcDS/jv6VUh0xJBsEimtFCxlYvEHg9a6l/1V8z2M3KlxsJXQJiFprQux
         wEYw==
X-Gm-Message-State: ACrzQf2BgehAYCBLhd/s/HUyUot+rLVgL4Fl7kngQukHxz9jRhw7h1cv
        Uf45/fYbvba8yuR0W41/6j+fQn+E4N9uiA==
X-Google-Smtp-Source: AMsMyM5dVMty/3ozLOAS/DfLgVVWkhYJsvVPdd8VxuPJt6lYEvr3uSR3Osyx+spC3O7amtpCEo98Aw==
X-Received: by 2002:a6b:b882:0:b0:6b7:56c3:b602 with SMTP id i124-20020a6bb882000000b006b756c3b602mr31411530iof.5.1667875830316;
        Mon, 07 Nov 2022 18:50:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z20-20020a05663822b400b00363ec4dcaacsm3359774jas.22.2022.11.07.18.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 18:50:29 -0800 (PST)
Date:   Mon, 7 Nov 2022 21:50:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matti =?utf-8?B?TcO2bGw=?= <Matti.Moell@opensynergy.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
Message-ID: <Y2nD9AR8acaGLXDH@nand.local>
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
 <xmqqwn904sof.fsf@gitster.g>
 <b5017077-720b-3085-39f0-54dc6b6fcaf6@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5017077-720b-3085-39f0-54dc6b6fcaf6@opensynergy.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 12:01:40PM +0100, Matti Möll wrote:
> On 16.10.22 00:40, Junio C Hamano wrote:
> >
> > If one likes the output from "submodule--helper list" so much, I
> > think your "ls-files" above should be the closest.  There seems to
> > have existed some logic to squash unmerged entries down to a single
> > one, too (git-submodule.sh in Git 2.0.0 era has a module_list shell
> > function that shows what "helper list" should be doing), though.
>
> I do actually like that submodule is hoisted out of the scripts but as a
> matter of fact it seems that the openembedded folks relied on the
> "submodule--helper list" call and with later git versions that doesn't work
> anymore.
>
> https://github.com/openembedded/openembedded-core/commit/6d9364e5f3535954f65cbbc694ee7933ac1d664f
>
> At the end of the day it's kinda their fault to depend on the
> submodule--helper but it does hinder adoption of new git versions for people
> using openembedded.

Yeah, I agree. It's unfortunate, but I think we consider anything with
'--' in the builtin name to be outside of our compatibility guarantee.

I recall a recent message on the list which where Junio said as much,
but I can't seem to find it :-<.

Thanks,
Taylor
