Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D544C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECFC2078A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 17:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uq1BtCfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgFORFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:05:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61455 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFORFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 13:05:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40DA3CEDCB;
        Mon, 15 Jun 2020 13:05:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GQqkrcrx4LfKCzY/uvmor52KOFw=; b=uq1BtC
        fSx/5GqG7yGiZmNsDTqjF9AyTbux0EFLi7pc5BGTB9nY7uT1BVPk3hPQEnln6du+
        O6p64zhbI/dRxMP/yQXo9DYPZF3mvXLRmaz96/xYek9TD8xqwh08prkLZeQPjWiV
        TtumgmgFfIbhtx2YFKrTUpVcmn53tqIJfpBBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ERubPHSFsX2OV2t6l6FBmno9eGhOcn1O
        2llnf69c1i0Rm97Nr+YGZF9+GVOhOEE32CRTDDK0RBqsMHQqSyA3kT7bDY6kVth3
        eE71F5nTJP1vB4a/0Cy//DCeO151AhclXv6BX2xBEBNhh2o0y5lCiLvcBivrQI87
        gPNWzzeRb/I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 376AECEDCA;
        Mon, 15 Jun 2020 13:05:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A7AACEDC9;
        Mon, 15 Jun 2020 13:05:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the main branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:05:41 -0700
In-Reply-To: <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 15 Jun 2020
        12:50:06 +0000")
Message-ID: <xmqqr1ugw97e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72A64A22-AF2A-11EA-A437-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 72d32bd73b1..43f4f829242 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -407,7 +407,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  				const char *current_branch)
>  {
>  	int i = 0;
> -	char *sep = "";
> +	char *sep = "", *main_branch;
>  
>  	strbuf_addstr(out, "Merge ");
>  	for (i = 0; i < srcs.nr; i++) {
> @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  			strbuf_addf(out, " of %s", srcs.items[i].string);
>  	}
>  
> -	if (!strcmp("master", current_branch))
> +	main_branch = git_main_branch_name();
> +	if (!strcmp(main_branch, current_branch))
>  		strbuf_addch(out, '\n');
>  	else
>  		strbuf_addf(out, " into %s\n", current_branch);
> +	free(main_branch);

While you are at it, taking

https://lore.kernel.org/git/20200614211500.GA22505@dcvr/

and the response to it into consideration, I'd suggest we should
support the case where the user says "no single branch is special
here" by configuring it to an empty string.

> +core.mainBranch::
> +	The name of the main (or: primary) branch in the current repository.
> +	For historical reasons, `master` is used as the fall-back for this
> +	setting.

As to the naming of the configuration variable and the actual
fall-back value, I would strongly suggest making them DIFFERNT
(i.e. separate the concept from an actual value).

An instruction

    ... oh, if you want to do so, you can set the core.mainBranch
    configuration variable to 'main'

sounds strange than

    ... oh, if you want to do so, you can set the core.primaryBranch
    configuration variable to 'main'

at least to me, and since I am OK with your choice of 'main' as the
replacement for 'master', a separate word would be more appropriate
for the variable name.

