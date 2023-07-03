Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ADBC001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGCRNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGCRNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:13:49 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CCBE74
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:13:45 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5704ddda6dfso56905187b3.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688404424; x=1690996424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9jx4K11McFJ2RR8RPjGAtjB5/2saSQa4u64EE4KJFQ=;
        b=KYCVGjGilo2IAU3XzZhmcLmVQoM0Iuq/7ZM8QQK8KO2yF+d8hzNE+cgI/vHk5XpePF
         pbtPglD6uLnRQyj/PXX0b54IRjX3Qn2vGN/Z4x7HtqeRqHJ8yQP1rTKq2MiUzO5nWvL8
         EA7/NP2QTlo8QlYO6GQP3M2W6xJxmSNXJjyanRy/sZXcA9hepKuT/3TFj8Uyk6DM90q2
         3p1hEXLwBSdSKcM7HdFfzhvMpLf5LiyqskLIP0yZYa/w6c991nT4rpbOn2+z9n88AylE
         57u0cgrwMiReu7ZwDoX6+oLJvQ5p8/olM/HuY3savajyeG8g2wiVZLHtm0ciTOxNSyY5
         lsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404424; x=1690996424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9jx4K11McFJ2RR8RPjGAtjB5/2saSQa4u64EE4KJFQ=;
        b=emCKGhh5nsibZAv19dnhIIPwkrgfSDsIOncR2tM6d+wjADxQ7Zh5VQEIC+Pl10g4uO
         8kT1N3YemeWNw9OcpbUGKKX0EbIVPtZQeDQpFYTQWsZKlbgOvPIgwZSBWVAsUwBZLJ9k
         OKm1OSYPk3PpRIRr8vNB34cKXestDTclcvfyQLbv8oLuX8KpFe40sl/bGBHeehvalpLz
         dxxwEv+uEAWRgXt+Hd70jglgq3U+y/jWtAJHZPOtcymWUo5iQsKIsugDU1U2tjmxINWC
         kuTSWH1LNq+p3+lomS0IMifidxWbQ6Vmop38jWmY2jwR8mG5J6PeCzLmkob0BJUQH6sq
         sITQ==
X-Gm-Message-State: ABy/qLbRWOD/56rC4ERHmUa+1f8cTs1IqwKqb0OmQsxNQi9Dr7A0H/Os
        wfmaIBph0DkTgya9YiYBeaxCtQ==
X-Google-Smtp-Source: APBJJlGHv5aOGqwwbsqueoVjcYRponD5cjke3jqNr1kGJQFIJePGQNOzHmL6gDSi4vCnaWjv6vSn5w==
X-Received: by 2002:a81:6dcc:0:b0:573:ad40:682 with SMTP id i195-20020a816dcc000000b00573ad400682mr11323618ywc.6.1688404424706;
        Mon, 03 Jul 2023 10:13:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o128-20020a815a86000000b005794a9576f0sm1612823ywb.9.2023.07.03.10.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:13:43 -0700 (PDT)
Date:   Mon, 3 Jul 2023 13:13:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 04/16] ref-filter: add `ref_filter_clear()`
Message-ID: <ZKMBxnQo1MyB7s9e@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <777e71004d68dc9bb9c4cad2b896acff2c615cbf.1687270849.git.me@ttaylorr.com>
 <20230703051946.GD3502534@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703051946.GD3502534@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 01:19:46AM -0400, Jeff King wrote:
> > +void ref_filter_init(struct ref_filter *filter)
> > +{
> > +	struct ref_filter blank = REF_FILTER_INIT;
> > +	memcpy(filter, &blank, sizeof(blank));
> > +}
>
> I was a little surprised by adding init() here, but we need it at the
> end of clear(). So this is an OK place for it (the other option would be
> in the earlier INIT patch, but it would be unused until now).

I used to write more patches in this style where I would add as much of
a new API as possible as early as possible in the series. But I think
reviewers seem to have an easier time reviewing API additions in the
same patch that adds their caller.

So I tend to agree that this patch is probably a good spot to introduce
`ref_filter_init()`. But if you feel strongly, I'm happy to drag it
around.

Thanks,
Taylor
