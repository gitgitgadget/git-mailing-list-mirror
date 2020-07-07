Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F279C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4C620708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHgbuBpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGGRV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 13:21:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990DC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 10:21:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n26so33487293ejx.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X7TySk6G9BzID2uIDMFna+3tzgeRKrXSyNfyXysGpZA=;
        b=cHgbuBpk+i4CNXWEaEVdwe/7mmdmYXARm4NP+OspgW1ueocy9s4yqW/L5bshNWwMYq
         kp1+iv0T5mgEEa/KGjlRrkZMjGYvirA9CbpQoMLWG1aic4DXltqF16JuNoaGR0KZySNj
         wgy6V/OCv3PP09Fvq6esyrpeH8fwirAl2S1d7IfoLICMlFV7GjA/Y4XA9G7RslAklYy8
         aa1aRRZGGpuDpu0GwR6WmZNXiSLDZUi8kPyM/uEXD8zVSALYvnkIblJ656bPal2kJMXP
         7g+pzLx3jKqG4lRj04blFgt9K99jCaThCJUi4Zbj/1uDBFSfIADkv3/8DkKUZUKqPkSh
         mi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7TySk6G9BzID2uIDMFna+3tzgeRKrXSyNfyXysGpZA=;
        b=W/NwpXiNwzYIcaf9PysitReVkdptXNMak2OhhfMKDbbqtrhCPbjGsXAtRnpn/If3RG
         7reA2Gu3Irs1CXwnUAfI5tmWfEmhH/w+7GJKdTuUz0+ZvDGZBjGFXVnZapVlIcjFvdJd
         j3WTABzJlifMW4mYw4uWhm4V6HBbTeV2AaFy66XbuOAoAfBbDL6P6Ach+1oALSKP7C5H
         qBGJWRkkHN3wmabXKsaTRjKoilaUuken2ecB5/sagO8+sTzG3AbGET6RPV4DkS9WZWgW
         7+qtj4NKIANpBRbs3WrqMthxULAetKP1q83iwdv2xDePNyTIDnJBOIzyn5nS4Dcxz2fx
         E3jw==
X-Gm-Message-State: AOAM531FIDMnlZy8VmBRyAp88rLmEeaXaQFHQlnp20eAkFMT1W2vhXZN
        e4GAjqtfQ8kPVRaIC5ecRBY=
X-Google-Smtp-Source: ABdhPJwW17Z2PoJjHGP1NEaAnr6+6fNgfrNB1o2Tf0djhGkiOvjCzqRfhVsrwDaepdPeDHqBNWWlEg==
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr47020848ejb.57.1594142485533;
        Tue, 07 Jul 2020 10:21:25 -0700 (PDT)
Received: from szeder.dev (84-236-109-193.pool.digikabel.hu. [84.236.109.193])
        by smtp.gmail.com with ESMTPSA id y7sm642515ejd.73.2020.07.07.10.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 10:21:24 -0700 (PDT)
Date:   Tue, 7 Jul 2020 19:21:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul
 2020, #01; Mon, 6))
Message-ID: <20200707172123.GD11341@szeder.dev>
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
 <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
 <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
 <7ce9163b-eafe-20a8-bd8e-7042807c98f0@gmail.com>
 <xmqqimez5l5q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimez5l5q.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 09:45:21AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> >> Oops, I am not sure what happened here.  There I thought were issues
> >> pointed out at least on the latter series but was I hallucinating?
> >
> > I believe I have resolved all the open comments in both series.
> 
> OK, then I do not have to be worried.
> 
> Let's merge it down before -rc0.

I think it was merged to next too soon.  I haven't even done with
reporting all the issues that were already in v2.27.0, let alone
looking through these followup series...

