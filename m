Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9629C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F8B20936
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb/bz6Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbgIHQ73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbgIHQ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:59:08 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC8C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 09:59:07 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so12464345qtj.7
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uOiGHLvVh8hBSYY430PUHPkmy89ulENKOj1WKtcFkxE=;
        b=kb/bz6QfyYxV9DwVmYE7+FDG18D5Xa6hSLV2bnmyw8yZnJIGWqDFJsmGjljHDf6fU/
         4tRtfEkrIOm37RCuor9h6UcyG3TajgYXv5G3xT1X1zKgvFoVwJ0LueJs3ISrrDzqWGFm
         7nGfEGCUbrqe/7B3IIRBbq8UeFGYD4a4xz3WmPId/ywapQt6Duq1UvUCmRVyLYyGqq3Z
         2QMHpnXIp0zcYqUx/yyTe/3+eDGRYp4m8MFV4+ZR/PKcS5WIWfIfntZv4yMHrhfkqLNE
         qEu2qMto7mC955KNpeN23TfsMhCi6JwQlmYtFpYAaebdF79jv99tafny9WEEpLllMezc
         kYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uOiGHLvVh8hBSYY430PUHPkmy89ulENKOj1WKtcFkxE=;
        b=f4SQKsf9+xZfqtaekLZ9ztkTFiV/k17RSw28zb7lHh3bp+6UOTiqdy22HReONRFFhk
         JTPJXeGBUxOAjwPDB0w3IQY2G4DCmG7sfR+VTInIxCmEHw4441P9yBBPX73SKTDNQNr3
         h+nqzIEvoE//Ej3gWkO5h5YU5uLjnM/K+jSRNbGbtQ8E07xPuA+xxmqnW0DAzoJbfAwu
         oJK7ineMNKIypbci71XUNMUbfgvylYHeLucZNg6l41EjI9/VS40T1/4k8VSTYS3mT5lm
         xgba7aYA+zMwq79eCjW7nfh+WbtCuk6rQ1TNJFn7MrvW6122ysAtjMIsWrp/Ffoz6IF2
         LL2Q==
X-Gm-Message-State: AOAM532MX3LKT5om+b7F2EacNQ7U+ZX7D2xaTkvOZ5gOIUhUV3ocEljh
        ZDpUPgR9ja4EMkh71WLiMeepk6B+5dxuVg==
X-Google-Smtp-Source: ABdhPJzw55KesNxtbGFVthJJJGL1CqROG8SxC/H8uSfKF21MaTQOqDzrX4LYA12yk6e6aqwkX/nwwA==
X-Received: by 2002:ac8:7b2c:: with SMTP id l12mr1019064qtu.98.1599584346947;
        Tue, 08 Sep 2020 09:59:06 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.105.42])
        by smtp.gmail.com with ESMTPSA id b43sm15481086qtk.84.2020.09.08.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:59:06 -0700 (PDT)
Date:   Tue, 8 Sep 2020 22:29:00 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
Message-ID: <20200908165900.GC40807@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 09/07/2020 21:45, Johannes Schindelin wrote:
>> [...]
> First of all: thank you for picking this up! The contribution is
> pleasantly well-written, thank you also for that.

Thank you for the kind words.

> Now, to be honest, I thought that this mode would merit a new option
> rather than piggy-backing on top of `--force-with-lease`. The reason is
> that `--force-with-lease` targets a slightly different use case than mine:
> it makes sure that we do not overwrite remote refs unless we already had a
> chance to inspect them.
>
> In contrast, my workflow uses `git pull --rebase` in two or more separate
> worktrees, e.g. when developing a patch on two different Operating
> Systems, I frequently forget to pull (to my public repository) on one
> side, and I want to avoid force-pushing in that case, even if VS Code (or
> I, via `git remote update`) fetched the ref (but failing to rebase the
> local branch on top of it).
>
> However, in other scenarios I very much do _not_ want to incorporate the
> remote ref. For example, I often fetch
> https://github.com/git-for-windows/git.wiki.git to check for the
> occasional bogus change. Whenever I see such a bogus change, and it is at
> the tip of the branch, I want to force-push _without_ incorporating the
> bogus change into the local branch, yet I _do_ want to use
> `--force-with-lease` because an independent change could have come in via
> the Wiki in the meantime.

I realize that this new check would not be helpful if we deliberately
choose not to include an unwanted change from the updated remote's tip.
In that case, we would have to use `--force` make it work, and that
defeats the use of `--force-with-lease`.

> So I think that the original `--force-with-lease` and the mode you
> implemented target subtly different use cases that are both valid, and
> therefore I would like to request a separate option for the latter.

OK. So, I am assuming that you are suggesting to add a new function that
is separate from `apply_push_cas()` and run the check on each of the
remote refs. Would that be correct?

