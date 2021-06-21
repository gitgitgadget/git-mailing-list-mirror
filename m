Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE34C48BDF
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 00:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC656109F
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 00:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFUAio (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 20:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFUAin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 20:38:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED8C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:36:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id he7so25711142ejc.13
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ks7RChT3z1lkU7riVS0U2Hj/H1ARyoVHf+HezoxlDJs=;
        b=NOQTaJbdGEfVnsZ26VQDYfQBiX7qgJE6ap9/bEvFsxjS+Gwc0ZUyVmrqjtJcrWmfYT
         k6YN8+2XrXsHSy/Mtw1kvZCpXR8cJS5UNZGZN7spOa9rOJA3bpYtbvGs40MUYD9i3xO6
         21T2fRdtrivm4Yq39fqyri5vEz/P1o2vWTPxs7Frt+tpTcW9E1UX/w04spRb2YUCG4Ek
         n6ORwkYwZzNzmr83LqHGolfvo29pPhWR1fultyH3Mcu+skfCAwqRZ7bQHJz5/pz24s3y
         GWYXPF9Yyhp9aq3pDmKvo7Ne/b3uWOHB1EQV2mUH47gkwJeOmmOuiEc2aDky2wOL926/
         274g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ks7RChT3z1lkU7riVS0U2Hj/H1ARyoVHf+HezoxlDJs=;
        b=KWOAM3VZomXifFccAGw0RnbaCVDjr0UvQs6FMoMrBFvXE8CBaxw1C9EAUTwW5ODy/k
         MDe7fNQ+zFYiUMg+9OLvncKRJHv6Sg2Aqvg2GD5ScNPDDNpcCPqG4gEDIKWapaApEbsH
         /fGpnCs7iYUjCsBIKkX3VccNYYGl1rJxkg/kSZ0U4QQx9+xzk9N4kmjp9GmUEXNrzoUk
         tYKnL1Ll+fqtvf58kV4WHZptGHZPjMmrNPP2gSuhpLbXNCVEijOOzIq6w+qdBN47wlFF
         3PB/uEdmm2mDYffTSCWqAqgUaj5jimPQ19xvBJYrxDsXK4N20i6twNW4AfbeEHc/gIYF
         Yjmg==
X-Gm-Message-State: AOAM533ND8teUDtlHTcx8+xnvzUResjG4HSv9D/oNBsTG/kH7Ycsvqp3
        Iz0zYJaCQxoE+NFSK4cf6fU=
X-Google-Smtp-Source: ABdhPJwIGG/B44PA8eqrww/CZTv4+pAxzedR85w/St0AfuRbQsP2PcsuTCfib69yTfPhlLHLDMs8YQ==
X-Received: by 2002:a17:906:dbf8:: with SMTP id yd24mr21690886ejb.160.1624235787369;
        Sun, 20 Jun 2021 17:36:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bh2sm4085528ejb.80.2021.06.20.17.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 17:36:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     git@vger.kernel.org, Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Date:   Mon, 21 Jun 2021 02:35:49 +0200
References: <20210620213836.10771-1-rhi@pengutronix.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210620213836.10771-1-rhi@pengutronix.de>
Message-ID: <877dio3vg5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 20 2021, Roland Hieber wrote:

> Currently, calling 'git bisect' from a directory other than the top
> level of a repository only comes up with an error message:
>
>     You need to run this command from the toplevel of the working tree.
>
> After a glance through the bisect code, there seems to be nothing that
> relies on the current working directory, and a few hours of bisect usage
> also didn't turn up any problems. Set the appropriate flag for
> git-sh-setup to remove the error message.
>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> ---
>  git-bisect.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 6a7afaea8da0..20ba0ee7c18a 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -32,6 +32,7 @@ git bisect run <cmd>...
>  Please use "git help bisect" to get the full man page.'
>  
>  OPTIONS_SPEC=
> +SUBDIRECTORY_OK=1
>  . git-sh-setup
>  
>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'

How does this affect out-of-tree scripts that will be run with "git
bisect run", is the cwd set to the root as they now might expect git to
check, or whatever subdirectory you ran the "run" from?
