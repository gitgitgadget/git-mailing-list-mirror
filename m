Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EE3C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D297720719
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlRnIjJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKBU3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBU3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:29:34 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2EC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:29:33 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c18so10670166wme.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSiRbFP3awMp7YzWC/qgglCA3pS+brTDRmnTqMG+h+o=;
        b=nlRnIjJ/3/YnA7TReJQ/8v9C/HAR8Wp6jWgxQdBOU2XfQjKRW3E7iFF8K+EOG0Ze+d
         itelsTNeSXmdi+EW4tfutGRWuwDJyM5DqLQuYxN6cba3T1TFAKO7c1sff5IQ0QnnCLRJ
         WH/eWe+tNwq60rqWxxX4rsCACKiewNeIiEIXtQoCB1vpSr51X8/xClrGos8qGivNpX56
         5DVmlHakpUDTUKXB7guAHqapRP2wzK9OyOn7HX6AIw1gWsw6Sy2rLiBvbllBgI84qBPJ
         tIwZKSDTM6YZ8POdJBLW+PZb0Ej03M8jj3UCBEy22eXzcBKbPkisL9Nk4JFqJFPluRv6
         fNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSiRbFP3awMp7YzWC/qgglCA3pS+brTDRmnTqMG+h+o=;
        b=JAap5kjO3az5f7rmSHdlsVa1j60bllJ/HZVovwVHb8Ao53d/cfTMTlHAs6YlL93V+v
         Ga6ES/xuPBQPz3cOyVKRRnwiwdCQkF1HH+gmv0aqzmFZch3BXd8cOf9HfzmPlKP+SQD6
         eol4bcZ0PFXr1xL61ifXQuYX+Ohj2oOsUmO35XR5qRYjoMllaYUqJwuhh96OtezHhV15
         2Kv+duQQkjHomDo1FbV/n9N6eV/HGVYjhoQqhLWrNKpvkIlRsoO2rShIwzLv5mTFKtZv
         VbhTlUJ7jVt7rzhITy+BOT9Ae+1NMMck1ZJeVdQAGEA66w0RKGM+NsPp3ZTgVe0TpUNn
         YBfQ==
X-Gm-Message-State: AOAM53386bnDE5cS8sJ2ZKM4KvkvpcOTdNsgb6Sx6G1IUwQ1Syvt/xOq
        Rwda40fF51RQIBvlN3yMdj2bqddRdVE9AZxr+IzKNUT55CiAyA==
X-Google-Smtp-Source: ABdhPJw6M3r43ErjTT7gK3RzouUDpj9UOpy+diBgnIt3mqkGlnHBLJKgNN33kXJNrdjE6AVfCZF4/nGn/bPu4gi2KMU=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr9560368wma.100.1604348972642;
 Mon, 02 Nov 2020 12:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de> <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com> <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
 <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 2 Nov 2020 14:29:21 -0600
Message-ID: <CAMP44s3Tx1DdzD3fAOA+_3fLMK6Ew9GQAJWiRoA2KR156jiZBg@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 11:19 AM Junio C Hamano <gitster@pobox.com> wrote:

> After making a brief observation for my previous message in the
> thread, I understand that oh-my-zsh is a very popular colleciton of
> third-party stuff for Zsh users, so it seems to me that the real
> useful choices, if I or somebody else were to become a new Zsh user,
> are between sticking with the Zsh default or grabbing the improved
> version from oh-my-zsh collection.  I could also use from our
> contrib/ but I would have to ask myself twice why should I, as a
> (hypothetical) new Zsh user, bother, especially when the latter
> promises to be always fresh anyway.

More or less. Oh-My-Zsh is very popular, but not everyone uses it, and
it's certainly not cheap on resources (it makes the startup a bit
slower).

So the two options are:

1. Use the script in contrib/ (or git-completion)
2. Use Oh-My-Zsh and enable the "gitfast" plugin

In my opinion to use the Zsh default completion is not an option.

Which is why I think distributions should package the Git Zsh
completion by default (like Hombrew does), which will happen more
easily if Git graduated those scripts and installed them by default.

If this close-to-ideal solution was considered, I would investigate
again if there's a way to automate the testing of the Zsh wrapper, so
that it doesn't break when the Bash script is updated (which is the
usual way the Zsh wrapper breaks).

Cheers.

-- 
Felipe Contreras
