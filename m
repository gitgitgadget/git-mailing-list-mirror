Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB164C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF35961178
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhIURfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhIURfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 13:35:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0D1C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:33:43 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bj32-20020a05620a192000b00433162e24d3so105023103qkb.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y9SsUy3bdjeQDVwnipVDt74dD99hjkZ3u2yWgK3GUsI=;
        b=KqwLKmpmFeD1NBi6iExbs1/iRIax6nggL8pCd27xyAY22n1CFY4uEzT3DIaXnhziPm
         CFnctclw3VwsuF5gSggy5POHXLHMeBDkOBdoxmJoCNcKRul+rgNTtWGeXhO+uM3Ef/8r
         mfTjbE8juxALe3cGfnb1I6BW3O3s/DB/h/xXJ/66ZmojRMrReDs/DEtUBIGsO8chpKEC
         LB4tPmyhdKNNnvOjGufOs3z5+t0fLY3SJwyca0JmfCexxBiqR7hA93CObzDuJGs1ZdaX
         vBhzjDm/1DXWdSqy6bg1P6nfOSFrcWoDTQwLYT7pqaACKH8/se+8eUvovTlJGNgxzmz4
         KRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y9SsUy3bdjeQDVwnipVDt74dD99hjkZ3u2yWgK3GUsI=;
        b=UP5o0FRrUz2+1UQYEIU51jteLzXKqYXabxTEd+SIndooVyjQx7AP74MfNsyZ0Xc/cq
         mPKB7+I9EXpOy6jZjHDTYrbCFGLaGnl3A6OTgV15Dy85Y/I3aJaSVzkXYfP48HGrU3w7
         8skjVGHem67+uabD4h1wlKTnfhuARZ2t4DBfHRIFSfxOLLRVQsNZjMMwx1N6G/w2ah79
         4bjceiMMSxXjjBZ1WdnhJ04jDJ+9S1d7P1rFEgR0QdEKTgqv4MZM+UZbnV7/leHPwvki
         1R1pxtCtHa+BnQzI/u7Hb0J+E3MrJVqWR8CFmjBAYu2QjY407MmkVYlM5mYVRDwIxoiK
         u3vw==
X-Gm-Message-State: AOAM533ZxCIPLoKt8eqdpwNQz3o0Koy1mivRXf7eeD21d4EMOGaZKvCX
        5HDNbIyyHpMj9AA7g5AxE3Z6uaywdSrhrA==
X-Google-Smtp-Source: ABdhPJwXgnXJM7ZHppvmQrsO6MyQeUUvhOCwsSkSPPbaG67FPuOT6D5jA2UZ5vz+mFmlOWdqStwanoBSeCkmHg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6214:1331:: with SMTP id
 c17mr15192958qvv.56.1632245622647; Tue, 21 Sep 2021 10:33:42 -0700 (PDT)
Date:   Tue, 21 Sep 2021 10:33:39 -0700
In-Reply-To: <CAPig+cR8ZRGVrNsf6nbBsjuLt768fr=SB+bY_bD+tQpkzrL7FA@mail.gmail.com>
Message-Id: <kl6l1r5hn898.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com> <20210920223226.25877-1-chooglen@google.com>
 <CAPig+cR8ZRGVrNsf6nbBsjuLt768fr=SB+bY_bD+tQpkzrL7FA@mail.gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
From:   Glen Choo <chooglen@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +Make your changes with `git rebase -i`. Once you're ready with the next
>> +iteration of your patch, the process is fairly similar to before. Generate your
>> +patches again, but with some new flags:
>
> I wonder if "Make your changes with `git rebase -i`" is a bit too
> terse for newcomers to understand. Perhaps a bit more verbose:
>
>     Refine your patch series by using `git rebase -i` to adjust
>     commits based upon reviewer comments. Once the patch series is
>     ready for submission, generate your patches again, but with some
>     new flags:
>
I like your wording :) It seems "obvious" that one should incorporate
reviewer comments, but your phrasing makes it that much clearer.

>> +The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
>> +range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
>> +helps tell reviewers about the differences between your v1 and v2 patches.
>
> This leaves dangling the question of where the range-diff is placed. Maybe say:
>
>     ... tells `format-patch` to include a range-diff between ... in
>     the cover letter.
>
Sounds good.

>> +The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
>> +you may notice that your v2 patches, are all named like
>> +`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
>> +prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
>> +be prefaced with "Range-diff against v1".
>
> s/V2/v2/
Thanks!

>> +Afer you run this command, `format-patch` will output the patches to the `psuh/`
>> +directory, alongside the v1 patches. Using a single directory makes it easy to
>> +refer to the old v1 patches while proofreading the v2 patches, but you will need
>> +to be careful to send out only the v2 patches. We will use a pattern like
>> +"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).
>
> To avoid any sort of confusion, perhaps:
>
>     ... "psuh/v2-*.patch" (not "psuh/*.patch" which would match v1 and
>     v2 patches)
Agree that making this explicit is a good idea.
