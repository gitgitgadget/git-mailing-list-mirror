Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D381C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 00:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhLUASe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 19:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhLUASe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 19:18:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216C1C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 16:18:34 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id w23-20020a17090a15d700b001b15a89e63fso486195pjd.3
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 16:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Pf17ISD7EEUd67oCoXD4p50ctBrTgo53fLKB02CoDk=;
        b=oifKv1ft9Ze1bb/YGPKvJug009qQCJZPJnpcBCqj/zVCISLjcEIZs3BOj1HaaE/9qi
         +SJzfqkocaRtyfGEl0C+lhjywL44I0NOM7Z4MnK8v2XN6nN55hdKs6yNEtDBVKqJfkmM
         SEz595Ozy45xNiidC3jo9KpsaRgV1UXCn3tqO6TZFaH49+f++IrKsAc74hNXmN2X1SKi
         RPTPKr+5F6jXMS34K7Q9zy9mAXjStUwT8adFi9nd+EEn15dIZ7Cxgbm3pgP4rLEUFj1V
         /lnOfj1p6TOWND4E0lu89t4tAzCeGjsyTuFXjUFSnK3FIgCMuh+rXWCyUypmglSWHOQx
         R4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Pf17ISD7EEUd67oCoXD4p50ctBrTgo53fLKB02CoDk=;
        b=tjQXbz3OGxSmz1/j5iQIAr7RD4lFJdMQUwq6myAOXzCRfSkf8xxjLsa6WQzy0AGhwn
         iRp8oPbcjcEAqiUKsQGbUWzvoSXJr9Vh8cIqCIiWbTi6Ze5BS4NB+guzenln/x2MHTSB
         cQX884k6DYzTpYNFUhj7L5kIKk/HfOM0DBe+CTDRmpjzSjvjVwUyuKPdmQsd1FtAIvpo
         ThxM/pe0pGlFYdsGCPs1Q31iNaH+7Z2v78kqYYY0gO04k7RonoxzI2jxPxJ1ZIZVZLgA
         dWSRvdg2QDFbgoAIyPAj3ond9ASyg9w/eELKihG9S+wCX70YS2jNmCa/8ZDFQz+HFMRi
         G+vg==
X-Gm-Message-State: AOAM531+YerO1zE9emEwAuiy3JWyHhnVAxTVccSzNQVBP4JXLoWwfhRQ
        X90BmWtxTvWEC+XpZq5ZgqcwQcSgpiZ4AA==
X-Google-Smtp-Source: ABdhPJyJjaf867PxuWnchXMnUO+9pJMwY2Y/YVd2JwOU8oRs38KEJp9cIE5zHlpNgDEVlMQ6MfVCyOzY92lDcw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3910:: with SMTP id
 ob16mr838189pjb.181.1640045913562; Mon, 20 Dec 2021 16:18:33 -0800 (PST)
Date:   Mon, 20 Dec 2021 16:18:31 -0800
In-Reply-To: <xmqqmtkvsz6y.fsf@gitster.g>
Message-Id: <kl6lee66zu7c.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211207192925.67680-1-chooglen@google.com> <20211217000235.68996-1-chooglen@google.com>
 <xmqqilvm24bb.fsf@gitster.g> <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq4k73vymp.fsf@gitster.g> <kl6lo85byp3b.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqmtkvsz6y.fsf@gitster.g>
Subject: Re: [PATCH v2] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> But maybe I am misunderstanding how Git treats CLI options in general?
>> We don't ever really hide CLI options, even if they are only
>> internal. There is PARSE_OPT_HIDDEN, but those still show up in usage
>> and documentation [1]. So we actually do want users to know about these
>> implementation details?
>
> At least they should be told not to use from the command line when
> they have no business triggering whatever feature these options
> trigger.  

Makes sense. I can add this to the docs if we think --negotiate-only
isn't meant for end users.

>> Presumably, the thought process goes something like this: if we add an
>> option, a user *could* find a use for it (or it might accidentally
>> conflict with a user's flags), even if we never intended it for end user
>> consumption. Thus we need to treat all CLI options with care.
>
> Rather, they can keep both halves ;-)

Hm, do you mean "both halves" as in, they should be able to choose
whether or not they want to use an internal option?