If that's the case, how does it work along with `--force-with-lease`?
On one hand we have `--force-with-lease` to ensure we rewrite the remote
that we have _already_ seen, and on the other, a new option that checks
reflog of the local branch to see if it is missing any updates from the
remote that may have happened in the meantime. If we pass both of them
for `push` and if the former doesn't complain, and the latter check
fails, should the `push` still go through?

I feel that this check included with `--force-with-lease` only when
the `use_tracking` or `use_tracking_for_rest` options are enabled
would give a heads-up the the user about the background fetch. If
they decide that they don't need new updates, then supplying the
new "<expect>" value in the next push would imply they've seen the
new update, and choose to overwrite it anyway. The check would not
run in this case. But again, I wonder if the this "two-step" process
makes `push` cumbersome.

> However, I have to admit that I could not think of a good name for that
> option. "Implicit fetch" seems a bit too vague here, because the local
> branch was not fetched, and certainly not implicitly, yet the logic
> revolves around the local branch having been rebased to the
> remote-tracking ref at some stage.

The message "implicit fetch" was in context of the remote ref. But yes,
the current reject reason is not clear and implies that local branch
was fetched, which isn't the case.

> Even if we went with the config option to modify `--force-with-lease`'s
> behavior, I would recommend separating out the `feature.experimental`
> changes into their own patch, so that they can be reverted easily in case
> the experimental feature is made the default.

Good idea!

> A couple more comments:
>
>> @@ -1471,16 +1489,21 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>>                * If the remote ref has moved and is now different
>>                * from what we expect, reject any push.
>>                *
>> -              * It also is an error if the user told us to check
>> -              * with the remote-tracking branch to find the value
>> -              * to expect, but we did not have such a tracking
>> -              * branch.
>> +              * It also is an error if the user told us to check with the
>> +              * remote-tracking branch to find the value to expect, but we
>> +              * did not have such a tracking branch, or we have one that
>> +              * has new changes.
>
> If I were you, I would try to keep the original formatting, so that it
> becomes more obvious that the part ", or we have [...]" was appended.

Alright, I will append the new comment in a new line instead.

>
>>               if (ref->expect_old_sha1) {
>>                       if (!oideq(&ref->old_oid, &ref->old_oid_expect))
>>                               reject_reason = REF_STATUS_REJECT_STALE;
>> +                     else if (reject_implicit_fetch() && ref->implicit_fetch)
>> +                             reject_reason = REF_STATUS_REJECT_IMPLICIT_FETCH;
>>                       else
>> -                             /* If the ref isn't stale then force the update. */
>> +                             /*
>> +                              * If the ref isn't stale, or there was no
>
> Should this "or" not be an "and" instead?

D'oh, you are right. It should have been an "and".

>
>> +                              * implicit fetch, force the update.
>> +                              */
>>                               force_ref_update = 1;
>>               }
>> [...]
>>  static void apply_cas(struct push_cas_option *cas,
>>                     struct remote *remote,
>>                     struct ref *ref)
>>  {
>> -     int i;
>> +     int i, do_reflog_check = 0;
>> +     struct object_id oid;
>> +     struct ref *local_ref = get_local_ref(ref->name);
>>
>>       /* Find an explicit --<option>=<name>[:<value>] entry */
>>       for (i = 0; i < cas->nr; i++) {
>>               struct push_cas *entry = &cas->entry[i];
>>               if (!refname_match(entry->refname, ref->name))
>>                       continue;
>> +
>>               ref->expect_old_sha1 = 1;
>>               if (!entry->use_tracking)
>>                       oidcpy(&ref->old_oid_expect, &entry->expect);
>>               else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>>                       oidclr(&ref->old_oid_expect);
>> -             return;
>> +             else
>> +                     do_reflog_check = 1;
>> +
>> +             goto reflog_check;
>
> Hmm. I do not condemn `goto` statements in general, but this one makes the
> flow harder to follow. I would prefer something like this:
>
> -- snip --
>               else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>                       oidclr(&ref->old_oid_expect);
> +             else if (local_ref && !read_ref(local_ref->name, &oid))
> +                     ref->implicit_fetch =
> +                             !remote_ref_in_reflog(&ref->old_oid, &oid,
> +                                                   local_ref->name);
>               return;
> -- snap --

Adding this condition looks cleaner instead of the `goto`. A similar
suggestion was made in the other thread [1] as well; this will be
addressed in v2.

> Again, thank you so much for working on this!

Thanks again, for taking the time to review this.

[1]: https://public-inbox.org/git/624d9e35-29b8-4012-a3d6-e9b00a9e4485@gmail.com/
--
Srinidhi Kaushik
