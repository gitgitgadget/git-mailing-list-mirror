Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97722C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AC061076
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhFPOYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhFPOYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:24:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F30DC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:21:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s14so2340192pfd.9
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DNYSDOvuNGOyXxEI+xmOIdLR+EtdMoWwS7c4UD4H98g=;
        b=tshFWTpxBf+kj5GfMgc7N1Itg34neRRgvzlnhM3VR2uLi6D/WTxUPNOuVRxbLO6VkC
         nlz2h0aqr6IF5DMvPNcTCnlgwpNaCRu35gXjgtCga12QVixsqnZ1bv4so2sawWfLWTmH
         tJQVRIt8rLBeMFMbbR0ADSfLQnmnxu9KVd1ncJ3rEHZw73AVV6T5TSxK59m061USIy4x
         3XlYYS2DNYjtQ+PEmaUgO+d6MzOhQSqySb6f0Cos9ME1KgTbxTC5p5lxHyX8lXKfzV4l
         27rC4wkrQ4B98Ci20paR5Q7zoiJRqfB1EL+F2R47Xo1fyYWXHfEUpUfaB7fraEUlt5Nr
         Bv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DNYSDOvuNGOyXxEI+xmOIdLR+EtdMoWwS7c4UD4H98g=;
        b=o5VE0E/vbUPqq6JUxxvPLl6BxMrSxsh94SwZZcyaysFkKWD5+es1VSMkFiZNo/pVK1
         tk2HoTM4w2T4Ch1xCJip1amcmyRDln5gx67Z5J0VgHi7LIdl9lbkmQxaOwCqbMasdlzv
         Fiv/U4Xp6tupTjGNvG3Il25gQO26ZgRJzupmmL6bLsl8/0u7jYg8v3tTh9hEyExOFpcp
         AEj6rgMuYdlDoe9Mo/2Z6+clIfw1Gh/al88TQWin58VSczFmU7mUzNd9BsjO/TCqGDt9
         8dBsS4gEv7dW+3BoZ9cm+Jj+kjXKIXbdVt5/wniaEi0ouWpc3D+MzAwVbb2/jRztrkOj
         /29w==
X-Gm-Message-State: AOAM533h7yOnxbwkFYYydRG4hovp3hXj+zxeV2XA3ZH3aeUTh7qnBtVc
        J6ctf0ZNeMk6gwkhjRJ9SPU=
X-Google-Smtp-Source: ABdhPJyD97KiDnZq1q76QX9i9g4TImY/nalBuCckH4jJFFx0senZatN7ME+VKcp/PbTDm0Gp2ASHIA==
X-Received: by 2002:a65:4242:: with SMTP id d2mr5141996pgq.243.1623853317579;
        Wed, 16 Jun 2021 07:21:57 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id x6sm2405216pfd.173.2021.06.16.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:21:57 -0700 (PDT)
Date:   Wed, 16 Jun 2021 21:21:54 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/5] t0041: use test_line_count_cmd to check
 std{out,err}
Message-ID: <YMoJAnvigwexX5b5@danh.dev>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <20210615172038.28917-4-congdanhqx@gmail.com>
 <xmqqlf7ase3d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlf7ase3d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-16 12:06:14+0900, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> >  test_expect_success 'tag --contains <existent_tag>' '
> > -	git tag --contains "v1.0" >actual 2>actual.err &&
> > -	grep "v1.0" actual &&
> > -	test_line_count = 0 actual.err
> > +	test_line_count_cmd --err = 0 git tag --contains v1.0 >actual &&
> > +	grep "v1.0" actual
> 
> Sorry, but I am not impressed if this is a typical/prime example of
> how the new helper helps in writing our tests.

Yay, reading through the patch again, and I'm become less enthusiastic
with persuading --err. The only useful application of --err is t4068.
----8<---
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 2d650d8f10..33e2327072 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -61,9 +61,7 @@ test_expect_success 'diff with one merge base' '
 # It should have one of those two, which comes out
 # to seven lines.
 test_expect_success 'diff with two merge bases' '
-	git diff br1...main >tmp 2>err &&
-	test_line_count = 7 tmp &&
-	test_line_count = 1 err
+	test_line_count_cmd --out = 7 --err = 1 git diff br1...main
 '
 
 test_expect_success 'diff with no merge bases' '
----->8----

However, going through all the trouble for a single application is not
really worth it.  I'm going to drop --err, remove --out option, too.
So, its prototype would be:

	test_line_count_cmd <op> <val> [!] cmd [args...]

> Notice that so many tests that you touched only care about 0 lines?
> 
> Instead of this new helper, I think it would be a more useful
> improvement if we check the emptyness in a more direct way, i.e.
> 
> >  test_expect_success 'tag --contains <existent_tag>' '
> > 	git tag --contains "v1.0" >actual 2>actual.err &&
> > 	grep "v1.0" actual &&
> > -	test_line_count = 0 actual.err
> > +	test_must_be_empty actual.err
> 
> I think this helper may be misnamed and test_file_is_empty would sit
> better with test_dir_is_empty and test_file_not_empty that already
> exist, though.

That would be an improvement, but it should be written in a different
series.

> 
> By the way, my opinion would be quite different if example like this
> one ...
> 
> >  test_expect_success 'tag --no-contains <existent_tag>' '
> > -	git tag --no-contains "v1.0" >actual 2>actual.err  &&
> > -	test_line_count = 0 actual &&
> > -	test_line_count = 0 actual.err
> > +	test_line_count_cmd --out = 0 --err = 0 git tag --no-contains v1.0
> >  '
> 
> ... were the majority, but I do not think that is the case.  Most
> tests that employ the new test_line_count_cmd in this patch still
> create either actual or actual.err in the working tree anyway, so I
> do not see much point in adding this new helper---it is hard to
> explain to new test writers when to use it.

I'm not sure if I get your opinion.  Did you mean you wouldn't take
whole helper? Or you meant you still wanted to see a new helper for
checking only stdout?  If it's the former, I'll send a different
series to only clean "git ls-files ... | wc -l" in t6400 and t6402,
if it's the latter, I'll rewrite without --err.

-- 
Danh
