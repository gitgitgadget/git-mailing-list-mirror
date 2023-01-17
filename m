Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A37C46467
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 00:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAQAxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 19:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjAQAx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 19:53:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F982193E9
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 16:53:26 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k8so14516781wrc.9
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 16:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzoypO5iEEwvhG33azPyqIgy+sfVKkEyxQc4uhClgU4=;
        b=fdaCmdX6+8Wtg0MIeANhBuPtfMLizAD1w8j0upMaPhbF2h+5/pdGy83PGPsFaNiEzP
         onsEGmuD5CLM1O1ihyhP+nBW3VehhSJv+TEcoNekTj8tUQNHC2c8TCRIPsMel1CuYUEm
         r3ggHpJabX0gKmEizfYbksMeEj4jjbOPatd8cAk88xeafg3UOSgH6OCtVN9eU78eyGzs
         wRYXOQTq13yOlVEST9aHbGPc9xbcG3qybzU6tuky7DbdYXh61q+oSO51RpPSzP2UOrdH
         jr1QrwLAgCAlsFqgSJemfu4Pl3HlTaSMt62JOFQgUKq0E/RzEvKkRuh2saZ4bgj3FHpx
         vTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzoypO5iEEwvhG33azPyqIgy+sfVKkEyxQc4uhClgU4=;
        b=psvgnWlF0RBaTfG6ttOrx8jsMgWboDw3yylWlOZpf/PeCHcSHYeG81T6WZE0lMvsuT
         34iJmzBfZWGQ9Fza6XXm/FFCp56JLfY9fa3N9YP9TxWg4T22wLb6kx7usdSkSU19851Q
         vTId4o8n96T4+abki4orvYuZYaOif3hbs6vRNiEqq6vQ+9NxUnpqA694LgDtZH3fjcY2
         5SLnx/Xys2VHjFp+JGmCoNFrq36NTazg7SRu2tMyqQQyqX5XqKyAxiWxLEpREXz2e7KM
         DhVoDwSFx99+NdBhGYPxqSg7OXwJuXNlywJzW2/s0JSvtl2g36PmU2zn/MlmE899wFwJ
         U3Tg==
X-Gm-Message-State: AFqh2krkL4HWLEs+SuAEOdhsAGrKJQ7u9iWSHv7dLHPtnd/CwaCgfL/a
        AXv2uxyt3qZpSRciEtoj3KQ=
X-Google-Smtp-Source: AMrXdXtqFhDt2RLIs8yhgKOHcADeW1BBKK8DCa10wKIf5hH4cDZYrBwm2xNWSg8AnWJEOrmKPsOq1Q==
X-Received: by 2002:adf:e703:0:b0:2bd:d948:3c3e with SMTP id c3-20020adfe703000000b002bdd9483c3emr1099801wrm.19.1673916804630;
        Mon, 16 Jan 2023 16:53:24 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm32419710wrs.0.2023.01.16.16.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 16:53:24 -0800 (PST)
Subject: Re: [PATCH] builtin/checkout: check the branch used in -B with
 worktrees
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     vustthat@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com
References: <20230116172824.93218-1-carenas@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <45cb1b38-1284-ddc9-a2d8-0a45f10abafb@gmail.com>
Date:   Tue, 17 Jan 2023 01:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230116172824.93218-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo.

Thank you for working on this.

On 16/1/23 18:28, Carlo Marcelo Arenas Belón wrote:

> @@ -1533,13 +1534,12 @@ static int checkout_branch(struct checkout_opts *opts,
>  	if (!opts->can_switch_when_in_progress)
>  		die_if_some_operation_in_progress();
>  
> -	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
> -	    !opts->ignore_other_worktrees) {
> +	if (check_branch_info->path && !opts->force_detach && !opts->ignore_other_worktrees) {
>  		int flag;
>  		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
>  		if (head_ref &&
> -		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
> -			die_if_checked_out(new_branch_info->path, 1);
> +		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_branch_info->path)))
> +			die_if_checked_out(check_branch_info->path, 1);


You adjusted this block to accommodate the problem with "checkout -B",
which is sensible, but we may need to do something different here.

What we are doing here, if I understand it correctly, is dying if the
branch is _not checked out in the current worktree_ and _checked out in
any other worktree_.  Which is OK for normal checkout/switch.

But IMHO with "checkout -B" we have to die if the branch is checked out
in any other worktree, regardless of whether or not it is checked out in
the current working tree.

Perhaps the scenario where the user has the same branch checked out in
multiple worktrees and tries to reset in one of them, is one of those
where we could use the "if it hurts, don't do it". But we are providing
the "--ignore-other-worktrees" modifier, so I think we should disallow
the "-B" if the branch is checked out in any other worktree, and let
the user use "--ignore-other-worktrees" if he wants to go wild.

But.. die_if_checked_out() does not correctly honor the
"ignore_current_worktree" in this situation.  I have submitted a patch
to fix this, in case you want to consider all of this.

Un saludo.
