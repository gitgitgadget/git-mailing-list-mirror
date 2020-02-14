Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A05C352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4918A20873
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcNx130E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgBNBUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:20:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35747 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgBNBUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:20:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so3068191plt.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDQA2+bLvqOdvcEztGuVa3+zH6M+KSJx7inHOeKzIbI=;
        b=bcNx130ECRohhfSUVKWfS5/Xjwt+gLO2Jdhp/ddFX0NwLggM7o4u/E3e0ho6HNXZfL
         s9kI5KLj1n+e6Mp/+32sQ3MzcxLZTZOpViLmhho0EH/hwlFo7/mU/CHkdHgM4et9mgQ2
         Mb7qRHh/S+84SlhnvDkfQCVzI9J1Etr+OBhud40twyKeqqCMwUkBU2TxVloWA603E7uY
         beqoY0GN3g7TWvIGquT5M3BO30ormPrn2nBt81Ed1Mwdrv7UY3UdHrFsRZQ7QhcupCXz
         M70w8PR0Oe0C+3leNr/r1kCjxx94PMxtMEP2Rap9Tnexik+FLiem3zJAoLmlcYu1L57A
         3/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDQA2+bLvqOdvcEztGuVa3+zH6M+KSJx7inHOeKzIbI=;
        b=diEFrk/vgesnqvrq7IGpa9IY67UF9eoihaj52YEossPHLufs4z/O0mCHRH+sLVzewH
         7hVTZNufXoeGk7ygSzLABDInOXMJ4Jj/uCcmr9a26T3FwHUV3k8RFHAcN0rpGvPz4Q5u
         GAklPRg26jlwHT7PUJyEAE2ciFvf4nJuWbz0NorsLr1DXqpln+7sSkadbtep/wqZ6iLT
         7AocdVUp9WeP3F9jltIlt/i+sFfjshM2ol6tt4LHUsuuvcDNNAGctImdp3Nj/8/nov/4
         ITp/uLWMse/YX/ssjxXiYRU47XyeEodAfE9VxdErA5xHZn/KFvpVodgyuZtDMsXB2MtR
         fKQQ==
X-Gm-Message-State: APjAAAUvVT+jT0LT2VVn/+pElRPKU2hn1WgafzRUb2RUe4sWRBgGU45d
        /yP1MXSJjl3uKNss1MIPB2dGkw==
X-Google-Smtp-Source: APXvYqzmkDUYsX4qw7yy3gwmJQWVnOVPQdzqvGVsx16xOcsXJZ/yk3ANJ+d7T8G2KZj2tPaJg1N4YA==
X-Received: by 2002:a17:902:9b8b:: with SMTP id y11mr754610plp.189.1581643243128;
        Thu, 13 Feb 2020 17:20:43 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d64sm4449544pga.17.2020.02.13.17.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 17:20:42 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:20:37 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v6 01/15] help: move list_config_help to builtin/help
Message-ID: <20200214012037.GK190927@google.com>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-2-emilyshaffer@google.com>
 <20200206013533.GA3993@danh.dev>
 <20200213225834.GI190927@google.com>
 <CAPig+cRDbOyDQm6wx7+fZoKDfehLjkPc3qenR5Mhc8OkeFJqbw@mail.gmail.com>
 <xmqq36beqdez.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT3gSARiHFN=79Z_BBACDyOqW8nZ+7RwODAmLrDv1SHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT3gSARiHFN=79Z_BBACDyOqW8nZ+7RwODAmLrDv1SHuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 06:29:39PM -0500, Eric Sunshine wrote:
> On Thu, Feb 13, 2020 at 6:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > On Thu, Feb 13, 2020 at 5:58 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > >> Thanks for the suggestion. You're right that I didn't look into the
> > >> contents of this script much, because I was just moving it; I modified
> > >> your sed expression slightly so it performs just one operation:
> > >>
> > >>   sed 's/^.*$/    "\0",/'
> > >
> > > This isn't portable and won't work with 'sed' from BSD lineage,
> > > including Mac OS. More portable would be:
> > >
> > >     sed 's/^\(.*\)$/    "\1",/'
> >
> > Or just replace Emily's \0 with &; that should be in POSIX.
> 
> Yes, that's nicer.

Sure, thanks.
