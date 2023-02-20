Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D792C636D6
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 21:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjBTVmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 16:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBTVmF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 16:42:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D78D1F91D
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:42:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n20so1278488pfu.12
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxbT4djABpwSo20guAxUdHWfW0qXg6cd1TAkRHnMt6M=;
        b=HKh/z6b1UggqxWHEEf1wwnkqeW3Yr9CcxGAzzObsosVDJru58ioocp+McY+kf6GW4F
         ltzNH4OycszmvZMY0r1Gjot1oI692hIG5P3yvwL0FbSEuQo5d88rL89Npe98F9pJ+XeP
         HkxbUviK4BkAI9hIQi7cB8NNVQei9pyvOOK+PYHSfZyGsq6HApsYtEzp/D5XueN35pzC
         jyChr3EQCqQX8C9M/Ag00RXyeyl4xJyLH5CWqGPg/07V2VZ1ySmyv2BO/OdF/+bZbwXp
         N3c4XuqED9GzyNgxq927y2zxMbekTNvJTEZ+VoRKyplnpSHYgKwt/JBQWZA6c47UjNDl
         lHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxbT4djABpwSo20guAxUdHWfW0qXg6cd1TAkRHnMt6M=;
        b=ZwLLRsPgw3I82pVvDdZLxY33iFMIs2TlyLP/YuJItBY4nXkPSWFYVtgWakZFp+iFL0
         2KdbHt/KsvVGoIR1iJcw7qoNCSIFsSanEUR1ImRFBXLR4AgtiQeUihbLwkE5We5fxwyR
         fwbyeMhr5Qj3O7oQ9xkAHe3/dSbimreC4cLm0lP7Yf16fH7GXSEcIy495/tzbxoaR7nP
         0qkZNJU6ngU/6pFMFVGpTAQ+ByQ7EoAMpebEX+TRFkE+AG4lQKKx+F0WT7ozHimHgU8I
         br0uz397KLr4p9pxRRNgslyHicpOQjStWmni8YIkKbEuT4AQIsJBl5KPyo3JsYJAi5RJ
         rwlA==
X-Gm-Message-State: AO0yUKWP81e8DT7u3M+N/tigZmrY9xcbulKQLvTjVrp17DDxO17jGSIX
        l6L22vLW5gy36j3GUCWjdit6Sc3E9lo=
X-Google-Smtp-Source: AK7set9gjsyNcsyZ69EI+8/P75LL6HONf1qKHBgTWjybCQP6RLvUgr9GFoqYXcD5MRBSfZ6dEB0AEw==
X-Received: by 2002:a62:1952:0:b0:5a8:4b70:885f with SMTP id 79-20020a621952000000b005a84b70885fmr3184951pfz.18.1676929323986;
        Mon, 20 Feb 2023 13:42:03 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b005941ff79428sm8363453pfn.90.2023.02.20.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:42:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/2] rebase: add a --rebase-merges=drop option
References: <20230220033224.10400-1-alexhenrie24@gmail.com>
Date:   Mon, 20 Feb 2023 13:42:02 -0800
In-Reply-To: <20230220033224.10400-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sun, 19 Feb 2023 20:32:23 -0700")
Message-ID: <xmqqr0ukggk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Name the new option "drop" intead of "no" or "false" to avoid confusion

This is traditionally called "flattening the history".  Don't we
confuse uesrs by introducing a new phrase?

rebase-merges is about transplanting the history without flattening,
i.e. keeping the mergy commit graph topology.  If there are only two
kinds of rebase (i.e. keeping the topology which is rebase-merges
and the other "flattening" kind) operation, shouldn't the option be
called "--no-rebase-merges" instead?  --rebase-merges=no is also
understandable.

> in the future if --rebase-merges grows the ability to truly "rebase"
> merge commits by reusing the conflict resolution information from the
> original merge commit, and we want to add an option to ignore the
> conflict resolution information.

I am not sure why such a change "in the future" is not merely a
bugfix of the current "--rebase-merges", though.  Once it is fixed,
is there a reason to make the fixed behaviour only available behind
an option?
