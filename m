From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/94] builtin/apply: move 'state' init into init_apply_state()
Date: Thu, 12 May 2016 12:25:28 -0700
Message-ID: <xmqq60ujf593.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-10-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:25:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wEy-0004mS-0V
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbcELTZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:25:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752943AbcELTZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:25:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 908401A7E2;
	Thu, 12 May 2016 15:25:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WlgDG0ZXF4he5h4RUFaxOzzNLvc=; b=fmhUhc
	/12PsJh9y9CcNdzTvlnnHMJswfWANy4ddUhvfA/yg3udj1U3+26XQUeoI8g79f6f
	W2ywUaRrUIkCK2nP2reAlpV9q0KDRU6G+wMsCF04Xbp18Y9tYGsgpbNvCeIttCJc
	RqLHRMNc4S3Eehw3c6wUUnUkhCC+2RKgVhTxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=otaRt3MrD8NNmZfxSk2+a4SiszIVzS8L
	kP/sFfOZ7JwtXBNzIp/9Zqvoy0a8t+UUdgOLSsqyPY8LPBOHq3t0oF+e13LqLwLp
	u6c121edwjozUKVYYuK5LhRj74On1m3O4gAA1Nxm05VpGmMO9ipU37+ra738zCSP
	WkcE2ljNW+E=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84BC01A7E1;
	Thu, 12 May 2016 15:25:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9D4E1A7E0;
	Thu, 12 May 2016 15:25:29 -0400 (EDT)
In-Reply-To: <20160511131745.2914-10-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49D72704-1877-11E6-8649-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294432>

Christian Couder <christian.couder@gmail.com> writes:

> When the apply functionality will be libified, the 'struct apply_state'
> will be used by different pieces of code.
>
> To properly initialize a 'struct apply_state', let's provide a nice
> and easy to use init_apply_state() function.

This probably should be done at 08/94, but I'll let it pass for now.
I am hoping 'prefix' is just one of a very few parameters this
function needs to take to initialize this (I do not think we want to
feed many different parameters to this function to initialize).

Will queue.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index ae068e7..e133033 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4522,6 +4522,19 @@ static int option_parse_directory(const struct option *opt,
>  	return 0;
>  }
>  
> +static void init_apply_state(struct apply_state *state, const char *prefix)
> +{
> +	memset(state, 0, sizeof(*state));
> +	state->prefix = prefix;
> +	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
> +
> +	git_apply_config();
> +	if (apply_default_whitespace)
> +		parse_whitespace_option(apply_default_whitespace);
> +	if (apply_default_ignorewhitespace)
> +		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
> +}
> +
>  int cmd_apply(int argc, const char **argv, const char *prefix_)
>  {
>  	int i;
> @@ -4603,15 +4616,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>  		OPT_END()
>  	};
>  
> -	memset(&state, 0, sizeof(state));
> -	state.prefix = prefix_;
> -	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
> -
> -	git_apply_config();
> -	if (apply_default_whitespace)
> -		parse_whitespace_option(apply_default_whitespace);
> -	if (apply_default_ignorewhitespace)
> -		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
> +	init_apply_state(&state, prefix_);
>  
>  	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
>  			apply_usage, 0);
