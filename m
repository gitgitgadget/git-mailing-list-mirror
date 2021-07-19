Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA2C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1E460E0C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349494AbhGSQUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352778AbhGSQOk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:14:40 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B59C069A6D
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:11:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b14so16534105ilf.7
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uL6fkuvAk3EJfMNITQo6OOjMmqr29vJyiEsVVKq++lM=;
        b=KefgDi4CqjVfzyzSjbSSQMpakVbN4y+rAyLzS90DBdzNHkOUFxbAL6Q8+3ieKz8/qn
         qNWWjlFp7aaGX2j+WX7ctSS8f5L/iOpwMyDaquwZwcmvXEOEwSoPph1ihQ7BmTswbCZr
         0PY0097JvGwHECg5Y8u89O3j0vzbURvVebMcNEh9ydOnNl6dFoUvk3JBYYUK3S34qVHE
         D3gurKvsqBjPZsCGMLD4/MCsaJYkonmvCxkIT7QdJLvsJ5YrDxHgQlexv2l152i08YLM
         bXIHRAWJdt8aIWwFn76TBPjskth86bnwqj8bK6wN3bN4ngYySLbgX98b9LH2+IZbZ0qK
         2I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uL6fkuvAk3EJfMNITQo6OOjMmqr29vJyiEsVVKq++lM=;
        b=Khmj6pzp0qt8rXTM2yqmN4/St1o+Aut8GVMRRdwebMDfPiiqKiSeijIeLJO+R94Ffk
         kluzRg3jMk0oo0nJOWG08Ya0DmY6zHIsH7RqHkau6FPg8MyVKa8bwbEQHLvJo6xw/2ru
         Wl4zPRpFW8OGAR1Ag5f1CqC//mozokE0MgEwefiUQUZ6UJq53cmiIBVtx3jrUM3rhuF8
         2Makyfn4X2lpd5D23mti8x5j43L7hawE9eJOdn/drwVr5+Swek1TypTT+zwsED9IYkrp
         JyRjv57nkk7ZQ/+0XQgKsp8lPVt5t6mz9OaQUAFLaR0Kh35JlZKD1EywYVlLxfLHAJy1
         uVSA==
X-Gm-Message-State: AOAM532Gj2T0T/O9DqPV8U6RGRw+yQfDZzrPU20pcSk7ttt7qo1YsfIA
        BVs3BXEbqZQ8LYe11vm3xwK5VA==
X-Google-Smtp-Source: ABdhPJw5Z2RtGo3X6J+Vs1H4+xjTEKJUjLswRkcP2wwB0wNZqJiwVIDXhI7S73e2FoQiKsEagzFfOA==
X-Received: by 2002:a92:7a12:: with SMTP id v18mr17158653ilc.27.1626712458863;
        Mon, 19 Jul 2021 09:34:18 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id i5sm10380492ilc.16.2021.07.19.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 09:34:18 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:34:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/5] commit-graph: remove redundant handling of -h
Message-ID: <YPWpiYInoJ/KyKhx@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <patch-2.5-6f386fc32c8-20210718T074936Z-avarab@gmail.com>
 <25b24cc9-a7fc-1286-6bcf-1fdd21ee8c49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25b24cc9-a7fc-1286-6bcf-1fdd21ee8c49@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 02:55:09PM +0200, Andrei Rybak wrote:
> On 18/07/2021 09:58, Ævar Arnfjörð Bjarmason wrote:
> > I think this code added in 4ce58ee38d (commit-graph: create
> > git-commit-graph builtin, 2018-04-02) was always redundant,
> > parse_options() did this at the time, and the commit-graph code never
> > used PARSE_OPT_NO_INTERNAL_HELP.

Yep, that matches my findings.

> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > index af88f805aa2..5fccce95724 100755
> > --- a/t/t5318-commit-graph.sh
> > +++ b/t/t5318-commit-graph.sh
> > @@ -5,6 +5,11 @@ test_description='commit graph'
> >   GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
> > +test_expect_success 'usage' '
> > +	test_expect_code 129 git commit-graph -h 2>err &&
> > +	! grep error: err
>
> New test is partially redundant to the test in the loop at the bottom of
> 't0012-help.sh'.

Agreed. The change looks good to me, but we should drop this redundant
test (although inspecting `git grep -w 'git .* -h' -- t` shows that
there are a handful of other ones that could probably be dropped, too).

I don't really feel strongly enough to worry about cleaning up the
existing ones, but we should strive to avoid adding new ones.

Thanks,
Taylor
