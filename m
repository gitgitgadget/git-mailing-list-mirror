Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9C6C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 02:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiBCCJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 21:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiBCCJV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 21:09:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557CC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 18:09:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u24so2447318eds.11
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 18:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8D+Q1jZlPLxuYZM/aChnSzSQC3yyaFA+8nOo8m6hIww=;
        b=M6QYY7gMdBHTwawbrLC9g3YP+xzx4m/55bkMPZ21cy03ryAfi0QTtqWk5WX+5JKu4S
         /2J2nNcSyjp6J82zyjtwPMay8uUve0EINb/VV08KULlV51IaUHyu9YJrV1tUmWeSywA0
         HZ9WwSZBFtlN214rJOXZma6bAlwWjli68pmL1BTYJtKG0XOwlJeDJwxBd4Pl5ihM4ov+
         IoZARtEEm4NSSaJp7hO4oFsWPcEfLykJLNwMV8VBx1nMUB7mgW98JNJEb1fapoaaqRUj
         1JiEZmyKRoP9B6l4V+f63ZMWIgDIZ4GgNl31CmujXyW2xmUeNDd9K2/GycmkoKHg7fTB
         mANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8D+Q1jZlPLxuYZM/aChnSzSQC3yyaFA+8nOo8m6hIww=;
        b=2KUiukF0N4U7Kr67E6PncZN5ltyv3WXLanTib2uutOiBsA0vu8HjIfzQjbDXz4sLzB
         SpECeF6UbgBAC25cxXpxZlnkGRzpoUpG+8JBae29ELyc4vnqksU2C852IiLpNZ2oQJlg
         fW43976q6cIpMeg/VR4XDSfLtYlC017TLub24A2hlvGKDJXaIC5AwFiVfHkBTSlMc6zC
         +KspHimeal/VSj2jOyS6hnWw79VzFDKf+YJ8AsPCIbHcf+T0N8XA0bMajVwfzBqBGfJE
         YVJKswuosFI5XZrp80c/Uuu+CFaSnCRN40w/9OByk2HiHrivDdurzhCw+sRBrqlNrqN/
         r0uQ==
X-Gm-Message-State: AOAM532QRO/OR0jhjD5AcK8WOLQVm6ayVa7QG9C37BpDqNgEmS21EMNN
        eR9HY3OQo5J+Fg0ZvAJsGyrpJc54MTBrXA==
X-Google-Smtp-Source: ABdhPJzKPuH6IeX2lMiibG8QzeFNG3Gn7aX+7SgOHCj1o6WjuSkpV6pvCyaJ4pF9FhH4umY1QrOyQA==
X-Received: by 2002:a50:9d0d:: with SMTP id v13mr33335503ede.242.1643854159860;
        Wed, 02 Feb 2022 18:09:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w25sm21678267edv.68.2022.02.02.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 18:09:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFRYk-004pc4-G6;
        Thu, 03 Feb 2022 03:09:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial
 shell for real merge function
Date:   Thu, 03 Feb 2022 03:05:27 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
Message-ID: <220203.86a6f87lbl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Let merge-tree accept a `--write-tree` parameter for choosing real
> merges instead of trivial merges, and accept an optional
> `--trivial-merge` option to get the traditional behavior.  Note that
> these accept different numbers of arguments, though, so these names
> need not actually be used.

Maybe that ship has sailed, but just my 0.02: I thought this whole thing
was much less confusing with your initial merge-tree-ort proposal at
https://lore.kernel.org/git/CABPp-BEeBpJoU4yXdfA6vRAYVAUbd2gRhEV6j4VEqoqcu=FGSw@mail.gmail.com/;
I.e. the end-state of merge-tree.c is that you end up reading largely
unrelated code (various static functions only used by one side or
another).

But maybe that's all water under the bridge etc, however...

>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc != 4)
> -		usage(merge_tree_usage);
> -	return trivial_merge(argc, argv);
> +	struct merge_tree_options o = { 0 };
> +	int expected_remaining_argc;
> +
> +	const char * const merge_tree_usage[] = {
> +		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> +		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
> +		NULL
> +	};
> +	struct option mt_options[] = {
> +		OPT_CMDMODE(0, "write-tree", &o.mode,
> +			    N_("do a real merge instead of a trivial merge"),
> +			    'w'),
> +		OPT_CMDMODE(0, "trivial-merge", &o.mode,
> +			    N_("do a trivial merge only"), 't'),
> +		OPT_END()
> +	};
> +
> +	/* Parse arguments */
> +	argc = parse_options(argc, argv, prefix, mt_options,
> +			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (o.mode) {
> +		expected_remaining_argc = (o.mode == 'w' ? 2 : 3);
> +		if (argc != expected_remaining_argc)
> +			usage_with_options(merge_tree_usage, mt_options);
> +	} else {
> +		if (argc < 2 || argc > 3)
> +			usage_with_options(merge_tree_usage, mt_options);
> +		o.mode = (argc == 2 ? 'w' : 't');
> +	}

Do we really need to make this interface more special-casey by
auto-guessing based on argc what argument you want? I.e. instead of
usage like:

	N_("git merge-tree [--write-tree] <branch1> <branch2>"),
	N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),

Wouldn't it be simpler to just have the equivalent of:

	# old
        git merge-tree ...
        # new
        git merge-tree --new-thing ...

And not have to look at ... to figure out if we're dispatching to the
new or old thing.

