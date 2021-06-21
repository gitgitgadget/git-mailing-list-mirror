Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433AEC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 23:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1F761153
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 23:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhFUX4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhFUX4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 19:56:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4835C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 16:54:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y14so4032422pgs.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 16:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z4NfY5qrgm3Fdc8cKYsNJXBoMqWCvetLPgXTAii06as=;
        b=BL0Fsl1JUSWbt8VClUFeVgbftCUQMGgf/RPhSnTjXH0BNIq0Wfr4RZGIorXpZyiSDF
         xu2rYrudJFnK0uCM1epdXgC8ltnxN26egcgNn9Z/gXf4suieOL/bfmGv8CdGAz9mS03x
         h7aC9X9vHttfucrheKXKtqcQCYSb8YubgzHusUaHgDrd+O4SWDJsOZ2GJNqGlFqT9B/z
         ThqyHJBId9m7l7kiyoM7Sgh9OXTQJwF2xB9QVYkyOY50CG2XU0UfidJD+ikwviJan/3g
         CxmjYEhstOeEdx3BcT+b1acvaoXYeY3J9+evrnmtKYN716uf+DYyUktn7gs8g6G/STDL
         rdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z4NfY5qrgm3Fdc8cKYsNJXBoMqWCvetLPgXTAii06as=;
        b=ZYGxugHfoDjQVMQ5th7xYF4dqqFd7JoM2qitR+jxc4luD+kmfF6DNqqAf2OGaEazyH
         ap4/vW/jzA7ERi9p1gEuWTAeAJdNxHFuXjU+0ETqR1pFSzpZscRpjM+ehKVLhVEJ7yzY
         SvDJkm0hj6KaQFSo1mYjGrW+5zjEXFYo+bkSShh4ztCyW2UEjcmWpNHxsQQY15a3HYg+
         AUWzMuCutgQBtWdZ0l9mH4vcdFYXjVh2sdtUzp10c0igrdRvIr9+7zLaXFykmTA+e04l
         +2ASJ8k2XyBRURzgjZzgZybHVYJU8rqxFz1FoIrE7/FIA0p6gXdE205QCRf0MNdIIDtq
         ozFg==
X-Gm-Message-State: AOAM530V/jMkJdCkW3NfhX2kJM4q6tyzdvbfdF9Tqq/clr4UVPRsgutN
        KHbzxjHUflLTNiUi1rAdhSU=
X-Google-Smtp-Source: ABdhPJxwyMqdz/QTPVH2b4ql+Qjc/XnTIMXIMFuVf6wKU4qbvx53zqgIO/Tk5uVkBx/N0E5xsJ/XHg==
X-Received: by 2002:a63:5b21:: with SMTP id p33mr953767pgb.402.1624319670272;
        Mon, 21 Jun 2021 16:54:30 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d894:c20c:47df:f687:87d4])
        by smtp.gmail.com with ESMTPSA id j13sm17590878pgp.29.2021.06.21.16.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:54:29 -0700 (PDT)
Date:   Tue, 22 Jun 2021 06:54:27 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/4] t6402: use find(1) builtin to filter instead of
 grep
Message-ID: <YNEms6638tIKnBDC@danh.dev>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <20210619013035.26313-3-congdanhqx@gmail.com>
 <d4082001-6c70-ae02-c448-e038923c840e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4082001-6c70-ae02-c448-e038923c840e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-21 10:17:52+0200, Andrei Rybak <rybak.a.v@gmail.com> wrote:
> On 19/06/2021 03:30, Đoàn Trần Công Danh wrote:
> > find(1) has a builtin (-prune) to filter its output, save a bit of time
> > for invoking grep(1).
> > 
> > In addition, in a later change, we will try to use test_line_count_cmd
> > to count number of lines in stdout and/or stderr of a command, due to
> 
> Looking at [PATCH v3 1/4] of this series, mention of "stderr" here is no
> longer relevant.

Yes, you're correct.

> > limitation of current implementation, it can handle pipe.
> 
> Seems like a typo s/can/can't/ ?

This is correct, too.

> > Let's replace grep(1)'s usage with find(1) builtin filter.
> > 
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >   t/t6402-merge-rename.sh | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> > index 425dad97d5..5d76cd6414 100755
> > --- a/t/t6402-merge-rename.sh
> > +++ b/t/t6402-merge-rename.sh
> > @@ -546,7 +546,7 @@ then
> >   		test_must_fail git diff --quiet &&
> > -		test 3 -eq $(find . | grep -v .git | wc -l) &&
> > +		test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&
> >   		test_path_is_file one &&
> >   		test_path_is_file two &&
> > @@ -565,7 +565,7 @@ else
> >   		test_must_fail git diff --quiet &&
> > -		test 4 -eq $(find . | grep -v .git | wc -l) &&
> > +		test 4 -eq $(find . -name .git -prune -o -print | wc -l) &&
> >   		test_path_is_dir one &&
> >   		test_path_is_file one~rename-two &&
> > @@ -593,7 +593,7 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
> >   	test_must_fail git diff --quiet &&
> > -	test 3 -eq $(find . | grep -v .git | wc -l) &&
> > +	test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&
> 
> Because in the original `grep` wasn't invoked with `-F` it means that
> ".git" is a regex which would match any path which contains the word
> "git" in it, because "." matches any character, including the leading
> slash that `find` outputs.  Such narrowing of what we intend to filter
> out is a good change.

I think the original intention is using "grep -F". I'll add that
information into the commit message.

> This semantic change in filtering doesn't affect tests in t6402, as the
> test directory doesn't have paths with the word "git" except for the
> ".git" directory.  It might be worth mentioning in the commit message.

Thanks.

-- 
Danh
