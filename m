Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B65C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2337920738
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 23:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Pqx5TvzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHYXJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHYXJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 19:09:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E336C061755
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 16:09:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o64so189184qkb.10
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMNZ4oEfv9sw4myC6+oximbYHxv1K/zd51l56wBbwEg=;
        b=Pqx5TvzKTPjfhga5K6/hO7gt33HU2NliytRkkuOxezP6KCYKnm9FPTsKGGW5Io/V3w
         /1pWqQJCiS5OsBJ5VcohT6ORdg7jtP4h1VcCj/ZzLRYrIesELyFWL2Laah9l1Ve59meY
         QmMWvjOyEQOkmSjII/nu1TU7KGpJmmAMcMB+Q6rVUR78GXfUgIEwOFr/4h+ebf/0Wb//
         3KjVmAKv21JtUkAvb3Kpd5aSZQTFYTAjctRaU8ThVRjeTdY0i3F6YkWFYRpdHpaCw4tA
         IS1pW4yXNjSyNv//PflxLW1Kq5w8/NqFTvu9z7iqwFjr2Vto/W2t0K03DOdEGnVpQ+/G
         ZoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMNZ4oEfv9sw4myC6+oximbYHxv1K/zd51l56wBbwEg=;
        b=fvE34R17F3O9A64tyjnlQlTARSgJ4j4p9EHdB9FvHVAGLolDmyVpXwK63nhu5CbKWn
         MG3wAMNmqbhM0DcBTeIpuWSA8fr0Tbd7CCo3Z7HaCKjXxtYQralYOpAULEBRh8ad/nJC
         UJwN/YaQ+vKPeQp1qd3jIcbUYTJdutn6jsuf6H/xMi96ZM0h2l1i8v4zkHJZUGb40yFj
         NX6r2R/esythy4rD5dIwS6Cu0kBdiy7ekwBEymvxw9Ip2EGDoqnNYiM9YOoMgWWY03As
         5KpWM2IxgkJrHQSNe0yEv93hk/wQLIgSozNgo2cGLzvQuLcNtClSkG+FxecGs9sB6NY5
         qvYA==
X-Gm-Message-State: AOAM532Tf00z/NlS6yCNUS3d3OOp1P2zGNBLJaz8XcVmvtRHHNAajTfT
        R3HilFWh7jXBtUI94qq1/hmf0w==
X-Google-Smtp-Source: ABdhPJz0JguU/lXxlpoqU99EW0sbHqhFEfd7zTbOEaXUt3XeWrkLPO65SgNsFSIZQl4UoyDB2yReQg==
X-Received: by 2002:a05:620a:8c8:: with SMTP id z8mr11530432qkz.63.1598396947009;
        Tue, 25 Aug 2020 16:09:07 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id m26sm477628qtc.83.2020.08.25.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 16:09:06 -0700 (PDT)
Date:   Tue, 25 Aug 2020 19:09:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] pack-redundant: gauge the usage before proposing its
 removal
Message-ID: <20200825230904.GA23203@syl.lan>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
 <20200825172214.GC1414394@coredump.intra.peff.net>
 <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
 <20200825182745.GA1417288@coredump.intra.peff.net>
 <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Aug 25, 2020 at 03:45:52PM -0700, Junio C Hamano wrote:
> The subcommand is unusably slow and the reason why nobody reports it
> as a performance bug is suspected to be the absense of users.  Let's
> show a big message that asks the user to tell us that they still
> care about the command when an attempt is made to run the command,
> with an escape hatch to override it with a command line option.
>
> In a few releases, we may turn it into an error and keep it for a
> few more releases before finally removing it (during the whole time,
> the plan to remove it would be interrupted by end user raising hand).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Thanks. Peff's plan seems reasonable to me (and I'd like to add that I
am a frequent reader of the release notes ;-)), as does this patch.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
