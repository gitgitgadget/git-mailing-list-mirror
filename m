From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] grep: add a perlRegexp configuration option
Date: Tue, 31 Jul 2012 11:04:57 -0700
Message-ID: <7vehnrkdrq.fsf@alter.siamese.dyndns.org>
References: <1343753854-66765-1-git-send-email-dark.panda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: J Smith <dark.panda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:05:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwGoi-0000Nl-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 20:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab2GaSFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 14:05:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999Ab2GaSFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 14:05:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CDC47491;
	Tue, 31 Jul 2012 14:05:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Cf/YF9F4qhw028eadLaN3eNGwQ=; b=C0YBLS
	NZLIZ+ACaFz+SD+rUioPVOHALhELHeu5gijZlaQadMAQzsg5CRVJiLEeyJ7PFhEZ
	qvtXQaQY0N0Z2ElD79u4GwkBrpe5nZSJJNEy/UUesjZE3IK9P3qCLLj9d9oQ5cK0
	BsIWW8NL0vFhZG0eE3nOOM0/2Fu8AWpJ5SbT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bHkxmVRWlBbL7bf1QFQ1UVAgixPkTdFA
	AELFvlM2BMge+OHIcSkxud4nDrQh+/DwSGEUv7hHFTmkC3l8tvUKIEXH/nO4eHtG
	yaDRTyihHXhsNk6JgfXS+CSeIGLk7udvd6mAVhZVjBPsexxwBOcLoPfpQ2iiV6/Z
	4mAJvyxdTS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0932F7490;
	Tue, 31 Jul 2012 14:05:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38C82748F; Tue, 31 Jul 2012
 14:04:59 -0400 (EDT)
In-Reply-To: <1343753854-66765-1-git-send-email-dark.panda@gmail.com> (J.
 Smith's message of "Tue, 31 Jul 2012 12:57:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DFD87DA-DB3A-11E1-9486-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202663>

J Smith <dark.panda@gmail.com> writes:

> Enables the -P flag for perl regexps by default. When both the
> perlRegexp and extendedRegexp options are enabled, the last enabled
> option wins.

Turning "grep.extendedregexp" from boolean to an extended boolean to
allow "grep.extendedregexp = perl" might be a better alternative.
That way, the user wouldn't have to worry about 7 variants of
grep.fooRegexp variables twenty years down the road, even though the
set of possible values given to "grep.extendedregexp" may have grown
over time by then.

> ---
>  Documentation/config.txt   |  6 ++++++
>  Documentation/git-grep.txt |  6 ++++++
>  builtin/grep.c             | 17 +++++++++++++++--
>  t/t7810-grep.sh            | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a95e5a4..ff3019b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1213,6 +1213,12 @@ grep.lineNumber::
>  grep.extendedRegexp::
>  	If set to true, enable '--extended-regexp' option by default.
>
> +grep.perlRegexp::
> +	If set to true, enable '--perl-regexp' option by default.
> +
> +When both the 'grep.extendedRegexp' and 'grep.perlRegexp' options
> +are used, the last enabled option wins.
> +
>  gpg.program::
>  	Use this custom program instead of "gpg" found on $PATH when
>  	making or verifying a PGP signature. The program must support the
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 3bec036..8816968 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -45,6 +45,12 @@ grep.lineNumber::
>  grep.extendedRegexp::
>  	If set to true, enable '--extended-regexp' option by default.
>
> +grep.perlRegexp::
> +	If set to true, enable '--perl-regexp' option by default.
> +
> +When both the 'grep.extendedRegexp' and 'grep.perlRegexp' options
> +are used, the last enabled option wins.
> +
>
>  OPTIONS
>  -------
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 29adb0a..b4475e6 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -268,11 +268,24 @@ static int grep_config(const char *var, const char *value, void *cb)
>  	if (userdiff_config(var, value) < 0)
>  		return -1;
>
> +	if (!strcmp(var, "grep.perlregexp")) {
> +		if (git_config_bool(var, value)) {
> +			opt->fixed = 0;
> +			opt->pcre = 1;
> +		} else {
> +			opt->pcre = 0;
> +		}
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "grep.extendedregexp")) {
> -		if (git_config_bool(var, value))
> +		if (git_config_bool(var, value)) {
>  			opt->regflags |= REG_EXTENDED;
> -		else
> +			opt->pcre = 0;
> +			opt->fixed = 0;
> +		} else {
>  			opt->regflags &= ~REG_EXTENDED;
> +		}
>  		return 0;
>  	}
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 24e9b19..5479dc9 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -729,6 +729,40 @@ test_expect_success LIBPCRE 'grep -P pattern' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success LIBPCRE 'grep pattern with grep.perlRegexp=true' '
> +	git \
> +		-c grep.perlregexp=true \
> +		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success LIBPCRE 'grep pattern with grep.perlRegexp=true and then grep.extendedRegexp=true' '
> +	test_must_fail git \
> +		-c grep.perlregexp=true \
> +		-c grep.extendedregexp=true \
> +		grep "\p{Ps}.*?\p{Pe}" hello.c
> +'
> +
> +test_expect_success LIBPCRE 'grep pattern with grep.extendedRegexp=true and then grep.perlRegexp=true' '
> +	git \
> +		-c grep.extendedregexp=true \
> +		-c grep.perlregexp=true \
> +		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success LIBPCRE 'grep -E pattern with grep.perlRegexp=true' '
> +	test_must_fail git \
> +		-c grep.perlregexp=true \
> +		grep -E "\p{Ps}.*?\p{Pe}" hello.c
> +'
> +
> +test_expect_success LIBPCRE 'grep -G pattern with grep.perlRegexp=true' '
> +	test_must_fail git \
> +		-c grep.perlregexp=true \
> +		grep -G "\p{Ps}.*?\p{Pe}" hello.c
> +'
> +
>  test_expect_success 'grep pattern with grep.extendedRegexp=true' '
>  	>empty &&
>  	test_must_fail git -c grep.extendedregexp=true \
> --
> 1.7.11.3
