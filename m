Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC290C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEB1222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rSAab13s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfLSTOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:14:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63413 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSTOX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 14:14:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0FC0908FF;
        Thu, 19 Dec 2019 14:14:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6p0v2NcxBd60bcuYKR2T2xSgZBQ=; b=rSAab1
        3skhuiGdn/02EW9a9j4zO2C8CaLNF4QOQNBmC9cbNORKPBvkL7ewikBLQ0tOEK/c
        ZdOI0wptGP3dZ/v6amqIlYdtyI12ZqQ038R2L91IM362j08/syBhrSs6KSa1Kr1g
        0Rml+CZIGIt7bRFT8YBrOBJXARcIFsXFoyfoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pN8uozBeYOtJgNrvGfCd5aG6IXbwOkO/
        Cd90gEUgQqtToq5YGskLLoDcnoExsPO4CL8SgcLGnTG2GtPodI1/MWrCARjKk2AC
        sZYgwNsydw5ZUAX7VLJfQ8GWrXXBBvCTDNrUsZkGDecLZisbo92eecwPrq8aeggE
        k+UOLZylJUI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9921B908FE;
        Thu, 19 Dec 2019 14:14:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA593908FD;
        Thu, 19 Dec 2019 14:14:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
        <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 11:14:13 -0800
In-Reply-To: <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Thu, 19 Dec 2019 09:16:22
        +0000")
Message-ID: <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF922CBC-2293-11EA-B57D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index e48c1fd90a..868c0d7819 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -811,12 +811,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	old_display_comment_prefix = s->display_comment_prefix;
>  	s->display_comment_prefix = 1;
>  
> -	/*
> -	 * Most hints are counter-productive when the commit has
> -	 * already started.
> -	 */
> -	s->hints = 0;
> -

Hmm.

> @@ -837,6 +831,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		int saved_color_setting;
>  		struct ident_split ci, ai;
>  
> +		/*
> +		 * Most hints are counter-productive when displayed in
> +		 * the commit message editor.
> +		 */
> +		s->hints = 0;
> +

We no longer drop s->hints when we are not using editor and not
including status (i.e. the "else" side) because these lines are
moved inside "if".  As this change is not about that "no editor"
side, I am not 100% convinced that this is a good change.

> @@ -912,6 +912,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		saved_color_setting = s->use_color;
>  		s->use_color = 0;
>  		committable = run_status(s->fp, index_file, prefix, 1, s);
> +		if(!committable)

Style: SP between "if" and "(".

> +			/*
> +			 Status is to be printed to stdout, so hints will be useful to the
> +			 user. Reset s->hints to what the user configured
> +			 */
> +			s->hints = advice_status_hints;

The "if" side has been changed to flip s->hints to the configured
advice hints value when !committable here.  The "else" side
(i.e. when we are not using editor and not including status) does
not do anything to s->hints after finding out if committable after
this change.  Because "s->hints = 0" was moved to "if" with this
patch, the "else" side no longer drops s->hints at all.

So the final run_status() called when the attempt to commit is
rejected will feed s->hints that is not cleared with this change.

Is that intended?  Is the updated behaviour checked with a test?

>  		s->use_color = saved_color_setting;
>  		string_list_clear(&s->change, 1);
>  	} else {

This fix was about "we do not want to unconditionally drop the
advice messages when we reject the attempt to commit and show the
output like 'git status'", wasn't it?  The earlier single-liner fix
in v1 that flips s->hints just before calling run_status() before
rejecting the attempt to commit was a lot easier to reason about, as
the fix was very focused and to the point.  Why are we seeing this
many (seemingly unrelated) changes?

Puzzled...
