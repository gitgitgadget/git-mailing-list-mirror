Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4737C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467AA20724
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TpM6Ny0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCTVVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:21:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54964 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCTVVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:21:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D41AC80F2;
        Fri, 20 Mar 2020 17:21:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G8P/rge1M/Ou/M3xQ4eUIKkFnms=; b=TpM6Ny
        0wqQTlxH3Y/Ga7ewudce9FeiI4Pv/M3SLK6ENlKc9t/efLmL861UmzwcoJD+33HA
        yviOcXLPo4uq3hu+JaP0di8Q1MzTx0a7HLIHSmcB6fcmbpBTeRExUuk1QuyUZB9w
        7aclLszqoYn+VLcYrp3JCFR27uEIalXgH7Skc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DzUtVQKrhiT0xeisrLO1LS5jzKywxXc2
        yMUS70sXeidOtcMSfQEC6D6x6BHJD01k3JPSBbQ4PlqOGuAFoUnDoQgz1ZzZl5PN
        eIoqo5f2fwa5XqrEC1p9vf7AuIptyn1D3SYkRhB1cg6E9q+qdDzbB8XA8RvPd/Di
        OntkJ4qaiGs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45AC2C80F1;
        Fri, 20 Mar 2020 17:21:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 88F33C80EF;
        Fri, 20 Mar 2020 17:21:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] trace2: teach Git to log environment variables
References: <0f5607a4242cc7b61ad36d0782c9d1250c4d4d7d.1584737973.git.steadmon@google.com>
Date:   Fri, 20 Mar 2020 14:21:28 -0700
In-Reply-To: <0f5607a4242cc7b61ad36d0782c9d1250c4d4d7d.1584737973.git.steadmon@google.com>
        (Josh Steadmon's message of "Fri, 20 Mar 2020 14:06:15 -0700")
Message-ID: <xmqqimiybu3r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C444E164-6AF0-11EA-9122-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +trace2.envVars::
> +	A comma-separated list of "important" environment variables that should
> +	be recorded in the trace2 output.  For example,
> +	`GIT_HTTP_USER_AGENT,GIT_CONFIG` would cause the trace2 output to
> +	contain events listing the overrides for HTTP user agent and the
> +	location of the Git configuration file (assuming any are set).  May be
> +	overriden by the `GIT_TRACE2_ENV_VARS` environment variable.  Unset by
> +	default.

In other words, by default nothing is logged?

>  		trace2_cmd_alias(alias_command, new_argv);
>  		trace2_cmd_list_config();
> +		trace2_cmd_list_env_vars();

OK, so we treat the settings of configuration variables and
environment variables pretty much the same.  Both affect how git
behaves for the end-users, and even though they are physically
different mechanisms, philosophically the reason they are worth
logging are the same for these two categories.

> @@ -439,6 +441,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	trace_argv_printf(argv, "trace: built-in: git");
>  	trace2_cmd_name(p->cmd);
>  	trace2_cmd_list_config();
> +	trace2_cmd_list_env_vars();

Likewise.  That is why these two appear together.

>  			trace2_cmd_name(cmds[i].name);
>  			trace2_cmd_list_config();
> +			trace2_cmd_list_env_vars();

And here.

> diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
> index 3c3792eca2..a380dcf910 100644
> --- a/trace2/tr2_sysenv.c
> +++ b/trace2/tr2_sysenv.c
> @@ -29,6 +29,8 @@ struct tr2_sysenv_entry {
>  static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
>  	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TRACE2_CONFIG_PARAMS",
>  				       "trace2.configparams" },
> +	[TR2_SYSENV_ENV_VARS]      = { "GIT_TRACE2_ENV_VARS",
> +				       "trace2.envvars" },
>  
>  	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TRACE2_DST_DEBUG",
>  				       "trace2.destinationdebug" },

In this array, similar things are grouped together and groups are
separated by a blank line in between.  As the new ENV_VARS are
treated pretty much the same way as CFG_PARAM, it is thrown in the
same group, instead of becoming a group on its own.  Makes sense.


> diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
> index d4364a7b85..3292ee15bc 100644
> --- a/trace2/tr2_sysenv.h
> +++ b/trace2/tr2_sysenv.h
> @@ -11,6 +11,7 @@
>   */
>  enum tr2_sysenv_variable {
>  	TR2_SYSENV_CFG_PARAM = 0,
> +	TR2_SYSENV_ENV_VARS,
>  
>  	TR2_SYSENV_DST_DEBUG,

Likewise.

Thanks.
