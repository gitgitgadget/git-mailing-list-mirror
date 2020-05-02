Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF080C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1A821974
	for <git@archiver.kernel.org>; Sat,  2 May 2020 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As07KcGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgEBNVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgEBNVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 09:21:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A4C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 06:21:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so2987356pfn.3
        for <git@vger.kernel.org>; Sat, 02 May 2020 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+LJW5tbYvEd9+U7Yj4sCCMEeOlYTZvZwiPxA+6keNo=;
        b=As07KcGoSluRdxBsngBrA2+NuviB1eXh+v6ASYCJI7LaXQi7Qfiu87oE0I1mwqNOT2
         lFw1vwfK4GyJGftUPwUNAqJ+4+eM5f05tivGAoQ1dBVISI+YaZ2Vfy2LFF5Wl7kSLtsa
         JHz9zxfe1Gvoa6B5YGFyXgBjMldqrgPXldrtmb4t99zgIxZ4l9bLOAuHywPcPbYzUllZ
         PVLPaOUa6+7B4QjUR3Mc1LLAw4wE6W2ALylYsLTOcJEe+TvmXlDbw/jzmBvd1bH3dWXd
         gKyu/Y2vap86EVDkda/tKvIdNIE8dP72kmhZ7ZnSpY15AHi9/FPVgA2HiPjU4IpYoxYR
         qz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+LJW5tbYvEd9+U7Yj4sCCMEeOlYTZvZwiPxA+6keNo=;
        b=b/jPPejHixtSG3E/atsDyvBipqqmeZkf9AkYzTlMQoT7WwC6vqxSlKSNEdQEwdqmu8
         KIoDCuwpWHTtCKLiWW2RZK9L3PJrmSqMTwKI9N59CkTf5zm03miWE6Fe1HqRmh+Ukc/b
         +2SHxkuWiloyc0ur14VTyTh+kxDDdDOnllmeIpGEwWckvnz+LbDDDFDAl1K6JeRkVxTV
         qaYatcl3PepUr1uC+gaKzrFk2526vL20q1MkSfo5oVTJeKfndqPLO/QlFr8md8UcPwk7
         bROkSjt+adk4W8qzqa/IJ4DstgCdPRVft8D6gFPMPp/p0jE3RYKwXQb/ztgOzx/YJ+DY
         Dg9Q==
X-Gm-Message-State: AGi0PubrrgK7M20eftMCmKQ09dlhN9SsM/FfvqQiu3aan1gjsOQkjGUY
        +sNo9cj9fXclAIxX4F2xhj2I6vnm
X-Google-Smtp-Source: APiQypLA5vYhwJ73J81cytNz1UvrTWhMSGfmYZqTsquyBVqHVmJOWT5YimC+dJ1/jIBkaXKwWXcM2g==
X-Received: by 2002:a63:225e:: with SMTP id t30mr8180219pgm.244.1588425707654;
        Sat, 02 May 2020 06:21:47 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id h13sm2526339pgm.69.2020.05.02.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 06:21:47 -0700 (PDT)
Date:   Sat, 2 May 2020 20:21:44 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200502132144.GB3143@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com>
 <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net>
 <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev>
 <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On 2020-04-29 14:12:43+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> > > Please correct me if I were wrong (I recall this from my memory
> > > without checking anything).
> > >
> > > The worst thing about CMake is we can't override (Make's) variable
> > > in Makefile generated by CMake.
> >
> > I really don't know enough about cmake to say one way or the other. I
> > can well believe there are parts of the Makefile that will need to be
> > manually translated, and that it may not ever hit full parity.
> >
> > But as long as it just a tool for people using Visual Studio, and if
> > they are happier being able to use that tool, even with a few
> > deficiencies, then it may still be worth doing.
> Adding the CMake script to contrib/buildsystem is a good option.
> Is there any changes (apart from the CMakeLists.txt critique and) that
> I have to do on my part?

(Sorry for this late reply, it's holiday over here).

It's long time since last time I worked with CMake, but I have some
suggestion, maybe it was written in my previous comment, maybe not.

- If we could find anything in CMake that equivalent with `sysconfdir`
  in autotools, please use it for configuration files instead of
  relative to `CMAKE_INSTALL_PREFIX`
- I'll change (this and alikes)
  	find_program(SH_PATH, "sh")
  with:
  	option(SHELL_PATH "path to POSIX compliance shell" "/bin/sh")
  in order to support Solaris people, should they want to try CMake
- I'll wrap the incompatible option of gettext under uname check
- and remove ${} around variable in `if`

-- 
Danh
