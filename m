Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582A6C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 00:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiLFAtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiLFAtk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 19:49:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8131B1CC
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 16:49:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z19-20020a056a001d9300b0056df4b6f421so11890921pfw.4
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 16:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rvfbL3jKNvJl4AdwB2nZe4MJuw+JQ5I6wk0q6xEUDQg=;
        b=Rtxr9L0UNj6E0MyL+8YVQjG8+8uu7/3Jld5yYg6BZEUholke9o50cbhYUGmyKCn/L3
         kzWfx46DXqAKXeGRuAwCKdVl335EHxksfsRBpKQW6CNNZEDQ/xKR+kBX5Dy7L2ZFEghQ
         uhW52f6m+8DWILs/VsEk4HZqqTOR07AEGuq4qHdU+GM49tXr/HbrnqZeZsO1337pJKFx
         FpHe5Jzja0l/kqrPmQWCXJsPfbxBV24v9s10F+JdBUQ7l47Nmn82HEmuuldeNAoVLAGg
         Ym58z1lWzov2fvqrOiq3M54vvg0YVUNeM32h2h4pu6/jHRSyAVSEt7Ts+iRZSx09Z4n+
         gdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvfbL3jKNvJl4AdwB2nZe4MJuw+JQ5I6wk0q6xEUDQg=;
        b=uvInyBnGNfDwYWqrdy7ghNCguqmmerjkALeauRibfhdnrdzk67EZvbm4PNZpLJ1ez8
         2V3EKL6y6qewYxB+0Y3IYpZ31c/dZF24OhUg78pcdzKue2CDw+3HH9oHaMDwb61lEEfu
         6Uf1/5ftYyE43MpQKVe3x3JJYCvf/c2wRDBSYrhQjO90A/Qt/knqQQcN+HsQpLKCfhIP
         1782Iibrv9Rcjw8smp3JvXEDbTfAUtTIbzOSB99loxsUJ3t6llslL2fSHZQzCzizQyIB
         xeC9T4ojBm2Dq3E4OtoOlkzlG5Pf60/sOuMt1T5YqAQ4fBcOPT89CGwp5f3/Hsh4lUv2
         fNZA==
X-Gm-Message-State: ANoB5plfGtBWSDh5VmvagKEB2oZzhMElDoWiGy/m4DuBzhsNtcT5r9YE
        DrSFA0Fl8pUE/+jwc0q9zGgKYb/5Q4vQ6UJxYgeG
X-Google-Smtp-Source: AA0mqf6T2LTjbV1X/2ST5MkjnAbshUjGWve92EtWq06Ye8uQ9+KJwZ/jW5TNWiG8hRYuPbU5Mr8B+8LpD1XqgDrHFowS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:d086:b0:219:227d:d91f with
 SMTP id k6-20020a17090ad08600b00219227dd91fmr4664263pju.0.1670287779158; Mon,
 05 Dec 2022 16:49:39 -0800 (PST)
Date:   Mon,  5 Dec 2022 16:49:34 -0800
In-Reply-To: <Y4lFbemK4HHiCsyJ@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206004935.1794596-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> Yeah, I don't see any difference in the new caller versus what the
> original was doing. The errno we care about comes from inside
> oid_object_info_extended(). So in any case, we'll see at least
> obj_read_unlock() followed by obj_read_lock() between the syscalls of
> interest and this check. And I don't even really see any indication that
> oid_object_info_extended() tries to set or preserve errno itself. The
> likely sequence is:
> 
>   - find_pack_entry() fails to find it; errno isn't set at all
>   - loose_object_info() tries to open it and probably gets ENOENT
>   - we check find_pack_entry() again after reprepare_packed_git()
>   - that fails so we return -1, barring submodule or partial clone
>     tricks
> 
> So it really seems like we're quite likely to get an errno from opening
> or mapping packs. Which implies the original suffers from the same
> issue, but we simply never triggered it meaningfully in a test.

Thanks for checking. I'm still not sure how the current code passes CI, but my
patches don't. 

> I'm not entirely sure on just removing the check. It comes from
> 3ba7a06552 (A loose object is not corrupt if it cannot be read due to
> EMFILE, 2010-10-28), so we'd lose what that commit is trying to do.
> Though I think even back then, I think it would have suffered from the
> same problems (minus the lock/unlock; I'm still unclear which syscall is
> the actual culprit here).

Ah, thanks for the pointer to that commit. Without that, my patch would report
corruption even if the real issue was EMFILE, as the commit message of that
commit describes.

> If we assume that errno from reading the object isn't reliable, I think
> you'd have to actually re-check things. Something like:
> 
>   if (find_pack_entry(...) || !stat_loose_object(...))
>     /* ok, it's not missing */
> 
> but of course we don't have the actual errno that _did_ cause us to
> fail, which makes the error message we'd print a lot less useful. Maybe
> this check should be ditched and we should complain much closer to the
> source of the problem:
> 
> diff --git a/object-file.c b/object-file.c
> index 26290554bb..743ba8210e 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1460,8 +1460,12 @@ static int loose_object_info(struct repository *r,
>  	}
>  
>  	map = map_loose_object(r, oid, &mapsize);
> -	if (!map)
> +	if (!map) {
> +		if (errno != ENOENT)
> +			error_errno("unable to open loose object %s",
> +				    oid_to_hex(oid));
>  		return -1;
> +	}
>  
>  	if (!oi->sizep)
>  		oi->sizep = &size_scratch;
> 
> That might make things more verbose for other code paths, but that kind
> of seems like a good thing. If you have an object file that we can't
> open, we probably _should_ be complaining loudly about it.
> 
> We may need to be a little more careful about preserving errno in
> map_loose_object_1(), though (gee, another place where the existing
> check could run into trouble).

Besides needing to be careful in map_loose_object_1(), I'm not sure if this
fully solves the problem. This is non-fatal, so the EMFILE commit's work would
still remain undone. If this were made fatal, I think this would change the
behavior of too much code, especially those that can tolerate loose objects
being missing.
 
What do you think of not putting any die_if_corrupt() calls in the commit
parsing code at all? The error message printed would then be different (just a
generic message about being unable to parse a commit, versus the specific one
here) but it does pass CI [1]. Also, I don't think that we should be doing errno
diagnostics separate from what causes the errno anyway.

[1] https://github.com/jonathantanmy/git/actions/runs/3624495729
