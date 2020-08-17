Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E464C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489EE2063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ha6T1C2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgHQRg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:36:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56611 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731292AbgHQRgj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:36:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B45BADE765;
        Mon, 17 Aug 2020 13:36:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vTkrqHevsk4pJy+RL4nh7AsUqfY=; b=ha6T1C
        2PweoWPemKZ5Tw94q2fbk6JmKZmkf2VRU1mAzBxoDxKK8O6ag/n6OG0advZpbMYV
        U22biwd8In//f61yXqdViVI1aAWSRP7eYQbixYK5ZrfHG/sXbOzr05wBgD48a9qk
        gNonpnduYPOF+XRuwUNxRisUA7div9Gt/3F0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m0CWg1nHcRRNsmdHa17lv0KC155qaGQ4
        nOmQ38gQg67UGpo6MktlxZxM1fg+Y+sIKYCLZOb50aK4PZf1h7AuuW6xAmu0nUDS
        t7Em+0al+gclxklFzvt8FoY/1gkUU+Ito4co9EfSxoYOWQEAcN1Oz8sGTwybbUeV
        9vLib5mqeZs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABA20DE764;
        Mon, 17 Aug 2020 13:36:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A715BDE762;
        Mon, 17 Aug 2020 13:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] config: drop git_config_get_string_const()
References: <20200814161328.GA153929@coredump.intra.peff.net>
        <20200814161921.GD595698@coredump.intra.peff.net>
        <xmqq364pvv03.fsf@gitster.c.googlers.com>
        <20200815063437.GA619381@coredump.intra.peff.net>
Date:   Mon, 17 Aug 2020 10:36:28 -0700
In-Reply-To: <20200815063437.GA619381@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 15 Aug 2020 02:34:37 -0400")
Message-ID: <xmqqft8l2mzn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FAD5064-E0B0-11EA-8FEB-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Whoops, I actually meant to do so (and made sure we didn't have any
> callers) but forgot to actually include it in patch 4. It doesn't make
> any sense to keep those other variants.
>
> The diff is pretty straightforward (see below). I'll include it in a
> re-roll (squashed into patch 4), but will wait for any other comments.
>
> It doesn't look like there's any extra fallout from merging this with
> "seen".

OK, thanks.

>
> diff --git a/config.c b/config.c
> index 8bb1945aa9..f0367c76ad 100644
> --- a/config.c
> +++ b/config.c
> @@ -2006,20 +2006,15 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
>  	return e ? &e->value_list : NULL;
>  }
>  
> -int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
> +int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
>  {
>  	const char *value;
>  	if (!git_configset_get_value(cs, key, &value))
> -		return git_config_string(dest, key, value);
> +		return git_config_string((const char **)dest, key, value);
>  	else
>  		return 1;
>  }
>  
> -int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
> -{
> -	return git_configset_get_string_const(cs, key, (const char **)dest);
> -}
> -
>  int git_configset_get_string_tmp(struct config_set *cs, const char *key,
>  				 const char **dest)
>  {
> @@ -2161,24 +2156,17 @@ const struct string_list *repo_config_get_value_multi(struct repository *repo,
>  	return git_configset_get_value_multi(repo->config, key);
>  }
>  
> -int repo_config_get_string_const(struct repository *repo,
> -				 const char *key, const char **dest)
> +int repo_config_get_string(struct repository *repo,
> +			   const char *key, char **dest)
>  {
>  	int ret;
>  	git_config_check_init(repo);
> -	ret = git_configset_get_string_const(repo->config, key, dest);
> +	ret = git_configset_get_string(repo->config, key, dest);
>  	if (ret < 0)
>  		git_die_config(key, NULL);
>  	return ret;
>  }
>  
> -int repo_config_get_string(struct repository *repo,
> -			   const char *key, char **dest)
> -{
> -	git_config_check_init(repo);
> -	return repo_config_get_string_const(repo, key, (const char **)dest);
> -}
> -
>  int repo_config_get_string_tmp(struct repository *repo,
>  			       const char *key, const char **dest)
>  {
> diff --git a/config.h b/config.h
> index d4d22c34c6..91cdfbfb41 100644
> --- a/config.h
> +++ b/config.h
> @@ -458,7 +458,6 @@ void git_configset_clear(struct config_set *cs);
>   */
>  int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
>  
> -int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
>  int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
>  int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
>  int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
> @@ -475,8 +474,6 @@ int repo_config_get_value(struct repository *repo,
>  			  const char *key, const char **value);
>  const struct string_list *repo_config_get_value_multi(struct repository *repo,
>  						      const char *key);
> -int repo_config_get_string_const(struct repository *repo,
> -				 const char *key, const char **dest);
>  int repo_config_get_string(struct repository *repo,
>  			   const char *key, char **dest);
>  int repo_config_get_string_tmp(struct repository *repo,
