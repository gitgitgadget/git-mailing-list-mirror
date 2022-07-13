Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2386EC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 22:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiGMWlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 18:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiGMWls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 18:41:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7B44E602
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 15:41:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 134-20020a63018c000000b0040cf04213a1so5901969pgb.6
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7XQKQj2nf7GUR7EN3cT09PET8gsi+4kR7kNGlWZ1AOg=;
        b=pvosBI3S6dJerW4XHPfnUmfYIqKTZVPUJL2VKcHdiSzchyUbjNnQz65XfZJoUj37e5
         E3nFKsVmjINGT/U6izsMrs1dOuabR4V3ZUvxFab7xq5g9xgYKxTkcMBCRRmQr8TOUCjX
         Du5F9DlgW/4V7DoEZ60EvDZ6lIu4qIZR3jmk8mvG5TG8Z1OQN5JmxOQpuKQ2i0RhR7wy
         Q4k2x38rdXwjxBarPqhf3Aq+WvECZDoGpGBurouMZ3kUZ/PKzvk8N3L7/Q5PUSJP9HdX
         aVXYpfM0MR+IQgphB5WN8+vsaRZUNFlCme/RvehtXEep8OAoiXztYp2OEB2N78Bcp+9w
         H+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7XQKQj2nf7GUR7EN3cT09PET8gsi+4kR7kNGlWZ1AOg=;
        b=X2KPbF8eju6rR5fpKcZOPwMucuCrZhCTGWBP2KuI703csd9GT6AAuzIHlBmyEvC8Nb
         3+rO0V5x5XmsrZd8cK5E5AZv5bDBmz1o/GluMfMIc2ijEr2qhhNEshqxTqMLzHvPxF1w
         ic1EOYwVoVUso5r+bH/Dd5f5v4VXoWMkqXAXw7QYwlVFmaf4S0n0UqkD7foz6LayKQP0
         Lw6GnpmDHZ44e7c0TQr1oTavVLyKohqlc7YPpZQBJk0XZQkvGO7tpX3h5mKhAK94wvUF
         u3/3QYyrYwGUqMKxxtWj10ccgI9Jn7x7nbQpJY98wqJZYLeCGYSnb9n4KLfwMvZb6jqK
         9xPw==
X-Gm-Message-State: AJIora8v/HCYZzmwhQh+WOMrp9g7EhmXGYjNh0fOf7/9QyfvTtS+Ghbv
        rt8d4Ys/J/hrUfeLhL1Sa8rEEMCo7GjFZg==
X-Google-Smtp-Source: AGRyM1vRrkixsg0MU01uiYa/aPDHT5avzzGDL8I1J8PwGfSQdquXnMPr+RqYM2D5BPQIB2quUnockGd1024lQw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:da92:b0:16b:ecee:28a8 with SMTP
 id j18-20020a170902da9200b0016becee28a8mr5202476plx.71.1657752106645; Wed, 13
 Jul 2022 15:41:46 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:41:44 -0700
In-Reply-To: <xmqqy1wwaey8.fsf@gitster.g>
Message-Id: <kl6lbkts63fb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
 <kl6lfsj4684n.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqy1wwaey8.fsf@gitster.g>
Subject: Re: [PATCH 02/11] submodule--helper: replace memset() with { 0 }-initialization
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Ok. I wonder if we could reduce this kind of churn in the future by
>> adding this to CodingGuidelines, e.g. "always use { 0 } for stack
>> variables". Tangentially, do we require { NULL } when the first element
>> is a pointer? (I'm not sure because this isn't in CodingGuidelines
>> either AFAICT.)
>
> A valiable can legitimately be left uninitialized, or initialized to
> a known value that is not zero using designated initializers.  So
> saying something like
>
>     When zero-initializing an auto variable that is a struct or
>     union in its definition, use "{ 0 }", whether the first member
>     in the struct is of a number, a pointer, or a compound type.
>
> may be OK.  I do not think we would want to say "always use X", as
> the world is not that simple..

Thanks. Also, I made a typo here, I meant to be more specific with
regards to memset(), like:

  When zero-initializing an auto variable that is a struct or
  union in its definition, use "{ 0 }", whether the first member
  in the struct is of a number, a pointer, or a compound type. _Do not
  use memset()._

Unless there really is a legitimate reason to use memset(&my_auto_var, 0
sizeof(my_autovar)) that I've missed?

> We do favor designated initializers over traditional initialization
> in the order of members these days, so something like
>
>     When declaring a struct/union variable or an array with initial
>     value to some members or elements, consider using designated
>     initializers, instead of listing the values in the order of
>     members in the definition of the struct.
>
> would also be good.

Thanks. If I have time I'll send that proposal to CodingGuidelines, or
someone else can send it (I don't mind either way).
