Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2265DC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC23A20BED
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KOH8VN2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgI3XmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:42:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgI3XmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 19:42:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFFE31025AF;
        Wed, 30 Sep 2020 19:42:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=atUOl+icy25u+89DoO4v64WQ688=; b=KOH8VN
        2Ku3ziUdIEIEE3zLO+YMmW7ZRtaCm/ElHDUaIDeTwsKFQtT959/Gd57dsBx9hJuZ
        Nc23hqEqwayhvFqtoiIBzmj5pCMuxGc2RS1Mca5CKo9/wc8tFG+XXBhb4lGDcUlw
        xbMgGS0iRNx3GOJvtqWNtDpxbu2cScOSJHrS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Noae3WDAEuRTnaUYCMm3A4qwjfptBwVK
        z1SW3o8lMb0bRt3Pw9Xm6fmlfcoQgYeAFB+MDsJT4yuac6vBAeIl5uNEtq5I+Zyy
        pUmi3BJk6XZCDaUvHPSMbyF4kE7MyLYiqJYCSGIJJ42t93SKecrnZPqtln7qt7HD
        HXYqL2ChZ8E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8FC61025AE;
        Wed, 30 Sep 2020 19:42:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0FA91025AC;
        Wed, 30 Sep 2020 19:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <20200930232138.3656304-2-shengfa@google.com>
Date:   Wed, 30 Sep 2020 16:41:57 -0700
In-Reply-To: <20200930232138.3656304-2-shengfa@google.com> (Shengfa Lin's
        message of "Wed, 30 Sep 2020 23:21:38 +0000")
Message-ID: <xmqqpn62essa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8823E3C8-0376-11EB-AE0E-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

> Users requested hiding location in the world from source control
> trail. This is an implementation to read user.hideTimezone in
> cmd_commit and set timezone to UTC if it's true.
>
> Added a brief explanation of the new field in Documentation
> and added tests for true/false and reset-author
>
> Signed-off-by: Shengfa Lin <shengfa@google.com>
> ---
>  Documentation/config/user.txt   |  4 ++++
>  builtin/commit.c                |  5 +++++

There are many ways other than running "git commit" for a commit to
be created, including but not limited to "git merge", "git rebase",
"git pull" (with or without "--rebase").

> +user.hideTimezone::
> +  Override TZ to UTC for Git commits to hide user's timezone in commit
> +  date

One level of indentation in this codebase is a single HT.

Unterminated sentence.

A configuration _without_ command line option that overrides it is
highly frowned upon.  I do not see a reason why this must be such a
configuration.  If anything, a feature like this should first start
as a command line option, and only after it proves its usefulness,
a new configuration for convenience should be added.

This only affects "git commit" and no other command (which I think
is a mistake), yet is placed in the "user.*" namespace?  That does
not make any sense.  I can sort-of understand if it were called say
"commit.useUTC" though.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 42b964e0ca..fb1cbb8a39 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1569,6 +1569,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>  	s.colopts = 0;
>  
> +  git_config(git_default_config, NULL);

Declaration after statement is not tolerated in this codebase.

One level of indentation in this codebase is a single HT.

> +  int hide_timezone = 0;

Unnecessary initialization.

> +  if (!git_config_get_bool("user.hideTimezone", &hide_timezone)  && hide_timezone)

Overlong line.  Double-SP before &&

> +    setenv("TZ", "UTC", 1);
> +
>  	if (get_oid("HEAD", &oid))
>  		current_head = NULL;
>  	else {
> diff --git a/t/t7527-commit-hide-timezone.sh b/t/t7527-commit-hide-timezone.sh
> new file mode 100755
> index 0000000000..41ed9c27da

Let's not waste a test number for just a single test or two.  Can't
we roll this into 

> --- /dev/null
> +++ b/t/t7527-commit-hide-timezone.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='git-commit can override local timezone setting by reading user.hideTimezone from config'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'commit date shows timezone offset +0300 when user.hideTimezone is false' '
> +        git config user.hideTimezone false &&
> +        echo test1 >> file &&

Style.  Documentation/CodingGuidelines

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'. ...

> +        git add file &&
> +        # unset GIT_AUTHOR_DATE from test_tick
> +        unset GIT_AUTHOR_DATE &&
> +        TZ=Europe/Istanbul git commit -m initial &&
> +        git log -1 > output &&
> +        grep "Date: .* +0300" output

Do they not have DST over there, and is it guaranteed that they will
never have one?  Would we see this test fail about half of the year,
when timezone rules change over there in some future year?  After
all, they changed in 2016 last time, which is fairly recent.

This test attempts to establish the baseline, but I do not think it
is a good idea.  I think it is better *not* to unset GIT_AUTHOR_DATE
like this.  Instead, make sure it is set to some timestamp in some
timezone that is not UTC, and the timezone of the resulting commit
author date is in that timezone.  But that must have already been
done in basic tests on "git commit" that we honor the environment
variable, no?  Which means there is no need to add yet another extra
baseline test here.

> +test_expect_success 'commit date shows timezone offset +0000 when user.hideTimezone is true and reset' '
> +        git config user.hideTimezone true &&
> +        git commit --amend --reset-author &&
> +        git log -1 > output &&
> +        grep "Date: .* +0000" output

This one IS interesting, but keep the GIT_AUTHOR_DATE set and
exported.  As long as that is from a timezone different from UTC, we
are testing what we want to test here.

> +'
> +
> +test_expect_success 'commit date shows timezone offset +0000 even TZ setting says otherwise' '
> +        git config user.hideTimezone true &&
> +        echo test2 >> file &&
> +        git add file &&
> +        # TZ setting corresponding to -0600 or -0500 depending on DST
> +        # unset GIT_AUTHOR_DATE from test_tick
> +        unset GIT_AUTHOR_DATE &&
> +        TZ=America/Chicago git commit -m test2 &&

This one is a borderline meh, compared to a test with explicit
GIT_AUTHOR_DATE getting overridden by the configuration.  It is not
all that wrong, but I do not see a point in adding cycles to the
already big testsuite.

> +        git log -1 > output &&
> +        grep "Date: .* +0000" output
> +'
> +
> +test_done

Thanks.
