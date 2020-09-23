Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D6C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6C420791
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WtB94X8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIWQkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:40:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59093 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 12:40:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B14688844;
        Wed, 23 Sep 2020 12:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4zG5/v9tx5x2c1F3XeXkCOjAcXI=; b=WtB94X
        8iEthmpwXUB7S7VXyzs/NHvUs8XDQeS2WMhxQ+k9DM3idLl+CqBxZau/Ox/yA5ZE
        mx/wyp6/hoDBAaIi8CttXmvB7yC9aofioP3wixv9gV32ONVKs9ZzPeNs2xa9LeoC
        oqbLnTYcE1g6IrwZ/HwOBsHPPuA4NT9fSiAao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GJDDkb8q5ZvgG9RJM0LobXC3nkSBbXsa
        gDxpe61vC8hS7HrCpdNQ+7L4pgZwjDoSridhi01QZf0qKLlYooEkOzON2jBwOb7M
        chtT9Uj0kuKVqpAtTxQH21oDEJ0pV5QkykT9wS03sxjs39SVjTfMukK/mq3AKHB3
        aiSAPrdSsvM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 331ED88843;
        Wed, 23 Sep 2020 12:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B103E88842;
        Wed, 23 Sep 2020 12:40:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] pull: do not warn when opt_ff is explicitly specified
References: <1093128c646b154a14d89321454f5361c0e616b4.1600854717.git.liu.denton@gmail.com>
Date:   Wed, 23 Sep 2020 09:40:29 -0700
In-Reply-To: <1093128c646b154a14d89321454f5361c0e616b4.1600854717.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 23 Sep 2020 02:56:31 -0700")
Message-ID: <xmqq5z84jvk2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DAC9FD6-FDBB-11EA-9E20-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In d18c950a69 (pull: warn if the user didn't say whether to rebase or to
> merge, 2020-03-09), `git pull` was taught to warn users if they
> have `pull.rebase` unset or `pull.ff != "only"`. However, this warning
> is a little too eager about happening.

In d18c950a69, we added some tests to keep the warning working as
intended, and the fact that this patch does not touch anything in
the t/ directory means that its test coverage was not perfect.

We'd need to add a test or two to make sure this new behaviour is
protected against future breakages.

Thanks.

> If the warning is silenced by specifying `pull.ff = "only"`, as
> instructed, the warning will arise again if the user runs
> something like `git pull --no-ff`. However, the warning should not
> happen as the user clearly knows what they're doing.
>
> Don't display the warning if opt_ff is explicitly set by a command-line
> option given by a user.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/pull.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 015f6ded0b..307b4b5d21 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -83,6 +83,7 @@ static char *opt_commit;
>  static char *opt_edit;
>  static char *cleanup_arg;
>  static char *opt_ff;
> +static int opt_ff_explicit;
>  static char *opt_verify_signatures;
>  static int opt_autostash = -1;
>  static int config_autostash;
> @@ -344,7 +345,7 @@ static enum rebase_type config_get_rebase(void)
>  	if (!git_config_get_value("pull.rebase", &value))
>  		return parse_config_rebase("pull.rebase", value, 1);
>  
> -	if (opt_verbosity >= 0 &&
> +	if (!opt_ff_explicit && opt_verbosity >= 0 &&
>  	    (!opt_ff || strcmp(opt_ff, "--ff-only"))) {
>  		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
>  			"discouraged. You can squelch this message by running one of the following\n"
> @@ -933,6 +934,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	if (!opt_ff)
>  		opt_ff = xstrdup_or_null(config_get_ff());
> +	else
> +		opt_ff_explicit = 1;
>  
>  	if (opt_rebase < 0)
>  		opt_rebase = config_get_rebase();
