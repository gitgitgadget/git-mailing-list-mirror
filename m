Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A02C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E70D2072B
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jTSZLdae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgAQSAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:00:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60506 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 13:00:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F39AA6EFA;
        Fri, 17 Jan 2020 13:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mrAYgMAj3DTsclc+4ENDJCHrO4E=; b=jTSZLd
        aeFDa1uXn+J35uLi/G7aLPDlKF9RcLta9j/lx6zDnzufN0UD44pdgly8kZzjx6PZ
        GRzxL+fgWVCpgJ+7gqcqP8b+nYAf1EH1fQkjndkmLD+iY+/Zkk2SrQsEHMcPmAxw
        +DBx8/lurl/raGvgMeShuvGtSwnXXY/7vXAnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eg/d0tX3ANXcP0QtC962YKcH0TUwfVIJ
        nNx68x9tAiDBnGm4AChBXLkPmR3sB8XroaNIGCyfXhY2mHtAs0mhf6Yt4ElhaO7r
        PQKYRWY0ITS4CQnB6U837A8Stlrfuhj/XadnRi8rt1qiRRcqBNwtRW5MjRf1V03y
        kps6mHD5k9M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 561EBA6EF9;
        Fri, 17 Jan 2020 13:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F03E0A6EF5;
        Fri, 17 Jan 2020 13:00:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] parse_insn_line(): improve error message when parsing failed
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <2ae2e435b0ef6888e72defc7abee1909b29aa914.1579209506.git.gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 10:00:08 -0800
In-Reply-To: <2ae2e435b0ef6888e72defc7abee1909b29aa914.1579209506.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 16 Jan 2020
        21:18:24 +0000")
Message-ID: <xmqqmuamdkuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3441B62E-3953-11EA-8099-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the case that a `get_oid()` call failed, we showed some rather bogus
> part of the line instead of the precise string we sent to said function.
> That makes it rather hard for users to understand what is going wrong,
> so let's fix that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index b9dbf1adb0..7c30dad59c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2118,6 +2118,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  	saved = *end_of_object_name;
>  	*end_of_object_name = '\0';
>  	status = get_oid(bol, &commit_oid);
> +	if (status < 0)
> +		error(_("could not parse '%s'"), bol); /* return later */
>  	*end_of_object_name = saved;

OK, so after making sure the line begins a command that takes an
object name, we first NUL terminated the token after the command
but it turns out the string is not a valid oid.  We show the part
we thought was the object name before reverting the NUL termination.

Makes sense.  And then later...

>  	bol = end_of_object_name + strspn(end_of_object_name, " \t");
> @@ -2125,11 +2127,10 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  	item->arg_len = (int)(eol - bol);
>  
>  	if (status < 0)
> -		return error(_("could not parse '%.*s'"),
> -			     (int)(end_of_object_name - bol), bol);
> +		return status;

...this is the *only* code that uses the status that was assigned to
the return value of get_oid().  

Because the implementation of this function (mis)uses "bol", which
stands for "beginning of line", as a moving pointer of "beginning of
the token we are looking at", the value of "bol" at this point of
the control in the original code is not where the "bol" pointer used
to be when end-of-object-name was computed (if it were, the '%.*s'
argument would have been correct) and shows a token after where the
object name would have been, which may help the user identify the
line but does not directly show what token we had trouble with
parsing.

And the updated code will avoid the issue by using the "bol" pointer
when it is still pointing at the right place.


>  	item->commit = lookup_commit_reference(r, &commit_oid);
> -	return !item->commit;
> +	return item->commit ? 0 : -1;

This changes the polarity of the error exit from positive 1 to
negative 1.  The only caller of this function takes anything
non-zero as a failure so this would not cause behaviour change, but
returning negative is more in line with the practice so it is an
improvement (it is unrelated to the theme of this patch and is not
explained, though).

OK.

