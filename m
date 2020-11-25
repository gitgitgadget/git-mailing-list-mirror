Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1904C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7247A206F7
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 20:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nMdBeMQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgKYU26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 15:28:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64014 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbgKYU26 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 15:28:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6145C9EE96;
        Wed, 25 Nov 2020 15:28:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oU9I73zCQM4EpVEGXHWHKIg13IA=; b=nMdBeM
        QFBZKWnWA565F+t1JnzNFZAm+Z/nLeZ2L33P8J+6J3irCSUJKkYrT4l6GcOZYxNs
        yWUhJMD8S7/QyfbMAP6bnThDzR4F37X9NwXkAOaWXWgl6n8ChQYvkibNF3lgIUZy
        +ZGgrIspJNhypaygd48XdCreMl/iASfhbENMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zu28CfkZz4PRUzqMbC1/+YoFwHjFqHct
        fsCSGCleSrSGj2pDu9P9gSkg7fOM+uixGihmXOIFb0g60jV8n8TcOafD0k8WPqfB
        CAkwu6rj7WQocABa9sXCmCSiydXw1lk5og6xftqzr+PHEYBQTaBopTouMM6Ai3Wa
        5wcRFVWq1cs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 572B49EE95;
        Wed, 25 Nov 2020 15:28:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF5219EE93;
        Wed, 25 Nov 2020 15:28:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
References: <cover.1606214397.git.ps@pks.im>
        <X740yqoYIhrqsNRE@coredump.intra.peff.net>
Date:   Wed, 25 Nov 2020 12:28:53 -0800
In-Reply-To: <X740yqoYIhrqsNRE@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 25 Nov 2020 05:41:14 -0500")
Message-ID: <xmqqv9dtdvui.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5FF070A-2F5C-11EB-B8D8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do still think that a "--config-env" option solves your problem in a
> much simpler way (especially in terms of interface we expose to users
> that we'll be locked into forever).

As a mechanism to allow a custom configuration for a single
invocation of a command, I tend to agree.  For a mechansim to affect
multiple commands in a sequence (read: scripts), I am not so sure.

The simplicity of the implementation we see below is also very
attractive.

> I sketched out the solution below if
> it's of interest (and I'd be happy to polish it up, or hand it off to
> you if so). But if you're unconvinced, I'll stop mentioning it.
>
> diff --git a/config.c b/config.c
> index 8f324ed3a6..d8cf6a5d6b 100644
> --- a/config.c
> +++ b/config.c
> @@ -345,6 +345,27 @@ void git_config_push_parameter(const char *text)
>  	strbuf_release(&env);
>  }
>  
> +void git_config_push_env(const char *spec)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *env_name;
> +	const char *env_value;
> +
> +	env_name = strchr(spec, '=');
> +	if (!env_name)
> +		return; /* die or warn? */
> +	env_name++;
> +
> +	env_value = getenv(env_name);
> +	if (!env_value)
> +		return; /* die or warn? */
> +
> +	strbuf_add(&buf, spec, env_name - spec);
> +	strbuf_addstr(&buf, env_value);
> +	git_config_push_parameter(buf.buf);
> +	strbuf_release(&buf);
> +}
> +
>  static inline int iskeychar(int c)
>  {
>  	return isalnum(c) || c == '-';
> diff --git a/config.h b/config.h
> index 91cdfbfb41..d05651c96c 100644
> --- a/config.h
> +++ b/config.h
> @@ -138,6 +138,7 @@ int git_config_from_mem(config_fn_t fn,
>  int git_config_from_blob_oid(config_fn_t fn, const char *name,
>  			     const struct object_id *oid, void *data);
>  void git_config_push_parameter(const char *text);
> +void git_config_push_env(const char *spec);
>  int git_config_from_parameters(config_fn_t fn, void *data);
>  void read_early_config(config_fn_t cb, void *data);
>  void read_very_early_config(config_fn_t cb, void *data);
> diff --git a/git.c b/git.c
> index 4b7bd77b80..342f2fb0c9 100644
> --- a/git.c
> +++ b/git.c
> @@ -254,6 +254,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			git_config_push_parameter((*argv)[1]);
>  			(*argv)++;
>  			(*argc)--;
> +		} else if (skip_prefix(cmd, "--config-env=", &cmd)) {
> +			git_config_push_env(cmd);
>  		} else if (!strcmp(cmd, "--literal-pathspecs")) {
>  			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "1", 1);
>  			if (envchanged)
