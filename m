From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Wed, 01 Aug 2012 14:55:52 -0700
Message-ID: <7vpq7ae0pj.fsf@alter.siamese.dyndns.org>
References: <1343845781-69246-1-git-send-email-dark.panda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: J Smith <dark.panda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:56:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swgte-00036w-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab2HAVz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:55:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778Ab2HAVz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:55:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AAED93F2;
	Wed,  1 Aug 2012 17:55:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3leJKPzu00dT+NhOHe5vHAx/Tk=; b=iaQNy9
	svH0JwCWwLzbFfu8G7bbmDn78YcUIDCxnqluQfnOgDgF1RI7+0kNJrUUEO3ILhwU
	LOM9dIAo2k1iLKaBvTCt1hIVmXRATgGHF/krAVLEcc8FuZfyPFps7LYIPHdUnnRM
	gVw9Dqdw/Q9Dq7VagOxO2HZsf4V1O3IL87BI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnIuXG1HCRdGwUna37dpKL8HXYioBKGc
	Q5qRWJ7dOjAeL2Ztq6broGJQLJFrjUd36UvcfBgza2sVeqzbayMH3FSX5Ytarc3X
	wJc3R2YQvGj9W2iEnUCURUjHynOjDx0cTEGNb5gd72BBhYzvilypfmUwMMkQukoX
	xXNFgnpQPAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27E9593F1;
	Wed,  1 Aug 2012 17:55:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00AD793EF; Wed,  1 Aug 2012
 17:55:53 -0400 (EDT)
In-Reply-To: <1343845781-69246-1-git-send-email-dark.panda@gmail.com> (J.
 Smith's message of "Wed, 1 Aug 2012 14:29:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA7CE664-DC23-11E1-92D2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202732>

J Smith <dark.panda@gmail.com> writes:

As the basic structure and the direction looks good, let's start
nitpicking ;-)

> Adds the grep.patternType configuration setting which sets the default
> pattern matching behavior. The values "basic", "extended", "fixed", and
> "perl" can be used to set "--basic-regexp", "--extended-regexp",
> "--fixed-strings", and "--perl-regexp" options by default respectively.

We tend to write the commit log message in imperative mood, as if
you are giving an order to the codebase to "behave this way!".  Also
we tend to give the justification behind the change first and then
present the solution.

	There is grep.extendedRegexp configuration variable to
	enable the -E command line flag by default, but there is no
	equivalent for the -P (pcre) flag.  We could keep adding
	grep.fooRegexp variables for different regular expression
	variants, but that will be unwieldy.

	Instead, add a "grep.patternType" variable that can be set
	to "basic", "extended", "fixed" and "perl" to use
	"--basic-regexp", "--extended-regexp", "--fixed-strings",
	and "--perl-regexp" options by default respectively.

	Ignore grep.extendedRegexp when grep.patternType is set.

> A value of true is equivalent to "extended" as with grep.extendedRegexp,
> and a value of false leaves the pattern type as unspecified and follows
> the default grep behavior.

With this round, we are not updating an existing a bool variable,
but are introducing a brand new one; does it still make sense to
support the boolean values for this new variable?

> This setting overrides the value set in grep.extendedRegexp which will
> be ignored completely if grep.patternType is set.
> ---

Sign-off?

>  Documentation/config.txt   |  11 ++-
>  Documentation/git-grep.txt |  11 ++-
>  builtin/grep.c             | 106 ++++++++++++++++---------
>  grep.h                     |   9 +++
>  t/t7810-grep.sh            | 187 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 284 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a95e5a4..38d56d8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1210,8 +1210,17 @@ gitweb.snapshot::
>  grep.lineNumber::
>  	If set to true, enable '-n' option by default.
>
> +grep.patternType::
> +	Sets the default matching behavior. This option can be set to a
> +	boolean value or one of 'basic', 'extended', 'fixed', or 'perl'
> +	which will enable the '--basic-regexp', '--extended-regexp',
> +	'--fixed-strings' or '--perl-regexp' options accordingly. The value
> +	of true is equivalent to 'extended' while false leaves the
> +	settings in their default state.

