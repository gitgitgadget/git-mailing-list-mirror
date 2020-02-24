Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B1EC38BF9
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3122084E
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXWLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:11:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36837 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXWLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 17:11:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so12306628wru.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 14:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abntYP55E1ishzFH6DMMKSPUFH9IuoM2QqqRRexKOfo=;
        b=DP7IUS3IfJXE4MHMqypPVCFWQ3LAEH7viBUs3Oa7FdtFwfBpokQUjCzQRvlxhFh43z
         N5zDe0fKW+vcL2MuNauFkhxq5Sgtaa1iDOkdjlb/Mxak1RwaKm1Twoc7txZpNjCMW15w
         xpiLFYpQbQRaIbPJ+5vxhYGU5RozvFKWngaGtGrgD6KZ1mOxPBoiiga5A7axPfLE3T6v
         7EmzYuedd0xMWz0ef6fzjMGEgFhwgVp429EsTtscQeSdyqjonYJo61P0hAtG7Yf/3cz2
         gphrodPSa5AH9n7ohAaCdNWJEhTG87/4HX9GyV0ILiQ2fyxgZJ2l6ntA8/Q9TkZAayoi
         +5EA==
X-Gm-Message-State: APjAAAXMxk9wXx/u/Fk+uDBPoQjSlJqOATb+xBIVOYqNm13HrNKYrkem
        HlzW2qtQURoFL7VgmkW9EUdr5rhvZz3RGakmxMbdOA==
X-Google-Smtp-Source: APXvYqzfE+Ly7TGZ/PWG5gR0SjKEQcc2Rt/bKqcJmUO2wtt0m7S3cDXOBzNao6cX1dq0imzh1Bw8ucbMziqUfktV0Cc=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr72428890wrr.226.1582582283010;
 Mon, 24 Feb 2020 14:11:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
 <pull.548.v4.git.1582557199.gitgitgadget@gmail.com> <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
 <xmqqftezod3n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftezod3n.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 24 Feb 2020 17:11:11 -0500
Message-ID: <CAPig+cRWEnQL2Pye=20M0cjHsAFPvLVFWpOv_JM-Gm0hXZUS7w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] advice: revamp advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 5:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +test_expect_success 'advise should be printed when config variable is unset' '
> > +     test-tool advise "This is a piece of advice" 2>actual &&
> > +     test_i18ncmp expected actual
> > +'
>
>  - Prepare the expected output inside test_expect_success block that
>    uses it.
>  - There should be no SP between a redirection operator and the
>    filename.
>  - Here-doc that does not use parameter expansion should use a
>    quoted EOF marker.
>  - The file that gets compared with "actual" is by convention called
>    "expect", not "expected".
>
> test_expect_success 'advise should be printed when config variable is unset' '

Also, s/advise/advice/ in the test title.

>         cat >expect <<-\EOF &&
>         hint: ...
>         hint: ...
>         EOF
>         test-tool advise "This is a piece of advice" 2>actual &&
>         test_i18ncmp expected actual
> '

s/expected/expect/
