Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE8AC33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382121556
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nHJi/0ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbgAMAsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:48:17 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:41009 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbgAMAsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 19:48:16 -0500
Received: by mail-pg1-f175.google.com with SMTP id x8so3869190pgk.8
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 16:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=en3AmEJjzZZ8X7LdMhuAh35bBwCEbfsW5SgnA7loCis=;
        b=nHJi/0aiubqZ+hD4x9MYGQMywTDvfOR6OHWv2MPs6yih/SuQo9MggqJE/17ixcJg2J
         glmMp/ORq9esPW8bGnHQOWJnI8qhKMESFV51m/wZdSEUmVIM/iimCzbsX/icjRJhRFCU
         QfOcJXDQCer7By9WsbKkxnvr7FLi7N/JA62wUgVcC71Lac9BfzMNELTjhresVa+MBi7l
         5koEH2Q1jGVhWHErTLp229iOg2s3IWWjbQVDBXvtw+TgJVEYjV+dNjFc+9iceHML/3DA
         lnzNtu91n5xbEs7t6E36XRtzkkCy/75B4Jc3jfv02Bc4k205XStRo0jtqpNdd/a0Yt1a
         7W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=en3AmEJjzZZ8X7LdMhuAh35bBwCEbfsW5SgnA7loCis=;
        b=cy3kYWps8ZwQ06rm9igPN7o98lgBczsZP/AZAmicfhkHo/dosCz9Blv3dHJ5ueV5y3
         zURAZ6HExXeqFGsxNgvnoTsVKmug2csjPhfHfDfrvd3wBdTgp8QmUuxiZhcWzmkTDkCg
         L32NzHjhFbfm4JPCXn0ToSE3i5/QkGNQzJUwI/O1wwewU9lnoGuTQ71yWIa9xbMGig8Q
         IiAbm9zrercpKPxu3M6AxJYXseT6BMfvG2xwCEVDKqQgntVg5O/J9PtqmtMTFguoEc1g
         avgLfSFbjSHo86CcIOIJN3W9GA6gal8LvOdK0X0+1ep1OZENRS6FyJnzgmaTQcM8VUbE
         V5yg==
X-Gm-Message-State: APjAAAX3wIB59gycPdTdFuG9QD+7HHoAoWHeoKcKQ2l5cqpsvWRmvQCl
        oqhxr0fWfl6mbg01rFhpU+YKADWXptu+yA==
X-Google-Smtp-Source: APXvYqxF6/mE0fhYYe6iawAXdvlz78r0rUxG2Fln+sSqPI4kUYPS1ghAS0YWc55A4IBAIW5FZKeKcw==
X-Received: by 2002:aa7:842d:: with SMTP id q13mr17254922pfn.249.1578876495619;
        Sun, 12 Jan 2020 16:48:15 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:d8d2:10f3:e6c2:e26])
        by smtp.gmail.com with ESMTPSA id g18sm11404600pfi.80.2020.01.12.16.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 16:48:15 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Sun, 12 Jan 2020 16:48:14 -0800
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jude Guan Wang <guan@clicktherapeutics.com>,
        git@vger.kernel.org
Subject: Re: Fwd: Issue with Git Branch
Message-ID: <20200113004814.GA15236@syl.local>
References: <56F9DC91-740F-47C7-9C2A-B6B1EC3A12B6@clicktherapeutics.com>
 <29742805-4992-47E6-9889-F55F5EFBBFF1@clicktherapeutics.com>
 <20200113001143.GA13099@syl.local>
 <20200113004235.GI32750@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113004235.GI32750@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 01:42:35AM +0100, SZEDER Gábor wrote:
> On Sun, Jan 12, 2020 at 04:11:43PM -0800, Taylor Blau wrote:
> > On Sun, Jan 12, 2020 at 07:01:04PM -0500, Jude Guan Wang wrote:
> > > 	I noticed something weird with my git command. In my local
> > > 	environment I seem to have a branch named `-D`:
> > >
> > > 	And I don’t remember how I was able to create a branch like that.
>
> > If you do find a reproducible way to create branches named '-D' or
> > similar, please do let us know, as these are not intended to be valid
> > branch names in general.
>
>   $ git update-ref refs/heads/-D master
>   $ git branch |head -n1
>     -D

I was assuming that Jude had gotten the ref to appear by using 'git
branch' alone, i.e., without the help of 'git update-ref' or 'cp
.git/refs/heads/{master,-D}'.

Thanks,
Taylor
