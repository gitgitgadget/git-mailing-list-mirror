Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A6C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9820776
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOtN/vr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDWVWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWVWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:22:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91049C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:22:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c21so2038916plz.4
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0WqcG9AK+fY5BV+fCB4R1LCRQZuffMwHS9HZA8cxglw=;
        b=lOtN/vr3szowZ9na8CSnFSBLigTPObUcb1RSQfh926FjarlaRvh0IU4bsMGbJDk4Tv
         Y363zWyYtdgCiUSN3VgLbMCUgMaN+8MgZrIkuUts7KTDhv2Zv3Zik39wjZH/75LgWEXS
         cD0oPWkeQsa5LXHuoJde9f2X8oAga5cCBX/KbOMJX6JDsCqDexkkw5c8QjRfk8PeNa2t
         K7ePfHL7Nj4OCsehiaU3Wymr36FVuHtlP7/Ko96eYgSqIBLuMsP9QM+uAQkPD/P6xHkV
         oV3xd5G0SZJmBzDWj5BaTxM3LXEJFbLnLvU/hZJFC5sHEBFe1VVCKiHrY6xmQmeq4sxZ
         0ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0WqcG9AK+fY5BV+fCB4R1LCRQZuffMwHS9HZA8cxglw=;
        b=SJxrVI+Q0VbANqmcrf5AoAdYRixEhpZnLFVa4V7UJkZZHscMQe0gGsP7D2qpUhDCaY
         f3U/FrUimNjafRSMD6Glhu1lNNhz0K4UbrWG7ZGVEvSbXQSUcKKA3q9Z4L8ufgmoEXbg
         w5QBA2A55yCgzq9EiECLKBum4JZ052KvVxBPAmeci4tWA4p5h3QXAAPFVQU8LyhRVnXx
         1OCpiWTNgDujnMZldXZKYPl+rx+hki4SzPYYlO11v8kJQxc6jnD82WZNZ+69iTskHe8E
         zZsk5fsXqrmGdZDgNzo1POnm8TbM4G3WCcyomngwbhMzaYuxgxtQ1dwpNX3KC2zsnfL1
         MaXg==
X-Gm-Message-State: AGi0PuaPZ8ioeiEuDVwC+BJbfN5s6R9lNCgADU8I8utOQ/lwAhpmSR4H
        AH/PZsEmP0IUzInEv0XMSfo=
X-Google-Smtp-Source: APiQypJ37llXJJClKHwz/E1zZDs5K8OBcNkt++z79y7Xn5iNLyB6jLI25kKEZb1HD1fP7tFT73PVlg==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr2899481pjy.143.1587676936675;
        Thu, 23 Apr 2020 14:22:16 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id b1sm3469929pfa.202.2020.04.23.14.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:22:16 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:22:12 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a
 non-strict mode
Message-ID: <20200423212212.GA20669@Carlos-MBP>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
 <20200422233854.GE140314@google.com>
 <CAPUEspgJvN6f6Wjo-yjYj-x+bYtC3vdSvwUtrF=MbJDjwYUTdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004231433060.18039@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004231433060.18039@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 03:28:13PM +0200, Johannes Schindelin wrote:
> On Wed, 22 Apr 2020, Carlo Arenas wrote:
> > On Wed, Apr 22, 2020 at 4:41 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > > Johannes Schindelin wrote:
> > > > @@ -382,8 +382,10 @@ int credential_from_url_gently(struct credential *c, const char *url,
> > > >               host = at + 1;
> > > >       }
> > > >
> > > > -     c->protocol = xmemdupz(url, proto_end - url);
> > > > -     c->host = url_decode_mem(host, slash - host);
> > > > +     if (proto_end && proto_end - url > 0)
> > > > +             c->protocol = xmemdupz(url, proto_end - url);
> > >
> > > What should happen when the protocol isn't present?  Does this mean
> > > callers will need to be audited to make sure they handle NULL?
> >
> > the previous code was ensuring protocol was always at least "" (albeit it
> > might had been easier to understand with a comment)
> 
> I fear that my patches did not make it clear that the lenient mode is
> _only_ used in the config parsing, in which case we very much do not want
> to have the unspecified parts be interpreted as empty strings.

I think the concern raised was that since we are using the same function
in both cases there might be unintended consequences on changing the
semantics for the other case.

the argument made by Jonathan to use something else for configuration
(as is done in master) will help in that direction, and might be needed
anyway as your code it otherwise broken for current maint and master, but
if not possible (maybe later?) something like this could probably help :

diff --git a/credential.c b/credential.c
index 88612e583c..f972fcc895 100644
--- a/credential.c
+++ b/credential.c
@@ -389,8 +389,9 @@ int credential_from_url_gently(struct credential *c, const char *url,
 
 	if (proto_end && proto_end - url > 0)
 		c->protocol = xmemdupz(url, proto_end - url);
-	if (slash - url > 0)
+	if (strict || slash > url)
 		c->host = url_decode_mem(host, slash - host);
+
 	/* Trim leading and trailing slashes from path */
 	while (*slash == '/')
 		slash++;

changing the condition there as you suggested to Junio would be a plus IMHO
as well as getting some test that would excercise the new warning that was
introduced in credential.c:57

Carlo
