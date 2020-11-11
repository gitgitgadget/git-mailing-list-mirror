Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52181C388F9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E183020791
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nk78pkgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgKLBcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgKKXcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:32:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E6FC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:32:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u2so1789639pls.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=udHTSmjtU7WDGTt+BpaC7khkqC+CV87nVMGO1Y368UA=;
        b=Nk78pkgc8E+l4nKVCTxzd378CpMC1+iHFVTYe8ll2OZyknsDMBHcvVhXofzU1kJEHu
         FW09Tv0i4l3fpKhP3z3L61AadTG2gbAlCf0f0SkinrdyiGL8h6Zl7CuYXT0iA18kIVLB
         JBlgYAGMSd1JO112OoBW2sf29Z35FKzeOCweP2angTB1YDw9BoqGKnpCg15QblbywsLw
         yfoWzp6jF76zJCaosZeqnXFmOKbB3dXykXsRVeZDafPnza87ROSAm9KmOsqjhZ63z1I3
         e1zRXervDfR9wwWJ3U94+tioTV+gm1eebbQAR1K1yRO1J4R7YXq2d7V9ylS/+9vSdV+s
         w/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=udHTSmjtU7WDGTt+BpaC7khkqC+CV87nVMGO1Y368UA=;
        b=B4p41IPrC2bJ6vARisaIbIIRpOqo5AW+UbE7In350CggfX9zWYjVpWqEPHebfRwUu5
         bJPAD8/g4/w7zBCG1uuQKJfHJw9Lwkt2DGPYKolyIQU2ZrPi6QiOhw7lb5j/dE+/yvr4
         ZSWII+AwpSPc9DWReMZdF0BGoAossChLf0tjHBwJoY681lZayzVllFpqpZEJpe/nR2OF
         N0bXim+qVpUs7hnenGGlQD6XgEgAGqoIomttL99fxRjTpwqA0NU3cBItOfPguKwgmrA4
         Lfh0MUTOJ255suoL5o1BEcdNbWs75xmHYx20BkWiZgt8RC/YoafK2fRJO9cjyG87Psey
         aXAw==
X-Gm-Message-State: AOAM533scZcGEs+QmoDzqBODUGRTGuvcO5oWg3cCjhT0fM12A0795+0S
        0qls2cMbNeiBbTQ3Br2yBms7Zg==
X-Google-Smtp-Source: ABdhPJwW2FHVz4MhPA6a5xM/fde8u9xVx1fZsRASJjqCKJ29UIB4CgkiXfRRxKl4yhCNov/oCvFqwQ==
X-Received: by 2002:a17:902:d713:b029:d6:c5aa:c163 with SMTP id w19-20020a170902d713b02900d6c5aac163mr23668932ply.59.1605137536031;
        Wed, 11 Nov 2020 15:32:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id n1sm3721904pfu.211.2020.11.11.15.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:32:15 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:32:10 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 08/11] fetch-pack: advertise trace2 SID in capabilities
Message-ID: <20201111233210.GH36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <11b5b1b54f14354f08c9eb230d5b4e6a3de1996b.1604355792.git.steadmon@google.com>
 <xmqqimaklsvg.fsf@gitster.c.googlers.com>
 <20201105185855.GB36751@google.com>
 <xmqqd00rk3t6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd00rk3t6.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.05 11:21, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> >> The same comment as 05/11 and 06/11 applies to this repeated
> >> appearance of this boolean expression:
> >> 
> >> 	advertise_trace2_sid && trace2_is_enabled()
> >> 
> >> If we are committed to stick to the "even if we were told to
> >> advertise, do not alllocate a session ID" design, perhaps it is
> >> cleaner to clear advertise_trace2_sid at the very beginning,
> >> immediately after we learn that the tracing is disabled and the
> >> advertiseSID configuration is read.  That way, everybody needs to
> >> only care about advertise_trace2_sid variable.
> >> 
> >> Incidentally, if we decide to change the semantics to auto allocate
> >> the session ID if advertiseSID configuration asks us to advertise
> >> (it is OK if we do not enable the full trace2 suite), we can still
> >> make the code only check advertise_trace2_sid variable, without
> >> adding repeated check of trace2_is_enabled() everywhere at all.
> >
> > Good point. Once we settle on whether or not to advertise when tracing
> > is enabled, I'll update these conditionals in V3.
> 
> Well, we can update these conditionals _before_ deciding that, and
> that is the whole point of the part of my message you are responding
> to.
> 
> Whether the advertise_trace2_sid means 
> 
>  (1) config asked and tracing enabled, or
> 
>  (2) config asked and we do not care whether tracing is enabled or not
> 
> it makes it easier to flip between (1) and (2) later if you clean up
> the conditional first.
> 
> Thanks.
> 

Done in V3. After some additional offline discussions, I've been
convinced that it makes sense to advertise the session-id capability
even when trace2 is not enabled. Specifically, it can be useful on the
server side to identify multiple connections that make up a single
larger operation, such as in a single `repo` invocation.
