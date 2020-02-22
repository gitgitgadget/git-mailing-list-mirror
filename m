Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB002C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDF820828
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3mXjqwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgBVAEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:04:44 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39547 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgBVAEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 19:04:44 -0500
Received: by mail-pj1-f68.google.com with SMTP id e9so1491514pjr.4
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G93mrEGaFmOpt9m/fDMlkTBEsTu5qLOoRGv0T5lQ0Rk=;
        b=J3mXjqwH/PI/9Lbn0++1ht8YFWRFH2IdbSlSGDHZQLUSvdFsiQV+gSzC7qGLa6Uyy4
         T8EQgLcWM8P5vuZy8qg0DbHM3Az3YasfWmd+MNyfzggZISkFKhhvMf5sLLh03olmDaum
         45NigLX73/ppab5YovJBAywU3HOVL3ARli+U2D6d02FDryNnKMu4GSUZqpWtpCeocB29
         ZBr5u9O28li2oXyu8NusBoRh+MhUDzfpDQgF+16KvGvKrkmWx+oom7dNitxigz8WTMvZ
         PF2kKJJQ7m4KWqWxwWZ+bNyE3d+S9gR6GXZDieKUS4wlUyO2MMy0MP5Dd2PjE+xmwBz7
         t3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G93mrEGaFmOpt9m/fDMlkTBEsTu5qLOoRGv0T5lQ0Rk=;
        b=XcrhIhkOJXwZy8yaGiPI2sJ7bT/aEFV13NOqBVaUpZKM7Ud9xHDYjuNJAHEKCP1mz2
         fyzpL6prDG9ZMhjNWPtMTEp52igGWpRrdNiJo0M5rFKriC46hWWa+LObDbjVXSZbTvpC
         3l/tGU1i/nI1mzlcOKKGsYddglupWhCndEMIyFqs0AGY4htJC+YzQcM4m8PDo0FRonxK
         9bU/K/c9XpcfkzGeRLh3vOIlXSJjvwy2nH4VSaNtQLIl+jShEZoAwGO/TsE/1YU6eang
         j54u29m24qqfWq8Ab0hVkEe9pWHjCCIR+Rw5NpAStFkxwk2aR9KBb5zY9ia/xRRh+Avn
         r85g==
X-Gm-Message-State: APjAAAWx0ce9ViH7SYjZ6BrMRchToGEaQEySl0AjbzmxUZC3eTo/D3vG
        Zr/lt8WhC7Xf1j+cDCqgUZj0f9cwj/Q=
X-Google-Smtp-Source: APXvYqyK1yOoD+39qlitF8YNxXZqYVCLLzrnd7iMFAbKbVbwnGDxXfR5lYLX/H4WLwQ2vP6IOe4zNg==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr6199548pjc.16.1582329883055;
        Fri, 21 Feb 2020 16:04:43 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b27sm3564501pgl.77.2020.02.21.16.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:04:42 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:04:38 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 06/15] bugreport: add compiler info
Message-ID: <20200222000438.GL2447@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-7-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet>
 <20200219224547.GC26221@google.com>
 <nycvar.QRO.7.76.6.2002202306390.46@tvgsbejvaqbjf.bet>
 <20200220233323.GI2447@google.com>
 <nycvar.QRO.7.76.6.2002211621470.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002211621470.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 04:22:43PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 20 Feb 2020, Emily Shaffer wrote:
> 
> > On Thu, Feb 20, 2020 at 11:33:05PM +0100, Johannes Schindelin wrote:
> > > Hi Emily,
> > >
> > > On Wed, 19 Feb 2020, Emily Shaffer wrote:
> > >
> > > >   #ifdef __GLIBC__
> > > >   #include <gnu/libc-version.h>
> > > >   #endif
> > > >
> > > >   static inline void get_compiler_info(struct strbuf *info)
> > > >   {
> > > >   	#ifdef __GLIBC__
> > > > 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> > > > 	#endif
> > > >
> > > > 	#ifdef __GNUC__
> > > > 	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> > > > 	#endif
> > > >
> > > > 	#ifdef _MSC_VER
> > > > 	strbuf_addf(info, "msc runtime: %s\n", some_msc_info());
> > >
> > > You could do it this way right away:
> > >
> > > 	strbuf_addf(info, "MSVC version: %d.%d\n",
> > > 		    _MSC_VER / 100, _MSC_VER % 100);
> > >
> > > Note: this is _not_ the MSVC _runtime_ version, but really the compiler
> > > version.
> > >
> > > You could also use _MSC_FULL_VER, which is a bit more complete.
> >
> > Sorry, but I'm not comfortable sending code I can't check for myself
> > (and already muscle-memoried into my format-patch/send-email workflow).
> > If you send a scissors I can roll it into the series with your SOB.
> 
> But you can check it yourself! I worked _really_ hard on that Azure
> Pipeline backing the PR builds at https://github.com/git/git. _REALLY_
> hard. You might just as well reap the benefits so that I did not spend all
> of that time and sweat and stress in vain...

I thought a bit about this. From your Github-using point of view, "just
check my Pipeline" sounds like "just look at one more thing". From my
format-patch using point of view, "just check my Pipeline" sounds like
"ugh, I have to add this remote again... I don't have a fork already?
How do I make that? Or is my fork just 6 months behind? How do I open a
PR again? Yeesh."

So I did what any good developer who's supposed to be writing
semi-annual performance reviews would, and wrote a first pass at script
with this brand new fancy 'gh' thing (which is, by the way, clearly not
intended for scripting): https://github.com/nasamuffin/quimby. Maybe
someone will find it useful.

I'll try and add your MSC snippet for the next rollup.

 - Emily

P.S. You can thank Jonathan Nieder for the name, as I asked for ideas
and he said "Wikipedia tells me Chief Quimby gives Inspector Gadget
something to read that later self-destructs." :P
