Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B894C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2CB20720
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq7C6XRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgF2TIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgF2TCm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E125C02E2E6
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 07:14:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so8080716pjc.4
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=viXiuNGLpUnUmVtW52pDz9PE9+4YAYTqdm5G4YkTK1k=;
        b=hq7C6XRQ0YqNGjMLy7627wBEKncsEvd1e2cBwIjRtLLm60yPUTe9xX/3n+V1CG/0Gr
         kWnFOhW0pq/5mN0myJt50+u1zBYelCn6iBHbERx6W3bPhP0+i6yjoJ59y3X7LeG63YNY
         j0YJ6B0X3J6y9aZWxHdH10CCFK8xt9Zo5T4WZBW4jJ5s4ZQPxndB0h0oc7FLxIughVJw
         b1DDG6CeBwZKyDQ+Hf4JE4Dg4mmpUuC+UBZwCRmHxegaQqUseGCs9SjyVdT/6JqbXtG2
         QR9Cj9auZoAsGCIVkDaWEG1ela/YjwNIgbvHQG8duQ2bvENJGmt/86cM/kpb70f2y+hs
         krOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=viXiuNGLpUnUmVtW52pDz9PE9+4YAYTqdm5G4YkTK1k=;
        b=g1XLCWKnIoUjiiwdVX2ylUWydm5ORglfkDkXyifUtiOBQZHKc2AZLP2ty71rHvjcc4
         Z3X1OFyqwcgHRkhL7KGtqMRX96uWI3lBQz4NG8wWIG1QDdhh0uS5c3iHV7zJrPutfz9L
         JAnkuAa3TThkq01AlAgvRZsmUgC4FBmhZDTRrKtZz9lZgAT7zRCi/+ReX1iYXUzoORxQ
         FL8Yap6pIWYd+ZHTxDYD9t2raXP5yeJgmCOWx5YXNH7D+rBiekGuw+37wE6ISOsCBLOl
         WeGbQeIm8qlqSGzm39vGRCs2P7zRKNzs6rcgHF2oo5wztSKnKm+sgaFCedon2Y9SJgXU
         FiYg==
X-Gm-Message-State: AOAM530XOjGtf9dW9Uah3KDDVbMTtjviJOnqbdKEWYrBSC59t8iGymj3
        GnHU3DUG7SHhrHN9YFqD2xrYOKmT
X-Google-Smtp-Source: ABdhPJxqRT2awo6B1jn9EzeLvVpUTGxUtdwcVDLKm1YAohvQeS73U+DD1A4c0HsAycMQRjjpf14bMA==
X-Received: by 2002:a17:902:b705:: with SMTP id d5mr3987737pls.118.1593440095967;
        Mon, 29 Jun 2020 07:14:55 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id b6sm9858pfp.0.2020.06.29.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:14:55 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:14:53 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] rebase -i: add --ignore-whitespace flag
Message-ID: <20200629141453.GB20303@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
 <20200626095528.117524-2-phillip.wood123@gmail.com>
 <20200626133714.GB12504@danh.dev>
 <78c32f2d-3af6-1514-51a3-1110531cbb88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c32f2d-3af6-1514-51a3-1110531cbb88@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 2020-06-26 15:43:00+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> > > +	if (options.type == REBASE_APPLY) {
> > > +		if (ignore_whitespace)
> > > +			argv_array_push (&options.git_am_opts,
> > > +					 "--ignore-whitespace");
> > > +	} else if (ignore_whitespace) {
> > > +			string_list_append (&strategy_options,
> > > +					    "ignore-space-change");
> > > +	}
> > > +
> > 
> > Hm, I've just noticed this by now.
> > Would it's better if we rewrite it as:
> > 
> > 	if (ignore_whitespace) {
> > 		if (options.type == REBASE_APPLY)
> > 			argv_array_push(&options.git_am_opts,
> > 					"--ignore-whitespace");
> > 		else
> > 			string_list_append(&strategy_options,
> > 					   "ignore-space-change");
> > 	}
> > 
> > Ah, the incoming patches will add more conditions into the:
> > 
> > 	if (options.type == REBASE_APPLY)
> > 
> > I'm still not convinced, though.
> 
> I wanted to keep the subsequent patches as simple as possible. Having to
> rewrite the if statement in the next patch just clutters it up and makes the
> real changes introduced by that patch less obvious

I think the code suggested by Junio may be cleaner ;)
I may write as:

	if (ignore_whitespace) {
		if (options.type == REBASE_APPLY)
			argv_array_push(...)
		else
			string_list_append(...)
	}

	if (other_condition)
		do_something_else(...)

