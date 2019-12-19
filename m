Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF94C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D124672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSWxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:53:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSWxK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:53:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so7329058wmf.2
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcWvf58cNpXplACNTAv7ozjhoOon1q2HDcblT+ntPxY=;
        b=SBAU3gOG7ifRr96M/jD1DEEYPPyLNpw4aGxZW3+Z+CHzeS0tHbTjQMQrjUdR5+1Lp9
         9KMcD8+BIyAFkU8NjFoxXF9wp597ZyV727JiAcW86PwUi2bCpg213bIkCEgYKDX59jEI
         G/dMzUOoTE7b2BpwcrF6AMORfElREdWPpsYQ9r4hsqnbWQI66xHeZUrqLe1BFfxFJxci
         VkndmZuM/sxyImC3RWtqGpTEAQAcOy7A/PV9MLUe2yWGFAPsvZQZyPAkUDkr4+kxyOUW
         Spe4k9vb5XXad621dbrMARt6lFVMze54Mz41DdiDf1XXvR4EEL54wzRyDW4CICgciWFm
         tkaQ==
X-Gm-Message-State: APjAAAUyU5dpZjAoqwhni78m1r1psJcPbQWlEWD3zG0sLZThmebDPcIT
        wtP+QdjyaCPEO6yEI7qp+cOOm3KgE2Eld7sOGGrUqOOhNos=
X-Google-Smtp-Source: APXvYqx06PASwW/uuAwOvPk32UQcPAbWIxmtzm30HscmO18Rpxg/qChaoZc4TZ/tnhVLQEXKz5LMH6xo2qv/ROVjfM4=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr13178854wml.55.1576795987908;
 Thu, 19 Dec 2019 14:53:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
 <83e47748bc9c541c725f6c42c553b1a69fd717ac.1576794144.git.liu.denton@gmail.com>
In-Reply-To: <83e47748bc9c541c725f6c42c553b1a69fd717ac.1576794144.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Dec 2019 17:52:56 -0500
Message-ID: <CAPig+cQuPDDun3NxnTwvmjo9zvPzSq+5f2utkHkS0f1c1Nwbvg@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] t1501: remove use of `test_might_fail cp`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 19, 2019 at 5:22 PM Denton Liu <liu.denton@gmail.com> wrote:
> The test_must_fail() family of functions (including test_might_fail())
> should only be used on git commands. Replace test_might_fail() with
> test_non_git_might_fail().
>
> The `test_might_fail cp` line was introduced in 466e8d5d66 (t1501: fix
> test with split index, 2015-03-24). It is necessary because there might
> exist some index files in `repo.git/sharedindex.*` and, if they exist,
> we want to copy them over. However, if they don't exist, we don't want
> to error out because we expect that possibility. As a result, we want to
> keep the "might fail" semantics so we use test_non_git_might_fail().

Thanks for adding this paragraph to help the reader understand why you
chose this transformation. However...

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
> @@ -350,7 +350,7 @@ test_expect_success 'Multi-worktree setup' '
>         cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
> -       test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
> +       test_non_git_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&

I can't say I'm a fan of patch 1 introducing the function
test_non_git_might_fail() for this one particular case. I'd rather see
this case follow existing precedence by being written this way:

    { cp repo.git/sharedindex.* repo.git/repos/foo || :; } &&

which is the idiomatic way this sort of thing is handled in existing tests.

While it's true that it may look a bit cryptic to people new to shell
scripting, as with any idiom, it's understood at a glance by people
familiar with it. That bit about "at a glance" is important: it's much
easier to comprehend idiomatic code than code which you have to spend
a lot of time _reading_ (and "test_non_git_might_fail" is quite a
mouthful, or eyeful, or something, which takes a lot more effort to
read and understand).
