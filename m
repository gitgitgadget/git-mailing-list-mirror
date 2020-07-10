Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5EFC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEC42077D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDxhESLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGJVNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgGJVNr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 17:13:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D8C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 14:13:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o8so7454530wmh.4
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F2APNfeG6XGrr7EXZc1c7dcWpDrn+ETQeNQOAj93AfM=;
        b=MDxhESLFlg0zTk3baVa3CKu1uAkOrU2P4JPL02kZNNn2KjLIFPA44KIEEemaHM29Ob
         0KXYEp9vf4vEYmtNQfPNibSuwmtqL+TahCXkTTw5AfJKHMDCEMsJkrCBfhDcDbhvE9sA
         yomSK0GyeZvENQC6cj7QgnEtIPpFvJf79Dk7bjjrnw/gvjfnB0D0UqYg/bgVNanB2iDo
         iY8KHLHJyeX4irbEX7Fa8CGE9b4CbGQMADldv1o95+a8Rz7TlROnLPlHPn9+FUANO3Zp
         aGgZqoZ8pQmF8AL0rM+GDptHUg6AOYp0F+9kSjmz+jSeB3DIcfeuIHQN261fGU9En7Lw
         yjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F2APNfeG6XGrr7EXZc1c7dcWpDrn+ETQeNQOAj93AfM=;
        b=dLneY4c4ol+be3eyJz9TLzZNbReYcQ5AZHTk2a+8T6tF7+7nJd5jLwtx6OGtxtyGZD
         JfCHsPaYqOOEnAHz18rbc/UGA/4rsJQjA/iDnkab1ZEROPBCMsPL2+bGyk4zqB1n9CzO
         aO1dkr0tLE6OFm/Mn+kVs2XpURdmvxiIIehhcIA7kxGbeV+ILWarH3VII2isyLArRHPu
         CZYemZosFCi0FQRDjEmXS8wkTlwbVcEPGRNZXARvLVC2u+8YfkK/7xzXRCnVY5Adix05
         pTlzLVAbdMqCSjd+venflCLxNmbuCrcbz2Mmifs67MJ7SD3vh0eA531/7kOXmL+Zg/YJ
         g87Q==
X-Gm-Message-State: AOAM531NbGw4qoBH1wdq0f7w79siF6s3VhBePl5wKg0UZ5lzvMq11RNY
        w7h6WiCAf6xvlQnKgBNrM98=
X-Google-Smtp-Source: ABdhPJwvXiQgisr3CvQfHQ7rttB0tA5bKiJsgiOZ2eVf5cxdGWy+qfuZN3p4sFDjE/axm07aOyMKJg==
X-Received: by 2002:a1c:449:: with SMTP id 70mr6482263wme.149.1594415625663;
        Fri, 10 Jul 2020 14:13:45 -0700 (PDT)
Received: from szeder.dev (78-131-17-27.pool.digikabel.hu. [78.131.17.27])
        by smtp.gmail.com with ESMTPSA id n16sm11571218wrq.39.2020.07.10.14.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 14:13:44 -0700 (PDT)
Date:   Fri, 10 Jul 2020 23:13:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul
 2020, #01; Mon, 6))
Message-ID: <20200710211342.GE11341@szeder.dev>
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
 <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
 <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
 <7ce9163b-eafe-20a8-bd8e-7042807c98f0@gmail.com>
 <xmqqimez5l5q.fsf@gitster.c.googlers.com>
 <20200707172123.GD11341@szeder.dev>
 <xmqqa70b5h3w.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa70b5h3w.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 11:12:51AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Tue, Jul 07, 2020 at 09:45:21AM -0700, Junio C Hamano wrote:
> >> Derrick Stolee <stolee@gmail.com> writes:
> >> 
> >> >> Oops, I am not sure what happened here.  There I thought were issues
> >> >> pointed out at least on the latter series but was I hallucinating?
> >> >
> >> > I believe I have resolved all the open comments in both series.
> >> 
> >> OK, then I do not have to be worried.
> >> 
> >> Let's merge it down before -rc0.
> >
> > I think it was merged to next too soon.  I haven't even done with
> > reporting all the issues that were already in v2.27.0, let alone
> > looking through these followup series...
> 
> Oh, so what's your preference?  Reverting all the commit-graph stuff
> that is not in 2.26 may be tempting but is not practically feasible
> this late in the cycle.  It sounded like Derrick was OK to leave
> them in 'next', and I am fine with keeping them out of the upcoming
> release.

Yeah, I think it's sensible to leave them out from the upcoming
release, because that would give us the possibility (and me the time)
to go over them once more.  Glancing through it, I see that Derrick
kept most of my commit messages as-is, but some of them contain
forward references to later patches in my modified path Bloom filters
series that don't make sense on their own.  There are also some
missing tests, a missing "Reported-by: me", missing updates to the
format specs, and even a missing(?) patch.

