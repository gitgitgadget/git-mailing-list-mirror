Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBA1C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E591D221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEer2QoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgHFRZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgHFRC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D941FC0617A4
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 04:27:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so184288plt.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2aZMeoyGcC0OG65MI/t22yh+KRcYGzigSpc8a0b+DA4=;
        b=BEer2QoMFQh2ag/6aNCeNw19AQdsqYImmDF+KskBb4uExRbRd9x7oxjQ7ru4Wh197e
         8B/wRP5CphRd7TRCz7Uud4L1CxpOfXO/aB1k/XwqbaApep6XKLNoWvgKsDfjboqAVOAb
         fCJfzT5gQl0DknuaST3k2/u9tU5Fcz1ffLm9tifB/Wyz+0bpyAMXfTGs7zqNoU8aLOWw
         oRucPVUVpsh46+Jeh7izOK7Z8MWCPQkwkU1dD8rPu80zyCfWC+kpjJGKug95tNZ73IyE
         bBstq7oB6pvOregzjRaLuSC0pdai+Fqef+TVadxF2QfjUXd3y+5eiQNSVf0NXVbV/Liy
         ZM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aZMeoyGcC0OG65MI/t22yh+KRcYGzigSpc8a0b+DA4=;
        b=bHCq/laQBru4v9XobBf1HCy6ZxRvx0xjuJjXAn/gYjDnqhsiVNSi2mQiHyQ8GNa/BO
         ORBcTVSghQAf+sWgmFaHArmchzc4Jr690RdiYCl4j/O1Yo68Pa/2aOmSviS64Kl1fLiu
         OiD1CaWcVeLQgzmjd8WTjlK+t2rapIlGUnsy3eQXOwqmcFIB4v0N2l4WSXAKgfjoAIUw
         uYqMok4yRhgkMU5MeXCZ7tgBShE6ii5sYPnuVfRbhIi9Ou36HjVAPohO+ju+cRvfh2P+
         Byi4Jbz7MyWIioG9geKTL3C5I+ouBFWui9AzD55r3yGspMcbQbPFV3xusSTsKh3fgQLW
         1hlg==
X-Gm-Message-State: AOAM532fZmEesvXAkpJeN8UtEw0DkwYmCXWEYmdYvQQCicPUOsHQLlKF
        BM1p+l5QSNEZISl6QS0tyYBLZZp3Cv0=
X-Google-Smtp-Source: ABdhPJzsht3B9zxBPuNHzugshDgLAyKJUCdSp8akm2WS+GkMc8ub+Km9kg3s3yNb+Cz6/bMYgE7p5Q==
X-Received: by 2002:a17:90a:6807:: with SMTP id p7mr7931922pjj.42.1596713228541;
        Thu, 06 Aug 2020 04:27:08 -0700 (PDT)
Received: from konoha ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id h5sm8769986pfk.0.2020.08.06.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 04:27:07 -0700 (PDT)
Date:   Thu, 6 Aug 2020 16:57:02 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        chriscool@tuxfamily.org, me@ttaylorr.com, liu.denton@gmail.com
Subject: Re: [PATCH 4/4] t7401: add a WARNING and a NEEDSWORK
Message-ID: <20200806112702.GA15343@konoha>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-5-shouryashukla.oo@gmail.com>
 <xmqqy2msn5b2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2msn5b2.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08 02:36, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > Add a WARNING regarding the usage of 'git add' instead of 'git
> > submodule add' to add submodules to the superproject.
> 
> Is that a warning worthy thing?  As far as I know, using "git add"
> to register a gitlink is perfectly fine and a supported way to start
> a new submodule.  It may have to be followed by other steps like
> "git config -f .gitmodules" (e.g. when operations that needs to use
> the contents recorded in the .gitmodules file are to be tested), but
> writing tests using lower-level ingredients for finer grained tests
> is not all that unusual, is it?  I dunno.

The thing is that 'git submodule {init,deinit}' fail when there is no
.gitmodules. I can initiliase the .gitmodules separately using 'git
config -f .gitmodules' but I think it will be better to use 'git
submodule add' throughout the script rather than worry about it all the
time.

But again, if the warning seems unnecessary, then I can obviously use
'git config' to initilaise the submodules and change this commit. What
do you reckon?

> > NEEDSWORK regarding the outdated syntax and working of the test, which
> > may need to be improved to obtain better and desired results.
> 
> Sounds good.
> 
> > While at it, change the word 'test' to 'test script' in the test
> > description to avoid ambiguity.
> 
> Sounds good.  I often search for a pair of phrases to differentiate
> a single tXXXX-name.sh file as a whole and an individual test piece
> in it.  "This test script", especially when written near the
> beginning of the file, is a good way to clearly convey that you want
> to refer to the former.
> 
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> >  t/t7401-submodule-summary.sh | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> > index 145914cd5a..2db4cf5cbf 100755
> > --- a/t/t7401-submodule-summary.sh
> > +++ b/t/t7401-submodule-summary.sh
> > @@ -5,8 +5,13 @@
> >  
> >  test_description='Summary support for submodules
> >  
> > -This test tries to verify the sanity of summary subcommand of git submodule.
> > +This test script tries to verify the sanity of summary subcommand of git submodule.
> >  '
> > +# WARNING: This test script uses 'git add' instead of 'git submodule add' to add
> > +# submodules to the superproject. Some submodule subcommands such as init and
> > +# deinit might not work as expected in this script.
> > +
> > +# NEEDSWORK: This test script is old fashioned and may need a big cleanup.
> >  
> >  . ./test-lib.sh
