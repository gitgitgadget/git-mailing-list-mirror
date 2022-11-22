Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E06C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 03:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKVDEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKVDEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 22:04:23 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3510E6
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 19:04:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so585260pjt.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 19:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cndkk09z0dsNvmd6r05/7yxFoPssBkLHPviKTgM2GwI=;
        b=lXAXNKEvSfOl+f5veiYwX4xGj+41bdx3nMDK8LJXsSGrVc20I9wcThfBqXd5lkjtOB
         pv7dYZA2C1vI7xERO+sr0Q9p/8LngjJtRPOnjE8pVVJgUQsS9bKEwVXSuqQW8YGGl1U4
         lhEyACaAtZECzdVxX20g9eAuh4PIVv9kWOh8JI1+caIdcXw24/cOt6S1iVBcyOV4lNqS
         joC0RrTpXgrm2BJnN6tR2kmSBOZcjmiWNfMWxo0o0CiNWV5Ph2ndalgK0RuuLWWzqkY+
         ars4n5GKz5Hs/sbNYvRZzLiozL6oO0GD/M3sB80OVLqHYtWGnPFLIDTh6cMB0ZGymJH4
         eX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cndkk09z0dsNvmd6r05/7yxFoPssBkLHPviKTgM2GwI=;
        b=r/Tfu8bfv99s2eq+eGQuV5fzHQjJrlVascxrLLVa7U+yZMFWJ2kk7wpUFo52UfQk5j
         fKLJ9v+vR4FyD/hez3VHdx3t17RcdL8FCfNP9/dYON0DVKw4a9RDRSShUNlpJ1rjhNPv
         uNIfMQXdr8nJOLMsgDFgyes9xfwJCAag6x6w7RDu3jlrZ7HUMveYhtjq6W6jiZRzwI10
         mZELz/qioZ17+mgcRxwIonT/1PyvENYE/HrqH2Z2vDz4fFx2y5GxIa1ZuFo2/YyPsy1l
         5QyURI2foyPec1SHhgEc8XjXGQN5/IAGzwcYGHz4N6htXmLI3fJHcE0nXO3gUYLJIZtv
         IF3w==
X-Gm-Message-State: ANoB5plfX4fO9kQWodn+nudvlxwzL11qOarVxa7QOVpEMKhR+rpXE5WY
        fbXTyNHCMem+oRzReci0vYDq10OhcccCDw==
X-Google-Smtp-Source: AA0mqf6qtMECaZCILv1zy9rj7FghtwK8RmmABcgXe+O2no5tVzrAjudwM0yZxFQjcbG0+OdrGgsM3A==
X-Received: by 2002:a17:90a:fc84:b0:217:ff37:2fe9 with SMTP id ci4-20020a17090afc8400b00217ff372fe9mr29648164pjb.242.1669086261916;
        Mon, 21 Nov 2022 19:04:21 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w13-20020aa79a0d000000b00562a237179esm9366027pfj.131.2022.11.21.19.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:04:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        kylezhao <kylezhao@tencent.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 1/2] merge-tree.c: add --merge-base=<commit> option
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
        <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <1cf1c69b8e8e8e81eccc42b5d8efc605a36ab7eb.1668210314.git.gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 12:04:19 +0900
In-Reply-To: <1cf1c69b8e8e8e81eccc42b5d8efc605a36ab7eb.1668210314.git.gitgitgadget@gmail.com>
        (Kyle Zhao via GitGitGadget's message of "Fri, 11 Nov 2022 23:45:13
        +0000")
Message-ID: <xmqqsfibsn9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--merge-base=<commit>::
> +	Instead of finding the merge-bases for <branch1> and <branch2>,
> +	specify a merge-base for the merge.

OK.

> +	const char *merge_base = NULL;
>  
>  	const char * const merge_tree_usage[] = {
>  		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
> @@ -515,6 +533,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  			   &o.use_stdin,
>  			   N_("perform multiple merges, one per line of input"),
>  			   PARSE_OPT_NONEG),
> +		OPT_STRING(0, "merge-base",
> +			   &merge_base,
> +			   N_("commit"),
> +			   N_("specify a merge-base for the merge")),
>  		OPT_END()
>  	};

This looks wrong, though.

Shouldn't "git merge-tree --merge-base=X --merge-base=Y A B"
allow you to compute the merge between A and B in a history
where there are two merge bases?

Unfortunately this is already in 'next', so let's see an incremental
fix on top.

Thanks.
