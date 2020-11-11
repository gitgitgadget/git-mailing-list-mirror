Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6708AC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BF1206F1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1sb5d78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKKJFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgKKJFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 04:05:01 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F9C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:05:00 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id s25so1725037ejy.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ShYDlUF4YvYvpBUSFySMwjjNZuvcHesFXFzpaAZyFCk=;
        b=p1sb5d788VFvD2xxye95Ctdqpv7YqIQCyTibs3qOUDmNoe/I9hrCGjzOXBub3ekNdL
         h0NRKiN3vRTqliEOWY6ri5SwfSqSvdUBC3eWHNqteuw4tnGreW0HWVIyQiVvtT4F9urf
         Y7xcmdKHpunIRdQshuSzMYwRxUuerlgoSNAi0Dd5vBHY7/OZFmaKlWek8IB45D3XLnF+
         ez/F4Adx8vNhEf+1X3mO/YFTvmeUjds5ecAPtdk/sjMst3IVVg82SRS+RLW+swCg0Fa+
         Hhafq1CKiD+c+50G0nodzoS7Xe46HFFYG5NSueTQXNBTNHzNLmAsgrQoZxYdFm2pqQ6R
         Abvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShYDlUF4YvYvpBUSFySMwjjNZuvcHesFXFzpaAZyFCk=;
        b=OHEcTvojYA8R58HIBba+MTrbNcEevkNzdlsmU5BwGNKXhbK7GvqCjZAkCUTK+KjN1g
         ru9kQyH6fmXOIoLo1J7qHpynKjLo2SslFbr8UyfNakY2fPbo+NhdAItv3jHctIW91CrR
         teTEp3ulGAxpPp5WC99JFCKQOvBZTv5mrRwfGMQ2jwlmfQsINCRCoVxak3cApghfTa6O
         XQxzp78kKZVQ/TBW6M80qz3vbJm0YOhiTcAZ05X4YfS5Zc3B6Zi+PPglWGt6+8KvAiLs
         hGvo/LAH+Ce12pARhsFurF3DAD1+ky31rCJZFHPrSgr7YLxQXwdYVRsniQHE+Oyz7A21
         r8GQ==
X-Gm-Message-State: AOAM5335wfaIdXRo0Mar+1WJHitKqAYh96kqzkv2Izeaq3j0hTODTN0e
        OffL/3rW18xMyWhN9Fjk3CEhLBPEu8k=
X-Google-Smtp-Source: ABdhPJwPX6Z1ucreFlCSPPAwwJ44HjWKixAEfHBWHe3CKFKySTkrSrhGk00pBgdgiLmJTfgWMkf5NQ==
X-Received: by 2002:a17:906:4bc4:: with SMTP id x4mr24059545ejv.66.1605085499388;
        Wed, 11 Nov 2020 01:04:59 -0800 (PST)
Received: from szeder.dev (84-236-109-124.pool.digikabel.hu. [84.236.109.124])
        by smtp.gmail.com with ESMTPSA id cn8sm617029edb.18.2020.11.11.01.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 01:04:58 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:04:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v3 1/4] t1400: avoid touching refs on filesystem
Message-ID: <20201111090454.GA4270@szeder.dev>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
 <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 07:58:38AM +0100, Patrick Steinhardt wrote:
> The testcase t1400 exercises the git-update-ref(1) utility. To do so,
> many tests directly read and write references via the filesystem,
> assuming that we always use loose and/or packed references. While this
> is true now, it'll change with the introduction of the reftable backend.
> 
> Convert those tests to use git-update-ref(1) and git-show-ref(1) where
> possible. As some tests exercise behaviour with broken references and
> neither of those tools actually allows writing or reading broken
> references, this commit doesn't adjust all tests.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1400-update-ref.sh | 72 +++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 4c01e08551..d7a57488ed 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh

> @@ -188,27 +194,26 @@ test_expect_success "move $m (by HEAD)" '
>  	test $B = $(git show-ref -s --verify $m)
>  '
>  test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
> -	test_when_finished "rm -f .git/$m" &&
> +	test_when_finished "rm -f git update-ref -d $m" &&

There is a leftover 'rm -f' here.

>  	git update-ref -d HEAD $B &&
>  	! grep "$m" .git/packed-refs &&
> -	test_path_is_missing .git/$m
> +	test_must_fail git show-ref --verify -q $m
>  '
