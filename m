Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001EC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 01:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A227421582
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 01:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMDmlvEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgBEBeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 20:34:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35342 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgBEBeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 20:34:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so127820pgk.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 17:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A3UfdwoS+Kho3IUfNNdBu8RnGSpRtn25dw+uc1xLwvc=;
        b=FMDmlvErYs4qt0ZAl8FglroslWpGi2/QWbPu5NSIkoCxneuygvSoWl/JUIpi0EVGJZ
         STPoCjRTLXMm1kOl+tKxaXsdeXlmGkqy4vKE5G6FrCjP4Yh+VqmnRAaldXyrLORxdcF6
         BXFEC33xpBUQzizPu7ubThzMhnAVaTO/kHzw8Mcs10MVxVVdBCiyxrI6zWsH/pKKHs9f
         ClFo0H/dKb1eGrMQWZmTjanDsZR6abigHklMM6R+uR2UGJkrxYzOHavTZ1ZOT51Yq+XN
         Nbq9+cwKqsz0YYH0gvHk8GGQN3uY+W1ndEBhjlQ0w5cxKED1xt9ppS4/3ICUPDT3F1KX
         8ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A3UfdwoS+Kho3IUfNNdBu8RnGSpRtn25dw+uc1xLwvc=;
        b=mp1CrnFuCbtKXvwmjRbmuZj+eTO/fAsdGW+eT0m5sxeLQ2Gpaj4sR77FuKqpqRoF8+
         I6rj2YwLIyhxabxeNq7ZjCUsiQdzia5O905gGyqzli5wrpgXIzL5DgmyQjNFyHGopruG
         iO4xkiKQu3damckVaTwPP5iuPvGJITvhKGrOCPWIhCgy5rPOrrIWdd+Me5U4kATq2V0S
         aCgqtXj7DwycbLeTtnHXd2QZyR3zXZmy72OTjpMTpHMUfgI0byMP8P6BtVATvIfpKfDr
         QDR0CvQDM2kOS+VYks9sZ6q7E0c9L5aHSg1ecVgAocfHJ4aQEbGdMsCU11xyO0zW9+NR
         Bjbg==
X-Gm-Message-State: APjAAAX6OMOxHpUTFhLu4KeeT1PZQgZ56AJcLlL7l2hCvGAlXSTMxt4v
        yziV9ZjInTGLtDr7GVjXCsWKr6CTMkM=
X-Google-Smtp-Source: APXvYqyElPBjOMl5c2G9sbzdQSWccAWwIU6Ck19jmXCpATC/rTi96K5weu4tf2mIcvGZFQZeZFfxgg==
X-Received: by 2002:a63:7152:: with SMTP id b18mr21008060pgn.232.1580866450361;
        Tue, 04 Feb 2020 17:34:10 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d22sm24847273pgg.52.2020.02.04.17.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 17:34:09 -0800 (PST)
Date:   Tue, 4 Feb 2020 17:34:05 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 10/15] bugreport: add config values from safelist
Message-ID: <20200205013405.GK87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-11-emilyshaffer@google.com>
 <CAN0heSr3WTtGh=gWTiXYEoSGGHPF_YniA9xH989=OtYfM2-Evw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSr3WTtGh=gWTiXYEoSGGHPF_YniA9xH989=OtYfM2-Evw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:36:43PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2465,7 +2465,7 @@ endif
> >  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
> >         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
> >
> > -git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
> > +git-bugreport$X: bugreport-config-safelist.h bugreport.o GIT-LDFLAGS $(GITLIBS)
> >         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> >                 $(LIBS)
> 
> Haven't looked at this patch at all, except I've noticed that something
> is up with the dependencies. I think bugreport.o needs to depend on
> bugreport-config-safelist.h. As it is, the latter may or may not be
> available as bugreport.o is built. (Reproduces fairly well for me with
> something like `make clean && make -j16`.)

Hum, I thought that the ordering of the dependency list here was
ensured. But I see where help.o relies directly on command-list.h, so
I'll add a dependency for bugreport.o (and drop it from the direct
dependency for git-bugreport).

 - Emily
