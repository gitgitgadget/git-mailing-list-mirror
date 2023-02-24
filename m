Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29FC7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBXR7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBXR7i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:59:38 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1F1ACF0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:59:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g12so8422754pfi.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kPWV4SQJGbuTfeRF9owFk2RJSoXtWMcHoP9N4FhziI=;
        b=IbsaubxzWHCQrex4fi/A/zextk4UZbyveF2ccy/AMF72pOk4Jc1Ok3f9zxBvQYHOOY
         cVn2VNkT4qKj7fCqkB1/N2/4JBQbq5PsYDrP+6BlZsSSsSENv1C0T1osyk6WwXWr8NAj
         TLvHgkkYtK1qYVKvyVOT/0XS9J38tvB/7nEdBVhCbR18jINoan6VmznjKqKAzG61dFGk
         frObOp9yH/ea9ODBMHVA3lxTcDEWptV1Q+hO3idTtfKDcnevFv5LJNRHlvj0QOdwms47
         Qt7mxG1/kr5EsFSSunkHt/cqvt0AeBSfgNQ2k+VdC8a/epplpgKrJvtRLSKow+1kqxen
         +Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4kPWV4SQJGbuTfeRF9owFk2RJSoXtWMcHoP9N4FhziI=;
        b=Uwllj/nhurxzAOi03iYnfeOO4SfPdyft+4J7HwT5Zqtjp3TFaXncGQmr2aiw3cq4u/
         p4d8lGK2pxZMuYEs4V9WxyVez6xDkNlIj4ebfB4aGJuVeCGcu9EkZChm3zR8O7egd/Ef
         qDBVI3mckdlYRLNve3rXHGXozC1DguoTi2p+QUujKe5ZwcPPCiz/PK9E+p46lXvLwJzb
         C/VKb8GsOcQht0zwFJ+varOgqdOhyHx4kF0JEbK9qNNm3sUInbw7Z9HyLstvLUxugGNZ
         kHeqAVuJOrANLsQFezoiBSGm6ui6Qr2hd4MWwNTngIj0u4xWENG5ukiSwD9kXKeBuQbV
         4XYA==
X-Gm-Message-State: AO0yUKXz+eqzu8Dk2TAnDoK2dGJ1v3dLEmfuIBHxX14dFfYvpkndF/Ku
        WUr8c8vDpnrXTHcNN7roQepRvMeH6rk=
X-Google-Smtp-Source: AK7set9XaOolxxmtIxYSl5bMdaQxQSP5/augdr9yWTVlVmGIeLgP5efL7CdWqQPiI/7clbujRK5zcg==
X-Received: by 2002:a62:1507:0:b0:5a9:d5c7:199e with SMTP id 7-20020a621507000000b005a9d5c7199emr15531663pfv.9.1677261576593;
        Fri, 24 Feb 2023 09:59:36 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b005e4d8c6168csm1357053pfi.210.2023.02.24.09.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:59:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/21] serve: use repository pointer to get config
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
        <Y/hbUsGPVNAxTdmS@coredump.intra.peff.net>
Date:   Fri, 24 Feb 2023 09:59:35 -0800
In-Reply-To: <Y/hbUsGPVNAxTdmS@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 24 Feb 2023 01:38:10 -0500")
Message-ID: <xmqqilfr0ws8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> A few of the v2 "serve" callbacks ignore their repository parameter and
> read config using the_repository (either directly or implicitly by
> calling wrapper functions). This isn't a bug since the server code only
> handles a single main repository anyway (and indeed, if you look at the
> callers, these repository parameters will always be the_repository). But
> in the long run we want to get rid of the_repository, so let's take a
> tiny step in that direction.
>
> As a bonus, this silences some -Wunused-parameter warnings.

;-)
