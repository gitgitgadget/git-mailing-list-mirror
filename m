Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B003C5ACC4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9020656
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGKiOj3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBSWpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:45:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39407 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgBSWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 17:45:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so827079pfy.6
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 14:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGrrXe8UArrvIvKsvvN2uhEO8bA99ZAo1agnXUFmmlQ=;
        b=EGKiOj3+o81mrKyy8GI9sMdLH8jNEwdwlUgKkCPK3MsdHaNDEMImLJk98T3uypu+Oc
         D0mzpvYo8P3v+2PuU/xirok53b76lRiQ20o0u7GIRsDi36rqbKAFFs4poGw/pKdkfta9
         D+tGZGL2QyB5JpYyp/1nVpr0Oz3Pkrc6xIbV7pZsS6ERBl9MWBkBSp9oK0iSdYWc0QNX
         HTTsQ7MRRw1fxQMzGz1Gc3HpFB9s/pb8SfOPLOAYPXdJRSEOVYihGPw4m2gycyLR82ZL
         S6IZECgTvhEEUpo9pnTuiy54cpK0w2L+4JXrTlX9B5L+iGkepWjbAh28C0Qows1iaiJH
         dv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGrrXe8UArrvIvKsvvN2uhEO8bA99ZAo1agnXUFmmlQ=;
        b=ftzqSWUsCiff6MzosoXx3ELDRAhyJV2YAyTzaztFNEj2WFfqHsYnaAhLprWxeRpbOZ
         S2pp5NklzEoZ8TsA1nQWz0uctT2EJB9D0gr5OVG+OSDYa6ALxwJ8ESMTwR3lfUENy3fv
         xPobcRaeZ7tZ1UMTYvG5mX5yG7p2jyMjB9v7m1SYQVH0IlGhplo9i5CPMEjU4NpTXB1D
         Rd0MheG2KRH0HDBrJ5Bed3BOcX3XDH4abApfPCnTEo73p6H+6Z704bD5og6+zZ/KTHyt
         frgnY4DeZpB5ADAeKx0ATeqPQl76bdnBaEJW5bwHmfIni4+YIrfajyat7CQhFp+ZbEKj
         o1UA==
X-Gm-Message-State: APjAAAX1hhl56c2lFVak6q1JeHM+TT1Vf+9NgCjGH1wMWePqcb/WxAqB
        zFNM4qLr7Qfz52sSWbSg+lE5PY4RIw4=
X-Google-Smtp-Source: APXvYqyhIthcJMM/dvD2BS0mtkqIfc4JIujOvR6KJs7hSFLG+6lGA+EFx10sa+ZMdRtEbn/0FxzUIA==
X-Received: by 2002:a62:b604:: with SMTP id j4mr10491955pff.93.1582152351943;
        Wed, 19 Feb 2020 14:45:51 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a10sm712622pgk.71.2020.02.19.14.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:45:51 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:45:47 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 06/15] bugreport: add compiler info
Message-ID: <20200219224547.GC26221@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-7-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 03:23:34PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 13 Feb 2020, Emily Shaffer wrote:
> 
> > To help pinpoint the source of a regression, it is useful to know some
> > info about the compiler which the user's Git client was built with. By
> > adding a generic get_compiler_info() in 'compat/' we can choose which
> > relevant information to share per compiler; to get started, let's
> > demonstrate the version of glibc if the user built with 'gcc'.
> 
> I agree with the need for the compiler information, but in the patch I
> only see information about glibc being printed out. Shouldn't we use
> `__GNUC__` and `__GNUC_MINOR__` here?
> 
> Don't get me wrong, the glibc version is good and all, but the compiler
> information might be even more crucial. Git for Windows had to hold back
> compiling with GCC v8.x for a while, for example, because the stacksmasher
> was broken. Similar issues are not unheard of, and could help pinpoint
> compiler-related problems a lot quicker.

Hm, sure. Good point - thanks.

This does make me start to wonder, though - does it really make sense to
have ifdef-gated redefinitions of the whole get_compiler_info() method
like I do now? I wonder if it makes more sense to have only one
definition, so we can write down everything we know regardless of which
pieces are put together. My thinking is something like this - what if I
am using glibc, but not a GNU compiler? (The GNU docs on __GCC__
indicate this is a situation that might occur - "a non-GCC compiler that
claims to accept the GNU C dialects") Is there some striking reason not
to implement this compat command thusly instead:

  #ifdef __GLIBC__
  #include <gnu/libc-version.h>
  #endif

  static inline void get_compiler_info(struct strbuf *info)
  {
  	#ifdef __GLIBC__
	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
	#endif

	#ifdef __GNUC__
	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
	#endif

	#ifdef _MSC_VER
	strbuf_addf(info, "msc runtime: %s\n", some_msc_info());
	#endif
  }

The thinking being - this way if I decide to use, say, LLVM + glibc,
then I don't need to reimplement this command with all the glibc
diagnostics again. Or, if someone else already wrote diagnostics for
LLVM with some other libc, then it even Just Works for me and my new
combination.

That said, I'm reasoning about these combinations of compilers and libcs
and whatever else from an inexperienced viewpoint, so maybe this isn't
necessary?

 - Emily
