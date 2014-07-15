From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 2/2] test-config: add tests for the config_set API
Date: Tue, 15 Jul 2014 08:57:52 -0700
Message-ID: <xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:58:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X757J-0003Ss-89
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 17:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbaGOP6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 11:58:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50724 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbaGOP6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 11:58:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AEDB28CFE;
	Tue, 15 Jul 2014 11:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GsD4tW5DB+9mPxvgIylYFUvE4SQ=; b=b95s0i
	YenVJYZSqJ/862rtllaRPDNyqixEqIZRdvk3seaILdwB9B38MRryJS+vvkxecRmq
	D7Q20BC2DB84xEfcNX7KlTlxJjgFKtIdq2InZ/fEcDcfXLL3/jubNA4sf7EYUylq
	OVmr8pxeabGocS6nBf0NPrF4EHT2ONoND8j4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WYi+Bi9aSV2SdGzwECJHGGINVoA1wOPb
	EiwbLPP85gGMMXOx9hya0ffjnQSR0AQPrNH87rKzXMafpGwVoY7VeZy5xyG8T0HG
	g0ODy3fZo7v7BhJ/xs+WJStVz/VAaoOJapwHixjjnG3tI0TLWTql4tarEU4jCvme
	jcW8KWgtjUU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1113728CFD;
	Tue, 15 Jul 2014 11:57:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 943EE28CF3;
	Tue, 15 Jul 2014 11:57:36 -0400 (EDT)
In-Reply-To: <1405434571-25459-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 15 Jul 2014 07:29:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD9CEBBC-0C38-11E4-BC95-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253567>

Tanay Abhra <tanayabh@gmail.com> writes:

> Expose the `config_set` C API as a set of simple commands in order to
> facilitate testing. Add tests for the `config_set` API as well as for
> `git_config_get_*()` family for the usual config files.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  .gitignore            |   1 +
>  Makefile              |   1 +
>  t/t1308-config-set.sh | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  test-config.c         | 140 +++++++++++++++++++++++++++++++++
>  4 files changed, 354 insertions(+)
>  create mode 100755 t/t1308-config-set.sh
>  create mode 100644 test-config.c
>
> diff --git a/.gitignore b/.gitignore
> index 42294e5..7677533 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -177,6 +177,7 @@
>  /gitweb/static/gitweb.min.*
>  /test-chmtime
>  /test-ctype
> +/test-config
>  /test-date
>  /test-delta
>  /test-dump-cache-tree
> diff --git a/Makefile b/Makefile
> index b92418d..e070eb8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -549,6 +549,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
>  
>  TEST_PROGRAMS_NEED_X += test-chmtime
>  TEST_PROGRAMS_NEED_X += test-ctype
> +TEST_PROGRAMS_NEED_X += test-config
>  TEST_PROGRAMS_NEED_X += test-date
>  TEST_PROGRAMS_NEED_X += test-delta
>  TEST_PROGRAMS_NEED_X += test-dump-cache-tree
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> new file mode 100755
> index 0000000..94085eb
> --- /dev/null
> +++ b/t/t1308-config-set.sh
> @@ -0,0 +1,212 @@
> +#!/bin/sh
> +
> +test_description='Test git config-set API in different settings'
> +
> +. ./test-lib.sh
> +
> +# 'check_config get_* section.key value' verifies that the entry for
> +# section.key is 'value'
> +check_config () {
> +	case "$1" in
> +	expect_code)
> +		if [ "$#" -lt 5 ];
> +		then

Spell out "test" and drop unnecessary semicolon, i.e.

	if test $# -lt 5
        then

> +			>expect
> +		else
> +			printf "%s\n" "$5" >expect

The other "expecting success" side of this function allows to expect
more than one line of output, but this one only allows you to expect
at most one line?  Why?

> +		fi &&
> +		test_expect_code "$2" test-config "$3" "$4" >actual
> +		;;
> +	*)
> +		op=$1 key=$2 &&
> +		shift &&
> +		shift &&
> +		printf "%s\n" "$@" >expect &&
> +		test-config "$op" "$key" >actual
> +		;;
> +	esac &&
> +	test_cmp expect actual

Perhaps you meant to say something like this instead?

        if test "$1" = expect_code
        then
        	expect_code="$2" && shift && shift
	else
        	expect_code=0
	fi &&
	op=$1 key=$2 && shift && shift
        if test $# != 0
        then
        	printf "%s\n" "$@"
	fi >expect &&
        test_expect_code $expet_code test-config "$op" "$key" >actual &&
	test_cmp expect actual

I dunno.

> +test_expect_success 'setup default config' '
> +	cat >.git/config <<\EOF

So the default .git/config that was prepared by "git init" is
discarded and replaced with this?  Shouldn't it be

	cat >>.git/config <<\EOF

instead?

> +test_expect_success 'find multiple values' '
> +	cat >expect <<-\EOF &&
> +	sam
> +	bat
> +	hask
> +	EOF
> +	test-config get_value_multi "case.baz">actual &&
> +	test_cmp expect actual
> +'

Hmmm, wasn't the whole point of the helper to allow us to make
things like the above into a one-liner, perhaps like this?

      check_config get_value_multi case.baz sam bat hask

I suspect the same applies to most if not all uses of test-config
in the remainder of this patch.
