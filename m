Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E133AC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 18:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjDAS4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjDAS4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 14:56:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A421A8C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 11:56:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t14so26397660ljd.5
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680375377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3+QIH3Z/mQXtohyxpdLP9piDczGQ4/ZwhjI1BmeM4s=;
        b=TW1RBavB7Fg0xpxa2OY2IuM42TchsE1cYUsxVLSO85P8L5FFRcrl6idfPP0qnha0aR
         aPCBnk+VWJfayoSPyTeDeVIMeRzlORD1X6N5sKFGFPxY6TmMDbvaJdLZJ79853eRXCCT
         WeIoyZuaFunKTiusQcSZJTV9JiJc9n5WCLXRJeP1YR2GYcl/XohwdxIKnPUHdOjhiqxZ
         SV2WfZmneoOpiBQ0LLPbQLUWQJhs0/fER0LLjmqaDZggtFGmkPv/HTai1xtbyNSECeVN
         betCtyHiGT4GfCrxlAbE+tn14ygPy1KFGffHr1suIJlv29+kVD5Xp/oQUKrH7JV+nIkS
         2Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3+QIH3Z/mQXtohyxpdLP9piDczGQ4/ZwhjI1BmeM4s=;
        b=60KVZx8p0hNZymN6idV0qPWrmLICYuJMLq9Qwvff6dRbauGZxipoD4Mrf9wnQJ7eqH
         2XmGOSfz+aHplXcgnCBDG92d6WHS4QOfGZGhYKM1hf7prC/9Qbc4+HMHZyFqRe6zzXU0
         t2o/lJ8d16lQD2Q1JBPh8METt94pl439o669PS2yLwrl2uo6VhSXYgsa3t0woH5j43eL
         as1ZwyNtHnuF8CKZ/3vb3cpAKbFwJ58AU0tuczSoMvPcV/I+hzAjLaJhQ1mZdXMGqvqj
         cwxbHAcKpdm8b7/6e0aYJqEdZzAB0ksBL3jLX6OtJr4Cu1yaMLYUsDf8dJy1vkVl2sED
         C3QA==
X-Gm-Message-State: AAQBX9dnltQ4hvGqKR2ILMIfyxENx2XmwqGGYrZiTswsq7MJC31750Cq
        M1mUrCcM8NvYx3md5C5Omm3AEiCn2EtnHP6ME8o=
X-Google-Smtp-Source: AKy350bjvRQFH/oLWXgc0mRHwBtjY9nTwGzC6V98eknaL3dTpasjcKkg7MH/Yk0OKkbAcPSyEX8v7nF6qdpve1MLCHQ=
X-Received: by 2002:a2e:6a0d:0:b0:29b:d4e5:8fc4 with SMTP id
 f13-20020a2e6a0d000000b0029bd4e58fc4mr9543948ljc.1.1680375376506; Sat, 01 Apr
 2023 11:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221224225200.1027806-1-adam@dinwoodie.org> <20230304212220.qkzc2joco5xj7d4s@lucy.dinwoodie.org>
In-Reply-To: <20230304212220.qkzc2joco5xj7d4s@lucy.dinwoodie.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Apr 2023 11:56:04 -0700
Message-ID: <CABPp-BGBYUHeYtsyM-gYvr0CsKGAmJ1OKqcmnHiKYy0ps6NrCg@mail.gmail.com>
Subject: Re: [PATCH] test-lib: allow storing counts with test harnesses
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2023 at 2:16=E2=80=AFPM Adam Dinwoodie <adam@dinwoodie.org> =
wrote:
>
> Currently, test result files are only stored in test-results/*.counts if
> $HARNESS_ACTIVE is not set.  This dates from 8ef1abe550 (test-lib: Don't
> write test-results when HARNESS_ACTIVE, 2010-08-11), where the
> assumption was that if someone were using a test harness like prove,
> that would track results and the count files wouldn't be required.
> However, as of 49da404070 (test-lib: show missing prereq summary,
> 2021-11-20), those files also store the list of git test prerequisites
> that were missing during the test run, which isn't something that a
> generic test harness like prove can provide.
>
> To allow folk using test harnesses to access the lists of missing
> prerequisites, add a --counts argument to test-lib that will keep these
> counts files even if a test harness is in use.  This means that a
> subsequent call of, say, `make -C t aggregate-results` will report
> useful information.
>
> It might be preferable to do make a wider-ranging change, including

Replace "do make" with either "do" or "make"?

> storing the missing prerequisites separately from the count files, so
> the results can be reported regardless of whether the success/failure
> counts are wanted, but that would be more disruptive and more work for
> relatively little gain.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>
> I submitted this as an RFC back in December, and received no comments,
> so I'm submitting this as an actual patch now.  My key concern was the
> final paragraph above -- embedding using the "count" files for something
> other than counts -- but I've mostly convinced myself that refactoring
> this code to separate that out is unlikely to actually cause significant
> pain.

Actual code change looks fine to me as well, though I see Peff has
pointed out we might not even need to make it an option.
