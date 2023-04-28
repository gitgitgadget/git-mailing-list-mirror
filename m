Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A7C7EE21
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 16:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbjD1Qst (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjD1Qso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 12:48:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B642524A
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 09:48:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51f6461af24so7659662a12.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682700523; x=1685292523;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA36LfSprhjBXSlCpx4cGgS0sI/mvvjaMZtox2IHmgI=;
        b=d8w8LZfnDmhN7GcB7mbsfmyS0BW6Ryf5sBcldHq/Mw60IBOTK9Ip8F9OiamkMDPPs7
         6ozhrk6XXEbr6lqcagzzNV4yVu75cXIRj784+T9v3SHFL22k9YEkFhv22Rul+jECT19q
         B8Asa1wjT8MsYlrz7k9fqVXGc4vw8dIFEgRbObmbjNaHWdHJy7Cz6badTu6wwImgdA3W
         mEcN8NfhgCx93GDQz+Hg5uVoB+nlynmH4bUMV6njMhvRxFjZkv6WiZ4Tptur052U/eeq
         eJZWRaLAXCbhA3LHdCeDpTjwJ+BH5f/hHPYQtTOPmzeGXLQJeGPWTe39SZcL9OjOBGh9
         HcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682700523; x=1685292523;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hA36LfSprhjBXSlCpx4cGgS0sI/mvvjaMZtox2IHmgI=;
        b=Mmk7MpGok1paAy8JgiJLhu/W2HY2EIcvruIO1t1ilVNzbT1Jje8mHiewOigxWp7LZg
         npQGCfaIOkLyBaN7JGrevsd680FJHip4nSMSLRtbMqOvRG67YccY2VEUoRBMsCBRPwVV
         jswKKGydmqAlKHDgHMuUvGGnTMkoeb42ibZCI1R5S37L/VP+xk4XBRm4Net7wpJIiO3x
         21VxM0Byr2NMV3Y/Y8XgoZrEcLk8OjZGG0n2pqam7b4XqNYoeW6ZIc36jr6YmFgqLb0z
         O1kOvxZETdevdClDPWRZ4T0jjOENy2cDz25bDnjxqIT0rspMaBMFbXCchKQ/o9gEVGjd
         PNMQ==
X-Gm-Message-State: AC+VfDx2WQpawYMA4yhlvNuHZ2CzQIhbr0axbWBs7aXVE9XhP1xLmZZE
        x4P2B/hNF/qB6Ur+Ulvbf9grhhz9ATdGVj0KRr6/9g==
X-Google-Smtp-Source: ACHHUZ6Z5/QJrU9EO35WzJy+xrHrI7XlPzuzbPzfThjUmq2UoxDjv5igue0peiXDqYtN5hAH6aGjUw==
X-Received: by 2002:a05:6a20:8f0c:b0:ef:a696:993a with SMTP id b12-20020a056a208f0c00b000efa696993amr6991986pzk.22.1682700522709;
        Fri, 28 Apr 2023 09:48:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:d2c3:4cc2:f9f7:57a9])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm15849470pfu.93.2023.04.28.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:48:41 -0700 (PDT)
Date:   Fri, 28 Apr 2023 09:48:33 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: trace bare repository setups
Message-ID: <ZEv38M7v3tROT6Nw@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <kl6lcz3onbhx.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lcz3onbhx.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.04.27 16:36, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > From: Glen Choo <chooglen@google.com>
> 
> I can confirm that I did write an initial version of this, which Josh
> cleaned up for the mailing list (thanks!). Most, if not all, of the
> mistakes are originally mine.
> 
> > To make this transition easier, add a trace message to note when we
> > attempt to set up a bare repository without setting GIT_DIR. This allows
> > users and tool developers to audit which of their tools are problematic
> > and report/fix the issue.  When they are sufficiently confident, they
> > would switch over to "safe.bareRepository=explicit".
> 
> One alternative to this is to trace all of the repository setup process.
> E.g. if we traced the data points in t/t1510-repo-setup.sh, like GIT_DIR
> and whether the repository is bare, you could reverse-engineer whether
> we've hit the "set up a bare repository without GIT_DIR" case, but
> that's significantly more complicated. If the goal of this patch is to
> make it easy for users, tool developers and sysadmins to see if
> "safe.bareRepository=explicit" might be tripped, giving a single,
> meaningful event is much easier way to get there.
> 
> It would be nice to trace all of the repo setup eventually, anyway, and
> I don't think this change precludes that.
> 
> > Change-Id: I8e8b5e70ce8c6c81ec4716187c27c44da38b35db
> 
> Leftover from Gerrit, perhaps?
> 
> Unsurprisingly, I don't have comments on the diff, at least not anything
> that Junio hasn't already spotted.

Whoops, thanks for the catch. It would seem my send-email workflow broke
somehow while I was away from work. I also had a comment explaining why
I was sending this out for you, which somehow got dropped.
