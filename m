Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A55EC433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0C2206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JvYo7fnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgGWUx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:53:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56404 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWUx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:53:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 271D6D486B;
        Thu, 23 Jul 2020 16:53:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eoJAPCMtzMujly/eufpIltYp0w4=; b=JvYo7f
        ncFRLyKMiudaYUv63bSjpesFiK6XBBA/S9DShoN5Ua4n8vk9lLaYoo5X94GnyISv
        B4RTewQkai2VOCXRcgLhSPfZ3iVZhcWw1JUrO8E9l9VIrlpftQwrLJd6Mu/SaxmN
        1gDbT5asAkjZ50seOD32HoiYKSSJmBkI+YvqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F7+fjRRxGjzkJXVgtIynFfJfYyXrAMfc
        yyhaEBqejntbUdx8EP2/dnoPNJItiD7UeXvWkQZePZ/UNCdFhQTcoyjKY7aKdm+g
        rgae/BzWfsWTBnlGlWxy47qERxQuusiGkfqK5R8M1xPuiXdGztma8kfIqRN5Z6Mi
        ZXqf1y3/GsQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E923D486A;
        Thu, 23 Jul 2020 16:53:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63C4DD4869;
        Thu, 23 Jul 2020 16:53:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 13:53:20 -0700
In-Reply-To: <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 23 Jul 2020
        17:56:30 +0000")
Message-ID: <xmqqwo2uosvz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BB0488C-CD26-11EA-85A5-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 9204762e21..0927643247 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -53,6 +53,18 @@ since it will not expire `.graph` files that were in the previous
>  `commit-graph-chain` file. They will be deleted by a later run based on
>  the expiration delay.
>  
> +prefetch::
> +	The `fetch` task updates the object directory with the latest objects

s/fetch/prefetch/ most likely.

> +	from all registered remotes. For each remote, a `git fetch` command
> +	is run. The refmap is custom to avoid updating local or remote

s/remote/remote-tracking/ definitely.  Do not forget the hyphen
between the two words.

I think it made the above unnecessarily confusing that you ended a
sentence after "is run".  It gives a wrong impression that you'd be
doing a "real fetch", which you need to dispel with a follow up
description of the refmap.

	For each remote, a `git fetch` command is run with a refspec
	to fetch their branches (those in their `refs/heads`) into
	our `refs/prefetch/<remote>/` hierarchy and without auto
	following tags (the configured refspec in the repository is
	ignored).

> +	branches (those in `refs/heads` or `refs/remotes`). Instead, the
> +	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
> +	not updated.
> ++
> +This means that foreground fetches are still required to update the
> +remote refs, but the users is notified when the branches and tags are

s/is notified/are notified/???

> +updated on the remote.

Often, when one needs to say "X.  This means Y.", X is a suboptimal
way to explain what needs to be conveyed to the readers.  But this
is not such a case.  Unlike the "This means" that is often an
attempt to rephrasing a poor explanation given first, this gives an
implication.

But let's not start with a negative impression (i.e. even with
prefetch, I still have to do X?  What's the point???), but let them
feel why it is a good thing.  Perhaps (continuing my previous
rewrite):

	This is done to avoid disrupting the remote-tracking
	branches---the end users expect them to stay unmoved unless
	they initiate a fetch.  With prefetch task, however, the
	objects necessary to complete a later real fetch would
	already be obtained, so the real fetch would go faster.  In
	the ideal case, it will just become an update to bunch of
	remote-tracking branches without any object transfer.

or something like that?  

> +	argv_array_pushl(&cmd, "fetch", remote, "--prune",
> +			 "--no-tags", "--refmap=", NULL);
> +	strbuf_addf(&refmap, "+refs/heads/*:refs/prefetch/%s/*", remote);
> +	argv_array_push(&cmd, refmap.buf);

The command line looks somewhat fishy, but I think it is correct.
At first glance it looks like a mistake to pass "--refmap=" and the
refspec "+refs/heads/*:refs/prefetch/origin/*" as separate arguments,
but I think that is exactly what you want here, i.e.

 - defeat any refspec in the configuration with "--refmap=<empty>"

 - give explicit refspec "+refs/heads/*:...", with "--no-tags" to
   decline auto-following, to tell what exactly are to be fetched
   and stored where.

The description in the log message about refmap needs to be
clarified, though (I've already done so in the above suggested
rewrite).

> +static int maintenance_task_prefetch(void)
> +{
> +	int result = 0;
> +	struct string_list_item *item;
> +	struct string_list remotes = STRING_LIST_INIT_DUP;
> +
> +	if (for_each_remote(fill_each_remote, &remotes)) {
> +		error(_("failed to fill remotes"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * Do not modify the result based on the success of the 'fetch'
> +	 * operation, as a loss of network could cause 'fetch' to fail
> +	 * quickly. We do not want that to stop the rest of our
> +	 * background operations.
> +	 */

The loop that runs different tasks abort at the first failure,
though.  Perhaps that loop needs to be rethought as well?

> +	for (item = remotes.items;
> +	     item && item < remotes.items + remotes.nr;
> +	     item++)
> +		fetch_remote(item->string);
> +
> +cleanup:
> +	string_list_clear(&remotes, 0);
> +	return result;
> +}
> +
>  static int maintenance_task_gc(void)
>  {
>  	int result;
> @@ -871,6 +929,10 @@ static void initialize_tasks(void)
>  	for (i = 0; i < MAX_NUM_TASKS; i++)
>  		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
>  
> +	tasks[num_tasks]->name = "prefetch";
> +	tasks[num_tasks]->fn = maintenance_task_prefetch;
> +	num_tasks++;
> +
>  	tasks[num_tasks]->name = "gc";
>  	tasks[num_tasks]->fn = maintenance_task_gc;
>  	tasks[num_tasks]->enabled = 1;

Two things.

 - As I said upfront, I do not see the point of preparing the table
   with code.

 - The reason why prefetch is placed in front is probably because
   you do not want to repack before you add more objects to the
   object store.  But doesn't that imply that there is an inherent
   ordering that we, as those who are more expert on Git than the
   end users, prefer?  Is it a wise decision to let the users affect
   the order of the tasks run by giving command line options in
   different order in the previous step?

