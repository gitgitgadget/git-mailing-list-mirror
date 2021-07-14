Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7600C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 04:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0861003
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 04:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhGNEHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 00:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNEHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 00:07:04 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B2EC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 21:04:12 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h6so396819iok.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BofuGh2l3LOiJv35Zb+mJYF9Aac8EVBe0Pg9cevZE+4=;
        b=UCeyD0ITO5SDN5DjSSBW8ey0vPjijGb/3FGRWAAje4KIJiBLOtnAbJTvoHlBHPizHe
         +mQWHO+lOUJYOE6TqOZ1etCPxI9cbRz0Jdh94mF9eFXfCQZuL6kVuTJyza9AsVlut6iJ
         yPzQ0a9XD0blJNObTl+ZTLUqiWAz5iS41GLF1mNs6Inv2TOQDId35EWQ9df1NctXFVwf
         Zd4bxIBvYuTYN7XS4bOjEqkchggwgcgG6akoJNYqQL694whIXiO1E/ASzOikOCBbbLf9
         kPnvGXkCg2Sf/VZv8FM6uaYCwjwiMP0BbA21hIB37ACbapeVkBefgRQADAFoS5PYmtXh
         3r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BofuGh2l3LOiJv35Zb+mJYF9Aac8EVBe0Pg9cevZE+4=;
        b=hmn6pBNgLWFuKrTaBhvel/py6ZBPmczqf8IxtZEUwz9AHKHsBghT2L0VnfjdahPDJQ
         UZNg3huevQNQR3MZ2b3fhksBMxOsJUihb7MM8hEe7oL/T+F3e3G0GJqfkO8q3WwKtPdW
         klzeNqYlwmWzO10uXYiQPN1BklF5C2QBebdgf7nH+MVY6PgOjpVPGfdrysvkrALIfEAp
         H9D/8G31EMc6hzYyZnaO7jgSbwKnAIYVPnFweNJJaPo5jIkv2EQQgHgJZMR80lhmE89H
         MuQcZyfr8x4c7v72vMoHeggHqgNYZkM3NLg9fOrabSs1oojtbo+pukBYKpBo0L29xF1n
         Z7eg==
X-Gm-Message-State: AOAM533OOE9/YQqXrE8BDmbkcJ0YAvN+0tg2ATwX1p6Q5pCWH4gdPk4t
        oofUlMAcsnkj0RTUWro0n0OljQ==
X-Google-Smtp-Source: ABdhPJxTPP+vA9ouKwFFLQ7WrMUbq0qJvxqdx0iWWAIlM2gV5Xok6emnNb3Im0TAVN6PR2jr2bGXTw==
X-Received: by 2002:a05:6602:3423:: with SMTP id n35mr2212311ioz.188.1626235452328;
        Tue, 13 Jul 2021 21:04:12 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3a49:b835:9d82:9993])
        by smtp.gmail.com with ESMTPSA id h6sm475934iop.40.2021.07.13.21.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 21:04:11 -0700 (PDT)
Date:   Wed, 14 Jul 2021 00:04:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] tests: replace [de]packetize() shell+perl
 test-tool pkt-line
Message-ID: <YO5iOqWx46UxdhKX@nand.local>
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
 <patch-3.5-92bfd8a87b-20210714T005115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.5-92bfd8a87b-20210714T005115Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 02:54:03AM +0200, Ævar Arnfjörð Bjarmason wrote:
> -extract_haves () {
> -	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
> -}
> -
>  test_expect_success 'with core.alternateRefsCommand' '
>  	write_script fork/alternate-refs <<-\EOF &&
>  		git --git-dir="$1" for-each-ref \
> @@ -27,18 +23,40 @@ test_expect_success 'with core.alternateRefsCommand' '
>  			refs/heads/public/
>  	EOF
>  	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
> -	git rev-parse public/branch >expect &&
> -	printf "0000" | git receive-pack fork >actual &&
> -	extract_haves <actual >actual.haves &&
> -	test_cmp expect actual.haves
> +
> +	test-tool pkt-line pack >in <<-\EOF &&
> +	0000
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	$(git rev-parse main) refs/heads/main
> +	$(git rev-parse base) refs/tags/base
> +	$(git rev-parse public) .have
> +	0000
> +	EOF
> +
> +	git receive-pack fork >out <in &&
> +	test-tool pkt-line unpack <out >actual &&

I don't think extracting the haves themselves (and stripping ".have"
from the output) adds much verbosity at all. Wouldn't it be:

  test-tool pkt-line unpack <out >actual &&
  perl -lne '/^(\S+) \.have/ and print $1' <actual >actual.haves

(in fact, it might be quite nice to leave extract_haves as-is changing
depacketize for 'test-tool pkt-line unpack').

For what it's worth, I also don't care enough to argue about it, but I
am curious why the change here was more invasive compared to other
locations (where depacketize was just replaced with the earlier
incantation).

If memory serves, I am the original author of this test (via 89284c1d6c
(transport.c: introduce core.alternateRefsCommand, 2018-10-08)), but the
Perl bits are Peff's from the discussion in:

    https://lore.kernel.org/git/20180922195258.GA20983@sigill.intra.peff.net/

Thanks,
Taylor
