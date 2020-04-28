Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F9C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F06206D7
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 11:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8kgRUw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD1LZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgD1LZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 07:25:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65287C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 04:25:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so10184237pgg.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=safKZbojNaToHnBb7w2EeXVc2F+V5UmLrVEC7CXPjkQ=;
        b=r8kgRUw1q9BChN0a9bekhQwd49Fy0XykT4hMN+7Fp+7ARjvKndwO7v3ru0ArJxY3NR
         Oxy0myNG2sOFG3pNZaultK6ua6KC0KGihVOk3EiwBUXKSg7ngEm3jMsvJuNg7HcyAIqv
         dPSMIXq14RhR/I9d2Zt+nPq0LQ9T67UVELY2ybdq4KhUPqJOilCXQDTLy4bvHdFwmB9W
         xu335NJo3+TTW7eiWCFZ+4JHqnCo5+IuvIKSCfhJ/d4qFbHziQpXwpmkh8SDgo0U7JVU
         Mcs5AB7lgo8AmNexC5TbAxUELGmVySwt+MNTWkJ3j26i3YD5ootBhttMMvtyLBnL4xmN
         NvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=safKZbojNaToHnBb7w2EeXVc2F+V5UmLrVEC7CXPjkQ=;
        b=kgyfIQtpnjhW69ZA1tyyYdCKofia7eHymKwwnKdCJS6JKZZV/EjyCb/HFVl8MIVnfk
         TV8gP4KY1MUFHfgLhNyBVDGK0gH1ufcjvgTdbXugp2g2iFLEHPnvYM5QSNFRYvoCjr/Y
         GrIv/s0Hf3xYM2jd4v4uy43Y8smZtK5r5Xx+ITKujepaT/oJo7NUewXlXl+VKASAw2SW
         aMKqsxIRqEIWZrWydCGU5qzFLmZ87zhGD8wXhCjRG5dZApYSYYqVzoAE1Fku4da80qCa
         LMPPK4lJ/jcxV4xBFlRPtmvkc4rnZcjIjvkPQB7ASe45BR0e0rzCW6k9slCsIuFf+PQm
         OteA==
X-Gm-Message-State: AGi0PuYj9g7I0n3gTssuCfzx8F96ipksKxopFeXgpKf/fg34bK//eepV
        MGK6/Il+0WauMoeeTPn0a4o=
X-Google-Smtp-Source: APiQypJxEIA/OzQG+X/7+S00a1iYQM0OdzpltwNMgHirCb02t9c2BLvPii9/WQOsSagF6UljxF3nTA==
X-Received: by 2002:a65:64d0:: with SMTP id t16mr26767637pgv.415.1588073121811;
        Tue, 28 Apr 2020 04:25:21 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 82sm14715515pfv.214.2020.04.28.04.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 04:25:20 -0700 (PDT)
Date:   Tue, 28 Apr 2020 04:25:18 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dirk@ed4u.de, sunshine@sunshineco.com,
        Stefan Tauner <stefan.tauner@gmx.at>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200428112518.GA15981@Carlos-MBP>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
 <20200428052510.GA201501@google.com>
 <20200428054155.GB2376380@coredump.intra.peff.net>
 <20200428071802.GF61348@Carlos-MBP>
 <20200428081627.GB2381876@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428081627.GB2381876@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 04:16:27AM -0400, Jeff King wrote:
> On Tue, Apr 28, 2020 at 12:18:02AM -0700, Carlo Marcelo Arenas Belón wrote:
> > 
> > it wouldn't cover cases where there were leading spaces/tabs around
> > the credential which I have to admit I liked just because it is
> > more robust to bad input, and there is no sane way now to tell the
> > user that there is invalid data anyway, but I am ok eitherway.
> 
> I think if we're discouraging people from hand-editing the file, then
> that feature would be going in the wrong direction anyway.

I think it will actually encourage them to edit the file (and complain
of a regression), since they can see the credential is correct, but
somehow git fails to work with it unlike their previous version.

remember there is no warning that could explain why that happens and
with this pach there is no error either.

> Did you or Jonathan want to wrap it up with the test and commit message?

I was going to say Jonathan will have to do it, since he was the only one
that didn't provide a patch (and therefore a sign off) but guess I can
save everyone some time and practice my git-send-email skills (which 
obviously failed me)

Jonathan,

make sure your patch[1] is complete and correct and to resend it with
a sign off, feel free to add me as Tested-by if you feel like, but I
added myself as Helped-by anyway ;)

Junio,

didn't fix the typo that Peff suggested fixed[2], because I forgot
and I wasn't sure if that also means I should SOB it, but if you
could also consider my suggestion[3] then at you get my SOB warranted ;)

Carlo

PS. guess I should had send it as an RFC instead

[1] https://lore.kernel.org/git/20200428105254.28658-3-carenas@gmail.com/
[2] https://lore.kernel.org/git/20200427211013.GB1732530@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/20200427234909.GC61348@Carlos-MBP/
