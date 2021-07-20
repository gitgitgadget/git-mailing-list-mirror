Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B6FC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6793B610FB
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGTQft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhGTQfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:35:34 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D5C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:16:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id w22so16662118ioc.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5pMSJE6wRSAcJG59YCAUbr4EHVJaSEEvhi232dusbGM=;
        b=MwrSHqlmUUPST3MdZOLpWLm7Qz4H8/Yx2p8u3Opro1A9OfGKCsESbgd+gAyC6STuzB
         VhS0TVcsEgWWtX3KiVkhRzVX45dUmg4jIE0rjDDIOxk7qi1MQry/LrWVTbvQUGhMHI90
         BpIzmhy6I2kvqqCiP5whA9s8JDd8Y3+vvsuEksmmB8C79vxUtlyvWtDFAkLjJ+1e26DI
         Gcv08pJMCLWmPYoUV/6pMocYhPuHiQjkG28485Ur6VGT6npaouS555Ji6ibTJ1ZavkB6
         7KgWTutqZsB69gsqik4QAIo8z/5ZpWWysHjwWeZ/JPdeu+NlJ7byDy51qdu+4TGs1N7i
         xCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5pMSJE6wRSAcJG59YCAUbr4EHVJaSEEvhi232dusbGM=;
        b=JTnENXBo3ECfI36DVk1Mjv6z/HUUxnDWrG1Q6YE5XsGcez1KLKw8UUGZLmuIIbWrfe
         GJlII8zqxsOKKXygwgyiRW93rqUj92y6aUtEtH7r0MfNYQNwd07ZDSU9DsjgN8CEpjnL
         EqNB7b0Zlp2Yzg6tKiYsGIm/92+eaQ1oRsXHyM4NV5VYqWEgbRw0OmUqCJTrgd+fjtxM
         B6MIjcLCw4p4A0PjGG9ir3iS0BCbRy99ox2U1G4N/NULouuyHj7xzTFYkQJHL6/kJYgt
         RQg62MTeiD8fgGFgnIhGSyMeA0ZVcls8x+RIBcw6ABcxScLOSdC2XhGBUYcNs2TNMrG9
         ilQA==
X-Gm-Message-State: AOAM530wFESh0hc2vQHAw48yfaIxERHzx0qR4q4Cxs+nUaxCDMhUjgte
        +o3M1Hzv7iY68aKV+g2whxAwCQ==
X-Google-Smtp-Source: ABdhPJw6X9+TwMNA7Ts68qFs1iu0zXGes1zUSXxoaSr/PC56DOR8OC/fbhM0tFSxIanQ7gwxjLJRtA==
X-Received: by 2002:a5e:d707:: with SMTP id v7mr8914618iom.46.1626801372059;
        Tue, 20 Jul 2021 10:16:12 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id h13sm10830825ila.44.2021.07.20.10.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:16:11 -0700 (PDT)
Date:   Tue, 20 Jul 2021 13:16:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] bundle tests: use test_cmp instead of grep
Message-ID: <YPcE24InpY4evFyE@nand.local>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
 <patch-2.2-062f34abf1a-20210720T115052Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-062f34abf1a-20210720T115052Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 01:52:09PM +0200, Ævar Arnfjörð Bjarmason wrote:
> So let's use test_cmp instead, and also in the other nearby tests
> where it's easy.

I took a look at this patch carefully to make sure that this
transformation also improved the readability, too.

Looking around, I think that this was a good improvement in readability,
but also hardened the tests (for the reasons that you mentioned). One
tiny note below.

>  test_expect_success 'empty bundle file is rejected' '
> @@ -67,11 +83,33 @@ test_expect_success 'ridiculously long subject in boundary' '
>  	printf "%01200d\n" 0 | git commit -F - &&
>  	test_commit fifth &&
>  	git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
> -	git bundle list-heads long-subject-bundle.bdl >heads &&
> -	test -s heads &&
> +	cat >expect <<-EOF &&
> +	$(git rev-parse main) HEAD
> +	EOF
> +	git bundle list-heads long-subject-bundle.bdl >actual &&
> +	test_cmp expect actual &&

This is quite readable, but the assertion below gets much more
complicated as a result of the change.

>  	git fetch long-subject-bundle.bdl &&
> -	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
> -	grep "^-$OID_REGEX " boundary
> +
> +	cat >expect.common <<-EOF &&
> +	-$(git log --pretty=format:"%H %s" -1 HEAD^)
> +	$(git rev-parse HEAD) HEAD
> +	EOF
> +	if test_have_prereq SHA1
> +	then
> +		cp expect.common expect
> +	else
> +		echo @object-format=sha256 >expect
> +		cat expect.common >>expect
> +	fi &&

Here we're setting up expect, but I think flipping the order might make
things a little easier to follow. Maybe something like this:

    rm expect &&
    if ! test_have_prereq SHA1
    then
      echo "@object-format=sha256" >expect
    fi &&
    cat >>expect <<-EOF &&
    -$(git log --pretty=format:"%H %s" -1 HEAD^)
    $(git rev-parse HEAD) HEAD
    EOF &&

Or, if you wanted to go further, you could do something like:

    cat >expect <<-EOF
    $(test_have_prereq SHA1 || echo "@object-format=sha256")
    -$(git log --pretty=format:"%H %s" -1 HEAD^)
    $(git rev-parse HEAD) HEAD
    EOF

which is arguably a little tighter (although I find the
echo-in-a-heredoc thing to be kind of ugly).

> +	if test_have_prereq SHA1
> +	then
> +		head -n 3 long-subject-bundle.bdl >bundle-header
> +	else
> +		head -n 4 long-subject-bundle.bdl >bundle-header
> +	fi &&
> +	grep -v "^#" bundle-header >actual &&

Here I would suggest getting rid of the bundle-header intermediary and
instead writing:

    if test_have_prereq SHA1
    then
      head -n 3 long-subject-bundle.bdl
    else
      head -n 4 long-subject-bundle.bdl
    fi | grep -v "^#" >actual

and then having your

> +	test_cmp expect actual

below.

Thanks,
Taylor
