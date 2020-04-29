Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E9C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58589208FE
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 11:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNzLMGMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgD2LwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2LwD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 07:52:03 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4445C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 04:52:03 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id t12so354738oot.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ITWRk/eTq5UdPr0x/5SoQn8IfusyG6FxVQDqGg1ZLxE=;
        b=oNzLMGMCdb1Kr+b3xrRaqLM4zGhrFZhmqXJ6xGWiakJgHu+mekOIZHoqrYeKQwhVnU
         E2Mp65aOThsZYb5ptl99l00dkyaxI5oGLakdacncKxGOWh0H224V0M0WkGHzKL5DQfii
         SMGRlyso5ihNqvfzRvBatjZCP8hl2yghqbdqwduMUEpBoZvZxUPsUEeFcOuBC7zXijT0
         FpycyagWMar36IPiANy7r8IOIDerYPIGe+3h0TCA8l/z4MTgHWPdQ7MRvARGXn9aDQsq
         4/Rwgm7GGGw19tdML7Gu+4fHHxXI/sm4YOvltQffRbHtkcDUv3o/IVDq2o/k0QpH+5FG
         7VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ITWRk/eTq5UdPr0x/5SoQn8IfusyG6FxVQDqGg1ZLxE=;
        b=KuucNcLDn0OI+NWvxPcowwjpS8V3L2z2PXHPsur2EcWxcwwHdgODm7lwmuo4br428K
         zkYLLs1Xs5bpaE1wBUz2/v81rkaGjkXB+zT0A76tP/Bq1pY8Xy/peSZvbnUBq1AKLc/h
         /mA8mxyvFgA1QxVn7GRFrBsAvK1sHoccg7ODI3dZPzQGoc07K56qeSpTl+9yTqZOQIE1
         KQJEIS+mshmV57Hvk0a23nc/NbolNdezeGe4B9NkdUGvA/BPBqoojJeZ04pA2ynuPina
         Jx29r5J/a+6eNovndfJ5AjIi91o0KfHpfbmB94W/A8kjgO6pFWNtXRWURG9ajMkb4eu2
         gcpQ==
X-Gm-Message-State: AGi0PubjMMF7OmWhSsc527gxFcg5HqXYiSYlhLHaEkXBhhwGNP650PR2
        eQ2JDc4fzwLxGQ76+mmE0W4=
X-Google-Smtp-Source: APiQypLeiv+nbM7bhI+MJTP7pLvtxEsJqAobkJLiuIqECPpINHLLtnFH2D/XX2NEbmQKDK3Z95nQZg==
X-Received: by 2002:a4a:d8d7:: with SMTP id c23mr27000589oov.8.1588161123075;
        Wed, 29 Apr 2020 04:52:03 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t20sm218783ott.51.2020.04.29.04.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 04:52:02 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as
 read-only
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
References: <cover.1588004647.git.me@ttaylorr.com>
 <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
 <xmqqr1w85vtq.fsf@gitster.c.googlers.com> <20200427235935.GA14984@syl.local>
 <20200428033438.GA2369457@coredump.intra.peff.net>
 <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
 <20200428205913.GC4000@coredump.intra.peff.net>
 <xmqqd07r1fu6.fsf@gitster.c.googlers.com>
 <20200428210821.GF4000@coredump.intra.peff.net>
 <20200428214413.GA47690@syl.local>
 <20200428215815.GA8526@coredump.intra.peff.net>
 <xmqqmu6vyz4q.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c88a9169-47fd-2fdf-823e-d69d59f406d1@gmail.com>
Date:   Wed, 29 Apr 2020 07:52:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu6vyz4q.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/28/2020 7:22 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Apr 28, 2020 at 03:44:13PM -0600, Taylor Blau wrote:
>>
>>> What do you want to do about the final patch that I stuck on the end of
>>> this series in [1]? If I don't hear from anybody, I'll send it as 5/5 in
>>> v3 and we can feel free to not apply it if it's controversial.
>>
>> I have to admit I don't care that much either way about it (see my
>> earlier response on three mental models). I'm happy for you or Junio to
>> decide. :)
> 
> My gut feeling is that our longer term goal (if we had timeperiod
> during which the codebase is quiescent enough and infinite energy to
> dedicate on code clean-up) among one or your options should be to
> consistently create files that are rewritten-and-renamed read-only,
> to discourage casual tampering, so I am OK with that 5th patch.
> 
> Having said that, I suspect that Derrick and friends are larger
> stakeholders in the "chain" file, so I'd prefer to see us basing
> the choice on their input.

I'm happy with how this discussion has gone. I'm sure the only reason
for the permissions I wrote was because I found them somewhere else in
the codebase and I copied them from there. Memory is fuzzy, but I can
guarantee the deviation from the norm was not in purpose.

Thanks,
-Stolee
