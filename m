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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FCC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E69620756
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 10:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT5EZIqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgKKKYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgKKKYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 05:24:16 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4EEC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 02:24:16 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so2029992ejy.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 02:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RSlyFZymeX2WOvJno0GLB53xqqZz4YfpP0N2jrE1x9o=;
        b=KT5EZIqRRhmfJ1unExKXfBKTKlWkQMImuq7/ORrWG9NPMnHK1pEAzv3VkIZ6jWC5WH
         p3rrtZzXnPyxACIUJfKtsASW8nQ8NgxrwYAKdkMWVe8n+Whusllot7/X0rv3UVl7qgoe
         II7Pv45OaV+1v1InT1SPmr3hZk7FVuxXzSBHOSxuEGrFwjWu5HPiPxdMxAnt7hdUrINU
         HBBKsCKU246HMm0kYf3zaGPDFmcjvSuUAhu6qIKx+JT+6AYytjGwP8PcC0Snk3hLGjMl
         gd6vQaLpKDVWSBvjy7ALpf5ZdyIwyjTDR8Ze/FlpkqH+d5Uiz0k4fvV4Psf68tjBTCvR
         DCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RSlyFZymeX2WOvJno0GLB53xqqZz4YfpP0N2jrE1x9o=;
        b=pjukenHK1Qi46nVuAVnW0qTN/rjYu4lU9QGnRuGNlSXkTMopuFwYNcMTko/7r0irob
         soPMhAtKMKDkEyFreSPX6GOFQ3U00Yj7uSgXrOAzRb0H6yba/bbhr4fMeoaLJ2x458sM
         tyxrdbIMSX4EGC5obeGDKZN4PzdMyLipaxgxZ6IA2Sd5xydwZigKR/La9ex7tKsJ/4Ng
         LSKtePgaA8s61+UJspgTwCq11LAvsyxTqy34BK7VzuT7NMm+YNNirN+GxoguTnBuR3va
         oJe08S64kXa71gNUEdr1PTxxEaPvzMHSSW1V54bP+hDsW090sDgC1lKjnEowM/quFwo9
         nvUw==
X-Gm-Message-State: AOAM5309k31tLExy4U5jf+lit5ccTSH115oT4DiwH4G9lGJyQIMSrUNT
        Io5VNsJJz45JRS2a1y4MQDo=
X-Google-Smtp-Source: ABdhPJyxvsRCJ1C/SaMlxxIgiaVhBHb5InrFtdiSdbJfSxIl4b5xYEcehBMd5qoSYqpJISWsLMSiNg==
X-Received: by 2002:a17:906:51dd:: with SMTP id v29mr24765229ejk.69.1605090254923;
        Wed, 11 Nov 2020 02:24:14 -0800 (PST)
Received: from szeder.dev (94-21-58-64.pool.digikabel.hu. [94.21.58.64])
        by smtp.gmail.com with ESMTPSA id mf13sm689130ejb.5.2020.11.11.02.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 02:24:14 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:24:12 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v3 1/4] t1400: avoid touching refs on filesystem
Message-ID: <20201111102412.GB4270@szeder.dev>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
 <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
 <20201111090454.GA4270@szeder.dev>
 <X6u2Lz9khi+DeF87@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X6u2Lz9khi+DeF87@ncase>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 11:00:15AM +0100, Patrick Steinhardt wrote:
> On Wed, Nov 11, 2020 at 10:04:54AM +0100, SZEDER Gábor wrote:
> > On Wed, Nov 11, 2020 at 07:58:38AM +0100, Patrick Steinhardt wrote:
> > > The testcase t1400 exercises the git-update-ref(1) utility. To do so,
> > > many tests directly read and write references via the filesystem,
> > > assuming that we always use loose and/or packed references. While this
> > > is true now, it'll change with the introduction of the reftable backend.
> > > 
> > > Convert those tests to use git-update-ref(1) and git-show-ref(1) where
> > > possible. As some tests exercise behaviour with broken references and
> > > neither of those tools actually allows writing or reading broken
> > > references, this commit doesn't adjust all tests.
> > > 
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  t/t1400-update-ref.sh | 72 +++++++++++++++++++++++--------------------
> > >  1 file changed, 39 insertions(+), 33 deletions(-)
> > > 
> > > diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> > > index 4c01e08551..d7a57488ed 100755
> > > --- a/t/t1400-update-ref.sh
> > > +++ b/t/t1400-update-ref.sh
> > 
> > > @@ -188,27 +194,26 @@ test_expect_success "move $m (by HEAD)" '
> > >  	test $B = $(git show-ref -s --verify $m)
> > >  '
> > >  test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
> > > -	test_when_finished "rm -f .git/$m" &&
> > > +	test_when_finished "rm -f git update-ref -d $m" &&
> > 
> > There is a leftover 'rm -f' here.
> 
> Oops, thanks a lot for catching. Funny that it still passed.

The '-f' option makes it ignore missing files like 'git', 'update-ref'
and whatever $m happens to expand to in this test, and '/bin/rm' from
coreutils (and apparently on macOS) understands the '-d' option
("remove empty directories"), so there was no error to fail this test
on common setups.  (I didn't investigate whether and how the not
deleted $m ref affects subsequent tests...)  But nowadays we have a CI
job running the tests with 'busybox sh' whose builtin 'rm' doesn't
have a '-d' option, and it errors out with:

  + rm -f git update-ref -d refs/heads/master
  rm: unrecognized option: d
  BusyBox v1.31.1 () multi-call binary.
  Usage: ......


https://travis-ci.org/github/git/git/jobs/742890453#L2853

