Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD154C433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A441422AAF
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439304AbgLLQBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgLLQBu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:01:50 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD78C0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:01:10 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 11so11250558oty.9
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8FSsC2XtE8yWIvnd6o0f1tuFy2dys2W15F5OoBSKC/I=;
        b=PWbAOfhKpjpvSG2m2IZJSrWUybGAXwrqL/3WEhoelEOIA05SjRT9+Jdd/QS9ImwnMD
         dprqgJL2BPSM4bqRVt+vnCr+6KR9cTcy5raiilopYwPcWTIgdEEKL8tUP8HENmTW2r0u
         IT0RzzC47LrMagFY09iZHU6wQFjA+C8QC8wRqy5369eFAZ6TvT5pMgohT50VCw/RtTju
         Cz59P5CjxQxs9A1zyaCf4r6r8BMqXoaayy8XVEwrtTN3rMxJ8S8KEukRyu2lAjMhJ6o1
         pSrZMf0IOO5ImjD/vB3EIthRVtubEF7sDls9Ppymb6H6Vcfgms6iKtOTmWhWbMCg2ndc
         C+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8FSsC2XtE8yWIvnd6o0f1tuFy2dys2W15F5OoBSKC/I=;
        b=tn5ZX95+q1kDPNWDXYxuLrPPaaywy+RvW0wbBFhytu7RS4liKLxDFnkk7k+S1O6WUM
         Ar1yh0VElFEhpsXeisHY1AEhsFl4fdTH7aa4Utopp+h37GrBFt68gpcCqaj4cgFjpWpX
         an8qVO4cFTtK7LlGD3CxfudpsVBIQf88cjJiO6dWLLRDXfYM7GcUVwUETe4yeMBKq/MP
         7CH2uPWQIK4c7B9TFIBM4Hwr0LIUb/1BG8ThNIp1dJGEknFl4VhSN6/HMGj25+EpYOy9
         UFTwzEa6AA2IYA62ZmTk16yn/txtTrIDSpYWa868iH5YSLASq/2gkluytA9CAhZyV2H2
         Pi/w==
X-Gm-Message-State: AOAM533+c4Xjf0ThqUHziDIko2VqCg+5NAkmi73FsM+OIiKvSzcFwNh8
        /CJ7fJwERcSmFeHLIyQQKEM=
X-Google-Smtp-Source: ABdhPJymasq5P1hqF703pGRna2adGGv+MF2ccBVoJNDqAVsM1w7My2m3JUxV64lH527BWQI4+Jc8og==
X-Received: by 2002:a9d:3b05:: with SMTP id z5mr14321295otb.138.1607788869339;
        Sat, 12 Dec 2020 08:01:09 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y8sm2477880oix.43.2020.12.12.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:01:08 -0800 (PST)
Date:   Sat, 12 Dec 2020 10:01:07 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Message-ID: <5fd4e94317d67_bc1eb208da@natae.notmuch>
In-Reply-To: <xmqq1rfvgtvx.fsf@gitster.c.googlers.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-4-felipe.contreras@gmail.com>
 <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
 <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com>
 <xmqqa6ujj3s4.fsf@gitster.c.googlers.com>
 <xmqq1rfvgtvx.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>  test_expect_success 'pull.rebase not set and --rebase given' '
> >> -	git reset --hard c0 &&
> >> +	git reset --hard c2 &&
> >>  	git pull --rebase . c1 2>err &&
> >>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
> >>  '
> >
> > This used to make sure an attempt to rebase c1 onto c0, which can be
> > fast-forwarded, would work fine, even though it used to give
> > warning.  We should keep testing the same condition.  The
> > expectation of seeing the warning is what must be changed, not the
> > test condition (i.e. rebasing c1 onto c2 instead of c0)---you are no
> > longer making sure that c1 can be rebased onto c0 cleanly.
> 
> Let's try to explain it in a different way.
> 
> The original author of this test cared that pulling c1 with --rebase
> into c0 succeeds, and that it does not give the error message.

I prefer not to attempt to read minds (plus, the author might have not
cared that the pulling succeeds), and anyway; that's not what matters.

What matters is the current situation, and the desired situation.

> We have no right [*1*] to say that scenario (i.e. "pull --rebase" c1
> into c0) no longer matters without a good justification.

But nobody is saying that. What I said is that in *this* particular
test-case that's not the objective of the test. And if you consider
hypothetical secondary objectives of the test, those are being tested
elsewhere.

> And it is not a good justification to say that the current code
> happens to behave identically whether running "pull --rebase" of c1
> into c0 or c2 so it is sufficient to test the operation into c2.  The
> test is *not* about how the current code happens to work.  It is to
> make sure the scenarios test authors care about will keep behaving the
> same way.

Again, I don't particularly care to mindread what the test authors might
have cared about.

It's clear from the tests themselves what they are trying to do: check
if the warning exists, or doesn't.

> Some tests may be expecting that pulling c1 into c0 would issue the
> message, and that the command succeeds, and with the patch 3/3 the
> outcome may become different, i.e. the command succeeds without
> annoying message.

No. All the tests (sans 1) check that the warning is *not* present.

If you do a fast-forward pull, the warning will not be present
(regardless of options), and the test would pass, but for the wrong
reasons.

> That would break the expectation of the original
> test authors, and it is a good thing.  By recording a change to the
> expectation, we can document how the new behaviour works better under
> the same scenario.

No, the expectation has not changed one iota; it's exactly same.

It's the reason for the same output that changed.

If I take the current tests, and I remove the thing that makes them
special (arguments and/or configuration), essentially making them all
"git pull":

@@ -35,52 +35,49 @@ test_expect_success 'pull.rebase not set' '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
-	test_config pull.ff true &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c0 &&
-	test_config pull.ff false &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
 	git reset --hard c0 &&
-	test_config pull.ff only &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c0 &&
-	git pull --rebase . c1 2>err &&
+	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
 	git reset --hard c0 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c0 &&
-	git pull --ff . c1 2>err &&
+	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
 	git reset --hard c0 &&
-	git pull --no-ff . c1 2>err &&
+	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c0 &&
-	git pull --ff-only . c1 2>err &&
+	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
What happens?

ok 3 - pull.rebase not set and pull.ff=true
ok 4 - pull.rebase not set and pull.ff=false
ok 5 - pull.rebase not set and pull.ff=only
ok 6 - pull.rebase not set and --rebase given
ok 7 - pull.rebase not set and --no-rebase given
ok 8 - pull.rebase not set and --ff given
ok 9 - pull.rebase not set and --no-ff given
ok 10 - pull.rebase not set and --ff-only given

They all pass. What are they supposed to be testing now? I don't know.

In my opinion they are no-ops now, but fine; I'll leave them as is.

Cheers.

-- 
Felipe Contreras
