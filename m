Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E5C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1790C611F0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhEJSNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 14:13:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50434 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhEJSNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 14:13:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20787B86A6;
        Mon, 10 May 2021 14:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dpOS8LNlh+IstRoEPVIed3Y4uurl1gqmcUuGkV
        Y6MOE=; b=DiylfD/YA+Vvskq5J+mH0Sud/uqJedrBKoMtjhdeCYRwNLHo5qvbEp
        bFPt6QkbnUxDqCUdE30ZcG7pY/NfUB1xh0ZJ+5CcPuCNTP4GrHw99oc22Y1H7+O6
        5N+Oqs/qxpaAs/HkQTItn06n+7hdhECT/OA4orrYpRd5IV8hJ9WQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 195EFB86A5;
        Mon, 10 May 2021 14:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C6B7B86A4;
        Mon, 10 May 2021 14:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/gc: warn when core.commitGraph is disabled
References: <510425b8b17411eb93770026b95c99cc@oschina.cn>
Date:   Tue, 11 May 2021 03:12:40 +0900
In-Reply-To: <510425b8b17411eb93770026b95c99cc@oschina.cn>
        (lilinchao@oschina.cn's message of "Mon, 10 May 2021 17:43:43 +0800")
Message-ID: <xmqq4kfaqwyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F6F6B58-B1BB-11EB-90FE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lilinchao@oschina.cn writes:

> From: Li Linchao <lilinchao@oschina.cn>
>
> Throw warning message when core.commitGraph is disabled in commit-graph
> maintenance task.

Why?  If I said, with core.commitGraph, that I do not want to have
anything to do with commitGraph, why should I get disturbed with
such a warning message?


> Signed-off-by: Li Linchao <lilinchao@oschina.cn>
> ---
>  builtin/gc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 98a803196b..90684ca3b3 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -861,8 +861,10 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
>  static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
>  {
>  	prepare_repo_settings(the_repository);
> -	if (!the_repository->settings.core_commit_graph)
> +	if (!the_repository->settings.core_commit_graph) {
> +		warning(_("skipping commit-graph task because core.commitGraph is disabled"));
>  		return 0;
> +	}
>  
>  	close_object_store(the_repository->objects);
>  	if (run_write_commit_graph(opts)) {
