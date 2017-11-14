Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A156201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 03:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbdKNDUP (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 22:20:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58403 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751184AbdKNDUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 22:20:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E510AD0F0;
        Mon, 13 Nov 2017 22:20:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LESU6XZq2QELIJ76Rkj6DajPXNk=; b=eslI/a
        rBNqDe4pD4Ea/U7cnAyQgbiNbROR23R+y5qscjPWuRaZEMHV4mgDvXeeqQVyKVN6
        VoFut69FJByaSsHeL8O3o2xAXvD/aFlphuDvwuN3Zuwn2Y4y7oS4/u8OxgCvsnA9
        WQRGo8hQUalEfVxx4X9mQWV6mJ9caTAH3ziA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R/yBbvvoxvN9Vo20DBXl6kQn4naN2kIC
        5YbMX4BS1PhwMI0yNLtXO+s/4ucRjg7GHw+FOgkFZCEGUX0E+vk6B3Gu/rU4MpG2
        3mScpivnG5hIY7qO3S9l9Wfrzrp6/I5BD1iVb7uQGow4uF8i6JYPTU0Hv9WGv4kD
        v5u4HYkJLTw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 452A4AD0EF;
        Mon, 13 Nov 2017 22:20:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAC1EAD0EE;
        Mon, 13 Nov 2017 22:20:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v2 6/6] Testing: provide tests requiring them with ellipses after SHA-1 values
References: <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-6-bedhanger@gmx.de>
Date:   Tue, 14 Nov 2017 12:20:11 +0900
In-Reply-To: <20171113223654.27732-6-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Mon, 13 Nov 2017 23:36:54 +0100")
Message-ID: <xmqqwp2t5yxg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA12FFD2-C8EA-11E7-9453-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> Where needed, we arrange for invocations of Git as if
>
>    "-c core.printsha1ellipsis=true"
>
> had been specified on the command-line.  This furnishes ellipses in the
> output which then matches what is expected.
>
> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> ---

I am not a huge fan of exposing undocumented implementation details
to the test scripts that much.  There are three in t13xx series that
mention GIT_CONFIG_PARAMETERS, but these are about testing the config
mechanism itself.  

An end-user script would instead be doing "git -c var=val" for each
invocation but this one is being lazy because it does not want to
bother identifying which "git" invocation needs the treatment and
also it does not want to keep maintaining it, which is understandable,
but it feels dirty.

This makes me wonder if core.printsha1ellipsis should really be a
configuration variable in the first place.  Wouldn't an environment
variable be more appropriate?  After all, the users of scripts that
would be broken by this series would need to the same thing as what
we do to our tests to keep them working while they update them.

> v2: rename patch series & focus on removal of ellipses
>  t/t3040-subprojects-basic.sh | 12 ++++++++++++
>  t/t4013-diff-various.sh      | 12 ++++++++++++
>  t/t9300-fast-import.sh       | 12 ++++++++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
> index 0a4ff6d824a0..63b85bfdd4f9 100755
> --- a/t/t3040-subprojects-basic.sh
> +++ b/t/t3040-subprojects-basic.sh
> @@ -3,6 +3,18 @@
>  test_description='Basic subproject functionality'
>  . ./test-lib.sh
>  
> +# Some of the tests expect an ellipsis after the (abbreviated)
> +# SHA-1 value.  The code below results in Git being called with
> +# "-c core.printsha1ellipsis=true" which satisfies those tests.
> +do_print_sha1_ellipsis="'core.printsha1ellipsis=true'"
> +if test -z "${GIT_CONFIG_PARAMETERS}"
> +then
> +	GIT_CONFIG_PARAMETERS="${do_print_sha1_ellipsis}"
> +else
> +	GIT_CONFIG_PARAMETERS="${GIT_CONFIG_PARAMETERS} ${do_print_sha1_ellipsis}"
> +fi
> +export GIT_CONFIG_PARAMETERS
> +
>  test_expect_success 'setup: create superproject' '
>  	: >Makefile &&
>  	git add Makefile &&
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index c515e3e53fee..8ee14c7c6796 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -7,6 +7,18 @@ test_description='Various diff formatting options'
>  
>  . ./test-lib.sh
>  
> +# Some of the tests expect an ellipsis after the (abbreviated)
> +# SHA-1 value.  The code below results in Git being called with
> +# "-c core.printsha1ellipsis=true" which satisfies those tests.
> +do_print_sha1_ellipsis="'core.printsha1ellipsis=true'"
> +if test -z "${GIT_CONFIG_PARAMETERS}"
> +then
> +	GIT_CONFIG_PARAMETERS="${do_print_sha1_ellipsis}"
> +else
> +	GIT_CONFIG_PARAMETERS="${GIT_CONFIG_PARAMETERS} ${do_print_sha1_ellipsis}"
> +fi
> +export GIT_CONFIG_PARAMETERS
> +
>  LF='
>  '
>  
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index d47560b6343d..6cc41b90dafa 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -7,6 +7,18 @@ test_description='test git fast-import utility'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
>  
> +# Some of the tests expect an ellipsis after the (abbreviated)
> +# SHA-1 value.  The code below results in Git being called with
> +# "-c core.printsha1ellipsis=true" which satisfies those tests.
> +do_print_sha1_ellipsis="'core.printsha1ellipsis=true'"
> +if test -z "${GIT_CONFIG_PARAMETERS}"
> +then
> +	GIT_CONFIG_PARAMETERS="${do_print_sha1_ellipsis}"
> +else
> +	GIT_CONFIG_PARAMETERS="${GIT_CONFIG_PARAMETERS} ${do_print_sha1_ellipsis}"
> +fi
> +export GIT_CONFIG_PARAMETERS
> +
>  verify_packs () {
>  	for p in .git/objects/pack/*.pack
>  	do
