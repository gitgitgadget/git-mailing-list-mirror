Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220251F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFRRBb (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:01:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33451 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRRBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:01:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so353483wru.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaX5/3PCknZAUezcL6dw4cCpWiRth9SH7CHkovWCqyE=;
        b=GRbxOKVy0W+0n47VPTw6RdwVKqAzW2lwIDCtIc7UfSt3+/Flx3ytiA5dODocBMOefc
         LP+z2/bWGfgFiF2+ydvvsdH7MTKkiRsrUSLis+TvPfhiyT9XBzRf3qXs00FNg7vkPooa
         IDk7j/7U5MjfQ9lQjc1dCAwyB9NIOXFqWy0N28S4YefGbuI5rNyHKloOamWIX/T+wpq8
         GvofukMl6UdnJtZwxhDt2RzwQwvxmQ00uhP+vhWOK2ja0pHULuRDwuYK9IFqhY6bZwvR
         lSOVelm8O28TqQBiLW6tN7YiTUkIFglKu31yOdAfjoND0yzvOJ6aAK3ru2k/S1SotRUz
         jHww==
X-Gm-Message-State: APjAAAVyxxnZKNXUB9yXEqNe48+Bd00PHEFJ1qNJxoRyIrSqMAX3UBxX
        FRl+ZuGU8ID0bZmqW9Ea+FxbSP6Rxuq6+Gk2EAFgRfuP
X-Google-Smtp-Source: APXvYqyfisoRghRc5MB5ujRfPp+/y2IhDk0e/KuXHezX16DJNCGUxtHN1mqSk1NUTo379KJqLrKKD5OknURT5/9tmJs=
X-Received: by 2002:adf:8b83:: with SMTP id o3mr77475209wra.278.1560877288779;
 Tue, 18 Jun 2019 10:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com>
In-Reply-To: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Jun 2019 13:01:16 -0400
Message-ID: <CAPig+cTFfhBz+xiq6VAMNOW4OTvByHJ1g5oF=RTTh_buA+nUQA@mail.gmail.com>
Subject: Re: windows: error cannot lock ref ... unable to create lock
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 12:39 PM Anthony Sottile <asottile@umich.edu> wrote:
> + git fetch origin --tags
> Unpacking objects: 100% (10/10), done.
> From https://github.com/asottile-archive/git-windows-branch-test
>  * [new branch]      master     -> origin/master
> error: cannot lock ref 'refs/remotes/origin/pr/aux': Unable to create
> 'C:/Users/IEUser/x/x/.git/refs/remotes/origin/pr/aux.lock': No such
> file or directory
>  ! [new branch]      pr/aux     -> origin/pr/aux  (unable to update local ref)

AUX is a reserved[1] filename on Windows. Quoting from that source:

    Do not use the following reserved names for the name of a file:
    CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7,
    COM8, COM9, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and
    LPT9. Also avoid these names followed immediately by an
    extension...

The default Git "ref store" is filesystem-based, so a branch named
"aux" is problematic. Other ref store implementations would not be
subject to this limitation (though I'm not sure what the state of the
others is -- someone with more knowledge can probably answer that).

[1]: https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#naming-conventions
