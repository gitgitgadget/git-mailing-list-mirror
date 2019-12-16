Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D6C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA38206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 16:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LNiril9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfLPQsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:48:32 -0500
Received: from mail-yw1-f41.google.com ([209.85.161.41]:35518 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfLPQsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 11:48:32 -0500
Received: by mail-yw1-f41.google.com with SMTP id i190so2715234ywc.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 08:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r+Zm36GX8FUYLHZzV4eqG7l9TYxDvkF6Zm4nOLil35o=;
        b=LNiril9XtmzC0ea1p3lq/A+WSVT+2/CrCSmAS4Vviy0QtQnp0CjNcnmCQz5zhsbPpG
         UcmffRmlerUbr91rzU9UxDfatlsIWdpxcss/jKMGkaucJmWS8ti8DtaB4dhnA43nPtLF
         +KLlbfb3WkaOJA8fhe1AcXIaBf95sCk9p1nkDK7PK2E9W0isNJc7oAxNa6Lbiahe3SDO
         Acy/N1U4z8lTkQDa6b/kih+KRezNw2yUAWcMEveHe6CE62nu92vyV9c8B/SpuJ9kwEFH
         CvVIp+66OiRKvoGHsur+mEz/oYtfUc1Vx4ey8UsiTdDF2d80lyemjhrV/neDYnIJhIlt
         esfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r+Zm36GX8FUYLHZzV4eqG7l9TYxDvkF6Zm4nOLil35o=;
        b=GyIq16lHnXdD4zF7q7WQM4cXt4xLpEzNWX8eALrC7nL46S0d3QM0SQ27/B/+8b0icF
         BTl4/HpsFug263fe/TH1ygEepMoNJmBSseCAEt/4ajnc3na+ZydjYgn+OjqtkVHjbgyC
         bZVVDhciJTIcbe/p3hlurpofMuzo1J2spchMtP/GysBfevk87eD/1b32qs+msoeLworQ
         Q7RkdDuRzCyd3xBNgmTLKVwu9m4T1qX+hq9H62QK6x0WAhOtXLa54IqSwrwkybGEvUqw
         JfG4aTiTVIqTVSoh3cw/eudsfhtMuWFB2F98emkSBlwK6Wmxy48y+GrKMm84UERW6JmR
         XXvQ==
X-Gm-Message-State: APjAAAVsrbrrVz4pbaEA542uNO45vTU5Y2Sk45XrGSiLYZ/OcrQkyCAE
        7Dz3gcLH1I/YCV7x9AEiSC5JGQ==
X-Google-Smtp-Source: APXvYqzRhkRDKvf6KseWdShC+CCOxAupO5GuCzt/H7/rhYgLqCJUpiA6968fOMALxg972FzsXE7CUw==
X-Received: by 2002:a81:7996:: with SMTP id u144mr5972852ywc.13.1576514911263;
        Mon, 16 Dec 2019 08:48:31 -0800 (PST)
Received: from localhost ([2601:401:c500:60a0:4d45:c8f4:844:e24d])
        by smtp.gmail.com with ESMTPSA id s130sm8788012ywg.11.2019.12.16.08.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:48:30 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 16 Dec 2019 11:48:28 -0500
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.24.0
Message-ID: <20191216164828.GA64423@syl.local>
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
 <20191104054924.GA47418@syl.local>
 <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com>
 <20191104062334.GA49488@syl.local>
 <20191216152047.GQ6527@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216152047.GQ6527@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 04:20:47PM +0100, SZEDER Gábor wrote:
> On Sun, Nov 03, 2019 at 10:23:34PM -0800, Taylor Blau wrote:
> > On Mon, Nov 04, 2019 at 03:18:32PM +0900, Junio C Hamano wrote:
> > > Taylor Blau <me@ttaylorr.com> writes:
> > >
> > > > Thanks for a great release. As always, your release notes were
> > > > very helpful in putting together GitHub's release highlights [1].
> > >
> > > Well, thanks for writing a version readable from humans ;-)
>
> > Please do let me know if you find any other such typos :-).
>
> The commit-graphs section contains a list, with one of the items
> linking to "lots of bug fixes".  The last of those links points to
> 2e09c01232 (name-rev: avoid cutoff timestamp underflow, 2019-09-24),
> which isn't in any way related to commit-graphs.

Thanks. I think that this link may have gotten lost in one of the many
shufflings of this blog post. I let one of the blog administrators know
about this, and they should remove the link shortly.

> Better late than never, huh? :)

;-).

Thanks,
Taylor
