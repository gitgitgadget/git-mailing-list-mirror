Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A22EC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 15:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355959AbiASPxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiASPxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 10:53:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91994C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:53:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f17so5617948edw.2
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4Xk7F2hFI+NGgXos//y9i4v5ay4l0oqiovD7HTo6VI4=;
        b=igFgimnOO7ODqakcdF7vZaVZUjdNKReXywD1Po2P3OBAlCOv8Vfn23/pZP+wHVYZDa
         8zC0XiDZL+eDnb7N8piSGL0WvQqxR6VdeqUIqq38+x/JseBwVFd0hnFo+GwOuCUKGXq2
         nm5y5u9Pmzd8binPliFZKS1LCXO+HZAG0KkyvmuwnhIK6ueETiP8mRj8TuW6i3KBxq+D
         dQm9kQMr8bmyOjMeTyuFUvCAWBk619skKOM1sdezNV639HLhcL160J46Y+3+X+jbco4j
         8ZGXcAXu/BNtTiOyJP3iM+4l0YeB4tY+G3tETcUo+ToC9RM+6hJ6XX818OfuMXHkdeE7
         qiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4Xk7F2hFI+NGgXos//y9i4v5ay4l0oqiovD7HTo6VI4=;
        b=NKVWULDSVwIiL/mvYKKniBwQBoPSBxeJX01WBvaLzVWpKs1iJOp/ioFOFF+r+sTi0b
         6J8+QAXffyItx2M1kdjUj/o3qMeb/ySiG4Es0mOyhQtO1HuRoKwPXD2OTegyxu+ClWrx
         dtj1SbuSrrNI2G25zTfZ4+Roiy7UA9urzGS/IS42aKwNBoXTOE67j5heaudGb36QK19j
         E5jtn017N5ZjaU1surVQxGL7qniu9uSt7uAzHzVp+AIWfzrku9MBqoioKvWFZCys6kqR
         CyMT/YyhZMCGWfJly9y1uMT1P09N5VokTt52iiy1ij+n/jklzjYopcdY4GCYpu2enhYY
         /BWA==
X-Gm-Message-State: AOAM530uFvEXIgb+K9Fcd28VQhhuISHUkfgszhNCOQJtVHPzzUYigP3u
        +FcO1dvraqhhdp7xJCGV5bJ9FybVSvXgiA==
X-Google-Smtp-Source: ABdhPJzYdB9PDOgma+DtfKKCJRXeHimYbA3Mg4xgyDcZowDxUaF+mcfS6N2uFdropa+reCwYpoCQcQ==
X-Received: by 2002:a17:906:4d10:: with SMTP id r16mr14325810eju.199.1642607613721;
        Wed, 19 Jan 2022 07:53:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cb5sm41409edb.82.2022.01.19.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:53:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nADHA-001ndq-IB;
        Wed, 19 Jan 2022 16:53:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/9] show, log: provide a --remerge-diff capability
Date:   Wed, 19 Jan 2022 16:49:57 +0100
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
 <d57ae218cf9eaee0b66db299ee1bba9b488b69b1.1640907369.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d57ae218cf9eaee0b66db299ee1bba9b488b69b1.1640907369.git.gitgitgadget@gmail.com>
Message-ID: <220119.86pmonn2mb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

> +static int do_remerge_diff(struct rev_info *opt,
> +			   struct commit_list *parents,
> +			   struct object_id *oid,
> +			   struct commit *commit)
> +{
> +	struct merge_options o;
> +	struct commit_list *bases;
> +	struct merge_result res = {0};
> +	struct pretty_print_context ctx = {0};
> +	struct commit *parent1 = parents->item;
> +	struct commit *parent2 = parents->next->item;
> +	struct strbuf parent1_desc = STRBUF_INIT;
> +	struct strbuf parent2_desc = STRBUF_INIT;
> +
> +	/* Setup merge options */
> +	init_merge_options(&o, the_repository);
> +	o.show_rename_progress = 0;
> +
> +	ctx.abbrev = DEFAULT_ABBREV;
> +	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
> +	format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
> +	o.branch1 = parent1_desc.buf;
> +	o.branch2 = parent2_desc.buf;
> +
> +	/* Parse the relevant commits and get the merge bases */
> +	parse_commit_or_die(parent1);
> +	parse_commit_or_die(parent2);
> +	bases = get_merge_bases(parent1, parent2);

There's existing leaks all over the place here unrelated to this new
code, so this is no big deal, but I noticed that get_merge_bases() here
leaks.

Shouldn't it call free_commit_list() like e.g. diff_get_merge_base()
which invokes get_merge_bases() does on the return value?

> +test_description='remerge-diff handling'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup basic merges' '
> +	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
> +	git add numbers &&
> +	git commit -m base &&
> +
> +	git branch feature_a &&
> +	git branch feature_b &&
> +	git branch feature_c &&
> +
> +	git branch ab_resolution &&
> +	git branch bc_resolution &&
> +
> +	git checkout feature_a &&
> +	test_write_lines 1 2 three 4 5 6 7 eight 9 >numbers &&
> +	git commit -a -m change_a &&
> +
> +	git checkout feature_b &&
> +	test_write_lines 1 2 tres 4 5 6 7 8 9 >numbers &&
> +	git commit -a -m change_b &&
> +
> +	git checkout feature_c &&
> +	test_write_lines 1 2 3 4 5 6 7 8 9 10 >numbers &&
> +	git commit -a -m change_c &&
> +
> +	git checkout bc_resolution &&
> +	git merge --ff-only feature_b &&
> +	# no conflict
> +	git merge feature_c &&
> +
> +	git checkout ab_resolution &&
> +	git merge --ff-only feature_a &&
> +	# conflicts!
> +	test_must_fail git merge feature_b &&
> +	# Resolve conflict...and make another change elsewhere
> +	test_write_lines 1 2 drei 4 5 6 7 acht 9 >numbers &&
> +	git add numbers &&

Just a matter of taste, but FWIW some of the custom
test_write_lines/commit here could nowadays use test_commit with
--printf: 47c88d16ba6 (test-lib functions: add --printf option to
test_commit, 2021-05-10)

I don't think it's worth the churn to change it here, just an FYI.
