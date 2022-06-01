Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF12BC433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 13:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351921AbiFANED (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiFANEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 09:04:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D4C1573F
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 06:04:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so3633396ejk.5
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gbIXCt5PIyh5d0GgbfVeOMtFdkYMvt9HGH6icCMS5fU=;
        b=hfj069Qiwr1BGkgkPSRocMaZxfUDEd8gAA3NFHbexmjxPCYGLgVZDfNTclxIIMPbc5
         bW+WI0xDaghNk9gCIeYBU0NyCHYior9LAZetBDnJ3Oa0jyPLlekaKTInA/xaZoyXJUIU
         CP/7IRRc5nmOrS5iwjx4m5dYh4nJ7iRd4V3Gnr/P3wq8wncMQqdcONMO1RbfFnmm9SpI
         1TgYcnlg5J9dReSp5wxgQ+9dovjcrycahuI+kKFBXOghK2LJAXUxlz6WbNs4y9x4+YMZ
         H170sXSGt/9sgWwKays3Fm6Z1D6koKtRKXgZYfn3PX/9nkyOG7p3icLC+ZfnoWcJFZYt
         3abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gbIXCt5PIyh5d0GgbfVeOMtFdkYMvt9HGH6icCMS5fU=;
        b=onLih2CJWJcqhsLqy/iJjdBLF5GW+6tEhPxkPyM2W95zTBV8fY2aVQvac7mXV2KJCq
         VUPfy9G4iRz33u5cOQaIU5B0DKS90sFP9AblmNwKxvfFOIkuc8ia4MOoDBdX49Luoenc
         2kzF/QTAGEJUCVMig9Sfka1Wmq+MkM282yePGPZfZaHMvaSuWLgtYAfeYMHPCAPHbyG6
         uvxBV2r6MLSq5J/UcmCy9+IUtfOKqI7QPNhfwgt6NeUib9W64XTAK/rDdJlyKjXPE/xF
         /N7y5GC0jD7FOwfix2FiC/M3LpcVmbCbuT0k0UoAk5ccZyjvN/lhEljJQNMnmEA3YaZG
         9LJg==
X-Gm-Message-State: AOAM531A45MfwJh+kzwei/JzZJxLAGK7qQunZ9XODrG+pMlRnJtBLa/w
        ModlIBiakt6YS5ssu7wLtDq66o6OaQWmVg==
X-Google-Smtp-Source: ABdhPJx8PB8d6QWAlxfBGCCWYtIFoPl8uLR5DSWdZvtJDBR47wxEtCHnIrssPV+ZMZRwLWVq7oyl/g==
X-Received: by 2002:a17:907:7d90:b0:6ff:b2b:8272 with SMTP id oz16-20020a1709077d9000b006ff0b2b8272mr33895146ejc.82.1654088638920;
        Wed, 01 Jun 2022 06:03:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090615cf00b006f3ef214dd9sm699359ejd.63.2022.06.01.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 06:03:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwO0z-001BWj-9b;
        Wed, 01 Jun 2022 15:03:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated warnings
Date:   Wed, 01 Jun 2022 14:29:38 +0200
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
Message-ID: <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The previous change added a warning when valid_remote() detects
> credentials in the URL. Since remotes are validated multiple times per
> process, this causes multiple warnings to print.

Why are we validating remotes multiple times per process? Can't we just
do it once?

Is this a case of two callers going through the whole machinery and not
being aware of one another?

Perhaps it's a pain to deal with that in this case, but it would be
better to note why here than taking it as a given.

> To avoid these kinds of repeated, advisory warnings, create a new
> warn_once() helper that behaves the same as warning(), but only after
> formatting the output string and adding it to a strset. If that addition
> signals that the string already exists in the strset, then do not print
> the warning.

This feels quite iffy given the low-level API & the rest of it aiming to
be thread-safe, see 2d3c02f5db6 (die(): stop hiding errors due to
overzealous recursion guard, 2017-06-21) for such a case.

I.e. there *is* racy code there already that (ab)uses a no-lock pattern
to optimistically abort early when we'd emit N of the same recursion
message.

But are we as confident that concurrent strset callers in multiple
threads will behave themselves? I'd think we should be adding this to
the caller that knows it's not threaded, e.g. whatever calls
check_if_creds_in_url().

> In the case of the credentials in a URL, the existing test demonstrates
> this per-process limitation: 'git clone' runs 'git-remote-curl' as a
> child process, giving two messages. This is an improvement over the
> previous six messages.

If we know about this limitation and we're going to be checking the same
URLs why not do slightly better and pass down a "don't warn please" to
the sub-process?

Or do we think it might warn about *different* URLs, aren't these always
the same (i.e. we read the full config)?

If you used advice instead of a warning you'd get a config key to pass
for free to disable it, and that might be a better thing to do in any
case (i.e. a better fit for this case). But we could also just check
getenv("GIT_URL_REDACTED_WARNING") or whatever, which seems easy
enough...

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index cba3553b7c4..6ae3eec9eb6 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -75,7 +75,10 @@ test_expect_success 'clone warns or fails when using username:password' '
>  	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
>  	! grep "URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
>  	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
> -	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
> +	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err >warnings &&
> +	# The warning is printed twice, for the two processes:
> +	# "git clone" and "git-remote-curl".
> +	test_line_count = 2 warnings &&
>  	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
>  	grep "fatal: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err
>  '

Hrm, between 1/2 and this I think this is a good example of a "just use
test_cmp" caveat.

I.e. reading 1/2 it's snuck past us that there's this existing caveat in
the warning being added, i.e. that we should really warn 1 times, but
are doing in N times, but as we use ad-hoc "grep" instead of
test_cmp-ing the full output that's not obvious.

I think this would be much more obvious as:

	warning="<your warning msg>" &&
	cat >expect <<-EOF &&
	$warning
        $warning
	EOF

Or whatever, followed by a:

	test_cmp expect actual

Then 1/2 could make a brief note that we're leaving this duplication
issue for now, and 2/2 would fix it.

But even better (and per the above, I'm not convinced about the
direction, but leaving that aside): Here we have a choice between having
1/2 and 2/2 in that order and having 2/2 add a new API that has its
first user right away, but at the cost of fixing a bug we just
introduced in 1/2.

I think even if we can't find another API user for this proposed usage.c
addition, just adding it without a user & adding what's now 1/2 as the
2nd commit would be preferrable. Then we're not doing a "oops, bug fix"
while we're at it.

> +static struct strset prev_warnings = STRSET_INIT;
> +
> +void warn_once(const char *warn, ...)
> +{

If we do end up keeping this (per the above I'm thinking while it's just
this caller it should probably own this problem):

I have a local change to clean up this warn v.s. warning inconsistency
in usage.c, but now it's all in internal code.

But let's not add to it by adding a warn_once(), it should be called
warning_once().

We're also missing an "errno" variant, which might be fine for now,
ditto variants for the other non-fatal functions (error &
die_message). That might be OK for now, but probably worth noting.

> +void warn_once(const char *warn, ...)
> +{
> +	char buf[1024];
> +	va_list params;
> +	va_start(params, warn);
> +
> +	if (vsnprintf(buf, sizeof(buf), warn, params) >= 0) {

It doesn't matter for the end result, but let's compare with "< 0" like
the other vsnprintf() caller in the file.

And how is this unlike that vsnprintf() in not needing the same error
handling vreportf() does here:

	*p = '\0'; /* vsnprintf() failed, clip at prefix */

Seems like either a bug, or that other code being something we should be
dropping.

> +		if (!strset_add(&prev_warnings, buf)) {

More on the general API usability front: E.g. builtin/pack-objects.c
seems like it could make use of thing like this in two places.

But the API you've added here would only be usable for 1/2, i.e. you
format and de-dup on the full warning, whereas at least 1/2 of those
callers wants to de-dup on the un-formatted string (grep for 'static int
warned').

Which (and I'm sounding like a broken record:) is another thing that me
wonder if the general API is premature, i.e. it's a red flag that we
have existing code that could benefit from it, if not for an arbitrary
limitation, in this case fixing the limitation would mean the churn of
either adding a new function, or a new parameter to all callers. I.e. a
"int dedup_on_args" or similar.

> +			va_end(params);
> +			return;
> +		}
> +	}
> +	va_end(params);
> +
> +	va_start(params, warn);

I'm rusty on the varargs API (and haven't tested) but didn't we need
va_copy() if we're iterating twice, or was that just if we're passing it
to another function and using it ourselves...

