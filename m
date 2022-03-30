Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1EAC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 23:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbiC3XbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 19:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347974AbiC3XbG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 19:31:06 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F427B28
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 16:29:19 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y26-20020aa793da000000b004fb7c6f5d10so4495029pff.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7eO3uKMzwRTndWHWDRsFFmU1N91Q4jhfJcxgOZY6M88=;
        b=qRk9C97uFotFGdEOlj6tFppUw7Qp7yaNy6nRUTM+7/wgM8KxHMRoehAE7bzL5vnBV2
         ouFsqmzM47raKI/BeMx5h/1ZrQy+mOR/6kao4M4FaZr+b2TtrjW7FsIOAB6jhoMFobvo
         /HoSIbfHgXzYjoFnAKahHq1fgkGRxn8UzBP6Aefn6rB3C9KFklLdJuEagbItn7tX69Ri
         qr49l3sUX3wcsfxiQ/8eqA0BGgLc/4ZfszaBGB6Fu2Vwin1+UJSazLWsRCxsxqtbDFQg
         2aaHsNES/SSOUqFZvBe/jUSb+bH/qgP9Mzymb/Ek/jt8Bu+A4VXl/HJdIDPvT41bbUtA
         mYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7eO3uKMzwRTndWHWDRsFFmU1N91Q4jhfJcxgOZY6M88=;
        b=gQB6Fh4rAoG1IRJ/mI2yxL6ddZ8IwyLemGk7XWw7o7pjZMbDSUachD6p01dmje2w/0
         paSp7XP1lIkarFcz2EFcWHEEpBk7P9ivMzgGBhOJFX6EBYJzKpKr8NUH86bUmd/OL6C4
         B6N2bhtZ5xBee6w+I1coutwwtAsr+Aoh/YB0Fz7ZhgRvuIqWFhf8mDyd1PsD6v+jopZV
         uhM4Du/m3mCABcIrIwmZWzT2E4rQnTVayqHQQ/TLcQu0cIfaUeAntZZ/eUcwGm4shVn+
         YlrFU70BFjgIuHKspsJnj3K1CLodCo3FEmeA34FSi/DSqzFeBEsjEejK+KTzuwIKUmea
         KI8A==
X-Gm-Message-State: AOAM532y2LuWoD61hUmJnuBRu3hwuVBaETdBjZBPZWsVRnZUOgfZVIri
        VADcvCYhdwJpXgwyLni6LKmZQcPtfj2pTg==
X-Google-Smtp-Source: ABdhPJxyrbo/vyeIOeGBvmGH+WcWMZhs6OuDSazKrDFMd6f9N5OLBfDzO1i2mF2X7Fc8NNvyg+EuTUuwOfGitQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:8d85:b0:1b8:a215:e3e4 with SMTP
 id d5-20020a17090a8d8500b001b8a215e3e4mr2463663pjo.175.1648682959388; Wed, 30
 Mar 2022 16:29:19 -0700 (PDT)
Date:   Wed, 30 Mar 2022 16:29:08 -0700
In-Reply-To: <xmqqee2j6t5l.fsf@gitster.g>
Message-Id: <kl6l4k3ft3y3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
 <0b682c173c8cfa7f49ba17b2d71049ac702ec747.1648584079.git.gitgitgadget@gmail.com>
 <xmqqee2j6t5l.fsf@gitster.g>
Subject: Re: [PATCH 1/4] branch: support more tracking modes when recursing
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/branch.c b/branch.c
>> index 6b31df539a5..7377b9f451a 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -233,6 +233,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>>  	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>>  
>> +	if (!track)
>> +		BUG("asked to set up tracking, but tracking is disallowed");
>
> I am wondering if this wants to be
>
> 	if (track == BRANCH_TRACK_NEVER)
>
> instead.  Do we elsewhere rely on the fact that NEVER is assigned 0?

As you discussed here...

> Given that we started simple and then gradually added more features,
> I would not be surprised if the older code written back when there
> were only 0 (no track) and 1 (track) assumed 0 means no.  There is
> one in create_branch() where we do
>
> 	if (real_ref && track)
> 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
>
> which also relies on the fact that NEVER is 0.

We know the answer is "yes there is older code that relies on NEVER
being 0". I believe this is the only instance though, which means this
patch comprises the majority of instances of "if (!track)", so we can
change it if you prefer. The older code is pretty old after all - the
enum was introduced in 9ed36cfa35 (branch: optionally setup
branch.*.merge from upstream local branches, 2008-02-19).

>> +	case BRANCH_TRACK_UNSPECIFIED:
>> +		/* Default for "git checkout". No need to pass --track. */
>> +	case BRANCH_TRACK_REMOTE:
>> +		/* Default for "git branch". No need to pass --track. */
>> +		break;
>
> Is that "no need to pass", or "no need to, and it will be detrimental to, pass"?
>
> IOW, if we are relying on the command spawned via start_command()
> interface to read and honor the configured default for themselves,
> then passing explicit --track=whatever from this caller will be not
> just necessary but is wrong, right?  I am worried about "No need to"
> tempting "helpful" developers into doing unnecessary things, just to
> be more explicit, for example. 

Hm, interesting, I hadn't considered that temptation. This is the
latter, i.e. it is not correct to pass --track. I'll reword it for
clarity, something like "Should not pass --track".

>> -		OPT_SET_INT('t', "track", &track,
>> -			    N_("set up tracking mode (see git-pull(1))"),
>> -			    BRANCH_TRACK_EXPLICIT),
>> +		OPT_CALLBACK_F('t', "track",  &track, "(direct|inherit)",
>> +			N_("set branch tracking configuration"),
>> +			PARSE_OPT_OPTARG,
>> +			parse_opt_tracking_mode),
>
> Hmph, this is quite curious.  How did the whole thing even worked
> without this?
>
> Ah, OK, this is in submodule--helper.c and tracking specification in
> the top-level were OK.  Just that we forgot to correctly pass it
> down when calling down to submodules.  Makes sense.

Yes, that's correct. This was missed because I only added tests for
--track and the default case (and didn't add tests for --track=inherit
or --no-track.
