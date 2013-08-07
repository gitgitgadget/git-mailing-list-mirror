From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH 4/4] OPT__FORCE(): clarify its expected use by using OPT_COUNTUP
Date: Wed, 07 Aug 2013 08:28:24 -0700
Message-ID: <7vbo59ed0n.fsf@alter.siamese.dyndns.org>
References: <7viozihh26.fsf@alter.siamese.dyndns.org>
	<1375831889-9610-1-git-send-email-gitster@pobox.com>
	<1375831889-9610-5-git-send-email-gitster@pobox.com>
	<5201F83C.60503@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 17:28:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V75f9-0003Yx-H5
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 17:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab3HGP2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 11:28:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3HGP23 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 11:28:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D537A35CCB;
	Wed,  7 Aug 2013 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ow5RaJqF+5JRkVdOVwIWwdt51Rc=; b=WbslYf
	FF2ZyApZRChXXz6xsBchGwCPClO6TnfYZucK6Ea1P2jhaQYXLIAiu3+PN5nqt+yS
	y17WmZ5SdHZ5HZ8DgnuFB8I3Fg1F4kdgs63OVscIQmU76GtD2ZSRm87CiWGYNFdT
	Y99rQW69soY1jFwFU7yRgh7zNClBMapx5h960=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hYbTG5SIArtTuTWR97GYUOGG7TU2Skhh
	Y9TlLY3cEYwkiyxtHk2isJ4uyrQspIE9jywr/nCxgVTIECCaH02KABurMW8I1OXj
	rGTnYXyobcwMJet0gYmlF90/tOrN+BoaweWTOB3a1Qg9GUF8Ph5VFH1d/825Huvu
	HZ5oKUYqeKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC46535CCA;
	Wed,  7 Aug 2013 15:28:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7DA535CC4;
	Wed,  7 Aug 2013 15:28:26 +0000 (UTC)
In-Reply-To: <5201F83C.60503@googlemail.com> (Stefan Beller's message of "Wed,
	07 Aug 2013 09:33:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 016BC320-FF76-11E2-B21C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231829>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 08/07/2013 01:31 AM, Junio C Hamano wrote:
>> The parseopt parsing for OPT__FORCE() is implemented in terms of
>> OPT_BOOLEAN() and users of it can take advantage of the "counting
>> up" behaviour to implement increasing levels of forcefulness by
>> differentiating "git cmd -f" and "git cmd -f -f".
>> 
>> Clarify this by explicitly using OPT_COUNTUP() instead.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>  * This _should_ be done with a similar audit of existing callers,
>>    but I ran out of concentration.
>> 
>>  parse-options.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/parse-options.h b/parse-options.h
>> index 78f52c2..1eeb0d9 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -238,7 +238,7 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
>>  	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
>>  	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
>>  #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
>> -#define OPT__FORCE(var, h)    OPT_BOOLEAN('f', "force",   (var), (h))
>> +#define OPT__FORCE(var, h)    OPT_COUNTUP('f', "force",   (var), (h))
>>  #define OPT__ABBREV(var)  \
>>  	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
>>  	  N_("use <n> digits to display SHA-1s"),	\
>> 
>
> We need the COUNTUP, because in builtin/clean.c we have
> 	OPT__FORCE(&force, N_("force")),
> 	...
> 	if (force > 1)
> 		rm_flags = 0;

Good that I marked it as RFH ;-)  Thanks.

> So a OPT_BOOL definitely doesn't cut it.
> Now that I started reviewing the OPT_FORCE parts, I realize
> there is still an error in the patch, which needed correction.
> (branch, commit, name-rev: ease up boolean conditions):
>
> -	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
> +	if (force_create + list + unset_upstream +
> +	    !!delete + !!rename + !!new_upstream > 1)
>  		usage_with_options(builtin_branch_usage, options);
>
> force_create is set via OPT_FORCE as well, so we cannot remove the !! before the force_create,
> hence we'd only remove it from list and unset_upstream, which are set by OPT_BOOL.

Good.  Will replace.  Thanks.

> -- 8< --
> From: Stefan Beller <stefanbeller@googlemail.com>
> Date: Wed, 7 Aug 2013 09:32:25 +0200
> Subject: [PATCH] branch, commit, name-rev: ease up boolean conditions
>
> Now that the variables are set by OPT_BOOL, which makes sure
> to have the values being 0 or 1 after parsing, we do not need
> the double negation to map any other value to 1 for integer
> variables.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/branch.c   | 3 ++-
>  builtin/commit.c   | 2 +-
>  builtin/name-rev.c | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4daed0b..0903763 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -872,7 +872,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	if (with_commit || merge_filter != NO_FILTER)
>  		list = 1;
>  
> -	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
> +	if (!!delete + !!rename + !!force_create + !!new_upstream +
> +	    list + unset_upstream > 1)
>  		usage_with_options(builtin_branch_usage, options);
>  
>  	if (abbrev == -1)
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c20426b..b0f86c8 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1072,7 +1072,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (patch_interactive)
>  		interactive = 1;
>  
> -	if (!!also + !!only + !!all + !!interactive > 1)
> +	if (also + only + all + interactive > 1)
>  		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
>  	if (argc == 0 && (also || (only && !amend)))
>  		die(_("No paths with --include/--only does not make sense."));
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index a908a34..20fcf8c 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -331,7 +331,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
> -	if (!!all + !!transform_stdin + !!argc > 1) {
> +	if (all + transform_stdin + !!argc > 1) {
>  		error("Specify either a list, or --all, not both!");
>  		usage_with_options(name_rev_usage, opts);
>  	}
