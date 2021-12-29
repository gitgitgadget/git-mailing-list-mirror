Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DFC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 00:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhL2Ate (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 19:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhL2Ate (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 19:49:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919CCC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:49:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y22so80049899edq.2
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BgWJ2OesjmML0odKEJRovpW18NMFyKggRwJ+8aCH1ZE=;
        b=is4thhdiuZBBtJmWkzOWl/qSGNEHZh6VmyWcAxefjaudzZk2luSBJvfBnfXn+RpRV6
         xmh5bYQwKWGOxmGz/tUJmbEamdi0iAOZXLSoPDyb0wLtHQmbO67pD0bNJNAzm/WZWnDu
         JMW0k78psb+nbMOVVcv8B6JnlUFZjRDX2NAvE7ygo47jHXTDT3KIB4m/6I5DmplLn78u
         AZYzbdCiM6UgYNK3g3+60/BNc7tJjMEWZQtGc5UA+CAsFEoEI8MSZvP6zsr8fNknE0KY
         RrWUINkwNjEuqL/Yg0p7cnel9vn3+BmZyxpq5ELiMsSMycYUk44YNqOfRc5kR3bptQb9
         u+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BgWJ2OesjmML0odKEJRovpW18NMFyKggRwJ+8aCH1ZE=;
        b=sGi6QgmdHunQHy+/uyqcWUJ51kF47G4nDmp+WsTJcnGGR1NzbO/1yCoK3CN2mv7i+g
         nmSSMo9EQGKtHLzj17YUFyCGm9VGkqLXFsSPYFpi9bommFtrRteTTkXH3ZckYEHJ7DHY
         VApxc4ykd95/68xiHu/ixOfeGYLJtW+z327qfKrgE6V20+1KL9ePEwIsRI4fHfyPIMQj
         wWOaaNaG6VwivROqAP0zbu9WolnaUIv3TzAg4OwZrzBXKRvLM/dHO8UnolK2J4sNseiD
         qJZzuKGKHmD2eVmNFSubKaZhIFPslQ1As7nICBJOTN/tBOhoebSO/4jnOmRlNf7H7cr0
         EU+g==
X-Gm-Message-State: AOAM5334+B0sefrBOXq1RAAK0wA9gnBEiwew6HMuGKJ/0UeF8BsznneT
        n6RnmjDI1uPNxp7vtH9rp84RYbUft2Jv1FXR
X-Google-Smtp-Source: ABdhPJxHDW311XG6L0QDh5LfTCXkRAlTGsGafHCFno6wyc7VocOIBwqVVkbejvLPXMs3XZfo9wY3ng==
X-Received: by 2002:aa7:c705:: with SMTP id i5mr23547452edq.81.1640738971945;
        Tue, 28 Dec 2021 16:49:31 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id g19sm7938360edr.6.2021.12.28.16.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 16:49:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2N9m-000H95-BY;
        Wed, 29 Dec 2021 01:49:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/9] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
Date:   Wed, 29 Dec 2021 01:48:12 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
 <96f6896a13e68263b96827e0c66f20178fb9dfd1.1640720202.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <96f6896a13e68263b96827e0c66f20178fb9dfd1.1640720202.git.gitgitgadget@gmail.com>
Message-ID: <211229.86r19wgrqd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Use "size_t" rather than "int" for the "alloc" and "nr_open_regions"
> fields in the "tr2tls_thread_ctx".  These are used by ALLOC_GROW().
>
> This was discussed in: https://lore.kernel.org/all/YULF3hoaDxA9ENdO@nand.local/

Let's keep commit messages self-contained when possible. It's fine to
reference on-list discussion (and I often do), but in this case all
that's being referenced just seems to be Taylor saying we might as well
change this while we're at it.

So I'd think a short sentence saying we generally prefer "size_t" for
these these days and we might as well change it here while we're at it
would suffice over the ML link.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  trace2/tr2_tls.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index b1e327a928e..a90bd639d48 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -11,8 +11,8 @@
>  struct tr2tls_thread_ctx {
>  	struct strbuf thread_name;
>  	uint64_t *array_us_start;
> -	int alloc;
> -	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
> +	size_t alloc;
> +	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
>  	int thread_id;
>  };

