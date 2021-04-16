Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C17DC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D356D613B0
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhDPT0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:26:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51509 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhDPT0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 15:26:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8ED0C115E94;
        Fri, 16 Apr 2021 15:25:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nzNEGd1efSv9EBjvYI0MqpEEC7o=; b=SZChM+
        ZM0tIuiuKJZjByItxosS1kVE6DgqFlUz9BlEa6xvP6wDRvRHgB6/FUDNQ3JBczpi
        pDyexwmayXGWy4MduOV94vaS7ct7QYmhtazL6r3nrI6k/Jl8QBPn/63xAs7z9U6S
        l6KTbHcep8shDPNYR0FIJM/QUEn6jiABNxL0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MvyzBw2usR4evF3XTng5qDkZgrpsqFh9
        0bGzdp0A8+Oyx3P6gu63uJ3W6SFAv9dPXkZtHTTr3SrgY/xe7qdPzkxCVz3kzjiP
        kvbd3z3C3bijsEYAzN97w3Ud2d/F0/L9TVmaPcll4djlBY14WwgymWYORDAbvguL
        oiVCYfrOwws=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86EED115E92;
        Fri, 16 Apr 2021 15:25:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA938115E90;
        Fri, 16 Apr 2021 15:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
        <xmqqy2dikpc1.fsf@gitster.g>
Date:   Fri, 16 Apr 2021 12:25:40 -0700
In-Reply-To: <xmqqy2dikpc1.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        16 Apr 2021 12:21:34 -0700")
Message-ID: <xmqqr1jakp57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 886EA322-9EE9-11EB-A7A3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK.  I think there still will be disagreement on this last point
> between Christian and I, but I'd be happy with this as the first cut
> for newly introduced .cmd and then when it becomes needed add
> something like the attached patch on top to optionally run the given
> command when configured.
>
>
>  trailer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git c/trailer.c w/trailer.c
> index 7c7cb61a94..39132211cc 100644
> --- c/trailer.c
> +++ w/trailer.c
> @@ -723,7 +723,8 @@ static void process_command_line_args(struct list_head *arg_head,
>  	/* Add an arg item for each configured trailer with a command */
>  	list_for_each(pos, &conf_head) {
>  		item = list_entry(pos, struct arg_item, list);
> -		if (item->conf.command)
> +		if ((item->conf.run_implicitly && item->conf.cmd) ||
> +		    item->conf.command)
>  			add_arg_item(arg_head,
>  				     xstrdup(token_from_item(item, NULL)),
>  				     xstrdup(""),

Actually, if we were to do this, I actually suspect that, unlike the
textual replacement of $ARG in the old .command configuration, we
should take advantage of the fact that the command can tell the
cases between an empty string given as $1 and no positional argument
was given for $1.  So what add_arg_item() does here for .command
(which has to give an empty string, because it will textually
replace an occurrence of $ARG) and for .cmd may have to be different.
Perhaps record NULL here, so that when the command line is formed,
we can tell that we do not want add an extra "" that becomes $1,
when we are dealing with .cmd in this codepath.

Thanks.
