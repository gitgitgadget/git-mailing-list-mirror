Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F69C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19B023E25
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393832AbgLJUsX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Dec 2020 15:48:23 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39406 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393767AbgLJUsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 15:48:23 -0500
Received: by mail-ej1-f65.google.com with SMTP id n26so9275936eju.6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 12:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3c69NqQFDyoQVM84qP3Wu1dKuDWMyqXfnldJn1OpvdE=;
        b=Ytn1JshUyjyBVgaWlwhg5Ox2+V4oQJMyHzybak6GTGQGSMQT9hzgQNHrH9nlLUhQfG
         Zs64JwTgUPteYujCn2apMTOwt4DD1wrQxuOUTJrsyvc4q1XtWPaf6pbDXINuAYerpnz+
         ugCuUSmhsUouWI40UI/JASreM3L0xyjY5wwrk2Iq4ufzifRgnEFb3MG6gf6m95JV3/nW
         4idThhwv72Q5yaWTnLMGPpFAPmh8eip43i2waQnhh/Y7ijydaQWjkzAqnIveSr6cQsa1
         E9TDFOnDH3VEfO2wRwcqgMFPtM8JUXTfh3S4ouh0zi9ee04G3kAFEYEtzuR4AiL3q22U
         DDdw==
X-Gm-Message-State: AOAM531zdX6zlBHAk2RbBoNWQJX/3dGy0U5wA2JY/bwRhTUwFqWmPjys
        YQcTw7nCQ42XiYWHTSXnMhqdx6hvsrcBjPe0JnQ=
X-Google-Smtp-Source: ABdhPJwscoPRCmwe9Y4+OuwXVHTCv+ZODYSS1rWIvqWM9I6WI2LNKAM/djhQ1/yY9nNhuH3Cqxv3l4peIgQ2s9wdD+o=
X-Received: by 2002:a17:906:c289:: with SMTP id r9mr7803575ejz.311.1607633261471;
 Thu, 10 Dec 2020 12:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20201210125321.19456-1-avarab@gmail.com> <20201210125321.19456-2-avarab@gmail.com>
 <CAPig+cQpB3B+Ywc1aFd7QMrqVKy29VmNKJfzcFeSCYz=mwO0Hw@mail.gmail.com> <87sg8dwglk.fsf@evledraar.gmail.com>
In-Reply-To: <87sg8dwglk.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Dec 2020 15:47:30 -0500
Message-ID: <CAPig+cSph9EcnGDUBjWsvR3yfbydK=mOMPmCEas=YC6bUJS=zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: warn on non-pseudoref looking .git/<file> refs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 3:29 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Dec 10 2020, Eric Sunshine wrote:
> > On Thu, Dec 10, 2020 at 7:55 AM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> +       GIT_TEST_GETTEXT_POISON=false grep "like a pseudoref" err &&
> >
> > What is the purpose of assigning GIT_TEST_GETTEXT_POISON here?
>
> Since 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
> 2018-11-08) we haven't needed to use the C_LOCALE_OUTPUT prerequisite
> for any new code, since we can just turn the poisoning off.
>
> I think we should just slowly refactor things away from that
> prerequisite and test_i18ngrep, which were only needed because it used
> to be a compile-time switch, but I haven't gotter around to that
> refactoring.
>
> In liue of that I think it makes more sense to always run the full test
> if possible, no matter what the GIT_TEST_* mode is.

I must be missing something. I've looked at 6cdccfce1e0 but I still
don't see how or why `GIT_TEST_GETTEXT_POISON=false` could affect the
simple `grep` invocation being done by this test. I could understand
if GIT_TEST_GETTEXT_POISON was applied to the invocation of a Git
command, but that's not the case here.

(I also notice that 6cdccfce1e0 only checks whether
GIT_TEST_GETTEXT_POISON is empty or not -- and the changes in
6cdccfce1e0 set GIT_TEST_GETTEXT_POISON to an empty value rather than
to "false", so I find myself doubly confused by this application of
GIT_TEST_GETTEXT_POISON to `grep`.)
