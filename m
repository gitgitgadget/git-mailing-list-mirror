Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881D4C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhLTThL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhLTThK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:37:10 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3848FC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:37:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p1-20020a17090a2d8100b001b1e44000daso66028pjd.9
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yLv2dYW+ccet+I9dFVbN3zF6xWZB3hcbzAhQI+ccugM=;
        b=ALdGnBG1hAJC97tE1ZhHfc3XakaPw+kBfjVFiPBXrtLryOXiZIPiHuwUqKTvwJkzr4
         pQL+nX6+D7SC3IZjJ9FoFc/Syb+jM5oY30d/g0fbWooV3fcABwR1saQdoszaU6G2zyIC
         t9Ak3FJoLEbCcpxRXb1qdOIWd3dnKkzcyA3JpBGu0q0gD/LTPW4mYfPFYdJWMgo5xWEq
         1N6VcN6LC5eFYoumBhSCoQcrXhBaaYeoiB2qLcqIvIovskji2gnraaRRIH+lrpWTPNzZ
         w0azS7rsPFGPYv9CMZ6YwRjlPOKbTYbdk8HzRtup4FyShF9JwPkwGA/sqXQ9NH0aURpq
         cjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yLv2dYW+ccet+I9dFVbN3zF6xWZB3hcbzAhQI+ccugM=;
        b=5e10URr+MPKRy1utGASMH7phKkTd1j9c9f3bN52pjihu1u2ZCPSX+D5xNwy+yAc0yb
         7n3/3fB7tjnmcl0QkPDfoi28A3etZ8kKiU6Uaa1FFXTmERGhd+Nnvu2LL5gwwJMtTlOD
         p2OPh10trHXLhJJhZbC2F9Rvupfw5fsAiT7V/1V4IMSUeWwZQkZMMbHaDqc5YpRSAeTQ
         MUINKZkuWtz6RS56c3PCWy34u2rMiWYuWt0JqL3UKeLWOtkTAI9p5Z1HMZSkxhiHzA75
         5uZ6WEv7LRQmFkVr8CLFPRvIY9xt/y580VZ1//Fwg9ee4w/zC896YaWs9tAT+N/dNehZ
         TC9Q==
X-Gm-Message-State: AOAM530DmkC846GyZQTlRku9XaSMQbQnsAtq32awyroNWqWG81LurAjF
        vQ9nYSeleF91u9fDy2CAn36ylx4BtUeL/g==
X-Google-Smtp-Source: ABdhPJy7ECsB/knzMADC1V16WgtAagJxykwReg1PpUxMbnc6Wt5oOh76/gY9hp1Jsq6XHBXt0eBJ4S8GntM58Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:1bc5:: with SMTP id
 r5mr567911pjr.133.1640029029720; Mon, 20 Dec 2021 11:37:09 -0800 (PST)
Date:   Mon, 20 Dec 2021 11:37:07 -0800
In-Reply-To: <xmqqilvm24bb.fsf@gitster.g>
Message-Id: <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211207192925.67680-1-chooglen@google.com> <20211217000235.68996-1-chooglen@google.com>
 <xmqqilvm24bb.fsf@gitster.g>
Subject: Re: [PATCH v2] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> * gc is run, but according to [3], we only do this because we expect
>>   `git fetch` to introduce objects.
>
> Makes sense.  As we haven't added any new objects, there is nothing
> (other than the passage of time) that adds to the need to collect
> garbage.
>
> It makes me wonder if we need to do anything upon "fetch --dry-run".
> I know we add to the object store without making anything reachable,
> so that the user can do pre-flight checks with the real objects.  We
> do not change the reachability so there is no reason to rewrite the
> graph file, but we do add cruft to the object store.
>
> Doing something about "--dry-run" is obviously outside the scope of
> this topic, but it may make sense to think about it while we are
> thinking about "fetch".

I hadn't considered "--dry-run". I'll think about that while I structure
this patch.

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index f7abbc31ff..85091af99b 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1996,6 +1996,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  
>>  	argc = parse_options(argc, argv, prefix,
>>  			     builtin_fetch_options, builtin_fetch_usage, 0);
>> +
>> +	if (negotiate_only) {
>> +		/*
>> +		 * --negotiate-only should never recurse into
>> +		 * submodules, so there is no need to read .gitmodules.
>> +		 */
>> +		recurse_submodules = RECURSE_SUBMODULES_OFF;
>> +		if (!negotiation_tip.nr)
>> +			die(_("--negotiate-only needs one or more --negotiate-tip=*"));
>> +	}
>> +
>
> This means "fetch --negotiate-only --recurse-submodules" silently
> ignores an explicit wish by the user.
>
> I suspect that this part should be more like this.
>
> 	if (negitiate_only &&
> 	    recurse_submodules != RECURSE_SUBMODULES_OFF) {
> 		if (recurse_submodules came from the parse_options)
> 			die(_("'--%s' cannot be used with '--%s'",
> 			      "recurse-submodules", "negotiate-only"));
> 		recurse_submodules = RECURSE_SUBMODULES_OFF;
> 	}
>
> That is, we complain if user gives us a combination we do not
> support, but we are OK if the configuration is set to do so and
> silently ignore (because we declare that the combination does not
> make sense).

