Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9216FC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5957520730
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUfYpAYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBDWvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:51:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38754 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDWvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 17:51:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6so17862plj.5
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 14:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pTh4Mdam9XNRz0r69Uis8VzFXm62LKdVzQEvGEMA7t4=;
        b=PUfYpAYVW78tir2ueuW0MurYozPgaTs2dVSqDSiUB5NngzYHMv7rpWg9HtV1cED23D
         JmzHqboEt4uBJkE1/6Xtg/Qb0L+9g/Hqvyq47snSHwgY+EMuUdwtztOwQyw1Kk5nWavF
         lP8oiwo1JbzVZ1K6D+UbDkfQn7HuRjLykvu8WbM5ir8vZroGnLBbF/mnme347+RmsGTh
         qbFvMIT+o6gQLNcvlBlXl/RpQGnR5Uhk+JHTp2XXnvrD5WVZAG7mzWUQ+IcawMkHpCy5
         fh7Ibrl+VFs0P334sQ29pDabdtOTB9ssiwNmvwyPgrLn5D1Se7C2yEzAay0MdLKfUvAZ
         pcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pTh4Mdam9XNRz0r69Uis8VzFXm62LKdVzQEvGEMA7t4=;
        b=VRPAF+IijjUsM6GYgd5FUgQ7eiEnecl7O4keuu9WsAyF9Uw18/39tjYcR+LZTygx5L
         lzYCAwPxowr0lNFc1TvaQFNKuYGS7zvxJRb18ozc6iOKa3Px4KwkAP1tMeRVrXew/xrS
         zpgtNXTVBexhd2YmaLYLLvQe2a9RnbPCV6NGt801cq1vmY0HGq/7QLgjzzVZuFKnX0dL
         SHa0Orb+p/v8VQKdvAoj4o8G+cubK1XAZaP/NXP7isELazDQi+PZJqJOsP7JfZCH1gLI
         n4CEs9Sz2wXf8xFWpPqCO+bAlsHf46/5Asa2PxzS5wcWmTvo+9OrwplfZ645VPfkH/v3
         GsKw==
X-Gm-Message-State: APjAAAUO9c63mBSiCYtANm0Kr8hYLiDKNQOjaBMEC8d2KFGjfiQRRTnr
        fTOcsudF00bTVPAl1M3+FeDhA0JpEsA=
X-Google-Smtp-Source: APXvYqykZemb5d66cSSOunu60e9BvWkIM9evx9fKtb8hJ20ljPIcHWRRyh/AX1AXP5bh4LRCtpqOFg==
X-Received: by 2002:a17:902:d216:: with SMTP id t22mr31757797ply.150.1580856683768;
        Tue, 04 Feb 2020 14:51:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g9sm25841460pfm.150.2020.02.04.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 14:51:22 -0800 (PST)
Date:   Tue, 4 Feb 2020 14:51:18 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 06/15] bugreport: add compiler info
Message-ID: <20200204225118.GE87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-7-emilyshaffer@google.com>
 <CAN0heSoh87_16y+B5=UXAhbaVnejmRj3XXjy5viABheBz+D3fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoh87_16y+B5=UXAhbaVnejmRj3XXjy5viABheBz+D3fA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:21:39PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> > +#else
> > +
> > +static inline void get_compiler_info(struct strbuf *info)
> > +{
> > +       strbuf_addstr(info, "get_compiler_info() not implemented");
> 
> Maybe "no compiler info available" (or s/ available//, or
> s/available/reported/), or something else more human-readable?

Hm. I envisioned the target audience for this as "Git developers" (and
that's why I didn't mark the unimplemented string for translation); Git
developers know exactly what "get_compiler_info() not implemented"
means. But I suppose it's just as easy to grep for one string as the
other.

I am hesitant to say "no info available" or "no info reported" when I'm
certain there is some environment variable set at build time which
contains the info we'd want to show here; it really is just a question
of some Git developer having put in the time to implement this function.

So, I think I will leave it. Thanks for your suggestions.

 - Emily
