Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7ECC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjDXQjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXQjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:39:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3410DC
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:39:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso6330796b3a.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682354349; x=1684946349;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yryzfWcmYqyOZKQ1BelbZ8gLhp6ulFfC70eTWJ1xALc=;
        b=Mex14OPlzgarcDgiRvBeyBggvx/gVixZJ9nuumsRVpXZXJrDtvmHCOT/CBxdlsKuS/
         sRzO8Y1Q4tu6xlzsO27LE8xJjdhFoSI/aIQaCTr3GV+5AX3ryAL3v1Ht/9F6YJB0Lrnu
         BjPHHOlUEqNLXP57Nz5cEhRmulmhx3Dpx7/E3XRgWdTgQ33gh0+Ceo8zeDZKStEl2Ppi
         UxWvxuECSVj93ioYJwtEBpNzvK8V3brt5li9Jy4MOdqTjLXijnOcl2CMGZ8VXnk0Ueph
         vvrBggfyfZIFYE6HhsbFq1AOUC5r6rKLVQtbqiKEKWJGiC8fxW1wg45VLjxhB1DguQqF
         kbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354349; x=1684946349;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yryzfWcmYqyOZKQ1BelbZ8gLhp6ulFfC70eTWJ1xALc=;
        b=YjI1ecmlWbklHhV4yeRhtzXxIKxnDzRvKQF+28UKSN+dEz1CxYG87GRXU7XqwC4IPT
         dnk2mu3XAuwv1C8nFDedjg/zky/bvmZeucRQzJqn9b0nIWNaBWgHphu1Ds+ZVtyhPVOO
         fq1fhI0ENVB3kYZjhXkEtJrrbQZWNf02XgXTKOM/m4bCFLjtzLbY096E+ngbpYYJOGk3
         hJXSbIBwvZSYI6QjXHebN9Kdccv6CTIdu3DnF2QisgfU3WnobwXUi9zgKIw9I5r/Zgb3
         7M6h6GmuwHes+lNnbezfomK0T5uNDKuCrTsjVp/FUSI8L3KPTEpqVldTl+W7C3U/OGro
         Kvvw==
X-Gm-Message-State: AAQBX9exPmh2sebQD9HrVEXjs/r8v/hSnKB2VPQeqKtlbVQl61gNX5kS
        JNCBbL2MrLwf8OGAtS5IAFA=
X-Google-Smtp-Source: AKy350YE5qHdhYwX6AixiERHf7qFYFS8ei1zayVKwftL/FvH5YqpusPhQaBS1ls5rQYuVrLmUnLRbw==
X-Received: by 2002:a17:902:e883:b0:1a6:bb7b:7a68 with SMTP id w3-20020a170902e88300b001a6bb7b7a68mr19475773plg.37.1682354348848;
        Mon, 24 Apr 2023 09:39:08 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ot2-20020a17090b3b4200b0023cfdbb6496sm8674953pjb.1.2023.04.24.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:39:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: tb/ban-strtok
References: <xmqqwn26w5cd.fsf@gitster.g> <ZEHyBbKN5MuxqfQn@nand.local>
        <20230422112213.GE2969939@coredump.intra.peff.net>
Date:   Mon, 24 Apr 2023 09:39:08 -0700
In-Reply-To: <20230422112213.GE2969939@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 22 Apr 2023 07:22:13 -0400")
Message-ID: <xmqqsfcpfd5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I would be curious to get Peff's (cc'd) thoughts on this series, since
>> it was something that he and I were talking about off-list. It was one
>> of those "let me see how hard this would be..." topics, that by the time
>> I finished investigating, I had the series ready to go.
>
> I left a few small comments on the series.
>
> On the greater question of "should strtok or strtok_r be banned", I
> don't have too strong a feeling. The hidden global state in strtok() is
> bad, so probably worth outlawing.

I was and still am inclined to say both can be banned.  The primary
problem I had with the original series was the way the replacement
was sold (namely, string_list based solution is not universally
superior but it was sold as if it were, and the sales pitch should
have been that in our codebase there is no usecase where strtok_r()
is more suitable than string_list_split and friends).

> I tend to think that strtok_r() is a bit confusing to use. As Chris
> noted, strsep() is better, but not necessarily as portable. Using
> ptr/len pairs to parse via strcspn(), etc, seems better still. But that
> is mostly aesthetics and preference, so I'm OK if we don't outright ban
> strtok_r().

I am OK if we do ;-)
