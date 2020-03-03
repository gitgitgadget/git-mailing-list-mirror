Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50EC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4F920716
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lVER9/Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgCCX22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:28:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33346 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgCCX22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 18:28:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id m5so57583pgg.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 15:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZuMIPN8rFKRUkEM26zSq6QZgGl09Bm7q3w6f9qVGu0=;
        b=lVER9/Eqx1t8GlK4cVMG05JBWNPlvD9flHLuN8lExqgjaNqUNDHPY8xMiSw1yT3m8z
         QYdjG2FteQeRZEI4RieGJnYbLKDoCe0EoVQpKH6knletZE+yiz++FG9CVnJs8V5r9xIW
         CiSCj3HfsCcoZ/56QiPvhzbrQ9RFHx9d9roqBVS5KTiqGHElKes2NCJmbn8rGkog82pV
         bulDMcUvq6c5rTifnSgEmaWXteb4PrTlXnKgCi7g+kHp6hwL1Nj7WIhZLNyr5iBkM22m
         UC5Xm66ktVOZoNMlk39o2WNLwwXzzLlkfmW0GUbRqb88wdN2Rryon9VfSrkpmD1i3v+d
         NeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZuMIPN8rFKRUkEM26zSq6QZgGl09Bm7q3w6f9qVGu0=;
        b=NYsslSYFTHE0k00lXjnNXJzk9kv9GSvjVSEbOqM+wHdYfXOAxjBkI/AfHSMM4DbLSB
         8a5OGUpsyy3kbay6oWMyLPk9vV0KX8MtZfG0TMpuTJ+iEgz3CjqJ/2WV3cDKAoEvsFEa
         jk2ccWsB9Mg1NIm/bpGXQ6P7K1TOxRCz2O13VPoQGlsVuQZCCcmqSzYHaXFAvbNk+un6
         y0mPgqyOASoZ5gCDW6+cRPxMCXifzHAw1z8IJeG1MiEqZ7Ikd8cnV/BjVU5HXNqlADc2
         zwEvaQ4sXCJz0c0ftYPBywGiE0ne6MJmLrdqdUOKW5WM42L1Vze33ZuATavOKQIvZXGN
         EmIA==
X-Gm-Message-State: ANhLgQ2g25AJg8VSOpxnbUOqsVYdNxsrSYl4/FsFOgGP/r0rKu5hGOIj
        +z/phICppoYAcEJP7065ATbsysGFvRM=
X-Google-Smtp-Source: ADFU+vsa/0dJ7u0/zHG2LpA3MwrwcSNGHHPUYGP6O8dZxWJztZvPKdfklr0WQ71aUaMg+zkUEjxwVg==
X-Received: by 2002:a63:d658:: with SMTP id d24mr6403504pgj.340.1583278107645;
        Tue, 03 Mar 2020 15:28:27 -0800 (PST)
Received: from localhost ([209.37.190.132])
        by smtp.gmail.com with ESMTPSA id f9sm13721703pfq.24.2020.03.03.15.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:28:27 -0800 (PST)
Date:   Tue, 3 Mar 2020 15:28:26 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
Message-ID: <20200303232826.GA17992@syl.local>
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
 <20200303230554.GA11837@syl.local>
 <xmqq1rq96nih.fsf@gitster-ct.c.googlers.com>
 <xmqqtv3558mt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv3558mt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 03, 2020 at 03:19:38PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> What's in 'v3' of that series [1] is ready to merge, in my opinion.
> >
> > Alright.  Let's do so.
> >
> >> [1]: https://lore.kernel.org/git/cover.1581486293.git.me@ttaylorr.com/#t
> >
> > Thanks.
>
> Hmph, actually...
>
> > It was intended as the former, but I share both of your feelings that it
> > could be read either way. I amended the commit message to clarify by
> > adding:
> >
> >   (and haven't since been deleted from the object store)
> >
> > as a parenthetical after "already in the graph...".
>
> ... don't we want to get that "amended" one, at least?  I do not
> recall if there were other things you said you'd tweak or not during
> the review of that v3, though.

I couldn't quite find where this amended version went, so I recreated it
and sent it as
7c47f37122ff2b03f0bccc48cb6ca022904f6353.1583278022.git.me@ttaylorr.com.

Thanks.

Thanks,
Taylor
