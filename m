Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D5C32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 04:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51CC222C4
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 04:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fmerP2qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgADE4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 23:56:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63620 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgADE4q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 23:56:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69845900DB;
        Fri,  3 Jan 2020 23:56:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pRW+vcUXqUR73BUOkWBMvloT6n0=; b=fmerP2
        qRLokCLbghZ/ljW/yaZHq9BDI4ume2JUyoja68RLeT0UZtSt1U0+dZZGb9QjcoKf
        dkH0UxCR3UcWDFAJSwy8aCSwGuf7lnrwGW1ZPPQ7MHxxcrC6TfN1VnOnXoJAr8ML
        /hPL+aRo+69teC7IXxO+2rsUaAhUlc5Q//5sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jOTr+dBlO1FZDhoJhTOep0wo4WXfVl4w
        xY0UjASKguu6pcy9M93YSP5mgCHWn1jmNj/Qk2KTQx603UgeeUlyUHwapE0pqHeJ
        vpNnTs5HJiEkIHjGsFXcJT0BTWU9EHl3xZTDxx4yLMb2JsTmTcxbEfo56UMl8X0P
        nZFeOnAcx5c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 553D7900DA;
        Fri,  3 Jan 2020 23:56:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6AD91900D9;
        Fri,  3 Jan 2020 23:56:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Oberholtzer <stevie@qrpff.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] bisect run: allow '--' as an options terminator
References: <20200104034551.23658-1-stevie@qrpff.net>
Date:   Fri, 03 Jan 2020 20:56:37 -0800
In-Reply-To: <20200104034551.23658-1-stevie@qrpff.net> (Stephen Oberholtzer's
        message of "Fri, 3 Jan 2020 22:45:51 -0500")
Message-ID: <xmqq1rsfddkq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97D1CED6-2EAE-11EA-92DD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Oberholtzer <stevie@qrpff.net> writes:

> The 'bisect run' feature doesn't currently accept any options, but
> it could, and that means a '--' option.

Sorry, but the above description does not make much sense to me.  I
do agree up to the "but it could" part with the above sentence, but
double-dash is hardly a logical consequence of it, at least to me.

> - git bisect run <cmd>...
> + git bisect run [--] <cmd>...

The only reason why you might want '--' disambiguator is if you have
a <cmd> that happens to begin with a dash (i.e. making it possible
to be confused as an unrecognised option), but I do not think it is
unreasonable at all if we declare that you cannot feed a cmd that
begins with a dash.  On a rare occasion like that, the user could
even do the "prefix with "sh -c'" you alluded to in the other thread
to escape/quote the leading dash, if the user really wanted to use
such a strange command.

> Additionally, this adds an actual test script for bisect run - it
> creates a repository with a failed build, then attempts to bisect
> the offending commit.

I do not think I have seen enough to justify addition of "--", but
addition of tests by itself may have a value, and I'd prefer to see
it as its own patch.  But I see hits for

	git grep 'git bisect run' t/

already in t6030, so "adds an actual test script", while it is not
telling a lie, may be giving a false impression that it is adding
something new that has been missing.

So, I dunno.

> diff --git a/t/t6071-bisect-run.sh b/t/t6071-bisect-run.sh
> new file mode 100755
> index 0000000000..e173ca18b3
> --- /dev/null
> +++ b/t/t6071-bisect-run.sh
> @@ -0,0 +1,96 @@
> +#!/bin/sh
> +
> +test_description='Tests git bisect run'
> +
> +exec </dev/null

All of our test scripts are designed to be used unattended with the
use of test_expect_* harness helpers.  Can you tell us why this new
file alone needs to dissociate the input to _all_ its subproesses by
doing this, while others do not have to?

> +. ./test-lib.sh
> +
> +{ test_expect_success 'Setting up repo for "git bisect run" tests.' "$(cat)" ; } <<'SETUP'

Yuck.  I have to say this is trying to be too clever and cute than
its worth.  Doesn't it defeat test-lint, for example?

> +echo '.DEFAULT: dummy
> +.PHONY: dummy
> +dummy:
> +	true
> +' > Makefile &&
> +make &&
> +echo '0' >path0 &&
> +git update-index --add -- Makefile path0 &&
> +git commit -q -m 'initial commit' &&
> +git tag working0 &&
> +# make some commits that don't cause problems
> +for x in `test_seq 1 20`; do

More than one Documentation/CodingGuidelines violation on a single
line X-<.

> +	echo "$x" >path0 &&
> +	git update-index --replace -- path0 &&
> +	git commit -q -m "working commit $x" &&
> +	git tag "working$x" || exit 1
> +done &&
> +# break the makefile
> +sed -i.bak -e 's/true/false/' Makefile &&

"sed -i" is unportable, isn't it?  Avoid it.

> ...
> +SETUP
> +
> +test_expect_success 'setup first bisect' 'git bisect start && git bisect good working0 && git bisect bad broken9'

Lay it out like so for readability:

	test_expect_success "setup first bisect" '
		git bisect start &&
		...
	'

In general, read and mimic existing tests that have been cleaned up
recently ("git log t/" is your friend).

> +
> +test_expect_failure() {

Do not override what we provide in test-lib and test-lib-functions.
Those who are familiar with the test framework depend on these names
to work the way they are used to.

Learn what are given by the test framework to you already before
trying to invent your own convention---that would hurt everybody,
including the current set of reviewers and future developers who
need to fix what you wrote.

> +	shift
> +	test_must_fail "$@"
> +}

The remainder of the file not reviewed (yet).

Thanks.
