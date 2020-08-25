Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09F9C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 22:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8DE206EB
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 22:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kv/0AdC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYWT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:19:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60947 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHYWT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 18:19:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64F11DFE38;
        Tue, 25 Aug 2020 18:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+dBdcFUjGjLCQKc3KUcAVDvVh7I=; b=kv/0Ad
        C2ZMr1GQcuRL/OwCINjhA5yOJoCG931REEhXk24WUlR4aSFFrKD1oVwgiQWBAe2Q
        wyX/ASJ4Klrn78iwPeufcJuirMn0cAduBpTJUDTqZPNO9ulxwbyiaDa6yPidxBYf
        vz+V1YkeAhYRuPtZDVfZjSIRS5tZ6n9RHxHCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=um+2qUo9HVL/iCjyZ01TLLpymPCcLDSz
        E6uKJeLEdVcOkjqC63f2GCGTfiPwCqn65UKfFHBf11vnh9E8ksWkeP+PpSRYmU2K
        pWgKce0NyoLvIcg3DP5d4PEUbZIHz8ybCc5t1udu6kkCLqLE1lTZSSMgSrSl+SSv
        /6Dr9DnYbhQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D6C5DFE35;
        Tue, 25 Aug 2020 18:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9C80DFE34;
        Tue, 25 Aug 2020 18:19:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/7] for-each-repo: run subcommands on configured repos
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <0314258c5cbb8fd771c35e433bf6be95297c4597.1598380805.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 15:19:50 -0700
In-Reply-To: <0314258c5cbb8fd771c35e433bf6be95297c4597.1598380805.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 25 Aug 2020
        18:40:01 +0000")
Message-ID: <xmqq8se2z7uh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19030A62-E721-11EA-A1DA-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +SYNOPSIS
> +--------
> +[verse]
> +'git for-each-repo' --config=<config> [--] <arguments>
> + ...
> +--config=<config>::
> +	Use the given config variable as a multi-valued list storing
> +	absolute path names.

Would it make sense to allow this config to be read from the current
repository, I wonder.  It is probably designed to be written to
either ~/.gitconfig or /etc/gitconfig because it is probably a need
that is not per-repository to list repositories for various purposes
specified by the config key, but I suspect there _might_ be a good
use case for storing some custom list of repositories in the
configuration file local to a repository, but it is not quite
obvious what it is.

If we have a good example, we may want to spell it out---that would
help future readers who wonder about this (just like I am doing now).

Also, if we do read from local config, should there be a way to say
"ah, you may have read values from /etc/gitconfig and ~/.gitconfig,
but please forget them---I have a full list I care when you are
running in this repository", i.e. clear the list.  It is purely a
convention and there is no built-in mechanism for this in the config
API, but often it is signalled by giving an empty string as a value.

By the way, I do not have a good concrete suggestion, but can we use
something better than <config> as the placeholder?  I first thought
this was naming the name of a file that lists repositories, not the
config variable name in our usual config namespace.

> +static int run_command_on_repo(const char *path,
> +			       void *cbdata)

Is that on repo or in repo?  When I saw "-C" on the command line, I
immediately thought of "in repo".

> +{
> +	int i;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct strvec *args = (struct strvec *)cbdata;
> +
> +	child.git_cmd = 1;
> +	strvec_pushl(&child.args, "-C", path, NULL);
> +
> +	for (i = 0; i < args->nr; i++)
> +		strvec_push(&child.args, args->v[i]);

Would strvec_pushv() work, or is args->v[] not NULL terminated?

> +	return run_command(&child);
> +}


> +	values = repo_config_get_value_multi(the_repository,
> +					     config_key);

Not your fault, but it is a bit unsatisfactory that we do not have
special "type" meant for paths in the config API, unlike the
parse-options API where there is a "filename" type that is a bit
richer than a vanilla "string" type by allowing "prefix" handling.
For the purposes of this, as the values are limited to absolute/full
pathnames, it does not hurt as much, though.

Thanks.
