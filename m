Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABBCC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0347261360
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhFAXOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhFAXOh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 19:14:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB1BC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 16:12:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so819764otp.11
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hLLYwcZ/+Ttsvg1WzJIPhy88xFBslBRAVs7Kpqj8Cxs=;
        b=fsVkCC369pKy0s7axBPCERbhb9+358wCBqS01wu5bK5qipDwTi4O+igUC8rpS7QwQL
         2J3MfvZill3DYhGf7Sj/unap/DK1rHQlrpeQURtpT44/y2ofn1LacgPPVuWzEogD7Vm4
         2nN8MiPuZh6JWP4xjHcF+2CYV+plR1IiH5Zv3FoASHJ98AyzYG6SfSfiKwpEOZbcsF0N
         kL8dz9fJtS9PuJk3BxshadiNQ6tzR9ax8e9ljFm2hUiBEXIvkdnWkIOp+YBmhd1HzvxB
         rjQOz+GOHAleQ1sWAkFix1JXcHyczwySw1oK5D/gP3r69AT04Rp/dl9bfEoG4xY8YMbs
         Oy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hLLYwcZ/+Ttsvg1WzJIPhy88xFBslBRAVs7Kpqj8Cxs=;
        b=swQqFyq6oIXHC8TXqnPz+XEbdjcukMuFKn46pEh+iQF74vhrfwaLk0sQkqJyEQO77t
         M8X2wLe4IMe8YCv3w07DnaB92hP2n6MD2SV5NrUcKW8ZZoJVNmI5ujMMeqU8XviXOBmg
         KtWfJbmH97o75O+7PtWvQDDapqBkKQSy5RqmffLuWI1QtEg7nqrPKVLa4D75Qd7R/yFG
         eFAv1hSmp21zGyrHCZQ8EM90HKu/mvZVNS9MjyemG8oCdPgCQeHEPxAK06z5/cKZVMIz
         gEZwaeLnE9RhnDmTgSRpnvYhqo4xsTxZLqs9k3p4zEuuvIZcMPatdxcjHZHAWeHAAaaZ
         cNZA==
X-Gm-Message-State: AOAM532FrsSqqNPUopwCC2vmiVsVEMRD7MjI5cVcv6v1a5Rr4h7gXvDD
        Qw9M/xmVeVPmUQdQhSv2miY=
X-Google-Smtp-Source: ABdhPJx1nRMuBaLpsZALv53Z848dinw3Qj/lh//XfGYpXIk9nfe7ydK1bwYHjgn/ntBIX0gY/wnXnw==
X-Received: by 2002:a05:6830:2fa:: with SMTP id r26mr662607ote.325.1622589173660;
        Tue, 01 Jun 2021 16:12:53 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i2sm4061245oto.66.2021.06.01.16.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:12:53 -0700 (PDT)
Date:   Tue, 01 Jun 2021 18:12:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60b6bef41791a_404420881@natae.notmuch>
In-Reply-To: <xmqqzgw9qky5.fsf@gitster.g>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
 <xmqqzgw9qky5.fsf@gitster.g>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > +1 for merge.conflictstyle = diff3, rerere.enabled = true, and
> > log.decorate = short from me. I noticed others already mentioned
> > these.
> 
> As the inventor of rerere, I agree on rerere.enabled.  It was made
> opt-in only because I thought it was somewhat risky when the feature
> was introduced, but it has been stable and useful, and it is long
> overdue to be enabled by default.

Agreed.

I personally would like some interface to see what's going on behind the
scenes because sometimes I've made a wrong resolution that gets carried
around and I don't know of a way to clear them (other than manually
hunting down the cached files).

But this is not a deal-breaker, the feature works great.

> I do not think of any downside with conflictstyle being diff3 (and
> think of only upside).

Same here.

I recall reading about issues of a GSoC student resolving conflicts and
setting up a mergetool. And he (or she?) mentioned the advice to
configure diff3... I didn't even remember there was anything else.

I wrote vimdiff3 precisely to edit diff3 output directly, and I've never
looked back.

-- 
Felipe Contreras
