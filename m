Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB0AC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 19:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjBGTeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBGTeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 14:34:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920643B679
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 11:34:17 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id bj12-20020a056a02018c00b004fac0fa0f9eso3547305pgb.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DtfewATZLyGmNhxvrc1XxRkI8Ma5PSu7f+T5kTTefWA=;
        b=Vv1USsNmloI8DNCXyEBxLnEiTR43m/xX3Vicg8xhSjfZEezzYr6ho1KPINUOczWdlO
         NiON3I4jbU4By23npBjJ1scgDGqNEa+luz+b6nGXBqNnMDHhA8ZwFutaJlCARt+mwydf
         IBwLIUltHsMDc3g2ZJq48jzIxx6EHbwWF2hjUtaSfFwRpW80Lw2IJaElsmGwLZAB5upJ
         Cp/W2TqBxCA2xcEtaloOuK9tgpaanGupR+KqPAL/aYM9gpjm4Er5KQiBa2yqP30mFMkm
         PrZP+O01GPmuBeg+TWe3wpfUsLHu7EoVgjenPvAv+hxlYwyDSWUf8VggTDOWuLCIWUII
         GUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtfewATZLyGmNhxvrc1XxRkI8Ma5PSu7f+T5kTTefWA=;
        b=HOMo69Wl53DoPcEVmPFW3v7Ps81JhgqcSd/DTzVS+wPYFc4eqbKae//dH8RxSVwAbv
         1TKWkpCK39l6WpQr0wQp9Fh76ff1X0YiqV26S+SidBsSY2eLyGnncbVC95Telj8t2dii
         ZuYwQwROEnzXsVPIkDqPQL80POZl9V9Dap8HdnMBh4/vn6+5MhVN6dKftmvrWVnmgr+j
         MZtwbm6XZCedr5uS4mK3Iud6qlKN+9TdWzIJB9vpZN18VfmDoPX+tUWZqAASM/Nk/Lf1
         Yi+dj+NZxLitaAIuPSNkB/tOO/idTIn81e+wGlyNBL06GSuOSkQNKPPC0I+xvQN0DWBJ
         73AQ==
X-Gm-Message-State: AO0yUKWEjKnNW93XDZoC/JAI0pKKINyi1ya29woI8kZGZrfRoRI0s6mn
        LOVjDPYu+/2hKnxop5Gs9/FAim+gsG62JyU=
X-Google-Smtp-Source: AK7set86Dmv6ObEZKeERUC5IVE5Yy7qdxgvI6sCai6JT0M1GFbn/Ahs3F1n74QTS6segGMqIMcT3UaNCBeAqHtI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:a101:0:b0:4fb:1c1c:5f38 with SMTP id
 b1-20020a63a101000000b004fb1c1c5f38mr569003pgf.47.1675798457029; Tue, 07 Feb
 2023 11:34:17 -0800 (PST)
Date:   Tue,  7 Feb 2023 19:34:07 +0000
In-Reply-To: <pull.1468.v2.git.1675751527365.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207193407.394971-1-calvinwan@google.com>
Subject: Re: [PATCH v2] name-rev: fix names by dropping taggerdate workaround
From:   Calvin Wan <calvinwan@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Are there any cases where a taggerdate heuristic would be useful now?
I'm having a hard time coming up with an example of such, so this
change looks very reasonable to me. Even if there existed such a case,
I would imagine it would be better solved using other heuristics rather
than checking the taggerdate since that was a very loose heuristic to
begin with.

> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 15535e914a6..df50abcdeb9 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -113,9 +113,7 @@ static int is_better_name(struct rev_name *name,
>  	 * based on the older tag, even if it is farther away.
>  	 */
>  	if (from_tag && name->from_tag)
> -		return (name->taggerdate > taggerdate ||
> -			(name->taggerdate == taggerdate &&
> -			 name_distance > new_distance));
> +		return name_distance > new_distance;

Comment above this block should be updated to match the new logic.

-Calvin
