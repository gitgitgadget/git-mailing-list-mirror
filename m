Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD7C55186
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A920700
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRsgvpH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDZAlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgDZAlY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 20:41:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5162C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:41:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so5696894pjb.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SNxEX/0D9e8+49LLoS6sM8uqBEa7rRrqTEiEjHlpe5Y=;
        b=kRsgvpH3l14GjUN8D0X80XjiKbO7gLQ+3qeeC4NihTMT5ADNBxqxBMiEHMy7u3nyQL
         fInfWbfPNxgvjM/3FDI9bogawn5+c9cpNGcTDyAJgcl35jEFXxAI0kDkMtRPdWEVLjun
         6Jf5z8WF8IuHTsgGhLtS9umKqafbB4Gloo7kbh8NxGUfXgQx0+S2r0pskqBaH6hufZQP
         8syMct3rpSVQLKo+Fl7va5v+FePPO4xApNF6ncAybmzrsFCLjLiTxye/8Z4RL1KohcRt
         09Rh0i+kFN9hzUXixhmGMz1SxWcSzfDenJndDF6AYsd6KU3qNvx66nrPxLS1S45eQesy
         HRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNxEX/0D9e8+49LLoS6sM8uqBEa7rRrqTEiEjHlpe5Y=;
        b=GnlwGuslGoVQaOiRxH5g9Zt6oPtUrVU+6bQKIiHxeTvFpAGsZUudCmo46hPvLjVlXC
         mmxhiCphh/61CHDPMPqOByCeegqVlfwDmQ0VPB2hrWPNvpR/q2IEWZ3vvLXcU76IgLyu
         16O2WqclI3ONCUQPrUzNq8MwjQaIW16X6bo8DU6n06Ec0bdO9eps3zWQq9kTJlDd9LHQ
         AJE8BvPTQGXFO5AJ6TBGyqhqqm3viLWRywMW2T/j1B1mbGxsZktOm8Y0qAbr/0g2FCHd
         3qeKv07nHdA2R4gaNH5hzi+jEntAUsBxw+7pbhqj6A7WLLnHoXlOE1S2YOhojTsgZd7r
         N0DA==
X-Gm-Message-State: AGi0PuZ1sEZU7HE2ba9+fTSbPqGhB9CsrA6t7maMMlckVnz/v1wjKDAP
        43c0wiv38Ck/AhcKAT/JIx0=
X-Google-Smtp-Source: APiQypICeWNdlwB22BjbyzuahVyGBhfsajP4oODhGwEgP9eOpuu0y/qTDxaCdchwGxSgFE9ERVHKTA==
X-Received: by 2002:a17:902:a985:: with SMTP id bh5mr12422989plb.163.1587861682112;
        Sat, 25 Apr 2020 17:41:22 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id d14sm8888109pfr.35.2020.04.25.17.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 17:41:21 -0700 (PDT)
Date:   Sun, 26 Apr 2020 07:41:19 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200426004119.otgynhnzvmykitez@danh.dev>
References: <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email>
 <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet>
 <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004251624100.18039@tvgsbejvaqbjf.bet>
 <CAKiG+9XpZjesKs4p_yRvtgEhqwSHDqnjJcNkzqg_AEWr5BeuQg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004251647520.18039@tvgsbejvaqbjf.bet>
 <CAKiG+9XwoD+UzHovS_mW76CPX_Vtt1eTaSM-xaszKWwt6R3ewA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiG+9XwoD+UzHovS_mW76CPX_Vtt1eTaSM-xaszKWwt6R3ewA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-25 20:27:37+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> Hi Dscho,
> 
> I guess this is a pain point having to manage two separate build systems.
> I will modify CMake script to get its sources from the Makefile.
> 
> > > I understand what you are trying to say, this is not impossible to do but doing
> > > so will make the CMake script dependent on the Makefile for the sources.
> > > I am not fan of this approach.
> > >
> > > We should write a separate script (say python) to match each of the sources in
> > > the Makefile and the CMake file automatically whenever the changes detected.
> > > This excludes the platform specific/compatibility stuff in config.mak.uname.
> >
> > Hmm. That is an approach that _I_ don't like. Why duplicate the
> > information when you don't have to?
> >
> > I don't see any issue with keeping CMakeLists.txt dependent on Makefile.
> > We could of course extract the lists into a separate file that is sourced
> > both from the Makefile and from CMakeLists.txt, but that would actually
> > not reflect that the Makefile _is_ authoritative. CMakeLists.txt will
> > never be the authoritative source.

(This email is hard to be replied, because Sibi do top-posting.
And, I want to quote both on this).

I'm still not a fan of CMake despite that I need to write it at
previous $DAYJOBS.

I would like to keep Makefile as authoritative source of information,
and to convince other developers, we need to keep Makefile as
authoritative source of information. Let's say this way, I dislike it,
but if it works for you, that's fine, just don't add more burden for
existing people.

Remember that with CMake support, we will never able to use CMake
generated build in-tree because we have an existing Makefile in-tree
(not a problem since it's expected to be built out-of-tree if CMake is used),
but please don't complain if it people accidentally break it.
./configure doesn't work correctly with `--without-<pkg>` and people
seems to not interest in my series to respect it, for example.

When writing this, I intended to write something to support
out-of-tree build with current Makefile. Hopefully, it won't be rocket
science.

Last but not least, (this point was discussed with Sibi off-list)
about our test infrastructure, when we add a new test,
we can simply run:

	make test

Makefile will pick it up, and run all tests just fine.

CMake's glob only works at CMake configuration time.
If there's a new test after CMake was run, and nothing changed in
CMakeList.txt. The list generated by CMake will still be the same,
ctest wouldn't know that there's a new test.
People need to manually run cmake again to pick it up (or as Sibi
told me off-list, that developer is question can run by hand

	path/to/git/source/t/t-9999-true.sh

That's not a problem for the person write that test,
but it'll be problem for other people, who will fetch the new source
to their own repo, and naively run msbuild and ctest.

It's analogue to this habit in git (me in my previous $DAYJOBS)

	yes | git add -p

Anyway, get back to the solution (should this series be accepted),
I think it'll work if we can split:

	SOURCE_FILES += cmake.c

into a source-list.mak

Then, cmake will do some magic with `configure_file` or something
similar, IIRC, it's a reduced functionallity of sed.

-- 
Danh
