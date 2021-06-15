Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F6C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F6F611CE
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFORrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFORrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:47:46 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982CAC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:45:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso15073704otl.13
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IdlO5vJHQqoIKJhvi5Mpa8c747kzXEaA6JipkSqa15g=;
        b=l5owA7gPL7bxxJaZiGrwD0YPTzibmBCVGjj3XMiKFv8Suw95b+sieGWOj0u0o5V8ye
         flXsNmhtcJR5m2oJNk4/Jb8mRzyneU+jcdum4Z1iO4d7RsHyavKNdbZX00VssraL0UQz
         j/amgTqXCIlOVx8sJRwKyDek+rtzOmc16kFHnzw+6b6f3tHXkiAYRth8oBZ2TOOxzAVk
         HYTwmtRuHuL8b37+EtgR1TjgBJR4f0ceOd/RjXIiy6AYqn6rU7KRV3Qqg39qgHBOMn+q
         v/9C+8qMWeU5XzP9z/pHWxgCFkDnjuAH9G4Gv1GN8s6imQ5xOww+H5M2xBK8qraLQnc4
         faqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IdlO5vJHQqoIKJhvi5Mpa8c747kzXEaA6JipkSqa15g=;
        b=SS3quy48KfJ32+A88d6xZ4Oh9QK2Pnwjg9Vr/tQJGCUXG/mLf8Fm9Hlf908du2FG40
         lgQZswPpYUsMFs0iuqJyoZwnD8nmyrx1n3xc9qTCkcaI3Jc1DyVRmWfKfqRv4TBurkBg
         kL8b6hfMeBgw0LVhT7eP1E0ih8nBF3Wwhwuvd+a80WYoQgqy1uahSQNtlWkOuVRXYMps
         xFTJ4YxDQXPuKuBU+9iajl763yarNZy1DJLxC+FnLfzXxcJ39wztCRDQs5TsBsRdXggY
         9gW6zibuv3J3+dAF3mbcOOBEiddYW+JK3YgqAI1ncXnTT8bUV/5Sa//oeLyIanCVNcGs
         0dHA==
X-Gm-Message-State: AOAM533C6lqSsmCqtTZa1AtL6DZeW+zPgwEEYEjKwgEJY3SdXicVU0Sm
        OeIqzOn+nACVIWMuiX4SftA=
X-Google-Smtp-Source: ABdhPJyL6CIrTUkUwiMtTQ6HiVgaJ93s46jEDAeXUQmEfj5eBredCkXwSjxPOhRc4tKZRh6udquoHA==
X-Received: by 2002:a9d:3e5:: with SMTP id f92mr333470otf.181.1623779139557;
        Tue, 15 Jun 2021 10:45:39 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b22sm3536348oov.31.2021.06.15.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:45:38 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:45:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Q2FybG8gTWFyY2VsbyBBcmVuYXMgQmVsw7Nu?= 
        <carenas@gmail.com>, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <60c8e7419b90c_12c282081a@natae.notmuch>
In-Reply-To: <8735tk22if.fsf@evledraar.gmail.com>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
 <60c715dd9939e_436208f3@natae.notmuch>
 <8735tk22if.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Mon, Jun 14 2021, Felipe Contreras wrote:
> =

> > Jeff King wrote:

> >> or even making things worse (as this patch did).
> >
> > I think breaking the test suite is objectively worse than having a fe=
w
> > extra files in the output directory, but to each his own.
> =

> We've got both in-tree and out-tree things that rely on e.g. the
> *.counts in that directory to have a 1=3D1 mapping with "real"
> tests. E.g. "make aggregate-results".

Yeah, that's not good, but I wouldn't call it "worse".

> >> I don't know if anybody still uses it these days, though. I suspect =
it's
> >> outlived its usefulness, in that we would typically not have any
> >> valgrind errors at all (so coalescing them is not that interesting).=

> >> =

> >> Possibly folks investigating leak-checking via valgrind could find i=
t
> >> useful, but even there I think LSan is a much better path forward.
> >
> > Yeah, but even if they do run this tool, they can set
> > TEST_OUTPUT_DIRECTORY manually.
> >
> > The needs of the few should not otweight needs of the many.
> =

> Do we need to bring Spock into this?:)

Hopefully not.

> I think the following alternate/on-top patch (which you should feel fre=
e
> to squash in with my SOB if you agree) solves the issue both of you are=

> noting.
> =

> It will barf if you run the tests under e.g. --tee with that environmen=
t
> variable, but that's intentional. It's better to loudly error if we
> don't have the expected test-results than to silently write in the wron=
g
> place.

I'm not sure how that patch was supposed to work:

  'err' is not empty, it contains:
  mkdir: cannot create directory '/dev/null': File exists
  /home/felipec/dev/git.git/git/t/test-lib.sh: line 1133: /dev/null.count=
s: Permission denied
  not ok 5 - pretend we have a fully passing test suite
 =

Does this assume the rest of the framework will be updated to properly
handle TEST_NO_RESULTS_OUTPUT?

Cheers.

-- =

Felipe Contreras=
