Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF49D1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 17:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeGBRoa (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 13:44:30 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:41789 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeGBRo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 13:44:29 -0400
Received: by mail-yb0-f182.google.com with SMTP id s8-v6so1785763ybe.8
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBMk5ZQWiVwPs2n6UdHp6soK3jGTj7U3EfDd17Hg7h0=;
        b=WdHR7tsQe84kHSSD0G9SkZCzRARoTA9NBq4wGQOcfyQdqxXOc8zpoiy9PVK4q8i8Qj
         fQGkbh1TkGmyr2aCDOZW6h26L49DBA08NtB9LghsoKEiP37oBTKImMYMM+of0fVSzisr
         Ge8640iosXHYDswhTR6j7UX0gxEP3Zrk7ElFiqaJEqZkjYKDmjGjKXLSHmQft4C7w4qj
         g64egS058IRIV+mSz5Hj5RD6RAb0rY69/zhcjTeAcGaBkkvXXOWjJkvW/1b8Py5F89hH
         Fw5nh8xYMmHAa/F2ORPrqoUU82Nn/IsGTME/19uAf+m5r2SzqHP53cbzlKaiLPG+GFtd
         su6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBMk5ZQWiVwPs2n6UdHp6soK3jGTj7U3EfDd17Hg7h0=;
        b=fyQ3Y5uaM6cikRIOxphbfMr7X7VXEqAmB83SR6gAEij36teaS7yA2IleqD72JwtJ53
         PFl+LooEqifGy6B/qrdLkyUuH+7IINB2nd4C4F1xIYZH0KrpDjETBcTprJQ+YTeDAOBm
         MKn8UnAVpCrnkYCoVAG5q3Ylq/y4u66DIXrV/YwVekM0YJBF6SQZ82HwTd1dXqHAA771
         O4sMXcEFCH5xoT9WWVZDNsSxx/dO79ehRPNgzE3KbxOx9vnxfe3pKVQdrMKb2sIDRfbU
         6ig/5oYG64YhvUMVJ2Bd7bG3ibziIF3R4LIQ4in9sbv7INsvVZ9t4XoPS3/rfgsh0V7q
         X5lA==
X-Gm-Message-State: APt69E0r6y4/Va/v/xM35KTEfhLIXl6DMeoHcffL8dLWM47QZWqJrKYd
        mk7Js2gkKZDWOXSexvBUsoeLfG7VtMJNQWvMJ8pLVQ==
X-Google-Smtp-Source: ADUXVKKI7aCZIPmQzuMug5VBEdjnO5nt152dWUTQBC34En0k5C5ZkApK+Wv+csQCM+7+79+CwM45XtMMzL6BWCnOLvE=
X-Received: by 2002:a25:b091:: with SMTP id f17-v6mr13388451ybj.167.1530553467546;
 Mon, 02 Jul 2018 10:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com> <20180702002405.3042-2-sunshine@sunshineco.com>
In-Reply-To: <20180702002405.3042-2-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 10:44:16 -0700
Message-ID: <CAGZ79kah+mFH0YZ1L0R+f=fRVku1mesigm86oHTHKRRFc3y+0A@mail.gmail.com>
Subject: Re: [PATCH 01/25] t: use test_might_fail() instead of manipulating
 exit code manually
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index 0a8af76aab..6579c81216 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -102,10 +102,8 @@ test_expect_success 'apply binary patch' '
>
>  test_expect_success 'diff --no-index with binary creation' '
>         echo Q | q_to_nul >binary &&
> -       (: hide error code from diff, which just indicates differences
> -        git diff --binary --no-index /dev/null binary >current ||
> -        true
> -       ) &&
> +       # hide error code from diff, which just indicates differences
> +       test_might_fail git diff --binary --no-index /dev/null binary >current &&

I am not sure why we need to be non-deterministic here, i.e. I would rather
test for success or non-success error code and not just *any* error code.

This code was introduced in
71b989e7dd1 (fix bogus "diff --git" header from "diff --no-index", 2008-10-05)
whereas the test_must_fail was introduced in
74359821020 (tests: introduce test_must_fail, 2008-02-28).
However this code was authored without Junios involvement
(he was AFK 2008-09-23..2008-10-08), so
maybe test_must_fail was not so popular back then?

While I think this patch is a strict improvement for the test suite,
I do wonder if we can tighten the exit code check here (maybe in
a follow up series?).

Thanks,
Stefan
