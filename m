Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F3C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0782074B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbkLGYqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFGUpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUpe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 16:45:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF83C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 13:45:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g62so9630340qtd.5
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mdai0KqKaifw/zoQPj2HvVbEw8E/yxW1Iz5FWiHnwFM=;
        b=BbkLGYqfIN1+Qpto6Y7HmPtS6eFkaKOWbSIsf+bYrFJfpUjnVyKvTKy1+7i60AhOpm
         tejY9i4bKylZCSTZm3IMWVIdssO6k8Ya9KtytqEiBqS6OzvXaeSPd9+O0ttvjUsjUDXE
         kAt8cnaCd/vaItS0eFbNIC8WgGPT73WdPF+f2rA7cogcgLXeZ1+7S+LzuaXuPEOON6Ff
         xRzpoERr1/y5ISzWAKfZ3B1SrwRc06tiKiIbY25uo77hZ0e2EY9sC7mWaF5elihfXPha
         V6qj1+AIIeh58zliyn7++6EjMEFT6mDn0cW2zjHkbTUFjxFmJdGkJy2XD0LayI6Vqz3w
         W/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mdai0KqKaifw/zoQPj2HvVbEw8E/yxW1Iz5FWiHnwFM=;
        b=qCtvF83FJnIlLTKL5gz+mRYitwuwOHs3zjGDEDOtmbJJ+SgTpJC/pUxVejYpV2AXWZ
         2SGsARqThXRECmmERPEHDBX+E4zde2asq9ap7CEjgXxLDSv8b3TCuxvGbMqCG67fGx+B
         Wj2auT03N3tRZ1XksZBHm6s6KgCBooos9SPQOp0lgvoRjeLoCZc7PfNTTPwVRDpC3mit
         n6BgZ3HKpOdXqT0nrwTzvHLF4oqOdAxsx56QeN7DDfY1QhUpH9x2bfjsxJTPvhpv231a
         XsZrkWlh2z+jd1MaBHR5zV9hn1nhrn1m+bnxPWRDPv82w371gIs2/H8KDGzW3C1Ih4lG
         CxIQ==
X-Gm-Message-State: AOAM532/4muCWwqLD0/BXGMeq35WF6tI/cwl8Rod+JjT+gURi3+xVsmd
        hd6kDlPb4lU8B0hGzkPoATg=
X-Google-Smtp-Source: ABdhPJwB38NFXt9NTYvTGqcgFAs0Udb6rHtHKh8dleCx/lgzRdHrudfBMi28miQ7uvEnMhAtTfetwg==
X-Received: by 2002:ac8:4b58:: with SMTP id e24mr20608596qts.278.1591562733833;
        Sun, 07 Jun 2020 13:45:33 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id b188sm5306493qkc.30.2020.06.07.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 13:45:33 -0700 (PDT)
Date:   Sun, 7 Jun 2020 16:45:31 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH] Recommend "git gc --auto" instead of "git prune"
Message-ID: <20200607204531.GA2313@generichostname>
References: <pull.651.git.1591546715913.gitgitgadget@gmail.com>
 <20200607162556.GJ6569@camp.crustytoothpaste.net>
 <xmqq8sgyn6o4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sgyn6o4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Sun, Jun 07, 2020 at 10:10:19AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> >> diff --git a/builtin/gc.c b/builtin/gc.c
> >> index 8e0b9cf41b3..3833a3de332 100644
> >> --- a/builtin/gc.c
> >> +++ b/builtin/gc.c
> >> @@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> >>  
> >>  	if (auto_gc && too_many_loose_objects())
> >>  		warning(_("There are too many unreachable loose objects; "
> >> -			"run 'git prune' to remove them."));
> >> +			"run 'git gc --auto' to remove them."));
> >
> > I'm not sure this is correct.  If we have just expelled a large number
> > of objects from a pack into loose objects because they're no longer
> > referenced, it's possible we may trigger another git gc --auto on the
> > next time we run a command.  If so, no amount of git gc --auto is going
> > to help here; you really have to run git prune.
> 
> Correct.  When running manually, after noticing the need to do a GC,
> it is a mental bug to add "--auto" to it, I would think.

Sorry about the confusion, when I was responding to the original
issue[0], I mistakenly typed the wrong thing. I meant to suggest
replacing it with `git gc --prune=now`, _not_ `git gc --auto` but I
guess I had my wires crossed. With this in mind...

The rationale behind this change is that John wanted to add bash
completions for `git prune`. However, I noted that prune is a plumbing
command and users should opt to use `git gc` instead. He mentioned that
sometimes when auto gc runs, it tells the user that they should run
`git prune` so I suggested (meant to suggest) replacing the command with
`git gc --prune=now` instead so that users could call the porcelain.

[0]: https://github.com/gitgitgadget/git/issues/642