Perhaps s/Sets the/The/ or at least s/Sets/Set/ (notice that the
description for grep.extendedRegexp says "enable foo", not "enables
foo").

The same comment as above applies to the "boolean"-ness part.

>  grep.extendedRegexp::
> -	If set to true, enable '--extended-regexp' option by default.
> +	If set to true, enable '--extended-regexp' option by default. This
> +	option is ignored when the 'grep.patternType' option is set.

We are not going to make grep.patternType a boolean, so "when ... is
set" is fine, but if we were to allow grep.patternType to be set to
"false", the description gives ambiguity to some readers who do.
Perhaps s/is set/is given/ is safer.

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 3bec036..f56f67f 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -42,8 +42,17 @@ CONFIGURATION
>  grep.lineNumber::
>  	If set to true, enable '-n' option by default.
>
> +grep.patternType::
> ...
>  grep.extendedRegexp::
> -	If set to true, enable '--extended-regexp' option by default.
> +	If set to true, enable '--extended-regexp' option by default. This
> +	option is ignored when the 'grep.patternType' option is set.

Likewise.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 29adb0a..1de7e76 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -260,6 +260,55 @@ static int wait_all(void)
>  }
>  #endif
>
> +static int parse_pattern_type_arg(const char *opt, const char *arg)
> +{
> +	switch (git_config_maybe_bool(opt, arg)) {
> +	case 1:
> +		return GREP_PATTERN_TYPE_ERE;
> +	case 0:
> +		return GREP_PATTERN_TYPE_UNSPECIFIED;
> +	default:
> +		if (!strcmp(arg, "basic"))
> +			return GREP_PATTERN_TYPE_BRE;
> +		else if (!strcmp(arg, "extended"))
> +			return GREP_PATTERN_TYPE_ERE;
> +		else if (!strcmp(arg, "fixed"))
> +			return GREP_PATTERN_TYPE_FIXED;
> +		else if (!strcmp(arg, "perl"))
> +			return GREP_PATTERN_TYPE_PCRE;
> +		die("bad %s argument: %s", opt, arg);
> +	}

Let's not do maybe-bool, as we are not upgrading an old bool-only
variable any more.

> +static void grep_pattern_type_options(const int pattern_type, struct grep_opt *opt)
> +{
> +	switch (pattern_type) {
> +		case GREP_PATTERN_TYPE_BRE:
> +			opt->fixed = 0;
> ...
> +			break;
> +	}

Please de-dent these lines inside switch() one level; switch and
case align.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 523d041..4fa24b4 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -245,11 +245,41 @@ do
>  		test_cmp expected actual
>  	'
>
> +	test_expect_success "grep $L with grep.patternType=false" '
> +		echo "ab:a+bc" >expected &&
> +		git -c grep.patternType=false grep "a+b*c" ab >actual &&
> +		test_cmp expected actual
> +	'
> +
>  	test_expect_success "grep $L with grep.extendedRegexp=true" '
>  		echo "ab:abc" >expected &&
>  		git -c grep.extendedRegexp=true grep "a+b*c" ab >actual &&
>  		test_cmp expected actual
>  	'
> +
> +	test_expect_success "grep $L with grep.patternType=true" '
> +		echo "ab:abc" >expected &&
> +		git -c grep.patternType=true grep "a+b*c" ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.patternType=false and grep.extendedRegexp=true" '
> +		echo "ab:a+bc" >expected &&
> +		git \
> +			-c grep.patternType=false \
> +			-c grep.extendedRegexp=true \
> +			grep "a+b*c" ab >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L with grep.patternType=true and grep.extendedRegexp=false" '
> +		echo "ab:abc" >expected &&
> +		git \
> +			-c grep.patternType=true \
> +			-c grep.extendedRegexp=false \
> +			grep "a+b*c" ab >actual &&
> +		test_cmp expected actual
> +	'

It might make sense to also make sure the order in which the
configuration variables are given does not make a difference with
these tests.

> @@ -725,12 +755,43 @@ test_expect_success 'grep pattern with grep.extendedRegexp=true' '
>  	test_cmp empty actual
>  '
>
> +test_expect_success 'grep pattern with grep.patternType=true' '
> +	>empty &&
> +	test_must_fail git -c grep.patternType=true \
> +		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
> +	test_cmp empty actual
> +'

When told to use basic-regexp, PCRE should not be used.  Good.

> +test_expect_success 'grep pattern with grep.patternType=basic and grep.extendedRegexp=true' '
> +	>empty &&
> +	test_must_fail git \
> +		-c grep.patterntype=basic \
> +		-c grep.extendedregexp=true \
> +		grep "a?" hello.c >actual &&
> +	test_cmp empty actual
> +'

When told to use basic-regexp via patternType, extendedRegexp should
not be used.  Good.

> +
> +test_expect_success 'grep pattern with grep.patternType=false and grep.extendedRegexp=true' '
> +	>empty &&
> +	test_must_fail git \
> +		-c grep.patterntype=false \
> +		-c grep.extendedregexp=true \
> +		grep "a?" hello.c >actual &&
> +	test_cmp empty actual
> +'

With the removal of "bool-or-type", this will become redundant.

>  test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=true' '
>  	git -c grep.extendedregexp=true \
>  		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
>  	test_cmp expected actual
>  '
>
> +test_expect_success LIBPCRE 'grep pattern with grep.patternType=perl' '
> +	git -c grep.patternType=perl \
> +		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
> +	test_cmp expected actual
> +'

What does this test?  grep.patternType=perl configuration is
correctly overridden by a command line flag -P?  But you cannot tell
which one turned pcre with this test.  Drop -P from the command
line, perhaps?

You want a test that runs "git -c grep.patternType=basic grep -P" or
something, guarded with LIBPCRE prerequisite, to make sure pcre
patterns are used because command line -P trumps over configured
default, too.

> @@ -761,44 +822,170 @@ test_expect_success 'grep -G invalidpattern properly dies ' '
>  	test_must_fail git grep -G "a["
>  '
>
> +test_expect_success 'grep invalidpattern properly dies with grep.patternType=basic' '
> +	test_must_fail git -c patterntype=basic grep "a["
> +'
> +
>  test_expect_success 'grep -E invalidpattern properly dies ' '
>  	test_must_fail git grep -E "a["
>  '
>
> +test_expect_success 'grep invalidpattern properly dies with grep.patternType=extended' '
> +	test_must_fail git -c patterntype=extended grep "a["
> +'
> +
>  test_expect_success LIBPCRE 'grep -P invalidpattern properly dies ' '
>  	test_must_fail git grep -P "a["
>  '
>
> +test_expect_success LIBPCRE 'grep invalidpattern properly dies with grep.patternType=perl' '
> +	test_must_fail git -c patterntype=perl grep "a["
> +'
> +

These three may not add much value, as long as we make sure that the
configuration "-c grep.patterntype" triggers the pattern matching
backend just like command line flags do with other tests.

Besides, I do not think you are testing the right thing in them
anyway (notice the lack of "grep." prefix).

> +test_expect_success 'grep pattern with grep.patternType=basic, =extended, =fixed' '
> +	echo "ab:a+b*c" >expected &&
> +	git \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=extended \
> +		-c grep.patterntype=fixed \
> +		grep "a+b*c" ab >actual &&
> +	test_cmp expected actual
> +'

What does this test?  The last one wins?

For the command line flags, people can do "alias g 'git grep -E'"
and then countermand the flags in the alias by appending a
contradicting flag when using it, e.g. "g -G", last one wins is a
defined and useful semantics, but for configuration variables that
are meant to take a single value, I do not think we give such a
strong guarantee on ordering (it may happen to work by accident,
though).

I would _not_ strongly suggest removing this test, but instead wait
until we hear from others, as they may disagree.

>  test_expect_success 'grep -E -F -G pattern' '
>  	echo "ab:a+bc" >expected &&
>  	git grep -E -F -G "a+b*c" ab >actual &&
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'grep pattern with grep.patternType=extended, =fixed, =basic' '
> +	echo "ab:a+bc" >expected &&
> +	git \
> +		-c grep.patterntype=extended \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		grep "a+b*c" ab >actual &&
> +	test_cmp expected actual
> +'
> +

Likewise.

>  test_expect_success 'grep -F -G -E pattern' '
>  	echo "ab:abc" >expected &&
>  	git grep -F -G -E "a+b*c" ab >actual &&
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =extended' '
> +	echo "ab:abc" >expected &&
> +	git \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=extended \
> +		grep "a+b*c" ab >actual &&
> +	test_cmp expected actual
> +'

Likewise.

>  test_expect_success 'grep -G -F -P -E pattern' '
>  	>empty &&
>  	test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c" ab >actual &&
>  	test_cmp empty actual
>  '
>
> +test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =perl, =extended' '
> +	>empty &&
> +	test_must_fail git \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=perl \
> +		-c grep.patterntype=extended \
> +		grep "a\x{2b}b\x{2a}c" ab >actual &&
> +	test_cmp empty actual
> +'

Likewise.

>  test_expect_success LIBPCRE 'grep -G -F -E -P pattern' '
>  	echo "ab:a+b*c" >expected &&
>  	git grep -G -F -E -P "a\x{2b}b\x{2a}c" ab >actual &&
>  	test_cmp expected actual
>  '
>
> +test_expect_success LIBPCRE 'grep pattern with grep.patternType=fixed, =basic, =extended, =perl' '
> +	echo "ab:a+b*c" >expected &&
> +	git \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=extended \
> +		-c grep.patterntype=perl \
> +		grep "a\x{2b}b\x{2a}c" ab >actual &&
> +	test_cmp expected actual
> +'

Likewise.

> +test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=fixed, =basic, =extended' '
> +	echo "ab:a+b*c" >expected &&
> +	git \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=extended \
> +		-c grep.patterntype=perl \
> +		grep -P "a\x{2b}b\x{2a}c" ab >actual &&
> +	test_cmp expected actual
> +'

As you are expecting the "last one wins" behaviour among
configuration variables, running a test with -P option would not let
you catch bugs coming from potentially screwed-up precedence between
the configuration and command line flags, would it?  At least, leave
the "-c grep.patterntype=perl" out from here to make sure what the
variable and the flag tell the command conflict with each other.  I
would also prefer to see only one "-c grep.patterntype=<foo>" used.

> +test_expect_success 'grep -F pattern with grep.patternType=fixed, =basic, =extended, =perl' '
> +	echo "ab:a+b*c" >expected &&
> +	git \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=extended \
> +		-c grep.patterntype=perl \
> +		grep -F "*c" ab >actual &&
> +	test_cmp expected actual
> +'

Likewise.

> +test_expect_success 'grep -G pattern with grep.patternType=fixed, =basic, =extended, =perl' '
> +	{
> +		echo "ab:a+b*c"
> +		echo "ab:a+bc"
> +	} >expected &&
> +	git \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=extended \
> +		-c grep.patterntype=perl \
> +		grep -G "a+b" ab >actual &&
> +	test_cmp expected actual
> +'

Likewise.

> +test_expect_success 'grep -E pattern with grep.patternType=fixed, =basic, =extended, =perl' '
> +	{
> +		echo "ab:a+b*c"
> +		echo "ab:a+bc"
> +		echo "ab:abc"
> +	} >expected &&
> +	git \
> +		-c grep.patterntype=fixed \
> +		-c grep.patterntype=basic \
> +		-c grep.patterntype=extended \
> +		-c grep.patterntype=perl \
> +		grep -E "a+" ab >actual &&
> +	test_cmp expected actual
> +'

Likewise.

> +test_expect_success 'grep pattern with grep.patternType=extended and grep.extendedRegexp=false' '
> +	cat >expected <<-EOF
> +	hello.c:int main(int argc, const char **argv)
> +	EOF
> +	git \
> +		-c grep.patterntype=extended \
> +		-c grep.extendedregexp=false \
> +		grep "con?st" hello.c >actual &&
> +	test_cmp expected actual
> +'

What does this test?  patterntype trumps extendedregexp?

That may sit better next to the earlier "patterntype says basic but
extendedregexp says true" test, if you can move this test easily
there.

Thanks.
