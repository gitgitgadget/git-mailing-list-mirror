Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D511F407
	for <e@80x24.org>; Wed, 13 Dec 2017 20:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbdLMUkd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 15:40:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752908AbdLMUkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 15:40:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD7E5B8610;
        Wed, 13 Dec 2017 15:40:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pJkCZ6EH/JQ6gXub4WqiR7iT5JM=; b=dlfPX+
        zH8sSF9WOrh0eNjMcpDfpyKFiqP1pwlM44xekkilFVKg6RgKjJ7Stvo46Ghc+lMO
        s16A/A+K0BzhPcCvcNWU0Ndfdosb9b0RaHGVpPxnfC0/oXptdN24oUCIX4ljvWcb
        jNMZjoddpRkuA/DN3qUZzGHkjm07L3yIJUP0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pmFKnQtIf97BOXKEbD5gDq8k9cLE6Rfz
        6USaK876jK2R25VM2bcfCZyWQdefXY+W4/lBJOvvBaNLApps+6ZF6SaEau3cxUOd
        mjNEIldsWX9lx8Whm/Mc8ByjSqk8f0XLtrmTb6wLCkaJjdel7ep3+7EBTrpJHLeh
        zjLMPVbRZ+s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5132B860F;
        Wed, 13 Dec 2017 15:40:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28F06B860E;
        Wed, 13 Dec 2017 15:40:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/8] perf/run: use $default_value instead of $4
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
        <20171213151344.2138-5-chriscool@tuxfamily.org>
Date:   Wed, 13 Dec 2017 12:40:30 -0800
In-Reply-To: <20171213151344.2138-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 13 Dec 2017 16:13:40 +0100")
Message-ID: <xmqqbmj2wedd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC5BCD4A-E045-11E7-8131-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/perf/run | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/perf/run b/t/perf/run
> index 43e4de49ef..bbd703dc4f 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -105,7 +105,7 @@ get_var_from_env_or_config () {
>  	env_var="$1"
>  	conf_sec="$2"
>  	conf_var="$3"
> -	# $4 can be set to a default value
> +	default_value="$4" # optional
>  
>  	# Do nothing if the env variable is already set
>  	eval "test -z \"\${$env_var+x}\"" || return
> @@ -123,7 +123,7 @@ get_var_from_env_or_config () {
>  	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
>  	eval "$env_var=\"$conf_value\"" && return
>  
> -	test -n "${4+x}" && eval "$env_var=\"$4\""
> +	test -n "${default_value+x}" && eval "$env_var=\"$default_value\""

This conversion changes the behaviour.  Because default_value is
always set by your change in the previous hunk, we end up always
doing this eval.

The original says "If $4 is set, then ${4+x} becomes x and if $4 is
not set, ${4+x} is empty, so let's check if ${4+x} is a non-empty
string to see if $4 is set.  If ${4+x} is a non-empty string, that
means $4 was set so we do the eval.

If you want to be able to use this helper to specify a default value
of an empty string (which the orignal that used $4 did), then the
previous hunk must be corrected so that it does not unconditionally
set default_value to $4.  Perhaps like

	if test -n "${4+x}"
	then
		default_value=$4
	else
		unset default_value || :
	fi

or something.

>  }
>  
>  run_subsection () {
