Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E87E1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 21:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeAJVb2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 16:31:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57557 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeAJVbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 16:31:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DE5EB822C;
        Wed, 10 Jan 2018 16:31:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LNXCeRFh+sFCvckNh3Cero3ENuk=; b=eQqClf
        UBXgdMn+0GTcT3/bIWCQfOCrZWC2B51VWRyQQ7er/4QxuagrFCVGNtd7LSUuEaGy
        8B4D5AOOGh3ymw3WsVTwqslAtgj5bC3RLvDRmw19DhL5ESwZzHYPO1zNOYavUHb6
        /e6ZkFzkbrKfy3hwDN5CRw1nDtc7UOOnmshnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lat2H2c9Jv2RZfi9EWB58aBaGPnEPCIw
        B2+nhDRdMQFli+fk/RPxp9Mq/qg0j2aXk6IQh6VDS4L16i7OUk2fAwU6kw4AvaOu
        zIQfDLg6m02HHmR7U6ilKaRi5DaDXlA8p560Wz5cKcPpwDi5RflZVRh5wpgt6+rV
        asmq7XdzEj8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 759D9B822B;
        Wed, 10 Jan 2018 16:31:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D10D7B8229;
        Wed, 10 Jan 2018 16:31:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3900: add some more quotes
References: <20180110095832.22077-1-dev+git@drbeat.li>
        <6b32292b-0f71-7cf8-2069-41766d440b58@kdbg.org>
        <20180110195323.GA26186@sigill.intra.peff.net>
Date:   Wed, 10 Jan 2018 13:31:22 -0800
In-Reply-To: <20180110195323.GA26186@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 10 Jan 2018 14:53:23 -0500")
Message-ID: <xmqqy3l5z9hx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B6EFB90-F64D-11E7-8AF5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah. One of the reasons for both of the errors in this thread is the
> nested double-quoting. Using single quotes is awkward because we're
> already using them to delimit the whole snippet.  I've often wondered if
> our tests would be more readable taking the snippet over stdin.
> Something like:
> +test_expect_success 'UTF-8 invalid characters refused' - <<\EOT
> +	test_when_finished 'rm -f "$HOME/stderr $HOME/invalid"' &&
> ...
> -'
> +EOT
> 
> +# Read from stdin into the variable given in $1.
> +test_read_to_eof () {
> +	# Bash's "read" is sufficiently flexible that we can skip the extra
> +	# process.
> +	if test -n "$BASH_VERSION"
> +	then
> +		# 64k should be enough for anyone...
> +		read -N 65536 -r "$1"
> +	else
> +		# command substitution eats trailing whitespace, so we add
> +		# and then remove a non-whitespace character.
> +		eval "$1=\$(cat; printf x)"
> +		eval "$1=\${$1%x}"
> +	fi
> +}

Yuck.  Hacky but nice.

I think this will make it easier to read but I suspect here text
would use temporary files and may slow things down a bit?  I do not
know if it is even measurable, though.

> +
>  test_expect_failure () {
>  	test_start_
>  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
>  	test "$#" = 2 ||
>  	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
> +	if test "$2" = "-"
> +	then
> +		test_read_to_eof test_block
> +		set -- "$1" "$test_block"
> +	fi
>  	test_verify_prereq
>  	export test_prereq
>  	if ! test_skip "$@"
> @@ -416,6 +437,11 @@ test_expect_success () {
>  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
>  	test "$#" = 2 ||
>  	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
> +	if test "$2" = "-"
> +	then
> +		test_read_to_eof test_block
> +		set -- "$1" "$test_block"
> +	fi
>  	test_verify_prereq
>  	export test_prereq
>  	if ! test_skip "$@"
