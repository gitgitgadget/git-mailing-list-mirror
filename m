Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B139C07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523CC611F2
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbhGSQUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352610AbhGSQOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:14:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F2C05BD40
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:05:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id v26so20651062iom.11
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LwR0yTdgL8M685MU1hqNYt98s1hdsKjfHbEHq64KQD8=;
        b=QjFbg6H9C9mqvkh5UCV0e6Y+Pdyc52l/ze8U6ns7SUgkgHH8kwREZQilVsjI7HbdIP
         HagnN7DrOvXcSm3nBudr6jEht337N3XLZ7p9dQjfuDHAiQq67EepTRBGGya064/aDvwl
         nTRkSUJR3aCWF/X/P+SkQbi1v44n9ZQ4V7DTBJxhzGOQixF4KRcXMG0qzOHb8OhXF3Jh
         kQsW7r649g+qfqwaLoGDSo4IwEzFW2txkBXpRTGNkgK5AsFhGo9ucy6Ewr7AKN9RA84X
         Y1VatQVIRVZebpgGWP3KuJHKrkuzSz8wtZ9olQfZh7isiUzvPhgSte4P+55I0jR/MUlg
         IPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LwR0yTdgL8M685MU1hqNYt98s1hdsKjfHbEHq64KQD8=;
        b=deSbHq0iU3YIIXXqOmQ6Ho7rHNz6A++FUBUlqN9uP1O4Z/uKvhtASUIPgznhjmIb0p
         xBL/cS8ep2kQWjQEIeGt/jLKfpvIyR3FCBVWA2Tz8e4Iln6iTbE8II6vlWybFsXCJsLV
         vczBHPZS3uE5HcIVc/39bWCRD9lKJi/TQnCRWFMgbjiSfdV53h87Z+VF+PjmHKUyFmpk
         o8gyl/FoLnXHqGbsy1eto4hRQM1ZenvAgMXGnMXB2AzlVsDRVZVrDrsybzk4hPF70kIf
         RjzICIpkknVKFwdsf6iQjYbT5XQn5p0Q0jiSz+bThl63jSY6aopa1Sj7BYKbZ9AqFyqw
         w2yA==
X-Gm-Message-State: AOAM531TlE45AVieIa8pz1NmNFv6dkvzmwRL6YPrvahr1uRp8NdJxUPV
        X2uhrRe9Z6I25eMqa4JGGjof9w==
X-Google-Smtp-Source: ABdhPJyYveHEQGaOyo8nS4fiZCfdYE1XJh0wJoFQkYwCPwpkjEQttAuBneyxU8AWtC11ks8j5LZvyA==
X-Received: by 2002:a02:2a88:: with SMTP id w130mr22326471jaw.60.1626712141212;
        Mon, 19 Jul 2021 09:29:01 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id k19sm10156209ilh.60.2021.07.19.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 09:29:00 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:29:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/5] commit-graph: define common usage with a macro
Message-ID: <YPWoTKIWRbg6tGrS@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <patch-1.5-0b0bb04ecf5-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.5-0b0bb04ecf5-20210718T074936Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 09:58:05AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Share the usage message between these three variables by using a
> macro. Before this new options needed to copy/paste the usage
> information, see e.g. 809e0327f5 (builtin/commit-graph.c: introduce
> '--max-new-filters=<n>', 2020-09-18).
>
> See b25b727494f (builtin/multi-pack-index.c: define common usage with
> a macro, 2021-03-30) for another use of this pattern (but on-list this
> one came first).

I don't have a strong opinion, but I believe Jonathan Tan suggested that
we move the #define's out-of-line with their variable declarations back
in [1].

I think that what you wrote here is fine, but I tend to agree with
Jonathan that the version we ended up with in the tree is cleaner and a
little easier to read (albeit a few more lines).

[1]: https://lore.kernel.org/git/20210302040625.4035284-1-jonathantanmy@google.com/

Thanks,
Taylor
