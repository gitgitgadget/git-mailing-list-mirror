Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B646C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E3860F24
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhIURcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhIURck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 13:32:40 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB567C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:31:11 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z6-20020a056214060600b0037a3f6bd9abso2167876qvw.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y9SsUy3bdjeQDVwnipVDt74dD99hjkZ3u2yWgK3GUsI=;
        b=cmllgpc99AgQWTzNQq7XqwTrhEnRXRONg+ROWdFfXA8hougvz9Vn+yvIsZDRJFDq9a
         01ewChAZraqIHvHwvgTJI2GpwMlls/XuCgpvoMVJiKGf8H/GCIbNQP46UOfd633wlq9L
         K5WO0uXwD21m85S4J8vFOiBLX7DdA4XyG3jP+8/i83ZcVMP+4SgDWifxxlMnjpPzt31s
         n2PfcCFZOEIBzCwixmaWOb6luaPLV4CxtQgjAEcyimdiC/E9n8GzJDkvc3OLc1+fvtqp
         0eXf2BhU1At0keIjq6zhEMFUH5x5VFNaoOVKWLnK8UfrR8rI4Tp1wjNuyQlLBo10V/4Y
         dNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y9SsUy3bdjeQDVwnipVDt74dD99hjkZ3u2yWgK3GUsI=;
        b=WKWZdGhtXdP8RAoARaExWpfxx6pRmfTOjYBgbrfld9R9bEx9m4aFaYqg0XRJBIQm/B
         P+OZCY5fu6kya52YhbFzaagP5P2hlDJucxL8mIsV4dt422o6EICJ99DRVxV6XNg81AIV
         QdRUbBZ0WLLs/yQTMzIuk1IKXWzi0Qk2haJP5fhplZCgivBI9iBHXtmms3RwSyzfa6Uj
         4z5IT5jBF01gA4Wu0ejgT8XVoUl/02FHtGYEXjHiw4FWurQjj5L2Hf4g4flxsx6Mpw14
         9TlkA9K2iL7Z46IpqunsU9nDrgBx/X3i+CZqh49OMzOruz74OeniPzv3qb+YLcrda9uk
         Oz1A==
X-Gm-Message-State: AOAM531ELyfCsu4kTgUHPk5SKfO9iu4b7kkd4NPI1axctNgP75RFuHuv
        b3ESjIXOF0N7HxwfuzKp9zEfdRWxo/IM7w==
X-Google-Smtp-Source: ABdhPJw2T1xEujrVzxJGpifTC+MOL6ORiDykTfYNAKcJztMM6QX9m407yR4ajwA8gAhHBHZ97FuOyLjDn5ix5Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:216:: with SMTP id
 22mr41020794ybc.543.1632245471049; Tue, 21 Sep 2021 10:31:11 -0700 (PDT)
Date:   Tue, 21 Sep 2021 10:31:07 -0700
In-Reply-To: <CAPig+cR8ZRGVrNsf6nbBsjuLt768fr=SB+bY_bD+tQpkzrL7FA@mail.gmail.com>
Message-Id: <kl6l4kadn8dg.fsf@chooglen-macbookpro.roam.corp.google.com>
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
