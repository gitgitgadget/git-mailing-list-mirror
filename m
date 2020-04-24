Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54634C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5620728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLt1MP2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXWeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXWen (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:34:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79FC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:34:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so5312962pgg.4
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y1+HPJPe8f+JFzVqFTGziUJuGOLmr5JYpRUcu8QLDTU=;
        b=kLt1MP2dzjOINM67DiEWTQG8au3isWFb+aFU21mPmK2xAl+jrwlP2ORcLu5lhd3tI9
         nbWWxUC2gS3/BcT1M4030KpuynWKHA1GEGPEig9aR20Sc7bxoCZ3bGjjHdjLZmPYe/20
         y41cV766yXxNSN/z85ZEEKtYPdtGvJMGY/Q4XHLxi8CpnStHQvn5CY74r7zOyzjPFjJR
         4gXoBIkedYX+/1y0HQBAJ7vE9bpq3zOP+nbjqKvaFM7UMtWqAhuaj5uunJjoAy8m/fhp
         JiOgiO8s1/slshn6WiPQ2napIeGhlb5Ioa9I9aFH1aFkzHdipwnIF7ZNOQ4ceilkc7hM
         K7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y1+HPJPe8f+JFzVqFTGziUJuGOLmr5JYpRUcu8QLDTU=;
        b=WxxPp27hDxPvyIEsifaGvtjTVng5ONBusfiFNewnOKnKYkIzVLPKXPicHjY8nmaTvG
         YcC7b3xPyhYlbLphmLTsUNfIUwqm5RuAFC7jBYgtbIR1QTU6n/wOJ2MwE/5zEE8ccp+6
         utGVtsYs6UZaM1vrUOUm10QK0oQd0izbfrqkV2tQKSNmx3T3tNjkPACKcjBNy4qAn/c9
         2TO9avR2mKGXe0Nhww10HSZwnUpkZmYJFrV5q8p9vnKFZv0YvAkmTFBfO+jUL3A6fhDn
         3tWndpssg8iJ4o5jms6OsS01/Q0QkkUHM3sRg7PLfPsYy68x5GysjVxQfGChEFsOyXjs
         9Lxw==
X-Gm-Message-State: AGi0PuaTf2TLnvP6ef4jzCouWvSkeRvxxUGqRaGv+QIJEVUUq1UDcNjh
        2bgr8kuiq5B1b3wB0Snc6yakaolj
X-Google-Smtp-Source: APiQypIvFC5Z5pDfnNXO08ivqeFF5/wUIwRY9QAInc5qTWflp+nDICs9NJIsDhzAyit+0E0jZ/V4sg==
X-Received: by 2002:aa7:8ec1:: with SMTP id b1mr12118334pfr.103.1587767682925;
        Fri, 24 Apr 2020 15:34:42 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id q200sm5864637pgq.68.2020.04.24.15.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:34:42 -0700 (PDT)
Date:   Sat, 25 Apr 2020 05:34:40 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
Message-ID: <20200424223440.GC721@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 19:29:31+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
> 
> On 24/04/2020 18:09, Danh Doan wrote:
> > On 2020-04-24 17:56:46+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> [snip]
> 
> >> So, again I don't see a problem. I guess it is possible that the
> >> version of sparse I am using (see above) has _also_ fixed this
> >> problem, in addition to the prototype attribute placement fix.
> >>
> >> Another option is that the version of glibc also matters. (I am
> >> on Linux Mint, which is based on Ubuntu 18.04 LTS) It would not
> >> be the first time that I have seen errors in system header files
> >> change from one release to the next ...
> > 
> > I'm using a Linux distro with musl libc.
> 
> Ah, OK.
> 
> I just tried re-building v0.6.1 to see if any '<alloca.h>' related
> errors/warnings show up for me, but they don't:
> 
>   $ sparse --version
>   v0.6.1
>   $ 
>   $ git checkout master
>   Switched to branch 'master'
>   Your branch is up-to-date with 'origin/master'.
>   $ 
>   $ make clean
>   GIT_VERSION = 2.26.2.266.ge870325ee8
>   ...
>   $ 
>   $ make NO_REGEX=1 compat/regex/regex.sp
>       SP compat/regex/regex.c
>   compat/regex/regex_internal.c:925:1: error: symbol 're_string_context_at' redeclared with different type (originally declared at compat/regex/regex_internal.h:433) - different modifiers
>   $ 
> 
> > I guess it's the main culprit?
> 
> Quite possible, I guess. What do the errors/warnings look like?

OK, I've tried with my glibc box, it doesn't have that warning.
On musl, it warns:

	$ make compat/regex/regex.sp
	GIT_VERSION = 2.26.2
	    * new build flags
	    SP compat/regex/regex.c
	/usr/include/alloca.h:14:9: warning: preprocessor token alloca redefined
	compat/regex/regex.c:66:9: this was the original definition
	compat/regex/regex_internal.c:925:1: error: symbol 're_string_context_at' redeclared with different type (originally declared at compat/regex/regex_internal.h:433) - different modifiers


-- 
Danh
