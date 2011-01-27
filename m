From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Sanity-check config variable names
Date: Thu, 27 Jan 2011 14:45:16 -0800
Message-ID: <7voc72ge4j.fsf@alter.siamese.dyndns.org>
References: <20110120232232.GA9442@sigill.intra.peff.net>
 <20110121000629.GA7773@sigill.intra.peff.net>
 <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz> <20110119141112.GD8034@fm.suse.cz>
 <20110120232232.GA9442@sigill.intra.peff.net>
 <20110121100212.GE19715@fm.suse.cz> <20110121102339.GG19715@fm.suse.cz>
 <20110121162318.GC21840@sigill.intra.peff.net>
 <20110127142815.GC6312@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jan 27 23:45:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piaar-0005t5-MK
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 23:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab1A0Wp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 17:45:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1A0Wp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 17:45:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D449130CA;
	Thu, 27 Jan 2011 17:46:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a9O5I45hx6mIH08Ie7vqd4AxCEo=; b=aFcjI4
	YW6/TVLJ5oxqIEou9CxMIyAfRTetQRgJGXaDbjSLTN2Dehq43Bj1U1C8qst2COzT
	Eq7J5nHsdoQIpAmNxSWrhYlbNSV5/r+WecYbisv/dCx0EZiMuagDg/uCm7CvRsMw
	bDE7ugJt98as9krS78BymByeJaI+UQxV2IOVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iicrbDy2DlMczdxNRh0XPOA5Meu+q17+
	HVe+2NiKm8fjwpl96lUCPKnTiHRL4sBP9IL8vJfDgvpK+0d8zzHWwxr+rZeOIok9
	t+xGVdJaCp7RiNKV5LcAqqpUC/BanYzerXT7NRnAKjakqhqiPJ0Q2TMHq6fsONE5
	eP8L0J1FD2Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B83D30C8;
	Thu, 27 Jan 2011 17:46:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C6EB30C4; Thu, 27 Jan 2011
 17:46:07 -0500 (EST)
In-Reply-To: <20110127142815.GC6312@fm.suse.cz> (Libor Pechacek's message of
 "Thu\, 27 Jan 2011 15\:28\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3DAF1E90-2A67-11E0-A16B-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165593>

Libor Pechacek <lpechacek@suse.cz> writes:

> Sanity-check config variable names when adding and retrieving them.  As a side
> effect code duplication between git_config_set_multivar and get_value (in
> builtin/config.c) was removed and the common functionality was placed in
> git_config_parse_key.
>
> This breaks a test in t1300 which used invalid section-less keys in the tests
> for "git -c". However, allowing such names there was useless, since there was
> no way to set them via config file, and no part of git actually tried to use
> section-less keys. This patch updates the test to use more realistic examples.
>
> Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
> Cc: Jeff King <peff@peff.net>
> ---
>
> On Fri 21-01-11 11:23:19, Jeff King wrote:
>> Typo: s/ckeck/check/
>> 
>> Other than that, this version looks good to me.
>
> Fixed the typo and return values from get_value and git_config_set_multivar.
> We have changed git_config_parse_key to return negative values on error, but
> forgot to negate the numbers when returning them as exit codes.

Earlier get_value() returned:

 -1: when it saw an uncompilable regexp (either in key or value);
  0: when a value was available (under --all) or unique (without --all);
  1: when the requested variable is missing; and
  2: when the requested variable is multivalued under --all.

As the new error condition you are adding is to detect and signal a broken
input, doesn't it fall into the same category as "broken regexp", which in
turn would mean that it should return the same -1?

Or to distinguish between "invalid character in the key" and "no section
name in the key", you might want to add -2 to the mix, but personally I
don't think it is worth it.  The advantage of being able to tell between
the two kinds of breakage feels much smaller than the cost of having to
worry about breaking existing callers that try to catch broken user input
by checking the return value from get_value() explicitly against -1, not
just any negative value.

Note that I am not suggesting to change the return value from
config-parse-key in the above; I am only talking about get_value().

>  	if (use_key_regexp) {
> +		char *tl;
> +
> +		/* TODO - this naive pattern lowercasing obviously does not
> +		 * work for more complex patterns like `^[^.]*Foo.*bar' */
> +		for (tl = key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
> +			*tl = tolower(*tl);
> +		for (tl = key; *tl && *tl != '.'; ++tl)
> +			*tl = tolower(*tl);

When moving an existing code segment around like this, I would not mind to
see style fixes thrown in to the patch, as long as the moved code is small
enough.  Perhaps like this:

	/*
         * NEEDSWORK: this naive pattern lowercasing obviously does
	 * not work for more complex patterns like "^[^.]*Foo.*bar".
	 * Perhaps we should deprecate this altogether someday.
         */
	for (tl = key + strlen(key) - 1;
	     tl >= key && *tl != '.';
	     tl--)
		*tl = tolower(*tl);
	for (tl = key; *tl && *tl != '.'; tl++)
		*tl = tolower(*tl);

The style rules applied above are...

  - We want to see SP around binary operators;

  - However, we don't want to see a line that is too long;

  - When there is no reason to choose between (pre/post)-(in/de)crement,
    post-(in/de)crement is easier to read.

> diff --git a/config.c b/config.c
> index 625e051..c976544 100644
> --- a/config.c
> +++ b/config.c
> @@ -1098,6 +1098,72 @@ int git_config_set(const char *key, const char *value)
>  	return git_config_set_multivar(key, value, NULL, 0);
>  }
>  
> +/* Auxiliary function to sanity-check and split the key into the section

	/*
         * Style. We write our multi-line comments
	 * like this.
         */

> +int git_config_parse_key(const char *key, char **store_key, int *baselen_)
> +{
> +	int i, dot, baselen;
> +	const char *last_dot = strrchr(key, '.');
> +
> +	/*
> +	 * Since "key" actually contains the section name and the real
> +	 * key name separated by a dot, we have to know where the dot is.
> +	 */
> +
> +	if (last_dot == NULL) {
> +		error("key does not contain a section: %s", key);
> +		return -2;
> +	}
> +
> +	baselen = last_dot - key;
> +	if (baselen_)
> +		*baselen_ = baselen;
> +
> +	/*
> +	 * Validate the key and while at it, lower case it for matching.
> +	 */
> +	if (store_key)
> +		*store_key = xmalloc(strlen(key) + 1);

Does it make sense for this function to be prepared to get called with
NULL in store_key like this (and in the remainder of your patch)?

The primary reason somebody calls this function is so that the caller can
then use the resulting lowercased form for matching, but "if store-key is
not NULL" feels as if this code is optimized for a special case caller
that only wants to validate without using the resulting lowercased key for
matching, which does not exist yet.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index d0e5546..3e79c37 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -876,11 +876,10 @@ test_expect_success 'check split_cmdline return' "
>  	"
>  
>  test_expect_success 'git -c "key=value" support' '
> -	test "z$(git -c name=value config name)" = zvalue &&
>  	test "z$(git -c core.name=value config core.name)" = zvalue &&
> -	test "z$(git -c CamelCase=value config camelcase)" = zvalue &&
> -	test "z$(git -c flag config --bool flag)" = ztrue &&
> -	test_must_fail git -c core.name=value config name
> +	test "z$(git -c foo.CamelCase=value config foo.camelcase)" = zvalue &&
> +	test "z$(git -c foo.flag config --bool foo.flag)" = ztrue &&
> +	test_must_fail git -c name=value config core.name
>  '

Don't you want to make sure that your sanity check triggers in new tests?
