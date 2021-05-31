Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9944C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7532A60FF0
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhEaGqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:46:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62376 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhEaGqj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:46:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BF8F13B0A6;
        Mon, 31 May 2021 02:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=XkoGZLkfR38vKDDZKxuddTIC65lQk9gdDds9VWwyQmU=; b=tBpf
        D1ZcRXQa1Ua7R4xE1jHZEYlZ20hQN7neY+d/qs3f0pSPy/zssMb5iHJHhaFPkTaM
        RQr1SsGuqayfE6gRuip4aaPawC9CUrl3BVvgcskX0CNXGPuqRk6r/rUGy3N7dCAK
        jSSTGw94Eopc5Xwe6ew8NmqH2wAJ1M+r5PCGJMQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9216513B0A5;
        Mon, 31 May 2021 02:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE10213B0A4;
        Mon, 31 May 2021 02:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 11/15] push: fix Yoda condition
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529074458.1916817-12-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 15:44:56 +0900
Message-ID: <xmqqwnrfv1uf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B71FAE7C-C1DB-11EB-B0B9-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We want to check if remote is the same as the branch remote, not the
> other way around.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is 10/15's making, and squashing them together will make both
the entire series (because doing so means that the reviewers need to
see one fewer step) and 10/15 (because the end result of the conversion
is more "logical") easier to review (and later read in "git log -p").

>
> diff --git a/builtin/push.c b/builtin/push.c
> index 7485522807..468ccc1067 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -204,7 +204,7 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
>  
>  static int is_workflow_triangular(struct remote *remote)
>  {
> -	return remote_get(NULL) != remote;
> +	return remote != remote_get(NULL);
>  }
>  
>  static void setup_default_push_refspecs(struct remote *remote)
