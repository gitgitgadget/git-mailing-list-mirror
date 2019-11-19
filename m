Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7840C43215
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6E920718
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj4/xJFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKSXgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:36:50 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38605 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSXgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:36:50 -0500
Received: by mail-pg1-f170.google.com with SMTP id 15so12337463pgh.5
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbdhJH3mUdyaKreNdrlbmHRb7pYfFWdyOAbtnaKN2vE=;
        b=mj4/xJFJPPPJZmg515evZTaZWepbkfbXqsWbCA9ijkVwrLQEcnoPuYv14IgdbCCjDB
         /JcAxuCaZGu/wxbSwOZtpdyQ00umjohVPmB77SsnPEvoesZQ2GMC2MJhCCbWKefXjA+U
         eL/Alskv4tatvWdsIiRBOwmvLM074sVTswEmNgllI+mCGfBfhb9IvJT5gygb1p82HU3s
         DLJwmlHr5X3B2e/GcUba2ihmG4ei0ApWxq5w6c3K/3Utuy27Rzkw7P4Fs6KhS8pHcq/s
         BuqkIQRtyPCMOubrq16szhbG+Cl8jCNkOiTbheLDr8RxODilWHWNivh8Hl+0pENScRUw
         mllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbdhJH3mUdyaKreNdrlbmHRb7pYfFWdyOAbtnaKN2vE=;
        b=Y+DKcZk/iq0yj6i1yyTkIiW0kl+jpPSd2UCdwmN+Ur3XH/vuKujis51efOq1729ESS
         ol0aIDEAZbxVzhLJhaJ1UsLg4PowEcpXzNNMhn9HRfRDc38vCoyyPkw0T1gFPRMHoD2w
         dojTrD5a9BwfB1wwQ9EnLuz6rtKY3mImSDM/w5R6cgQY0p+XkFSuRi9W/6jYwqRFvVlX
         kNMjU9/Jla1rEZLhle8Wc94yG2KlWBnQ9HitPeyPLyo2g4xvWZyPoQB9CpSLDFMxYo80
         wy/p9VRCat16hKd4La9oYEY2Vgvz8HsUzR1ldZmbQQDbook7fN6+OoEvsnmNmXqcnB0n
         mc0A==
X-Gm-Message-State: APjAAAXce9YOSe4eZHEoDbBqYbm+tP71I2K7+OUojiG1jHIx1T9+XlXM
        G6M2go/8XDPEnItb3xD8LXg=
X-Google-Smtp-Source: APXvYqxCJaquiOkXYfgn3PocmJJClH3CXSPYTHo1BlJsbK9h4J7MnbNaRx+NYZewQUO7oPvqM5rF+g==
X-Received: by 2002:a65:4506:: with SMTP id n6mr8551738pgq.105.1574206609571;
        Tue, 19 Nov 2019 15:36:49 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a19sm24389736pfn.144.2019.11.19.15.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:36:48 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:36:45 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Force.Charlie" <force@forcemz.net>, git <git@vger.kernel.org>
Subject: Re: Protocol v2: The wrong --shallow-since time format causes git to
 wait indefinitely
Message-ID: <20191119233645.GA99848@generichostname>
References: <tencent_AB1A7466D1F2EF9A84B437705F06A7652709@qq.com>
 <xmqqpnhwbfx7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnhwbfx7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Nov 13, 2019 at 12:42:28PM +0900, Junio C Hamano wrote:
> "Force.Charlie" <force@forcemz.net> writes:
> 
> > # time format wrong
> > git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
> 
> That's the valid/right way to specify the timestamp that is
> 20,151,012 seconds after the epoch (i.e. 1970-01-01), isn't it?

I don't think so. When we run the same thing under protocol v1, we get
the following:

	$ git -c protocol.version=1 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...
	fatal: the remote end hung up unexpectedly

even though the following does work:

	$ git -c protocol.version=1 clone https://github.com/git/git.git --shallow-since=2015-10-12
	Cloning into 'git'...
	remote: Enumerating objects: 93982, done.
	...

which suggests to me that the non-dashed form is invalid.

Thanks,

Denton
