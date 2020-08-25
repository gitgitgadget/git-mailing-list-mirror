Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E82CC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2639A2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wepoaJVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHYVw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:52:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56250 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYVwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 17:52:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D0F8E4E4E;
        Tue, 25 Aug 2020 17:52:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgG4ivJ6mkvHDURsqEXdTxNPRcc=; b=wepoaJ
        VjtrZLW8eF4QahdzhB36JguoYHlAm2zRwcl4cnBNFqNX3kn4YMUlxubSOfgEEHQ8
        9BPyOcUeckMbOZbHLDnqAzut36iQoRQg2fuOFDzAjxOCE8GjQ/nr12oQ1YDRSwYI
        M3nUqlbtwfSISjiREiB5Psnq/pRBKItBzvABM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QEG5LSzM7eU6VKZ5o1r98acQrAK2LPrN
        tnJa+jfwflY/Jy7GCSeVeLVhZmNAlfqwv6oYkIwU/yV2zdRemod4VQH2b4mniCbQ
        tju2j7MdL4cTKAr/ZcncyEkzuyBsDofKYm8klMOVJfcwR2C7LuIRvgq8UpvZgGVd
        +8oiGOv3Seo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25200E4E4D;
        Tue, 25 Aug 2020 17:52:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94860E4E4C;
        Tue, 25 Aug 2020 17:52:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/7] maintenance: store the "last run" time in config
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <e3ef0b9bea4a31c72ce88841639e88355408f0c1.1598380805.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 14:52:47 -0700
In-Reply-To: <e3ef0b9bea4a31c72ce88841639e88355408f0c1.1598380805.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 25 Aug 2020
        18:39:59 +0000")
Message-ID: <xmqqh7sqz93k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51899C6A-E71D-11EA-9816-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I selected the timestamp before the task, as opposed to after the task,
> for a couple reasons:
>
>  1. The time the task takes to execute should not contribute to the
>     interval between running the tasks.

... as long as the run time is sufficiently shorter than the
interval, that is.  If a task takes 10-30 minutes depending on how
dirty the repository is, it does not make sense to even try to run
it every 15 minutes.

> If a daily task takes 10 minutes
>     to run, then every day the execution will drift by at least 10
>     minutes.

That is not incorrect per-se, but it does not tell us why drifting
by 10 minutes is a bad thing.

>  2. If the task fails for some unforseen reason, it would be good to
>     indicate that we _attempted_ the task at a certain timestamp. This
>     will avoid spamming a repository that is in a bad state.

Absolutely.

> +static void update_last_run(struct maintenance_task *task)
> +{
> +	timestamp_t now = approxidate("now");
> +	struct strbuf config = STRBUF_INIT;
> +	struct strbuf value = STRBUF_INIT;
> +	strbuf_addf(&config, "maintenance.%s.lastrun", task->name);
> +	strbuf_addf(&value, "%"PRItime"", now);

So is this essentially meant as a human-unreadable opaque value,
like we have in the commit object header lines?  I do not have a
strong opinion, but it would be nice to allow curious to casually
read it.  Perhaps "git config --type=timestamp maintenance.lastrun"
can be taught to pretty print its value?

