Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB40C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7231613B1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFBLUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFBLUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:20:32 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F2C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:18:48 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id e18so1044243qvm.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rGzXAg0k8z31OPT4J/DjLZTBL6SWwulpLe02jmiZq1s=;
        b=neTIurNjbcotdrowmqxkukf9iF8oAzKa3TdaT9WPM7/peuf5Ao/q+IMzNTUkgB4tKl
         expRoNF2KECr3zCE50BQGhOyqSxPeWAm4xbQquP1mX98iI3/fJgo084Nw/ctAEv4Ef6j
         kwSI/edsPTd9hTi445esUoTaf0ictUY+b02B1HO4rODVTQrEEAU+QhgxoUZ844q/HJrj
         p9GJvkgou3KRjn2I4Y7sdhIiTNYGgnTTKbAE4Ih+JxrMJ+V8v5QTluzSuQK8HkCr9QED
         0fN2u/aFAdEjy7rL7h/bHCkdwecFIfTdstDT9KRhkbIUHUN7lc5BlABrXWBss5Cjx+zV
         acow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rGzXAg0k8z31OPT4J/DjLZTBL6SWwulpLe02jmiZq1s=;
        b=BpDzTiWqs8nHtgzfqkX12KftZciBCBxvSwUBW9RKDhbDJMsQ69HHfhhP0rKz1E2Mrx
         mgg8pbJ/E5fH/apk32Be6OLo6fS/szO0KhTDgLsagE9CdzuIyQcIB3STXnuVXuA8lVdP
         MzJ1krNBeOD4mMj6oXy8iieFgfGbaGLEMzVUtc9dmx1Oofg+j3/PVUDalNS/rjnJGz9z
         aCRcoypFn+zplQWBNbVI2MJAegj5P2UJdTLde25N9opHiKWg3J78dVVuzRWsbddum5AF
         XG3MtHo/W1VK4AfvUfBZx7tgZ3+rLKH1ADBiKjhSPEWXmaaEYi4ByZh0dWdrlh+esmFO
         DZTQ==
X-Gm-Message-State: AOAM53309sO3S6KWIsd7qtBYUXjhqRxn54u3p650SYbmuewfLYfBnzDG
        mKRGLmByFgqhvHgSctKOIqV3sb60bsDrmA==
X-Google-Smtp-Source: ABdhPJyuViTFebn43F6yBU11WahOJzFS2r+PAnc7tr9H4Ep80ecpF73fmxDeIwSOpqrewi9waCc3ng==
X-Received: by 2002:ad4:4e68:: with SMTP id ec8mr320862qvb.62.1622632727560;
        Wed, 02 Jun 2021 04:18:47 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:e0dc:47dd:9a00:5b65])
        by smtp.gmail.com with ESMTPSA id c7sm512098qtd.25.2021.06.02.04.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 04:18:47 -0700 (PDT)
Subject: Re: Partial Clone, and a strange slow rev-list call on fetch
To:     Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
References: <CAPMMpogCz4o3ZGYHnux_6w+uFyxV-FR0R1hFNeg1COiv0qd_0g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <71e60d80-44c1-225d-3cf4-26740de2ac6d@gmail.com>
Date:   Wed, 2 Jun 2021 07:18:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPMMpogCz4o3ZGYHnux_6w+uFyxV-FR0R1hFNeg1COiv0qd_0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/21 12:56 AM, Tao Klerks wrote:
> Hi folks,
> 
> I'm learning to use Partial Clone, and finding a behavior that I don't
> know how to interpret or investigate:
> 
> Under some circumstances, doing a plain "git fetch <remote>" on a
> filtered repo results in a very long (6-30 min?) wait, during which I
> can see the following command being executed in the background:
> 
> /usr/libexec/git-core/git rev-list --objects --stdin
> --exclude-promisor-objects --not --all --quiet --alternate-refs
> 
> So far, I have noted this happening under two distinct circumstances:
> * Anytime I try to fetch on a filtered repo with a git 2.23 client -
> shorter pause
> * When I try to fetch with a recent (2.31) client in a repo where one
> large packfile has no *.promisor file (but the others do, and the
> remote I am fetching from has promisor=true) - looong pause

This makes me think that there was a bug fix for this situation
but the fix requires doing extra work. To help track this down,
could you re-run the scenario with GIT_TRACE2_PERF=1 which will
give the full Git process stack as we reach that rev-list call.

> Can anyone explain what this rev-list call intends, and/or any hints
> as to how I could see what the stdin content being fed to it from the
> parent process actually is?
> 
> For background, I ended up in the "missing promisor file" situation by
> trying to be (too?) clever about the blobs present in my clone: I
> cloned unfiltered shallow to a certain depth with certain refspecs,
> then added the promisor and filter config, and finally fetched with
> "--unshallow". This produced exactly the blob-population state I
> intended, but meant the original first packfile had no ".promisor"
> file.

This is the critical point: you first cloned without a filter,
and then converted the remote to a promisor remote without
marking the pack-files you received from that remote as promisor
pack-files. That means that Git needs to do some work to discover
which objects are reachable from promisor packs or not, and that
extra work is slowing you down.

Partial clone is designed to work where every remote is a
promisor remote, and always has been so. Any deviation from that
norm is venturing into uncharted territory and will have friction
like this. Another similar issue comes when you have multiple
remotes and one of them is a promisor remote and another is not.

The general advice right now is to use partial clone only if you
will use it for all remotes across the entire existence of the
repo.

Part of the difficulty here is that once you download that first
pack-file from the remote, Git has no way of knowing that the
pack came from that source or was created in another way. We
have no way to be sure that we can "upgrade" the remote in an
automated process.

This does make me wonder what happens when Git repacks objects
created locally and then starts fetching from a promisor remote.

There are some challenges here, for sure. Most likely also some
potential gains, but it is unlikely to create a seamless
experience for what you are trying to do.

Thanks,
-Stolee
