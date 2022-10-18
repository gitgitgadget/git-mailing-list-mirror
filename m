Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB77C43219
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 12:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJRMqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJRMqt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 08:46:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C271724
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:46:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy4so31852713ejc.5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Qk2e4U6xP1pAkwsr2FyySYpJKvv1UZvDB/QX9BIj7E=;
        b=GKmoiiDZrmyUUumW4z8kBht0PaX/Mz7IAwSwDVidC3XDnLV++2FbowSgcNH4+n4ZQQ
         uflBslenrzHO+G44Ss146IM+3IlDDNwMhDREgqjWCK0dZiTQJBWPu03XQMozE3fyyhUl
         WaaupchqLUU8nVlpEG3Rr94zfyQewo/WG/MTj0xvlxdSDVHDBGm9lWPxRZCN0R2JzD6c
         1RBnNoWMea933htKVXyR3vG481e+ZpixutRSu6wXtj4z/D2p1T0WDkiWIs/xFyVUzr6Q
         sWQfpb06QoHhRDRNBQdbQJ6v160F0Wifq/gBS74fAjc3HuGpRXbzlbhzhOUceyXIRzP6
         PvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Qk2e4U6xP1pAkwsr2FyySYpJKvv1UZvDB/QX9BIj7E=;
        b=mDB6sa96Ft17XdfGuw84PMdaJuKPsIyrmlhxu+wPTGC+A0dgIpnJD+WDy40QOWLb+g
         8AGQZUER5t4MnB8VVCm8gBTLDJs3N1z5eswpgat4gyTOT7UEo0+shXfSgWDy0gUOPHrS
         +HhCXtAx7tUlGznJhG+VIdKoIOgzJBEPWBQpB0Jd4hUl5ZgfKloomeZ3fkTfN4UhmTU1
         VpYgv43f9JDK48ujJXSkjUBTFf5w0GwEjlWYzlhQhxQdR4Tyo20ObzhjuYBDKr55m7Df
         EvK0zMS3ed216SMozvz8qDQQ6TbBqUn+PNyNMl8O1uUfZl/Fg5javVU3AGFGGm0kg2Le
         dC5Q==
X-Gm-Message-State: ACrzQf1LVE4mUwNwHJAkd4NN1AdQCggrBRSsE+XCLh0ucHY1eIDmwtIp
        luhXTEJ6s4uJfuO5HcVso5xTriDIkVDWLw==
X-Google-Smtp-Source: AMsMyM7ZlsFDpZps28xuBZZPJ3zReJIwhqsHj9Z/7ngwDdArbjjOCYo/iPae6c/z8hBxWGsIsWRdMw==
X-Received: by 2002:a17:906:fd84:b0:730:acee:d067 with SMTP id xa4-20020a170906fd8400b00730aceed067mr2304098ejb.206.1666097206855;
        Tue, 18 Oct 2022 05:46:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b0078d175d6dc5sm7431183ejo.201.2022.10.18.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:46:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oklzZ-005kEu-1Y;
        Tue, 18 Oct 2022 14:46:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 12/12] fsmonitor: update doc for Linux
Date:   Tue, 18 Oct 2022 14:43:43 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <77ed35b3b80de9ecfea179357115428ab89d9864.1665326258.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <77ed35b3b80de9ecfea179357115428ab89d9864.1665326258.git.gitgitgadget@gmail.com>
Message-ID: <221018.86ilkhi9je.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 09 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Update the documentation for Linux.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  Documentation/config/fsmonitor--daemon.txt |  4 ++--
>  Documentation/git-fsmonitor--daemon.txt    | 24 ++++++++++++++--------
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
> index c225c6c9e74..2cafb040d96 100644
> --- a/Documentation/config/fsmonitor--daemon.txt
> +++ b/Documentation/config/fsmonitor--daemon.txt
> @@ -4,8 +4,8 @@ fsmonitor.allowRemote::
>      behavior.  Only respected when `core.fsmonitor` is set to `true`.
>  
>  fsmonitor.socketDir::
> -    This Mac OS-specific option, if set, specifies the directory in
> +    Mac OS and Linux-specific option. If set, specifies the directory in
>      which to create the Unix domain socket used for communication
>      between the fsmonitor daemon and various Git commands. The directory must
> -    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
> +    reside on a native filesystem.  Only respected when `core.fsmonitor`
>      is set to `true`.

I think this should be squashed into the relevant commit(s) when we
start supporting this fsmonitor.socketDir for that platform.

But on the content: Shouldn't we just reword this to say something like
"*nix"-specific, we only have one platform which is likely to not have
"sockets", i.e. Windows, no?

So rather than having an ever growing list of OS's that'll inevitably
grow to something like:

	Mac OS, Linux, FreeBSD, NetBSD, OpenBSD, GNU/Hurd-specific
	option, if set...

Let's find some way to refer to the platforms we do support, and instead
mention the only one we don't support sockets on?

> diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
> index 8238eadb0e1..c2b08229c74 100644
> --- a/Documentation/git-fsmonitor--daemon.txt
> +++ b/Documentation/git-fsmonitor--daemon.txt
> @@ -76,23 +76,31 @@ repositories; this may be overridden by setting `fsmonitor.allowRemote` to
>  correctly with all network-mounted repositories and such use is considered
>  experimental.
>  
> -On Mac OS, the inter-process communication (IPC) between various Git
> +On Linux and Mac OS, the inter-process communication (IPC) between various Git

Ditto.

