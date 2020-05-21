Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AA4C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34EF20738
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEV+4m4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgEUSzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbgEUSzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:55:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB3C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:55:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f13so8350610qkh.2
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jHbBHbB393Tqx+xKRt2ba6ThnR4kWRYQea1QuCt1Zxs=;
        b=bEV+4m4ov8o5+E8ODaktuBLVsi0G0kGcitNg3HXJoUAxTFqW6M/+UpOFRs12aY7qFW
         f8CtqvMIT/aXQKKm42qodaxvtjvNhFRMTz8pKeJwPORxPZeIyRw+mNGgAyRlx7K4v3eY
         DioN8OFc6oKy4v4w+l0TH4Qb9PDZgHBx01tVoxc+suqA7rHQbFAVOz+pL4dfZGrVY+E5
         JGCR0FuVk2BGwG77I/I919hynpDyG6h9iR857fvE8YQN5wv3sjRWHmgiWIyQkLY495CI
         3t2nOE01sFsMrja4q2pE0E+GvJIz/41Xpa2DWdKXQu2fByvjjT+Eg9zKwdVBYIqJDyAB
         pzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jHbBHbB393Tqx+xKRt2ba6ThnR4kWRYQea1QuCt1Zxs=;
        b=SqpGvxYavyDP5JeM8A2bIUi30X8QDWywtZptIYJObfngO6ebOOZzgMTzbFmnCnpeVn
         X9BgVHGI/7slt5RCWLUZC12WZru1KfApGH9QWlF92K4w/7/DvlVZcWXZB4e3tLELl8cE
         2WiMV/7n4UI7xtK/esuow48ygzsVs0kEgQTpNyJX8ZXdqTTTQrK4CfpSxWOzd+cKg6R6
         j8D1OfV6obJVJufNWPu76jpmB7Ee/+/iW4o2wYbPLhjkUSXQ5y8OMBavDOliW29jjkJ1
         QWGR2pcXSjnifGW8cm+TMzv6dBI0Xved+TJ7YEnc4iGZdHJDUQQZgyES+7vvbQQJ0XTV
         WIHg==
X-Gm-Message-State: AOAM531R38ZNFByrgOdQBHs+/aTnXBl9l0/ieBdEJNseGwKFY09yL8cr
        NQUQmeCNLWmT2z/4lUiktHPNG2HJ
X-Google-Smtp-Source: ABdhPJyeyk01sHBbE0oYR9Dhw/8iQ+BleTjUS/vfqYzQaoqVBefZ5sQx275SMBiKfl3j0DSth07eEA==
X-Received: by 2002:a05:620a:556:: with SMTP id o22mr11684175qko.434.1590087317873;
        Thu, 21 May 2020 11:55:17 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id k57sm5907374qta.20.2020.05.21.11.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:55:17 -0700 (PDT)
Date:   Thu, 21 May 2020 14:55:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] lib-submodule-update: pass OVERWRITING_FAIL
Message-ID: <20200521185514.GA615266@generichostname>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <cover.1590019226.git.liu.denton@gmail.com>
 <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
 <20200521182928.GA1308647@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521182928.GA1308647@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, May 21, 2020 at 02:29:28PM -0400, Jeff King wrote:
> > This is useful because currently, when we run a test helper function, we
> > just mark the whole thing as `test_must_fail`. However, it's possible
> > that the helper function might fail earlier or later than expected due
> > to an introduced bug. If this happens, then the test case will still
> > report as passing but it should really be marked as failing since it
> > didn't actually display the intended behaviour.
> 
> Now this second concern I think is much more interesting, because it
> impacts the test results. And it's really not even about test_must_fail
> in particular, but is a general problem with checking failure in any
> compound operation. We may expect the early parts to succeed, but the
> later parts to fail, and we want to tell the difference. And that's true
> whether you're using "!", test_must_fail, etc.
> 
> You solve it here by passing OVERWRITING_FAIL down into the callback
> functions. And that does work. But I think it may be easier to
> understand if we invert the responsibility. Let the outer caller specify
> two callbacks: one for setup/prep that must succeed, and one for a
> single operation where we might expect success or failure.

I believe that we'll need a third optional argument. For example, in
t3906, we have the following diff

	diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
	index 6a7e801ca0..6e8dac9669 100755
	--- a/t/t3906-stash-submodule.sh
	+++ b/t/t3906-stash-submodule.sh
	@@ -8,7 +8,11 @@ test_description='stash can handle submodules'
	 git_stash () {
		git status -su >expect &&
		ls -1pR * >>expect &&
	-	git read-tree -u -m "$1" &&
	+	$OVERWRITING_FAIL git read-tree -u -m "$1" &&
	+	if test -n "$OVERWRITING_FAIL"
	+	then
	+		return
	+	fi &&
		git stash &&
		git status -su >actual &&
		ls -1pR * >>actual &&

which means, when we're doing test_must_fail, we have to skip the
remainder of the function otherwise, if the first command succeeds but
it fails later in the test, then we report success even though it didn't
fail at the point where we were expecting. I think that we'll have to
have an optional third arg for $cleanup or something. The only thing
that I'm worried about is that having three separate functions being
passed in may be too messy.

Aside from that, I like this approach much more than mine.

Thanks,

Denton
