Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_C,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C709C433DF
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B252065F
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sGQ5Ga6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGWUWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:22:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51169 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:22:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEACE7F14A;
        Thu, 23 Jul 2020 16:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=P6BiM4X+GQUukMebsZM1Vzj9teI=; b=sGQ5Ga6duxaPeVHw7GHO
        YXxtpY8UbzIRsf0EcsgkTHQg7XNhn2W8q+6sAV6Uf1a5yjo9rooJZObwVqWh5FQM
        UEKGWyV3RDoG4QK6VXf4ZO7u8arEcWnaYskJFyKo51caTBnBEU7JhyZ/N9ktyGXL
        c6WUaN5FsFCC1eI0rDOePME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=G7u2n1TteadvmCL9u/tKrMaKJqUanln3Ogtic6ESpbdqbO
        hgrKx2ppVOnLByRL18uNyWTzvRogqYrIg21/HaJlu6Z3CsIqATFS6QmIKkgxLdU/
        ngxhmTE+WGr+B3kMcPtPQwyZeGv3eVNdzWxapVk33PYTIt2+vY4e5TEStKZ+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C302C7F149;
        Thu, 23 Jul 2020 16:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F087E7F148;
        Thu, 23 Jul 2020 16:22:06 -0400 (EDT)
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
Subject: Re: [PATCH v2 05/18] maintenance: add commit-graph task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <04552b1d2ed751a11eb7c50f6898cbc078b552b4.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 13:22:06 -0700
Message-ID: <xmqq4kpyq8wh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DD98FB0-CD22-11EA-8668-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int maintenance_task_commit_graph(void)
> +{
> +	struct repository *r = the_repository;
> +	char *chain_path;
> +
> +	/* Skip commit-graph when --auto is specified. */
> +	if (opts.auto_flag)
> +		return 0;

Stepping back a bit, back in "git gc" days, "--auto" had two
distinct meanings rolled into one.  Check if it even needs to be
done, and perform only the lightweight variant if needed.

For this task, there is no "lightweight variant" is possible, so
returning without checking the need to do a lightweight one makes
perfect sense here.

But wouldn't it suggest perhaps we could name "auto" field of the
options struct in a more meaningful way?  Perhaps "quick" (i.e. only
the quicker-variant of the maintenance job) or something?

> +	close_object_store(r->objects);
> +	if (run_write_commit_graph()) {
> +		error(_("failed to write commit-graph"));
> +		return 1;
> +	}
> +
> +	if (!run_verify_commit_graph())
> +		return 0;
> +
> +	warning(_("commit-graph verify caught error, rewriting"));
> +
> +	chain_path = get_commit_graph_chain_filename(r->objects->odb);
> +	if (unlink(chain_path)) {
> +		UNLEAK(chain_path);
> +		die(_("failed to remove commit-graph at %s"), chain_path);

OK.

> +	}
> +	free(chain_path);
> +
> +	if (!run_write_commit_graph())
> +		return 0;
> +
> +	error(_("failed to rewrite commit-graph"));
> +	return 1;
> +}

Error convention is "positive for error, zero for success?"  That is
a bit unusual for our internal API.

>  static int maintenance_task_gc(void)
>  {
>  	int result;
> @@ -768,6 +836,10 @@ static void initialize_tasks(void)
>  	tasks[num_tasks]->fn = maintenance_task_gc;
>  	tasks[num_tasks]->enabled = 1;
>  	num_tasks++;
> +
> +	tasks[num_tasks]->name = "commit-graph";
> +	tasks[num_tasks]->fn = maintenance_task_commit_graph;
> +	num_tasks++;

Again, I am not sure if we want to keep piling on this.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index e4e4036e50..216ac0b19e 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -12,7 +12,7 @@ test_expect_success 'help text' '
>  	test_i18ngrep "usage: git maintenance run" err
>  '
>  
> -test_expect_success 'gc [--auto|--quiet]' '
> +test_expect_success 'run [--auto|--quiet]' '

It does not look like this change belongs here.  If "run" is
appropriate title for this test at this step, it must have been so
in the previous step.

>  	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run --no-quiet &&
>  	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
>  	GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
