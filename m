Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FFCC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6B661056
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhIPUmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhIPUmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 16:42:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF36C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 13:40:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p80so2911540iod.10
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZyzEr+f08nxYpwTvGj72xLjxYc5k6g7ncBRqbTQ/A0k=;
        b=ZDvWLdYUF1ktHmSNYzRJJfibaDpYUI3X5DO6oEkYYqNjGtaPXTbP+SeReV5Or1Pg4c
         zjkYal6V879SCJB1BPVSESYsCeO+vsBjGQZF9QWZWlnajWhuL1g0iWum17uik3EJnuqM
         tRFhDDSLWBipqGONCgW3nlBZ2b1q3s0ke794lWjVqIeOgKsA0DLm+xtkHQuRxBRR43GQ
         9dfLVvlmJ/iWX/dbcLbqQmExsXor04LBlP2LjVTt0KftM6i7mtPWAQBTs9U3wVQGwtPn
         jdvSaFfdzV+iWQxWnL/H7hNMaxyJZb4B1jOnXpSGkQ3oR48LcfBGoh1JkIEgNxUHwo/8
         9icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZyzEr+f08nxYpwTvGj72xLjxYc5k6g7ncBRqbTQ/A0k=;
        b=FXH6iUu+iespTIuFpH4lRoN+2jGYwQYNbObd0v5AH06iUlm/wVGab8IYQ7o6mglCrC
         vaLNn47qiDkHOPlpvhvypK6Hbi9rFNA2xGYtlMgmIh/neWYjwMGNi+pVHbPSTpukZHbz
         UxEvDhcxCiaIwZKPhQppvO5FaJv5ZcakmlIJ8E1id00v35mc2LnF7arUG48zQTqpZ3JI
         +0haX2hMoPVbmjjpTIljeiIInzsDLbTBpJO7p2tTyEbudqn7GYKrBJ1gKuhzZc7gaMal
         TyjtvyizhNEy0FI/tt7mBSBS2BUdRlPV7Eveb2jeMY62FAxxVMrXiqdX1Ab+A2gIHcZl
         paHg==
X-Gm-Message-State: AOAM531A5BXBk+BXDykoZbdIciWemVBz5inYQKI5Z7kLrg6RlqODHCCx
        sXzAQ218FmfX8wNJ93xZq5IuL2WsgtHV8rfe
X-Google-Smtp-Source: ABdhPJw6EoG0uE5PmxH8apoDP6XmyM0VC+U5vjkC0aLcsGkwHiyiuPGF4N0gu9ehVPuKq19cCD/YmQ==
X-Received: by 2002:a05:6638:408f:: with SMTP id m15mr5953955jam.94.1631824843086;
        Thu, 16 Sep 2021 13:40:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x13sm2432944ilq.18.2021.09.16.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:40:42 -0700 (PDT)
Date:   Thu, 16 Sep 2021 16:40:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 05/22] rev-list tests: test for behavior with invalid
 object types
Message-ID: <YUOryeVj1WNk1Sqd@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-05.22-82db40ebf8a-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-05.22-82db40ebf8a-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:00PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a blindspot in the tests for the "rev-list --disk-usage" feature
> added in 16950f8384a (rev-list: add --disk-usage option for
> calculating disk usage, 2021-02-09) to test for what happens when it's
> asked to calculate the disk usage of invalid object types.

I'm not sure that I agree this is a blindspot, or at least one worth
testing. Is the goal to add tests to every Git command that might have
to do something with a corrupt object and make sure that it is handled
correctly?

I'm not sure that doing so would be useful, or at the very least that it
would be worth the effort. That's not to say I'm not interested in
having tests fail when we don't handle corrupt objects correctly, but
more to say that I think there are so many parts of Git that might touch
a corrupt object that trying to test all of them seems like a losing
battle.

Assuming that this is a useful direction, though...

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t6115-rev-list-du.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
> index b4aef32b713..edb2ed55846 100755
> --- a/t/t6115-rev-list-du.sh
> +++ b/t/t6115-rev-list-du.sh
> @@ -48,4 +48,15 @@ check_du HEAD
>  check_du --objects HEAD
>  check_du --objects HEAD^..HEAD
>
> +test_expect_success 'setup garbage repository' '
> +	git clone --bare . garbage.git &&

Since this is cloned within the working directory, should we bother to
clean this up to avoid munging with future tests?

> +	garbage_oid=$(git -C garbage.git hash-object -t garbage -w --stdin --literally <one.t) &&
> +	git -C garbage.git rev-list --objects --all --disk-usage &&
> +
> +	# Manually create a ref because "update-ref", "tag" etc. have
> +	# no corresponding --literally option.
> +	echo $garbage_oid >garbage.git/refs/tags/garbage-tag &&
> +	test_must_fail git -C garbage.git rev-list --objects --all --disk-usage

See also my earlier comment about this being much more readable in a
sub-shell.

Thanks,
Taylor
