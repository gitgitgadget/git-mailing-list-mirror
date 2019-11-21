Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C843CC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997AE2067D
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQnmmizN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUNtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:49:33 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:46301 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUNtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:49:33 -0500
Received: by mail-pg1-f179.google.com with SMTP id r18so1602750pgu.13
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 05:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lcKpRFvpvYyRPHrd4yCHXlgxj/TxLn/jwyqByTVaGkY=;
        b=AQnmmizNyazyNyV3uuDhiyHN1yZ8ROURyPHKct7yDmg5vGFa2Spo1rwdrs+3WongRP
         XSZHfsRdHJ5U/WjSR4SMdAyJgKAPhmuuNx30HvC6+GVTJNJ67PJs6BB5mKj1BwHnKtEY
         isII/bWy31eS7XcrQJiwy6RxjMIR86HNfJM35WK2UkDolFCHt3HAVKDeAzRE4jX8DT5/
         HRmxmBgqP7hOjsaVNMlh6hfSkpBriGsaOB48g9qPnnE0XbI/IHv4f35qb75+1HrkSqev
         /qijo/YxXjle6n/69ubbZuHsqb68MecDT5lwYV1neA/dzIdq/OW3o3ENY234Hm6iWrhp
         4VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lcKpRFvpvYyRPHrd4yCHXlgxj/TxLn/jwyqByTVaGkY=;
        b=f8CxqGgYVvF9Y9ZSOe7PNVx4b/fRrP/oD6kGWa4uw7CtMdyj/hZAA7FECjWo5GNDS7
         rIPa1rp8QKBWamxbnctEosp/1i2vNwC5aq1s5KEEsTr1aTGmvwVBHsiC2l5G8tasRyQb
         Kcg6vLjRXxGUyo0cOagxlllOmZ+z8DEGDEeQ1rfinPXNVpjUItXaY4x7wfCngHTg+Ubl
         QuSqqK8Ohbnvdpv2sMbW2fieN0CBnPhKPZ+TKVmDQCwtM7ZDORE17lOmc5F58HEJBjSD
         7t/lIaBH3X1ek5LdoQlrYQkKH9DXn3lVZrAOYN5H8JleVnAl6tsE8XxeZrrPXn4Y1jO2
         vxpg==
X-Gm-Message-State: APjAAAWjY5v6zn3FNY/wav4HFbJbLUlQVXl/oMFhevWNKtnXoLKQ5HDl
        TZvMLIEhyNbQPHN5flHcYIg=
X-Google-Smtp-Source: APXvYqymzZ8vkC/fHr1B2d5zBMY9vEQ6m2hbBJJh/FRC/e9GAyWRJEuyYyT+basu1RNJe2yS56tGzg==
X-Received: by 2002:a62:108:: with SMTP id 8mr10980719pfb.53.1574344171530;
        Thu, 21 Nov 2019 05:49:31 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id y12sm3252410pjy.0.2019.11.21.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 05:49:30 -0800 (PST)
Date:   Thu, 21 Nov 2019 20:49:28 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Christoph Berg <myon@debian.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git clone git clone some://url
Message-ID: <20191121134928.GA1018@danh.dev>
References: <20191119141537.GD18924@msg.df7cb.de>
 <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
 <20191120064157.GA22081@msg.df7cb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120064157.GA22081@msg.df7cb.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-20 07:41:58+0100, Christoph Berg <myon@debian.org> wrote:
> Re: Junio C Hamano 2019-11-20 <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
> > Christoph Berg <myon@debian.org> writes:
> > 
> > > On some git hosting sites [*], if you copy the repository URL, you'll
> > > actually get "git clone some://url" in the cut buffer. When you then
> > > proceed to do "git clone <paste>" in the next terminal window, the
> > > command executed is actually this:
> > >
> > > $ git clone git clone some://url
> > > fatal: Too many arguments.
> > 
> > Or
> > 
> >     $ git git clone some://usr
> >     $ git git git diff
> > 
> > ;-)
> > 
> > I seriously doubt "git" should do anything funky when fed such
> > command lines.
> 
> "git git git" is obviously silly. The problem is really just about
> this single issue:
> 
> 1. go to some website, copy the git url
> 2. type "git clone" in the terminal
> 3. paste the url, hit enter
> 4. be annoyed when you ended up with "git clone git clone url://"

Seriously, people should stop pasting random command from internet
without reading.

Someone had written about paste-hijacking in the past.

c.f. https://news.ycombinator.com/item?id=10554679

-- 
Danh
