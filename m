Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E0C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADC1246A8
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 23:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ka5t5T8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB1XQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:16:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61839 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 18:16:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BAA4AA60E;
        Fri, 28 Feb 2020 18:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PIEJr7f3EP4E69EFNmXqZKYm3vI=; b=Ka5t5T
        8Wuqjdy2YPqJBZmZWhjLbx4jey3bpoDna/LK7agf/CZwSlOvWh2hQT3X73CkiIVZ
        iO8gvJsipGawTnKyce6gwa4xnlVaJGCaaxcUxG6KyI/23SnGQHCH7/MnkZWkjzOB
        VGNvC7hhNaEVx05eNjOoIcX0dY/f2xGy0p4kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d6rdQVE1VI0AN6WPrXD0S1eZSE0wsY8M
        PD/wqLMMkm3uM/Szo/3Bpi7on8sLC1PoGD733JcB3GihG9LxDkgCxBkxb28up/Y6
        k35j/7SPADrKyncINhZqyX+Sluf465XSHG3MDAAXhc4VDqPUjMIRkF245tRHREkN
        hcu9RafQnBc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23805AA60D;
        Fri, 28 Feb 2020 18:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C7E0AA608;
        Fri, 28 Feb 2020 18:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, annulen@yandex.ru
Subject: Re: [PATCH] pull: warn if the user didn't say whether to rebase or to merge
References: <20200228215833.319691-1-alexhenrie24@gmail.com>
Date:   Fri, 28 Feb 2020 15:16:01 -0800
In-Reply-To: <20200228215833.319691-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Fri, 28 Feb 2020 14:58:33 -0700")
Message-ID: <xmqqeeuecngu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A12A60E-5A80-11EA-9547-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Most Git users are contributors, not maintainers, and want to use
> `git pull` to rebase their changes before sending a pull request to the
> upstream project. However, novice Git users often forget to specify the
> --rebase option when pulling, leading to an unwanted merge commit.

The logic above looks somewhat twisted.  Even if most Git users were
integrators who would not want "pull --rebase", everything you said
after "However" still holds true.

    Often novice Git users forget to say "pull --rebase" and ends up
    with an unnecessary merge from upstream.  What they usually want
    is either "pull --rebase" in the simpler cases, or "pull
    --ff-only" to update the copy of main integration branches, and
    rebase their work separately.  The pull.rebase configuration
    variable exists to help them in the simpler cases, but there is
    no mechanism to make these users aware of it.

> To
> avoid that situation, Git should require users to explicitly specify
> whether their primary workflow is a contributor/rebasing workflow or a
> maintainer/merging workflow.

There is nothing Git "should" do.  There are things we wish Git did,
and we give orders to the codebase to do so in our proposed log
message.  Perhaps like:

    Issue a warning message when no --[no-]rebase option from the
    command line and no pull.rebase configuration variable is given.
    This will inconvenience those who never want to "pull --rebase",
    who haven't had to do anything special, but the cost of the
    inconvenience is paid only once per user, which should be
    reasonable cost to help number of new users.



>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/pull.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 3e624d1e00..8ec8e6f5d3 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -327,6 +327,13 @@ static enum rebase_type config_get_rebase(void)
>  	if (!git_config_get_value("pull.rebase", &value))
>  		return parse_config_rebase("pull.rebase", value, 1);

This helper function is called only when opt_rebase < 0 in the
caller, which means there were no --[no-]rebase on the command line.
That's why we called this function to learn what the configuration
say.  So it is the right place to add the new check.

Luckily for us, the caller also made sure opt_ff is already set up
by calling config_get_ff() first when there was no --ff related
command line option ;-)

>  
> +	if (strcmp(opt_ff, "--ff-only") != 0) {

Style.  Do not write "!= 0" in the condition.  Just

	if (strcmp(opt_ff, "--ff-only")) {

is enough.

> +		warning(_("Pulling without specifying whether to rebase or to merge is discouraged\n"

I briefly wondered if this wants to be an advice instead, but the
way to squelch the message is already built into this codepath so
there is no need to ;-)

> +			"and will be disallowed in a future Git release.\n"
> +			"Next time, run `git config pull.rebase (true|false)` first\n"
> +			"or specify --rebase or --no-rebase on the command line.\n"));
> +	}
> +
>  	return REBASE_FALSE;
>  }
