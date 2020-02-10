Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA6C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9920715
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CqnGtr+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBJSDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:03:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62776 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgBJSDI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:03:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5961BF692;
        Mon, 10 Feb 2020 13:03:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nPvZ/FDudLkKyMywtzTGjQVc3LE=; b=CqnGtr
        +po3iLU1b0FWeTsZcE4hK8hD0Un9HSyYQ5NIUM2p+cvy8wvRZYxLqEWDMZobRWDY
        qtkVUH4EBojleLCLPpdv/ab+Ab+vRC840eebkonIrI9xZNEYZ0UorUcUOS5zIFKh
        y1Vi4QHWazyBocQpyakpYNkDoqmfOBZYl+M4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DPjsGnE9c/LLu0y1Y+nwuFNT31BKR7eE
        BTjlxs4gKyBNxwm3OiWuRIutjI5Hf9k1cGBeMSP1WKYGJP6w/SHuE9jft418+vff
        Jlot4QTMXltdQSf6mpj/0esnq4h7MJCpLtiLnj/nH6nJKNirOkyg1SiKLkCloKT1
        +XYtsaWxAtY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEF20BF691;
        Mon, 10 Feb 2020 13:03:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF870BF68F;
        Mon, 10 Feb 2020 13:03:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v7 04/10] config: make scope_name non-static and rename it
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 10:02:59 -0800
In-Reply-To: <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Mon, 10 Feb 2020
        00:30:53 +0000")
Message-ID: <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9403B4BA-4C2F-11EA-B77B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> To prepare for the upcoming --show-scope option, we require the ability
> to convert a config_scope enum to a string.  As this was originally
> implemented as a static function 'scope_name()' in
> t/helper/test-config.c, we expose it via config.h and give it a less
> ambiguous name 'config_scope_name()'


> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  config.c               | 16 ++++++++++++++++
>  config.h               |  2 ++
>  t/helper/test-config.c | 17 +----------------
>  t/t1308-config-set.sh  |  2 +-
>  4 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/config.c b/config.c
> index d75f88ca0c..83bb98d65e 100644
> --- a/config.c
> +++ b/config.c
> @@ -3297,6 +3297,22 @@ const char *current_config_origin_type(void)
>  	}
>  }
>  
> +const char *config_scope_name(enum config_scope scope)
> +{
> +	switch (scope) {
> +	case CONFIG_SCOPE_SYSTEM:
> +		return "system";
> +	case CONFIG_SCOPE_GLOBAL:
> +		return "global";
> +	case CONFIG_SCOPE_REPO:
> +		return "repo";
> +	case CONFIG_SCOPE_CMDLINE:
> +		return "command line";

The change from "cmdline" to "command line" does need to happen
before the end of the series, but I do not think it should happen
here, especialy given that the proposed log message explains that
this step is to expose scope_name() under a better name (which is a
very good split point).

How are you reviewing the patches in your own series before sending
them out?  This round is better than the previous rounds where we
didn't have a matching change to the tests so "make test" may not
have passed in the middle of the series, though...

> +	default:
> +		return "unknown";
> +	}
> +}
> +
>  const char *current_config_name(void)
>  {
>  	const char *name;
> diff --git a/config.h b/config.h
> index 91fd4c5e96..dcb8c274d4 100644
> --- a/config.h
> +++ b/config.h
> @@ -35,6 +35,7 @@ struct object_id;
>  
>  #define CONFIG_REGEX_NONE ((void *)1)
>  
> +
>  struct git_config_source {
>  	unsigned int use_stdin:1;
>  	const char *file;
> @@ -301,6 +302,7 @@ enum config_scope {
>  	CONFIG_SCOPE_REPO,
>  	CONFIG_SCOPE_CMDLINE,
>  };
> +const char *config_scope_name(enum config_scope scope);
>  
>  enum config_scope current_config_scope(void);
>  const char *current_config_origin_type(void);
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 214003d5b2..1e3bc7c8f4 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -37,21 +37,6 @@
>   *
>   */
>  
> -static const char *scope_name(enum config_scope scope)
> -{
> -	switch (scope) {
> -	case CONFIG_SCOPE_SYSTEM:
> -		return "system";
> -	case CONFIG_SCOPE_GLOBAL:
> -		return "global";
> -	case CONFIG_SCOPE_REPO:
> -		return "repo";
> -	case CONFIG_SCOPE_CMDLINE:
> -		return "cmdline";
> -	default:
> -		return "unknown";
> -	}
> -}
>  static int iterate_cb(const char *var, const char *value, void *data)
>  {
>  	static int nr;
> @@ -63,7 +48,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
>  	printf("value=%s\n", value ? value : "(null)");
>  	printf("origin=%s\n", current_config_origin_type());
>  	printf("name=%s\n", current_config_name());
> -	printf("scope=%s\n", scope_name(current_config_scope()));
> +	printf("scope=%s\n", config_scope_name(current_config_scope()));
>  
>  	return 0;
>  }
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 7b4e1a63eb..5f3e71a160 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
>  	value=from-cmdline
>  	origin=command line
>  	name=
> -	scope=cmdline
> +	scope=command line
>  	EOF
>  	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
>  	test_cmp expect actual
