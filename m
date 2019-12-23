Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFE1C2D0D5
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A320709
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 21:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3RYPaiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLWV7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:59:31 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:52012 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWV7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 16:59:31 -0500
Received: by mail-pj1-f53.google.com with SMTP id j11so324102pjs.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 13:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SyrdCAQG3tMkzo900MY6dNpZqvK5+io8FBeOTx+mVyA=;
        b=b3RYPaiJufMXG4UqNabwi51k67TQ2gBC2AqU5MBilRwbWJ//fJddCBnjse2IRkU2z/
         pt7lc+dWd0tSGvYeygUfN5lMBTf+WzBqYEzKtevBu592MZWzVQTynhTpcoSnxMZobKgJ
         eJI7Pu7nT9/xcOc0Qvnl+b+jTsQ3a4uYYCaKASrB2QvS0H01kiC4K+A/Vca2ncqGzNPr
         wDp327ySZanBrR8ZkZ7ZlceA5Kin2qxJRHFLEehbXNPZbxNiDLRNqV2B1k5BK+Q8w2s0
         7NQ4vrw6XnPMiy4o+ysS2AtaN+KSxtrs7JvN1dtK0JTdq9Stsnjy8NFWRFYp5UTpmymS
         iubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SyrdCAQG3tMkzo900MY6dNpZqvK5+io8FBeOTx+mVyA=;
        b=R5nZPoCSIqa6x0fM7rt6G2PmMJNko8hhN+QluG47LXPR5gsBTaT2YS5SbXZ9QHB++K
         MOt3tHmHlMdsjLarr9jVq6EC0pwtsEtWWtyrJpEeYickeYQ+GRT8n1SCpCbGbXxvhquK
         8lzBCPFuse4dRbe6t9/aoCLpgLttO0JH/8H0lEPPIlnm6HtJCPBkIbwJGRSINC3xsLXt
         BowrjjyEVMK2Vzn6N2Bulmm+lMYTY0Dbrlm2VU91+18h+Zkcrnohdv4gGdB8FtYQcvGf
         Gaf4GZHFFczw6pblEYFxPGLXVckwN0q7rfexONk9K583NjHiCDRc/g71Ws9mSqZxdig/
         vWxg==
X-Gm-Message-State: APjAAAUlNhDMZJV7tAkfMfnR6qOv6Wv4pGmNCmTslfdK+kLNjdOtlwiH
        uQ8/jHgU/OKyjBApo1RhOe8=
X-Google-Smtp-Source: APXvYqz1wbfewlWIOvn1QMuDnQkjVfV9DCtcTlTamVSB5NU64iOIiHsOHDInD2iWuYe5JrYojPX7Yw==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr32200060plc.117.1577138370753;
        Mon, 23 Dec 2019 13:59:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i23sm4821297pfo.11.2019.12.23.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 13:59:30 -0800 (PST)
Date:   Mon, 23 Dec 2019 13:59:28 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kevin Daudt <kdaudt@alpinelinux.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Arnaud Bertrand <xda@abalgo.com>, git@vger.kernel.org
Subject: Re: Mismatch meaning between git-diff and git-log for the .. (double
 dot notation) and ... (triple dot notation)
Message-ID: <20191223215928.GB38316@google.com>
References: <CAEW0o+gYqWT5u-Tf8aDoMgXaf36Mb-XOApLNs4D+GMVLvsOjxg@mail.gmail.com>
 <xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com>
 <20191223182939.GB676947@alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223182939.GB676947@alpha>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt wrote:
> On Mon, Dec 23, 2019 at 10:02:31AM -0800, Junio C Hamano wrote:

>> Please unlearn dot-dot and three-dots when using "git diff", which
>> is not about ranges but about comparing two endpoints.  If we were
>> reinventing Git today from scratch, we would make "git diff A..B" an
>> error.  You can consider it a bug that the command accepts a range
>> notation, but this will not change any time soon without a large
>> fight to find and fix uses of the syntax in scripts by longtime Git
>> users have written over the years.
[...]
> I agree that you should not use `A..B`, but what is wrong with
> `A...B`? The alternative is a lot more verbose.
>
> git diff $(git merge-base A B) B

Commands like "git checkout" have been learning a `...` shorthand
which is not much better as far as intuitiveness goes:

	# doesn't work, just here for demonstration
	git diff A...B B

With hindsight, "git diff A..B" would be the perfect spelling for
this, but that would break too many people's muscle memories and
scripts.  Would it make sense to have a commandline option for this?

	# doesn't work, just here for demonstration
	git diff --fork-point A B

A random thought,
Jonathan
