Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E060C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D5A20878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCm1MEEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgJLTiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgJLTix (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:38:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B40C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 12:38:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b193so14463338pga.6
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IJ4q7wFlqbvViojEZkgF98VrQMP8PFjdMqHlzMhKCfQ=;
        b=DCm1MEEQB14dt0xOSXjoWHxomFxOKMdqxTAamFi3SQsjmrGa2Ho7NL4gEQ5mcWEQYq
         hEgpc6iGX9KbXVF2AXqAguWKFPrpzy/iWAVMcprrOlsoFXcBP2125qGq7pS8el3WHMIt
         09KaK2uShpisB/z1dxKutTnfOoAmRVsBq0zuimrENC+WSg0pOkWbB77Z/RIap4NJrcIB
         EkFxCp7vYYWLhQrJNN6T7oJcFKCrEYWhwa3DUOk6gXVEz7DKHGSzQ162oFHEvdtWF0jo
         BvfsCxA8lz1kAfcBS/YBFR1CCcS1HajaGyAVQwSyXxATobLXRwXKZUeO7Ygsp9qTGNTg
         CPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJ4q7wFlqbvViojEZkgF98VrQMP8PFjdMqHlzMhKCfQ=;
        b=VanU8PqiJdg40KzZ8RkAHVN3p0Ckqbi+AXd8wtmRMg9E1YBiOjJp5X5JxJqYsFfn+A
         hXTB53TeP4fAKsgo3Lx5xm9GgptLOkQgCMGa/yjELnQD9fUK6xc8F19i9ztwCZVOshY0
         P5R8EOpD3wJPqYFKFnCaN2zSv5m8ybrSqekjqzyqt/W4BbHiyKULEvDtPk+OHRqyyemP
         i/X1J33st6MBJ2e1J7fHsMC3lmvLxLhYR7gl2EYKvdRJSno6ds6ciwkM08e6cNgizfCw
         TyQwOUDIW4lPHevIT1tSnNxusDQqn+VtTCuyh4Gddu+VItAIiIesE6L00+TwOgTmFV1B
         eGWQ==
X-Gm-Message-State: AOAM532UhI/g6mcNkfy9aCQ0XVz+7liB2T/Tcbysx7tU4Wwd2jQsTn5y
        wIx9jKY/4GS0FEsbwphQdqM=
X-Google-Smtp-Source: ABdhPJzViySZKiKLi/nmfqx/TZbxQzdRX1CukRaq16O0I7yU0jLcmObOd9Ead0MG8iLQWrRyuq02nA==
X-Received: by 2002:aa7:8e54:0:b029:142:2501:34d2 with SMTP id d20-20020aa78e540000b0290142250134d2mr24257423pfr.43.1602531533337;
        Mon, 12 Oct 2020 12:38:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id g14sm20751505pfo.17.2020.10.12.12.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:38:52 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:38:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Patchwork now does the right thing with GGG submissions
Message-ID: <20201012193850.GE3740546@google.com>
References: <20201012180034.tu4rmeoadhy5j4w7@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012180034.tu4rmeoadhy5j4w7@chatter.i7.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev wrote:

> Just FYI, I made the necessary tweaks to patchwork to make it properly
> assign "From" for gitgitgadget submissions:
>
> https://patchwork.kernel.org/patch/11832689/

\o/ Thanks much for this.

For the curious, any links to the change behind the scenes that made
that happens?  Does it use Sender[1] or a different field?  Does the
change live in [2] or [3]?

Sincerely,
Jonathan

[1] https://lore.kernel.org/git/xmqqiml4bsra.fsf@gitster-ct.c.googlers.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/
[3] https://github.com/getpatchwork/patchwork
