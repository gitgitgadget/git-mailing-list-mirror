Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DE1C4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26FF61374
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhEaGum (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:50:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59774 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhEaGul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:50:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92648D5763;
        Mon, 31 May 2021 02:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ozu8C1Uw7hu9SHl6lJezyh+iweecG9LPxLjebR0TBFY=; b=bVtu
        6NvGuk/W/nQYsrXFjwhUiZUqkfsyvoI9XtXFP8ztihJvsbGikZPYceSWX8W/78xU
        VvoefKZgClpu0VUKUMxGJjtGlFQtFl/44+AdNko0HxnER4HVc1qwOQWu4HtSZfPT
        ldTZ/8kLhW0BVCfjXUk2iMXqnSpdmOoO+rxlIuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 572D0D5762;
        Mon, 31 May 2021 02:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41ADCD575D;
        Mon, 31 May 2021 02:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 13/15] push: only get triangular when needed
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529074458.1916817-14-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 15:48:59 +0900
Message-ID: <xmqqr1hnv1no.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4795DC60-C1DC-11EB-BA86-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index c220f70795..818ca4c5c9 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -205,8 +205,8 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
>  	struct branch *branch;
> -	int triangular = remote != remote_get(NULL);
>  	const char *dst;
> +	int triangular;
>  
>  	switch (push_default) {
>  	case PUSH_DEFAULT_MATCHING:
> @@ -225,6 +225,7 @@ static void setup_default_push_refspecs(struct remote *remote)
>  		die(_(message_detached_head_die), remote->name);
>  
>  	dst = branch->refname;
> +	triangular = remote != remote_get(NULL);
>  
>  	switch (push_default) {
>  	default:

This is another change that got helped by an earlier split.
Good.