I don't know if it's cleaner or not.
I haven't tried applied it into real code.

> > Anyway, IIRC, --ignore-whitespace and --ignore-space-change has the
> > same meaning, I think it's better to use the same option for both
> > legs, no?
> > 
> > I can understand the decision to use --ignore-whitespace as keeping
> > the pass-through behavior of old code, but I think future maintenance
> > is more important than that.
> 
> I'm not sure how it affects future maintenance. The two different options
> are for two different commands so I'm not sure it is worth the effort

I vaguely remember I was thinking about same option text in both leg
would make the code easier for reasoning. And we can unify the
recommendation for both backend. We will never strip
--ignore-whitespace from git-apply, but it would be easier to always
answer: "--ignore-space-change should be used to ignore space" when
someone asks about it.

Typing this now makes me wonder if we should teach --ignore-space-change to
git-rebase?

Thanks,

-- Danh

> 
> Best Wishes
> 
> Phillip
> 
> > I've tried changing ignore-whitespace to ignore-space-change and run
> > make test
> > 
> > It looks good to me (aka nothing failed _in my machine_),
> > 4/5 and 5/5 is not applied, though.
> > 
> > >   	if (strategy_options.nr) {
> > >   		int i;
> > > diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> > > index 50e7960702..55ca46786d 100755
> > > --- a/t/t3422-rebase-incompatible-options.sh
> > > +++ b/t/t3422-rebase-incompatible-options.sh
> > > @@ -61,7 +61,6 @@ test_rebase_am_only () {
> > >   }
> > >   test_rebase_am_only --whitespace=fix
> > > -test_rebase_am_only --ignore-whitespace
> > >   test_rebase_am_only --committer-date-is-author-date
> > >   test_rebase_am_only -C4
> > > diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> > > new file mode 100755
> > > index 0000000000..4f8a6e51c9
> > > --- /dev/null
> > > +++ b/t/t3436-rebase-more-options.sh
> > > @@ -0,0 +1,60 @@
> > > +#!/bin/sh
> > > +#
> > > +# Copyright (c) 2019 Rohit Ashiwal
> > > +#
> > > +
> > > +test_description='tests to ensure compatibility between am and interactive backends'
> > > +
> > > +. ./test-lib.sh
> > > +
> > > +. "$TEST_DIRECTORY"/lib-rebase.sh
> > > +
> > > +# This is a special case in which both am and interactive backends
> > > +# provide the same output. It was done intentionally because
> > > +# both the backends fall short of optimal behaviour.
> > > +test_expect_success 'setup' '
> > > +	git checkout -b topic &&
> > > +	test_write_lines "line 1" "	line 2" "line 3" >file &&
> > > +	git add file &&
> > > +	git commit -m "add file" &&
> > > +
> > > +	test_write_lines "line 1" "new line 2" "line 3" >file &&
> > > +	git commit -am "update file" &&
> > > +	git tag side &&
> > > +
> > > +	git checkout --orphan master &&
> > > +	test_write_lines "line 1" "        line 2" "line 3" >file &&
> > > +	git commit -am "add file" &&
> > > +	git tag main
> > > +'
> > > +
> > > +test_expect_success '--ignore-whitespace works with apply backend' '
> > > +	test_must_fail git rebase --apply main side &&
> > > +	git rebase --abort &&
> > > +	git rebase --apply --ignore-whitespace main side &&
> > > +	git diff --exit-code side
> > > +'
> > > +
> > > +test_expect_success '--ignore-whitespace works with merge backend' '
> > > +	test_must_fail git rebase --merge main side &&
> > > +	git rebase --abort &&
> > > +	git rebase --merge --ignore-whitespace main side &&
> > > +	git diff --exit-code side
> > > +'
> > > +
> > > +test_expect_success '--ignore-whitespace is remembered when continuing' '
> > > +	(
> > > +		set_fake_editor &&
> > > +		FAKE_LINES="break 1" git rebase -i --ignore-whitespace \
> > > +			main side &&
> > > +		git rebase --continue
> > > +	) &&
> > > +	git diff --exit-code side
> > > +'
> > > +
> > > +# This must be the last test in this file
> > > +test_expect_success '$EDITOR and friends are unchanged' '
> > > +	test_editor_unchanged
> > > +'
> > > +
> > > +test_done
> > > -- 
> > > 2.27.0
> > > 
> > 

-- 
Danh
