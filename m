Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ED6C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A0D206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1fX/pO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEEMF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEEMF0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 08:05:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4CC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 05:05:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h26so1632245qtu.8
        for <git@vger.kernel.org>; Tue, 05 May 2020 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9SdykflwR0WTRvaoWqHspKEqxbuI0B1y5dg3SH2PzJk=;
        b=X1fX/pO3CFRO1uLaWgAjvVucdV/74SNsZjoV6qk3KrihckCK46aTXiFArHpTF60LrV
         0b+4oJy7N/jMvKARVkf3jSmZPR87pgXUdjJNrwrDyxxVBykp58kPZLin9IC4yu6PT+fn
         Xp+xCK0ncQpIXSt6KMTVKztC5DvjtyCOdII8r5L3z9f8ML8UkEtccslFS2x0W0dgGgO6
         84PPSahwPPzwPzVz+q2IQU3GfLYCWJP80LFTEm9tQQyWVYA2cg5ML8cD5KYRc1QzYcC3
         m1xhCz/8uMj4W1nWym0kgZ7MvvuMPVmJSS6ljAYMR0Xs/qKiRzDwdJxGhGERZznfX8in
         1ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9SdykflwR0WTRvaoWqHspKEqxbuI0B1y5dg3SH2PzJk=;
        b=fKC/P2vidnZb30RxiTLHcEWk+Ak+tniOA8s74A4zT21yMxZHN07N0sFcnZTDjgt/Ts
         RPPJ7tHmH9GKSZErHlMaG6keEUpK1BMgJ+p2GgDEOHNywMaPgysTf6gtCwDfd+ON+rqr
         cFdtTzoVHfKhBi9bS27ZIhekb9Y3MQaGqSPIa9bzLlscff2Nd1G5KSruaI0ptUnJyi/C
         p8NWEemP9bGk3t0sr+1WZxNlk3KaKrR9UAVa9gm5XGwKeoIjOdS07R5lNbcyThEtB8tS
         L1snIVJcRJqV0RilmKQUH6psJqsbOI5PWCYOHJgzKltW7YUPJevgkPJ4i9DQqXBrh2d0
         xMmA==
X-Gm-Message-State: AGi0PuZ6nZdJnnaeGAaTJW7WZ9pzlVQVpM6hDq/mPJik+Hr2FH5bAlOZ
        +SPW4ablXqAnNcM9StGOVmM4uMG7xpk=
X-Google-Smtp-Source: APiQypL+KQfF4VtYspUtdr0HQ0+BO7RETEmN8d62qNFZQzb0QCRG8sQkTpgapFqFkDYrELAw8qjHIg==
X-Received: by 2002:ac8:1b6a:: with SMTP id p39mr2222286qtk.158.1588680325477;
        Tue, 05 May 2020 05:05:25 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w42sm1535457qtj.63.2020.05.05.05.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 05:05:24 -0700 (PDT)
Subject: Re: [PATCH 6/8] commit-graph.c: simplify 'fill_oids_from_commits'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1588641176.git.me@ttaylorr.com>
 <7e9d8c1f1a124171ebb5b4d874718053d1c9064a.1588641176.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b36f9210-bc26-5ca8-b163-62d75349b381@gmail.com>
Date:   Tue, 5 May 2020 08:05:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <7e9d8c1f1a124171ebb5b4d874718053d1c9064a.1588641176.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 9:13 PM, Taylor Blau wrote:
> In the previous handful of commits, both 'git commit-graph write
> --reachable' and '--stdin-commits' learned to peel tags down to the
> commits which they refer to before passing them into the commit-graph
> internals.
> 
> This makes the call to 'lookup_commit_reference_gently()' inside of
> 'fill_oids_from_commits()' a noop, since all OIDs are commits by that
> point.
> 
> As such, remove the call entirely, as well as the progress meter, which
> has been split and moved out to the callers in the aforementioned
> earlier commits.
...
>  	oidset_iter_init(commits, &iter);
>  	while ((oid = oidset_iter_next(&iter))) {
[snip removed code]
> +		ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
> +		oidcpy(&ctx->oids.list[ctx->oids.nr], oid);
> +		ctx->oids.nr++;
>  	}

After looking at this loop, I wondered why we can't just use the
oidset inside the context struct. But then I realized that the
oids list expands with reachable commits and then is sorted
lexicographically. Thus, this is the best time to copy from the
oidset to the commit list.

I agree that dropping the progress is valuable here, since this
_should_ be a very fast operation even for enormous commit sets.

Thanks,
-Stolee


