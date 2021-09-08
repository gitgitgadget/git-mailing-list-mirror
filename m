Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC85FC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8FA60EB7
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347332AbhIHCcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347240AbhIHCcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:32:05 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D367FC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:30:58 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x5so746760ill.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gc4AKu6CDUrMXgwQ13YHxFBUeTCfd1i95hwjcxdLPZM=;
        b=reSPPkgVt6mmcbxVvHawcTKW5GMvr67lL68qIoIDz6Qtto7ZlmY1RmcqCMMZVi5w4r
         cSQbc0yZJQmwDc44laCFQq++KsLgQCYnCHuS+gdTRZSDKZotdQEWdzmtByy/IePzG7uR
         4vIZ7vsXlUi1GLs4u0+ssp9F3yWXX5J0p94f5717HHWorg2ojdkvWlnyD+K8Msy6PVmo
         l6KOxPXCRU+bDXhLf4Csbh4PI+5UxZPsCd3XPWmUwHCGybbTCXnb6gz1SFf+94Ol3SAU
         ZpkfsOdgDhVeGRBMtCL4iO4inBOc5VcoZOxa+0ZAlfVKVY29TL+J439B/dNfB/b37B86
         aQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gc4AKu6CDUrMXgwQ13YHxFBUeTCfd1i95hwjcxdLPZM=;
        b=a1gBGSeK7cLIRcW7vqJpwa5T/DgukwlVbDqGvmmoNGW3MrDTqYFz8zqP6KrH+ElKyh
         VcOyVsAX9OMSn0CjUJqbqzppQEPiVLl30+dHX26lqAaXmufvgiTBVDKVMfhHivqE6OYh
         uB2N1KN3/A3Dja1FtPuSGUu4Lq4o/51PakO5D79SXsbcayeXO0y4WDZZ/ya1l8pZkmgr
         4UaWsihdivBaw/UYvtvJzFAsKszWLhXxX79HHE5SpX+kdPFmwxSWGNsJrfUlHr7vsQM/
         v6wsaa59o3l7cccLaOCi8ZrsJseoN2f17CH2cn7Wmm+YgrWntPfSAWm4yMDx/+oUSk0n
         oYcw==
X-Gm-Message-State: AOAM533ZddD4wEhrpx8Bo+HWaNh23pqrb6+6D/4vzIwM50zlx7EI0noL
        zBkQakccZ+gejScvX12zwfs1XA==
X-Google-Smtp-Source: ABdhPJxL6p9SJL5bye+upgh/Ks3o+FkSSpxXTXU0Tj6OZMvU4RiP7A9dSMwuNpnEu8O+H67lnI2iLw==
X-Received: by 2002:a92:cbc6:: with SMTP id s6mr1065345ilq.260.1631068258303;
        Tue, 07 Sep 2021 19:30:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9sm479771ilr.36.2021.09.07.19.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:30:57 -0700 (PDT)
Date:   Tue, 7 Sep 2021 22:30:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YTggYXtyS/AW4JRF@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <87zgsnj0q0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgsnj0q0.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 03:46:29AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Sep 07 2021, Taylor Blau wrote:
>
> > Now that we both can propagate values from the hashcache, and respect
> > the configuration to enable the hashcache at all, test that both of
> > these function correctly by hardening their behavior with a test.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  t/t5326-multi-pack-bitmaps.sh | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> > index 4ad7c2c969..24148ca35b 100755
> > --- a/t/t5326-multi-pack-bitmaps.sh
> > +++ b/t/t5326-multi-pack-bitmaps.sh
> > @@ -283,4 +283,36 @@ test_expect_success 'pack.preferBitmapTips' '
> >  	)
> >  '
> >
> > +test_expect_success 'hash-cache values are propagated from pack bitmaps' '
> > +	rm -fr repo &&
> > +	git init repo &&
> > +	test_when_finished "rm -fr repo" &&
>
> It seems the need for this "rm -fr repo" dance instead of just relying
> on test_when_finished "rm -rf repo" is because of a 3x tests in a
> function in tb/multi-pack-bitmaps that should probably be combined into
> one, i.e. they share the same logical "repo" setup.

Yeah. There's definitely room for clean-up there if we want to have each
of the tests operate on the same repo. I have always found sharing a
repo between tests difficult to reason about, since we have to assume
that any --run parameters could be passed in.

So I have tended to err on the side of creating and throwing away a new
repo per test, but I understand that's somewhat atypical for Git's
tests.

> > +	(
> > +		cd repo &&
> > +
> > +		git config pack.writeBitmapHashCache true &&
>
> s/git config/test_config/, surely.

No, since this is in a subshell (and we don't care about unsetting the
value of a config in a repo that we're going to throw away, anyways).

(Side-note: since this has a /bin/sh shebang, we can't detect that we're
in a subshell and so test_config actually _would_ work here. But
switching this test to run with /bin/bash where we can detect whether or
not we're in a subshell would cause this test to fail with test_config).

Thanks,
Taylor
