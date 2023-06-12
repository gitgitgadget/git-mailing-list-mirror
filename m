Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76FEC7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbjFLVZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238772AbjFLVZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:25:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80FD2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:22:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-665a18f5643so782494b3a.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686604974; x=1689196974;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrmsd448J74AiDShTGF7HCDSV6/GgYt2TVFwTzT4nsk=;
        b=C/oN6WCWKJlQMOxzgaJEfv6XRyqXcr2Wj1XUvPYK1FGzFOXfUm9uGKr2z1X+xf+cfQ
         7uwRiUXa4sDECu1wknyKNzJsKrk0cspi1PWtGrt5V76GZrKpP7e5sCJnZElZAtuG1Wk3
         0qHtKUe/Uoxi5uvQFkNu26X6oPM+lD4BmWimmVwDeI+da6DUP4FQ9YcHSt2gLToxC1Vi
         hyx5ovq9aNA1kBu5Y9+Ub07bWUq5vPUeODwKjFHJk+d/OCWWmfthWc9n1+F3JoI1xy7h
         4myQ1Nr7gTAWlBrTPKeUUHyIOTPuDnR7OoyGRVs1m95jl8rle2o4AHBBvGRbO6y+OIO7
         ACcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686604974; x=1689196974;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wrmsd448J74AiDShTGF7HCDSV6/GgYt2TVFwTzT4nsk=;
        b=HuOiJ7UEXXJVX832KrKCBauWbHTeL0BrQw3Qjl05Quo73FqWxwMw2rqWgTo+FfGjs/
         t/dKom/FCapUADZpJkYGgAcGAZGCLXhuI2UERRx40MoTbdeCfdRtRSJeT/VP6JbqED1/
         aE0WnvGqw2C8UqqpqPvkQ2hXof0xlurW7o6vDa641e3rKDB0kP7fIwhO/UTbfFQwJ4LH
         BGUqTBJ1bS1Z8aGsSsi/weIIO9xNKeT+QOWm6IR23hkcBC4GqmAuO5hw+gk6AMCfsrlX
         TIwrU3YN7EJaIpjEp+IxATY86eM8VmxSvu7CVf8TdN6vMcD6oc6ZVwt5zjcVsSfhAl0Z
         qsyg==
X-Gm-Message-State: AC+VfDy0TfsOSJRwMnrLb7tJz7UgsMDnHz5hwWfCCDRKpdUWfN+DVopL
        HAMYAJe+QKE/TKbuauejFk0=
X-Google-Smtp-Source: ACHHUZ54Dn7b4ZpNTKjrLzrTsn863UN3SHxipj+1fH1m6BOLoH6hB0DuQWwUcbEDrNuSt5SUlssxpQ==
X-Received: by 2002:a05:6a00:3a1f:b0:656:39af:513d with SMTP id fj31-20020a056a003a1f00b0065639af513dmr17001996pfb.14.1686604974376;
        Mon, 12 Jun 2023 14:22:54 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b0064d3e4c7658sm7530325pfo.96.2023.06.12.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:22:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] shortlog: introduce `--email-only` to only show emails
References: <cover.1686178917.git.me@ttaylorr.com>
        <44179d28fa7676965a28734e20584d54b44e051b.1686178917.git.me@ttaylorr.com>
        <67c66cd7-fb6c-3fa0-82c8-0e778f377f96@kdbg.org>
Date:   Mon, 12 Jun 2023 14:22:53 -0700
In-Reply-To: <67c66cd7-fb6c-3fa0-82c8-0e778f377f96@kdbg.org> (Johannes Sixt's
        message of "Thu, 8 Jun 2023 09:35:14 +0200")
Message-ID: <xmqqlego8jf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> A note from the peanut gallery: "--email-only" sounds like an option
> that affects the output of the command.

Good observation.  I had exactly the same reaction.
