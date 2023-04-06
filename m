Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34AEC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 16:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbjDFQeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbjDFQeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 12:34:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6D7ED8
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 09:34:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f22so33874548plr.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680798861; x=1683390861;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lk3M0NCRxu8tbnKd5oUX735hDQKTj7uTHk+WJezR6ko=;
        b=iVjry3KMT6H6CHWT0UtpuIv6hq6adAEYNPV/LcRkRk56l2IabZVwmqBlPCRMNnToGc
         kVmWD/UqmIbzazQq7TwDs/3zTHFH7Z6j7piCI4+Hy8hhOvVLYPRSlW95k5Wlz2lOzIrr
         6iyZbFq4gEKZq7ysVtW6kR5QSW2/cdAr+yLqOWqF2QOjkNZYiKXwrOeUtU9yjdJUFPhi
         Jk2ySDe7gKgWkRF2sdAFbN5zAKH5edLtOEszai8o3fFw/6QeG9qmx4J/QMesQaFKuhRR
         8CfwR1hEus83wbd35rkdRJMjs40YW9111daJv9S/+NA9PSyHiJGhD8Po4g/ihz6I8BK2
         YWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680798861; x=1683390861;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lk3M0NCRxu8tbnKd5oUX735hDQKTj7uTHk+WJezR6ko=;
        b=5OSA1IcZW1tyfe+3RO6nAuQS9zqyLmArWzA99LaHpTSarUfUBf9Og/7x+7Hma+4Kcw
         fpDbBFWlP/qvt5lRk6UD/FCC8Ve7hD6vqSKYsWL67wKhSDhwwOeFNnhQRqyznxAUvtEG
         KtQSgECxcVN2t6wjM6rJDIjaejB63vCQgFK9ut7YDEk5lU0efhI1y5xw4N5njLjKkMOd
         AsnH+J+6NEa5fhDf1YzEtr7kSdLBoTzXf7eIYjphykRqBJD40djb+GB75MJ+/vofIo6W
         BaWUbVgAT1/KoK9s8Mguk6ie1pFX9l7BGj0eA848DUYKmnA6eg3Ydcw2sWW1ZN+XFPMi
         i4fg==
X-Gm-Message-State: AAQBX9fVv+d7AfJ7bV0d4BuJhww8mmAtAsmAnVVOPVM477+ek0oTR2kz
        T+dNbJLHOdxvAJ+yd6tAsP0=
X-Google-Smtp-Source: AKy350b9JDuOondG7QrfhyGfywD/fCs27/t4MHe5H4vcevNZ3g/ezFtdYA2VsdfgMqbbtB70m/fF0g==
X-Received: by 2002:a17:902:c60a:b0:1a2:8940:6db8 with SMTP id r10-20020a170902c60a00b001a289406db8mr8239836plr.69.1680798861129;
        Thu, 06 Apr 2023 09:34:21 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001a072be70desm1596221plb.41.2023.04.06.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:34:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] t/lib-httpd: pass PERL_PATH to CGI scripts
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
        <20230406032647.GA2092142@coredump.intra.peff.net>
        <ZC6AdylF4TI41vnX@ncase>
        <20230406093602.GD2215039@coredump.intra.peff.net>
Date:   Thu, 06 Apr 2023 09:34:20 -0700
In-Reply-To: <20230406093602.GD2215039@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 6 Apr 2023 05:36:02 -0400")
Message-ID: <xmqq1qkxq8ab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: t/lib-httpd: pass PERL_PATH to CGI scripts
>
> As discussed in t/README, tests should aim to use PERL_PATH rather than
> straight "perl". We usually do this automatically with a "perl" function
> in test-lib.sh, but a few cases need to be handled specially.

Thanks, all, for a discussion that led to this simple solution that
allows us to consistently use what the builder specifies as PERL_PATH,
which we document as the way we aim to invoke "perl".

Will queue.

