Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A63C1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 03:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeJPLXV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 07:23:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45126 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeJPLXV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 07:23:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id e10-v6so24093047qtq.12
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 20:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxrsBNW8t6R3wxe8JERCpXtuf8B8oSEhEBcX7E3A+A4=;
        b=HYPPMkFmKhZtpjdkmxr0HQSYKTNlWWUOzpTo/6bcwyojkCYT9PJzzUAColtMZ17IH4
         w0NhhwuOILQBbCLVSY4wkAMbjzwRMnaVKhwhfRmxgBx+C1aZ7gwrouccZc5Ol4fvrTOz
         bmgC7qDQhEAvNH21uTOzECJnwRybWweekJ6p0gDdR8D7y2yT5LGzGMdOalBEesd5l9hN
         2Ezvf5cDNvrtnvJDkIzSsilO6XgcmpR9KwcRAlcpY4/CJHdF4BzVyqm2z9h93hqV8ywS
         Z5RX7XJ7wek5egDX5ObYvbGxapj06Wijrs9pEUD87oWsMZ6tOy95bM10eWDhLlKwcfKZ
         Ba8A==
X-Gm-Message-State: ABuFfog7e8SLDzAkcbdRMP9TFf3mUWFflyWAFJNRT3MCzIXIeFnkVY/2
        rO1vV8SIDk5BU2xC3b23T2YrpR+eIf3FG2ij2Pw=
X-Google-Smtp-Source: ACcGV60QsgSysGjcdaQTzBdMSK3BnD2iu2zH9QAk1h9am71Iksz7uR5utNWV/Hd/G4/z9pk8aiPzEucT3zNQ8n+BdC4=
X-Received: by 2002:ac8:73c5:: with SMTP id v5-v6mr13743706qtp.352.1539660904830;
 Mon, 15 Oct 2018 20:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com>
 <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Oct 2018 23:34:53 -0400
Message-ID: <CAPig+cQp1jpcQGjvMkCAypQZO_95R5yQDT8Fm=Du2pBOe4Pgbw@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 6:12 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This should be more reliable than the current method, and prepares the
> test suite for a consistent way to clean up before re-running the tests
> with different options.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> @@ -134,6 +134,7 @@ check_sub_test_lib_test_err () {
> +cat >/dev/null <<\DDD
>  test_expect_success 'pretend we have a fully passing test suite' "
>         run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
>         for i in 1 2 3
> @@ -820,6 +821,7 @@ test_expect_success 'tests clean up even on failures' "
>         > 1..2
>         EOF
>  "
> +DDD

Is this "DDD" here-doc leftover debugging goop?
