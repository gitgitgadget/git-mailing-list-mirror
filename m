Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED0C74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 23:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCPXGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCPXF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 19:05:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D0E63CA
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:05:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so29942567b3.19
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679007953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpEWYR0U6+KOphq/e6myVhaUaaGED7h1FThsX06L5FU=;
        b=EU6craDHQhAwCgxuSgSjiy3cxi3TZ1t0yiBt7+bQbCsq+Xhqt+3PGBTGMHtrZumrJ3
         TNXJRH5zr1Qw1qVqLkssGrxIUNRwWbjEi97i27l0w5pNlc2uD03ys9dQK6WK57B0uqtA
         06J4SoL2dRQIX/jP5WLj+yFqy58qZUj/8IJR8Db4Sdx6I9fMrJxeFSmqtf2X9ctbGeqs
         L92nNZobhyRe30aRrC5G83m7LV/+0StD6wPlkwAK96T+ulV8W4UIikS+CEv01mcABV1t
         fdUKFd7BIlHIfOtCG9yVCmRyCIT6qYDE6TeMvRfzF/mdoixo+RfmJB1hxGmEgbhGf6Tw
         V6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpEWYR0U6+KOphq/e6myVhaUaaGED7h1FThsX06L5FU=;
        b=orjOEnd9s1wEUuBxhr7qIbo5CT7V5T68RFur7aBFO78xCdFBI5+ChMEbZzFvR91pVV
         8tM0C9/qB0ESAasU65tro2qwItVwEyVUPe7kKpNszWscXENSSlELBPg3XdjTU0Q6sZx0
         O5ZrRiOr2Wkmaeq9CyN2U5Gr1YutRcXYQOdIMHp5dN/UpGZQI25BKVCnnsZ+9wUhqxIt
         r/ZiRV/uT9oNI5kAp7PessdR89/g/HJ3YqR6aWf6PjG/1sXGN+q2oTzkPCuhh8lTE1Fj
         Vd/UWzGg82lL3S+7O1yTm6hPPC9mYtYbmLPwFCS1Sb6QGPl5roiX/7oX3EjPwYFVG8zu
         74rg==
X-Gm-Message-State: AO0yUKW1jC9NPb/AMZAwcFftp/yrYu0nA64FCnNJZ54iKIQjhvwzu6Dc
        6KKbxPVjThTfj+Fyx1SCSkEJVtTfQ2rukg==
X-Google-Smtp-Source: AK7set/waEssucKfl7uUs9Nvb6Ek3HMpKOThihSpQKBmpSVKdq51+Y/FH5GgjAOk0KXnWhDW1mpmTMPGQpE+8A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:208:b0:9fe:195a:ce0d with SMTP
 id j8-20020a056902020800b009fe195ace0dmr24292837ybs.10.1679007953392; Thu, 16
 Mar 2023 16:05:53 -0700 (PDT)
Date:   Thu, 16 Mar 2023 16:05:51 -0700
In-Reply-To: <20230316222200.320596-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230316222200.320596-1-jonathantanmy@google.com>
Message-ID: <kl6lmt4cuwj4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 7/8] config: report cached filenames in die_bad_number()
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>>                                Refactoring is needed because "git config
>> --get[-regexp] --type=int" parses the int value _after_ parsing the
>> config file, which will run into the BUG().
>
> You say "fix this", but are there actually 2 bugs (so, "fix these")?
> Firstly, that BUG() is run into when invoking "git config" the way
> you describe, and secondly, die_bad_number() only reading cf and not
> checking kvi to see if anything's there. (I'm not sure how to reproduce
> the latter, though.)

There is actually only one bug (the latter). That is tested by the new
test I added in this patch. To reproduce it, we need:

- To iterate a config_set (git_config() or repo_config() will suffice),
  in which case the config_kvi is set, but not cf.
- Then in the config_fn_t we pass to it, we call git_parse_int() on an
  invalid number, which will result in die_bad_number(), which prints
  the less specific message.

The former case isn't a bug. We never ran into the BUG() when invoking
"git config" because die_bad_number() doesn't use current_* prior to
this patch (which is where the BUG() is). t1300:'invalid unit'
demonstrates that we print the correct message (and that we don't
BUG()):

  test_expect_success 'invalid unit' '
    git config aninvalid.unit "1auto" &&
    test_cmp_config 1auto aninvalid.unit &&
    test_must_fail git config --int --get aninvalid.unit 2>actual &&
    test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
  '


(which is a good signal that I should probably reword the commit
message)

>
>> Also, plumb "struct config_reader" into the new functions. This isn't
>> necessary per se, but this generalizes better, so it might help us avoid
>> yet another refactor.
>
> Hmm...I thought this would be desired because we don't want the_reader
> to be used from non-public functions anyway, so we can just state
> that that is the reason (and not worry about using future refactors as
> a justification).

Ah, good point, thanks.
