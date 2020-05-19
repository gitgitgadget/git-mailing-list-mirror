Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1562BC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D694720674
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4M4wG7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgESXB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 19:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESXB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 19:01:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797EBC061A0E
        for <git@vger.kernel.org>; Tue, 19 May 2020 16:01:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so547644pgm.1
        for <git@vger.kernel.org>; Tue, 19 May 2020 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z7PzawgaJfAiEfb1+uU29ijq9EoaFmS1QgzJXz8AQUQ=;
        b=O4M4wG7sRCqki62VwDdP9dGOYe4at7wH4xbi+LXNwXwEoRVj+JTE8cEKWJevrGSA+v
         1/DPVTOs0f+wDQfDGkyBIfT8DyJY6Xy3pS5ffdOMb8hJ/RjKzxnjnRus6T2+iuWWEuik
         f08xeSSyalSkT27VmbIgDI39qXTRKq57LMriybO4ADcFewGhSeq6Z64zoVxygmof9kEG
         EdBpS5x9bdF1sJRqaDcgtQ/AbR74MNcYTsVmIaNeLAsEkRORSXe/lJ87Ci8BmaI81sw/
         a9lr/RhL1ASMn2N4y5W3dMi3LJk8//klJ1T9CuLBXgT97R7uBTDylmIQvzgsa5g+Ff/Q
         kbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z7PzawgaJfAiEfb1+uU29ijq9EoaFmS1QgzJXz8AQUQ=;
        b=YGrusGlNQ8h4cykY3fQd+OzZoZ/gKjvOHCqqRd8WqDFAG9FgyGRTLYCUOvqrMwUOiI
         xUomz4drK6biHmzaiH2R3AFNc3EAtwKXHUWAgPNFbC0HhxvYfSmJ/LH9WHno2aVaci8u
         s1Tau+mINr7+zkiRpWitycNhrSpzwq6672uJUWWYIlP0SIzyvIJM6ldUuz191a967QxQ
         FP2bfZH3i+5BNsLrDvseiKP5qnCYjHBZYEMRB7sa/TqYAKC+jNneQ0Ch/utEosoo7FCa
         XCi3hqxJLsnVCcI7sbXyp1r/WIhc77pXtc6jMcsY4WK+Jriz7Nqe0tX83UvkJaOVo/94
         TWuA==
X-Gm-Message-State: AOAM533MTgNYZD/TOwnvVYaKyz2Finq3U0r+8LdvO9YlkQz0Rn/78ps1
        i3SbNxmYwCeRbacQ87JXeZQ=
X-Google-Smtp-Source: ABdhPJwcGVSGp1d1IXUX+Y+hQg04uWs9ZkjNoKMIx9O0pmckSOa5Sqmsai9kuzMOeipPGFGVvfIG3g==
X-Received: by 2002:a62:6186:: with SMTP id v128mr1291192pfb.185.1589929287908;
        Tue, 19 May 2020 16:01:27 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id m7sm436329pfb.48.2020.05.19.16.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:01:26 -0700 (PDT)
Date:   Wed, 20 May 2020 06:01:24 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v7] diff: add config option relative
Message-ID: <20200519230124.GA12509@danh.dev>
References: <20200517021452.GA2114@danh.dev>
 <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
 <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
 <20200518191205.GA1999@danh.dev>
 <xmqqo8ql0yjg.fsf@gitster.c.googlers.com>
 <20200519003006.GC1999@danh.dev>
 <xmqqv9krztwp.fsf@gitster.c.googlers.com>
 <20200519193902.GA202573@spk-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519193902.GA202573@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-19 21:39:02+0200, Laurent Arnoud <laurent@spkdev.net> wrote:
> 
> +check_diff_relative_option () {
> +	dir=$1
> +	shift
> +	expect=$1
> +	shift
> +	relative_opt=$1
> +	shift
> +	test_expect_success "config diff.relative $relative_opt -p $*" "
> +		short_blob=$(git rev-parse --short $blob_file2) &&

We need to quote the first dollar, in order to run that command
inside the test.  Current version will run that git-rev-parse
outside of the test and interpolated into this command by outer shell.

	short_blob=\$(git rev-parse --short $blob_file2) &&

Sorry, I didn't think about this earlier.

> +	test_expect_success "config diff.relative $relative_opt -p $*" "
> +		short_blob_file1=$(git rev-parse --short $blob_file1) &&
> +		short_blob_file2=$(git rev-parse --short $blob_file2) &&

This test also needs to quote that dollar.
Beside that, LGTM.


-- 
Danh