Yes, Jonathan proposed this as well. This is identical to the approach
in gc/branch-recurse-submodules, which as I noted in [1], is a bit
inconsistent with submodule parsing in general.

I decided *against* this because I thought that "--negotiate-only" is
internal-only. I don't see why a user would use "--negotiate-only", but
if this is a user journey we want to care about, then adding the
explicit check sounds ok.

> By the way, do not move the check about the number of negotiation
> tips from the original location.  That check, or its location, have
> nothing to do with what you want to do in this patch, which is "do
> not gc or update the graph file if we are not fetching".  It is
> better to leave unrelated changes out of the patch.

Ah, I see that it's not easy to tell whether or not the behavior is
correct after that line is moved. I'll avoid doing this in the future.

I still think that it is cleaner to move the negotiation_tip.nr check.
Should I do this in a follow-up patch?

> In order to tell if recurse_submodules that is not OFF came from the
> call to parse_options(), you may need to capture the value of the
> variable before calling parse_options() and compare it with the
> current value in the above illustration code snippet I gave.
>
> Having said all that, is it true that recurse-submodules should not
> be combined with negotiate-only?  I naively think it would not be
> surprising if users expect negotiate-only fetches are done also in
> the submodules.

In the current form of "--negotiate-only", no it does not make sense for
them to be combined. I think users would have the same expectations as
you if they were invoking "git fetch --negotiate-only" directly, but I'm
not convinced that that they will ever do so, except to debug push
negotiation.

I hope Jonathan can chime in to confirm whether or not users want/need
to invoke "--negotiate-only".

> Whatever we decide the right behaviour should be, we should document
> it. With your patch without any of my above input, I would expect at
> least something like
>
>     diff --git i/Documentation/fetch-options.txt w/Documentation/fetch-options.txt
>     index e967ff1874..baf2e9c50d 100644
>     --- i/Documentation/fetch-options.txt
>     +++ w/Documentation/fetch-options.txt
>     @@ -73,6 +73,9 @@ configuration variables documented in linkgit:git-config[1], and the
>      +
>      Internally this is used to implement the `push.negotiate` option, see
>      linkgit:git-config[1].
>     ++
>     +Note that this option silently makes various options that do not make
>     +sense to be used together with it (e.g. `--recurse-submodules`) ignored.
>      
>      --dry-run::
>             Show what would be done, without making any changes.
>
> to leave wiggling room for us to silently ignore more.  We may know
> about --recurse-submodules today, but I would not be surprised if we
> find more.

Sounds good.

>> @@ -2112,6 +2120,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  		result = fetch_multiple(&list, max_children);
>>  	}
>>  
>> +	string_list_clear(&list, 0);
>> +
>> +	/*
>> +	 * Skip irrelevant tasks because we know objects were not
>> +	 * fetched.
>> +	 *
>> +	 * NEEDSWORK: as a future optimization, we can return early
>> +	 * whenever objects were not fetched e.g. if we already have all
>> +	 * of them.
>> +	 */
>> +	if (negotiate_only)
>> +		return result;
>> +
>
> I find it somewhat misleading to have the early return before the
> block for recurse_submodules, as we _are_ already forcing it to not
> to recurse.  It would be more readable if it went before the place
> where we start doing the post-action clean-ups like reachability
> graphs and garbage collection.

Your feedback is valid, but I think it is true because negotiate_only
and recurse_submodules just happen to have a specifal interaction. As
indicated by the comments, this early return can apply to any situation
where objects were not fetched at all, but we only consider
negotiate_only right now.

This early return should also apply to submodules because if no new
objects were found in the superproject, all of the superproject commits
are referencing known submodule commits. If the submodule commits are
not known, they should be updated with "git submodule update", not "git
fetch".

>>  	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
>>  		struct strvec options = STRVEC_INIT;
>>  		int max_children = max_jobs;
>> @@ -2132,8 +2153,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  		strvec_clear(&options);
>>  	}
>>  
>> -	string_list_clear(&list, 0);
>> -
>
> Namely, here.

Hm, I realize that I could have used a goto instead of moving
string_list_clear()..

>
>>  	prepare_repo_settings(the_repository);
>
> This is existing code, but I wonder why it can be done _SO_ late in
> the sequence.  We've already called the transport API for the
> negotiate-only communication at this point, but a call to this
> function is the only thing that gives fetch_negotiation_algorithm
> member in the_repository its default value, isn't it?

That's right, this looks like it could be a bug. Maybe Jonathan knows
more.

[1] https://lore.kernel.org/git/kl6lwnk4to5x.fsf@chooglen-macbookpro.roam.corp.google.com
