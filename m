Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B8C432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 22:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC2A222DC
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 22:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6gxeOdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKSWvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:51:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36873 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfKSWvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 17:51:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so5757747wmj.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5fV1xj/MIVyJF4Nh+It2VllE9z2jvdw920QBVWTuuo=;
        b=s6gxeOdTP29wPCobSaw97ojNfln/F+QtWvBomWRCSjHrPbT419cUmh5CLsDuacdMMU
         52TglFVc7jXoX7jen1UKYMQz1pqeWOCz4LRBPhMe+atixt4OGA/phUyynzEfBAtPpEeF
         nK9+jexAXxxfCa8uxWKBI7AXzFbNbQRARo1TkJL5jn3L88Ipq18uvAN/ClWx9irJvXmh
         ufBybbVemUsrHm8/afR90ux0F5iPsCKgawxVFbmAhGarqGSEEr4QjXl/0DlXj7vyKgES
         91pMqiM534xtrGIo7wEEU/Tfo2n+CUo9Fb1zJRYPFN0Vi2GvZj8pU9AZ7nMdoWNwXK2e
         +V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5fV1xj/MIVyJF4Nh+It2VllE9z2jvdw920QBVWTuuo=;
        b=boNXX3O+U71L0fiyV0zxF6asgHntWX4W6ZOUYmiJm0ZCWjFAMrdI7uPYRfLgxOarZJ
         8BZYisGsFJ61NoWGM5J0jUTWucifOzSX68iA8ZcBmS1nWWcgDrTo+KeZ3a+qOPPGedC2
         oeH3KFWk4AyUlHFmz23PONltO7IGYn9kawKP7k3tDLBz/PmNzh2izMYA2JhJA02YMkpf
         2ztFLGfwcntHXkOE8RT7G88qgCAj2JxijKm/Ezb97uOdL/BR5D/K9TZgs4tj4WG/OwgT
         bVVj/SMru9hGIc8kRTu7YZF7WxgkjMC1jn3b5O67MINTlClxh7MAD/gDoh3OgNqP+KjZ
         fZHw==
X-Gm-Message-State: APjAAAXq+rnZXGcADyi5l5LL5lYMAxQkt1jsipaRQ0Ee/1FKsg+yrXqd
        r4Dzt11w/JTYi1Tg2mjo790=
X-Google-Smtp-Source: APXvYqxpDB9RxircG9qPAE7sxb6k5Kez3U/yDubI5DADMkP6mT6SMnp9bF7YkZQ++YgdfoHA09IAFg==
X-Received: by 2002:a7b:c098:: with SMTP id r24mr252977wmh.63.1574203896567;
        Tue, 19 Nov 2019 14:51:36 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id c24sm33182902wrb.27.2019.11.19.14.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 14:51:35 -0800 (PST)
Date:   Tue, 19 Nov 2019 23:51:33 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/17] sparse-checkout: create builtin with 'list'
 subcommand
Message-ID: <20191119225133.GO23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <55c306a73a5e100b56b184c1ce5428c1259cfc2a.1571666186.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55c306a73a5e100b56b184c1ce5428c1259cfc2a.1571666186.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:10PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> new file mode 100644
> index 0000000000..9d6ca22917
> --- /dev/null
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -0,0 +1,89 @@
> +git-sparse-checkout(1)
> +======================
> +
> +NAME
> +----
> +git-sparse-checkout - Initialize and modify the sparse-checkout
> +configuration, which reduces the checkout to a set of directories

s/directories/paths/

> +given by a list of prefixes.

s/prefixes/patterns/

E.g. 'README' is a file, not a directory, and it's not interpreted as
a prefix:

  $ git sparse-checkout set README
  $ find | grep README
  ./README
  ./Documentation/ABI/README
  ./Documentation/virt/kvm/devices/README
  ./arch/m68k/fpsp040/README
  [...]


> +SYNOPSIS
> +--------
> +[verse]
> +'git sparse-checkout <subcommand> [options]'
> +
> +
> +DESCRIPTION
> +-----------
> +
> +Initialize and modify the sparse-checkout configuration, which reduces
> +the checkout to a set of directories given by a list of prefixes.

Likewise.

