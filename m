Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC5C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2311261051
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhHQSjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHQSjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 14:39:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F478C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:39:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h9so40543086ejs.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JUetLi+qqYBj27Nc3Ys929f8RpM2jOiaXbvRgaDBOVo=;
        b=Or2KiszRHMdmUb4f0oMDyzE6XExxLjQ8n5iaWQH91Bf5uMHGg73151Pom5I8iCCGOS
         Eu3zgy1jDCEzpDa+LO9JtTsRd7C1mzMAJdeoEEZvKXyhSRIeYVAdADplO9aZnFycHnJ+
         nGyI4MvDxDBLwlmTKTbapDDtLA2VCTd53H24ARclCn0SajIpOytZgmgNIKBOkVZiMAs5
         IEHhfosSSs9O/Up8z0BZOukjnmlqFer8XHw+4sX2HbhSZdHT1vNcIgOjcwSCuLUpgWEn
         z4k+0O2O3KoaeLtYXkIfpjDs+7Oc6ISSkXXknmVm6msi5FNHpVkPSaNys9M2fHFya7g8
         uYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JUetLi+qqYBj27Nc3Ys929f8RpM2jOiaXbvRgaDBOVo=;
        b=B3V6NCyc+sJbh4DK1ZT9V0y/aDIcLO+NqxT5pg9eeeIMLUoFinwjZpUQAEG1HSm3r6
         x2UUu5HaUsKVbrznjmjlRsthqtYUvIFRj9+mDIyPbaNkBnJyVikITNPESrX6p1MuM0cV
         dimi6IwtKIHzprFgivgF3Unm/iCxE2ZZU4cnRyMQXzXFC7rYQ/+6Tj3qQ+5hImR2mull
         79WiBBIFA575PQ2Xc2jfHC9R7zW8ybgnk5MOj/9oLZb6Q3PC0GujBnvIXd1++mEjbXih
         LdKG756Wsc6ckIMc/j5ArAgIjUr4C9D8z+wCrvvyW2RvtIgH0fy0AuS+AjFktGYbtCY/
         2lEQ==
X-Gm-Message-State: AOAM5320278NKX5StOdwtNRfzY3s4Ub3RdPEGB6h6mgWypuB/MmJTMSk
        mIrONucqgIF2ISb7HzskdopiUpQkOAg=
X-Google-Smtp-Source: ABdhPJx3Mj+yL3wJfC9pu5lnpiLRzCIuk/pUzuB0a/nczgFkCdeWWeVhubKJ4aPWmLx1CYmuYoswhw==
X-Received: by 2002:a17:906:d7b6:: with SMTP id pk22mr5593895ejb.522.1629225559078;
        Tue, 17 Aug 2021 11:39:19 -0700 (PDT)
Received: from szeder.dev (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id y2sm1078802ejd.111.2021.08.17.11.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:39:18 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:39:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/6] t1600-index: remove unnecessary redirection
Message-ID: <20210817183917.GC2257957@szeder.dev>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210817174938.3009923-2-szeder.dev@gmail.com>
 <d8d8d59a-ecac-2cd5-18a3-f1cb65e48c2e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8d8d59a-ecac-2cd5-18a3-f1cb65e48c2e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 02:12:36PM -0400, Derrick Stolee wrote:
> On 8/17/2021 1:49 PM, SZEDER Gábor wrote:
> > In a helper function in the 't1600-index.sh' test script the stderr
> > of a 'git add' command is redirected to its stdout, but its stdout is
> > not redirected anywhere.  So apparently this redirection is
> > unnecessary, remove it.
> > 
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  t/t1600-index.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/t/t1600-index.sh b/t/t1600-index.sh
> > index c9b9e718b8..5d10cec67a 100755
> > --- a/t/t1600-index.sh
> > +++ b/t/t1600-index.sh
> > @@ -79,7 +79,7 @@ test_index_version () {
> >  		else
> >  			unset GIT_INDEX_VERSION
> >  		fi &&
> > -		git add a 2>&1 &&
> > +		git add a &&
> >  		echo $EXPECTED_OUTPUT_VERSION >expect &&
> >  		test-tool index-version <.git/index >actual &&
> >  		test_cmp expect actual
> 
> Since here we have a 'test_cmp expect actual', perhaps the
> actual mistake is that the line isn't
> 
> 	git add a 2>&1 >actual &&
> 
> What do you think about that?

The actual file is written two lines later as:

  test-tool index-version <.git/index >actual

So it seems that neither stdout nor stderr of that 'git add' command
matters.

However, in most of the preceeding tests 'git add's stderr does indeed
matter, as they do:

    git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
    # write expect.err
    test_cmp expect.err actual.err

I suspect that the 2>&1 redirection this patch is removing might have
been a copy-paste error.

