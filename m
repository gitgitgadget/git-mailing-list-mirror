Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51014C433E0
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD95E207F7
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 00:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cqPfDqu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHMADj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:03:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58429 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHMADi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 20:03:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1441D8448;
        Wed, 12 Aug 2020 20:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f9UJguuzJF05/trRxu6rbOvGwO8=; b=cqPfDq
        u/MnytltFyUIbw5YYidiYrEaPhtLnu1ZJa68hUI2twvkO+BdpglSqolUhxvIiPE8
        pfiW4L+ZcTlNSJ+n13J4xs9/b0k0xTnJ6Xdii7HCs0Jn7Aul7+Uv9FdA3P2MWbPn
        cNmLDd5/y3+IiuRVTmO0DH57o0JYfH1z6/Oc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gGqfSYWJwJMGg49aHj7vkagNbJkfFS6h
        l+wpTcMqMqbEm7j+0DIPU1Iq6Vc/DFT2wnstSAqyk+gACDJgglFbvNp7tN57+YM2
        Em0SBndY3nTBGckhEU5bk/s3zJZK12daNUSD0tfXFB0EQpV6yVoXcZm6hRzkY9f6
        HzR5ZUKQgXc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8A78D8447;
        Wed, 12 Aug 2020 20:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D91DD8446;
        Wed, 12 Aug 2020 20:03:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/9] fetch: optionally allow disabling FETCH_HEAD update
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
        <20200812231021.GG2965447@google.com>
Date:   Wed, 12 Aug 2020 17:03:32 -0700
In-Reply-To: <20200812231021.GG2965447@google.com> (Emily Shaffer's message of
        "Wed, 12 Aug 2020 16:10:21 -0700")
Message-ID: <xmqqo8nf4dkb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DDCAD82-DCF8-11EA-9252-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> +fetch.writeFetchHEAD::
>> +	Setting it to false tells `git fetch` not to write the list
>> +	of remote refs fetched in the `FETCH_HEAD` file directly
>> +	under `$GIT_DIR`.  Can be countermanded from the command
>> +	line with the `--[no-]write-fetch-head` option.  Defaults to
>> +	true.
>
> [jrnieder] Is providing a config option creating more trouble than
> benefit? Is this a burden on script authors that they need to check the
> config state, when instead they could just pass the flag? Or rather,
> because of the config, the script author has to pass the flag explicitly
> anyways.
> [emily] removing the config also clears up the confusion around 'git pull' +
> 'fetch.writeFetchHEAD' I commented on later.

[A meta comment, but I somehow find this format cumbersome to read
and respond to.  Would it be possible to dedup and/or summarize
comments on a single point?]

I do not think "it becomes cumbersome to design interaction between
command line option and configuration" is a valid reason not to add
configuration variable.  It would be a valid reason not to, if we
have a convincing argument why people won't pass the command line
option very often, though, but you'd need to be prepared for a
possible future in which somebody finds a good use case where a
configuration is useful, which means you cannot forever depend on
the lack of configurability to avoid making a proper design of the
interaction between configuration and command line.

As the feature itself is primarily designed for scripts that want to
always disable writing of FETCH_HEAD, I can certainly understand a
short-term/sighted view of not wanting to add configuration, though.

>> @@ -895,7 +902,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>  	const char *what, *kind;
>>  	struct ref *rm;
>>  	char *url;
>> -	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
>> +	const char *filename = (!write_fetch_head
>> +				? "/dev/null"
>> +				: git_path_fetch_head(the_repository));
>
> [emily] Huh. so what does the dry_run codepath look like now? It looks
> like it's been superseded by write_fetch_head but the option parse
> doesn't tell dry_run to update write_fetch_head instead. (Found the
> answer later, see below)
>
>> @@ -1797,6 +1806,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  	if (depth || deepen_since || deepen_not.nr)
>>  		deepen = 1;
>>  
>> +	/* FETCH_HEAD never gets updated in --dry-run mode */
>> +	if (dry_run)
>> +		write_fetch_head = 0;
>
> [emily] Aha, here is where dry_run informs write_fetch_head. I wonder if
> there's a way to instead tell the options struct that --dry-run ~=
> --write-fetch-head?

I do not know with what meaning you used the symbol "~=".  Dry-run
tells the command to operate differently in a few ways, and one of
the (smaller) ways is not to write the FETCH_HEAD file.  Did you
mean "contains", "includes", etc.?

>> +test_expect_success '--write-fetch-head gets defeated by --dry-run' '
>> +	rm -f .git/FETCH_HEAD &&
>> +	git fetch --dry-run --write-fetch-head . &&
>> +	! test -f .git/FETCH_HEAD
>> +'
>
> [emily] Would it make more sense to make these args mutually exclusive?

At least, give a hint, if you cannot state in concrete words, why
you suspect it might make sense to do things differently.  What use
case do you think an alternative design would help better?  Without
it, you can just get "no" and such an exchange would not be useful
at all to improve the patch.

> [jrnieder] If someone specifies both, then they probably want to say
> "show me what I would write to FETCH_HEAD but don't actually do that" -
> which isn't info that we print anyways, right now.

Do you mean "don't actually write but show it to standard output
instead" or something?  If we were designing --dry-run from scratch
back when there were no "git fetch" command, that would have made
tons of sense, I think ;-) To me, the "--write-fetch-head" option
tells it to "write to the file", and not "write the info to unfixed
destination that is not specified by this option but derived by the
presense of other options".  While the "don't download and show what
would be in FETCH_HEAD" might be a good feature to add, combining
these two options may be a good way to invoke the feature.

>> +test_expect_success 'git pull --no-write-fetch-head fails' '
>> +	mkdir clonedwfh &&
>> +	(cd clonedwfh && git init &&
>> +	test_must_fail git pull --no-write-fetch-head "../parent" >out 2>err &&
>> +	test_must_be_empty out &&
>> +	test_i18ngrep "no-write-fetch-head" err)
>
> Should this be shown as a usage error instead of a die()?

As "pull" does and should not take "--[no-]write-fetch-head" as its
option, I think the above command line deserves an usage error, just
like "git pull --update-head-ok" does (or "git pull --no-such-option"
for that matter).

