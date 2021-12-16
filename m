Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C0C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 00:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhLPAho (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhLPAho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 19:37:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F4DC061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:37:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o13-20020a17090a4b4d00b001b11820de9eso947791pjl.3
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o+P7r7YKxxQTHnOXfH20BhZe4qqX9SAGp/5QbZlplis=;
        b=kQQP/lGzLymif157Jnr+i98nw2EYoG6HxjceJjYMq1dBkfB70Jrz8QX3beQeStf7+w
         tShj/7xyyEED8Pbr6KcsS33CpyuLHUoOQBxBrQ6FK73ygF8q8Y3ezlh+nsOeIWv2/BL1
         mGcH/w1GExEltdgGWWFvvgkWX+FXn7tQo1Q0ZAj52zD9xZMznTdq5NDCxzDZPGXpKFrz
         /8ZZoYU/ZPsVzCkXKSaGVM65VsxELHwqEWChS8sarmOiu/d/NerWTjqIlbjmyTccPmRp
         RfRx6Xh5FRAJSSYsFAVoUV2oXWkxVy8XkRvipAbPvOaw3w0my9Xpo0/omB/JAr7AznVH
         SxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o+P7r7YKxxQTHnOXfH20BhZe4qqX9SAGp/5QbZlplis=;
        b=FmlLEvkmvb3i147nMHAYiAMQpz1R4rmPFXxp/LGQYGRwQLVtivjy7xFnhmEdYbi1cm
         /D8dfTuDx1AqEfs4FvPANbwRtDjvKFOKW6F9+abiZKiFgGBPtlePbZ48munoRWGcpDgB
         sK4w91/M55yaijH/XPq30gtK7i3DR1x7kf3+KZgN+hI0+r3pRpg4iUau3BTqdxZlX95v
         NG4GcaQen4mUs6nj3uwe4zai/xWCi0VYfC1kd5x/I3RPN6BWMgsAjTdzY6bjhoVp+Nd0
         TGfoFaG8xmhkfbe84Ol/iKLA/C2IYmJV5S4MZx2vepws8W/SWEYHM9mYYg6xViwRRRPg
         F84A==
X-Gm-Message-State: AOAM533CTPQ4hWGBWogaBhyadKzHV5Dr+QJxRSGVc8rh5WOjBwKkj+fx
        Urncg1lLdT3VX7IBOQRi5cJDFHRN6FWrJg==
X-Google-Smtp-Source: ABdhPJxfeW+AQD+EC1k4t/TPZ6zJ2ZAP6R2nEIYm4FoENsb6uxe1v1IX5sjfgACDzfylOS4kXgCoFPZ2Sjrjhg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f54f:b0:148:a2e8:276c with SMTP
 id h15-20020a170902f54f00b00148a2e8276cmr6992761plf.115.1639615063276; Wed,
 15 Dec 2021 16:37:43 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:37:40 -0800
In-Reply-To: <xmqqsfutzaaq.fsf@gitster.g>
Message-Id: <kl6l35mtv0yz.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com> <xmqqsfutzaaq.fsf@gitster.g>
Subject: Re: [PATCH v6 0/3] branch: inherit tracking configs
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> Changes since V5:
>> * Greatly simplified BRANCH_CONFIG_VERBOSE output to not require nearly
>>   so many conditionals.
>> * Note that rebasing is not compatible with inheriting multiple upstream
>>   branches.
>> * Moved the change to case-sensitivity for branch.autosetupmerge to its
>>   own commit.
>> * Improve advice on failed tracking setup when multiple branches are
>>   involved.
>> * Make better use of string_list API.
>> * Make better use of config API.
>> * More straight-forward use of the `struct tracking` API.
>> * Numerous style fixes.
>
> I've queued this, and rebased Glen's "branch --recurse-submodules"
> on top, and parked both of them near the tip of 'seen'.  I do not
> have much confidence in the conflict resolution needed during the
> rebasing or the other branch or merges into 'seen', and I would
> appreciate it if you two can take a look to sanity check the result.
>
> Thanks.

I've just sent out a new version [1] which is rebased on top of Josh's
v6. Please use that version instead :)

I did not rebase this on top of 'seen' though; I'll take a look and see
if there's anything of concern.

[1] https://lore.kernel.org/git/20211216003213.99135-1-chooglen@google.com/,
