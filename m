Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45DDC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 23:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B399B2087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 23:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iP4a9YM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgBDXQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:16:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44118 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDXQI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 18:16:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id y5so120156pfb.11
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aOk3xpWTsQP8lp22qMsEQymkjdoFix+vf3uE88QOPq4=;
        b=iP4a9YM3BEZkanhywgIrdyvuwT5/15U/yJ/uW4x26Y784U1DS6AoVKF4wGVuEKLzsA
         UDnjlP3RmTKnK1Lk9lvi79pZPfLkzeubgJ0o1mUm+QKp27EatEJWzmG81Jm1+EUzbiSo
         eE40pSBLDjvurEVrx+zOOCqhmjqesj29C2r9wUNsLHGMONOMiGqzoylXVCeB0jQLbpIr
         x5jjPVnmi/J+gHTLSvNgViTTEq17ic32GWjJJFGAUbRfKLC3VjcHCEyTi+lVlZ4g6Gmr
         RE3d/1QMHgIsFhT/lQ4rHe/6GT03eJT7VmgVTx5THOl2kPGkMPc1MbsYGpsq7VfEKI8r
         lhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aOk3xpWTsQP8lp22qMsEQymkjdoFix+vf3uE88QOPq4=;
        b=ikDQlA8j35bTNuTkemWROtEYmg8qxhY112a3z14bf1/lIUXJc4rMrtUAleNpqIeu+2
         SUb/J11d8JemIX3USxaYSmvhcl9IiUTwdaBMtXenuLyswdS1CyWz0sKqUawVPHG8afi/
         DOk/S6JtGNISfCCcPQS+VS4eNPt++Ykm/8Re0b9ZtAoptw8ihwKNjmACzMqeHPdgtJni
         7/0hWrZkYsZlpIHqVi/MhkHhnyZHLXT6L+7z/TPR/2Oa5G1u1kYWjYfypx1niCcwJXHb
         gatJi7+vNXiEEnW2bjWTYhwgYewKZc3XRwkllPMidnNCT83Iw7RyEKJVuCPbhJz8mcvT
         gl7w==
X-Gm-Message-State: APjAAAXUUZbJdsW0hvpF4MtsztETqZ6y0aB98F3XxMdt5z8ieokeJXRq
        m58JooFQ+ZQL+1gi24HuqW9M2g==
X-Google-Smtp-Source: APXvYqzeIoD0iahy/pXLX2Vwod8IAGitsl3A3/mkALsdv+nASCPSYV90WGfHfnLS4Qhfhv8lQ0uzkg==
X-Received: by 2002:a62:8e0a:: with SMTP id k10mr34321751pfe.49.1580858167926;
        Tue, 04 Feb 2020 15:16:07 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g9sm25874233pfm.150.2020.02.04.15.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 15:16:07 -0800 (PST)
Date:   Tue, 4 Feb 2020 15:16:02 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 08/15] bugreport: include user interactive shell
Message-ID: <20200204231602.GG87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-9-emilyshaffer@google.com>
 <CAN0heSq9AdF_WPmSkxDA3cPzOQBAbuw4oa+8azvLtjbP-jQfKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSq9AdF_WPmSkxDA3cPzOQBAbuw4oa+8azvLtjbP-jQfKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:28:40PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:41, <emilyshaffer@google.com> wrote:
> > +       char *shell = NULL;
> 
> (Unnecessary initialization.)
> 
> > +       shell = getenv("SHELL");
> > +       strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
> > +                   shell ? shell : "(NULL)");
> 
> Thanks for avoiding a classic pitfall. :-)

Thank Junio. I fell right into it because it Just Works in gcc. ;)

> "<unused>" instead of "(NULL)"? "NULL" is mostly an implementation
> detail.

Sure, why not.
