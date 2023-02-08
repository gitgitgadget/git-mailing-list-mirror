Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE2AC636D7
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 20:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBHUzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 15:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHUzj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 15:55:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00D233D1
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 12:55:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so85556pjw.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50hfct9YegohUi7MJ7ImFUfoAnf5xjaoc9X7Q6y4Nm8=;
        b=TuvN+1el/MAkTZ5GvSSObl4EXz2e0LluW6HDzdYIHPVgpt+HCM++hUkygNEjluyd/j
         fvoiNq0WM7jM+6d5uw/rb+xl1wfr2Qpf26mk5eO/jv5iOIIhHnIRGYe2xtZQhwnSoTJX
         UQZ7L5LLq2coA1rcmvqadrcHKrumiqWSnKuWepVBspkOV8rwjuGKa6qXy/BTisNNSWQL
         y4zPTKUOheYhlwueqzViv9+o8ovt7hy89sqyRwsrBSZQyIIgK6IclDuEzMCArTQZF2E3
         BmrtYeJSXEjFSOFYY4Yo0L6jhiX2d+hligFRkzf+vwlybFd62rkO3nVHzAh0ZzJ5kzdK
         6PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50hfct9YegohUi7MJ7ImFUfoAnf5xjaoc9X7Q6y4Nm8=;
        b=XdehjMAtqETnFaGEKgGvFkgp24k4wbij9o8KzMH/R/Abb3ksY7OqN98LsOceBRVhz7
         oVTXXf9fptXi9MLDQyHXkIRKp6Gyyl3Orx9wQ9jzkKTe3tTg/fvuWDB5SrH/qtEEKawE
         DdKhNW03SJ2BM3ARl8hFDcG4Xnjp+CKsGSdWIOWn2QtTjA4iW4J/uLsRH5vwLI2m8exV
         XZhzWNF9AKDUXX/vDXto2zB7cQdl+qAGVaDsll2BTDWmXpmKHl0uczoqEcU1DOEhaRt3
         cESazCYe4/akLkQjNBsb5k7wAakNveX3zzn1Ft6VAyNN9eKo4z5I5fwVBuT6T+8mDqj6
         rQGA==
X-Gm-Message-State: AO0yUKW+jb0wEQvQHQLJC1QcMb1AoLLnwkoVqwfFp1tbtfGGTD8HwB8x
        76rygB3PRJ97gs3iSly9VbU=
X-Google-Smtp-Source: AK7set9SCinyxOt0nbXOPeMX2MIvlFl7VEzWkCd/b5ANfKgMPCcxY6Fu35CEepN+Mfqx9mZIwwjYPw==
X-Received: by 2002:a05:6a20:9382:b0:b6:3e6e:af94 with SMTP id x2-20020a056a20938200b000b63e6eaf94mr10182098pzh.32.1675889730181;
        Wed, 08 Feb 2023 12:55:30 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b004da5d3a8023sm10066335pgf.79.2023.02.08.12.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:55:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, Jeff King <peff@peff.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] userdiff: Java updates
References: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
        <20230207234259.452141-1-rybak.a.v@gmail.com>
        <e16e4190-9db0-1519-0114-858118882d5d@kdbg.org>
Date:   Wed, 08 Feb 2023 12:55:29 -0800
In-Reply-To: <e16e4190-9db0-1519-0114-858118882d5d@kdbg.org> (Johannes Sixt's
        message of "Wed, 8 Feb 2023 21:51:01 +0100")
Message-ID: <xmqqedqzri66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Yeah, let's assume that nobody writes code like this.
>
> This iteration is all good!
>
> Reviewed-by: Johannes Sixt <j6t@kdbg.org>

Thanks.  I think I've queued this round already, but let me amend
your Reviewed-by into them.

