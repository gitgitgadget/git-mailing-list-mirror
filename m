Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030D5C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D107420936
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ELbAUX1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgEFRio (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFRin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:38:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55235C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:38:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so795018plr.4
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1RXLMElhqCWiGXu5I2qiRew5/cqZwodRet7FDvs0/mg=;
        b=ELbAUX1L9uxHxHWmuKf/so/l9EguI8q0OpbOb/hw7GXGGUSaUn7NC/187yZgVlyXhU
         LCJZtVAA8XTXTGn+VaCZgjd5/eMMr23CDZrrK4IXBbZtvovzrQTVgHi6I1anAyTiZVzW
         UxZ94BkKWX5PE+i64KYqLaMFNsAbYCwn66DlnGBSLPd8lthw2NjgVNAgTXvbAGRwUNAX
         EvSvVBFv9Zf29++3W8MEqij+m8eQ/Tn/FvYNRoJ5cCpO87FP+yoOua17rkCEhhSREyMS
         /8Q87SwO8AHUB4OMtZ3kXFXTkqdKJQxBlbM7SqzgxgNPFEB6fe79YZ1L5C+mjbjUmWQ4
         Se+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1RXLMElhqCWiGXu5I2qiRew5/cqZwodRet7FDvs0/mg=;
        b=ZvJmrHUsMoquFHnQyDZ6IOnZ6WXYojFDww0mbhtexwuihZWt61E6JfJE531ICkt0OV
         tuJmSVdJENnOH9JgnNSq95+f7BJpUIOGcIyi00653T9YRQDuKw9lKc8qwr/GP6GC65Lj
         6+U14Mt+sCPGlRYV82dyuB1zGfsC8bpQ95TpnTlZuHf5pQYRc3hdGC2Spt/XnUVcGU2j
         J3Sa2UO/KJPegPKpNtUt/zuDuXu2MPi6VBmBT2+FUTevLktUwbZcC0m14cQ9+ucaoVeU
         6FT21VGVFmfNABZNM3MZsBLUOKOjmFye/nffxh44j5Lpgsa2peZ8PEoX2tuyw5w5WexX
         ZMgQ==
X-Gm-Message-State: AGi0PuYQudA6p4Aj3XFwWBHpvdP5AeSBoFQbL5zpSSMuE4e380VLSKJc
        1CtBtk6LrSoEsbewq+gLNBJRy/2f1x8=
X-Google-Smtp-Source: APiQypKy4hQgE8VP1udmPqSpEHFiscNFb6BVWSSvPP9cTjncZkkroX4PwHeiRyn3KuAzt7+R/0wYfQ==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr8699963pll.273.1588786721751;
        Wed, 06 May 2020 10:38:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a136sm2443613pfa.99.2020.05.06.10.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:38:40 -0700 (PDT)
Date:   Wed, 6 May 2020 11:38:39 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Pierrick Gaudry <pierrick.gaudry@loria.fr>, git@vger.kernel.org
Subject: Re: option -q not passed from "git commit" to "git gc --auto"
Message-ID: <20200506173839.GA6598@syl.local>
References: <20200506094327.GC31637@rillettes>
 <20200506172823.GB6078@syl.local>
 <20200506173356.GC6078@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506173356.GC6078@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 11:33:56AM -0600, Taylor Blau wrote:
> On Wed, May 06, 2020 at 11:28:23AM -0600, Taylor Blau wrote:
> > On Wed, May 06, 2020 at 11:43:27AM +0200, Pierrick Gaudry wrote:
> > > Hello,
> > >
> > > It seems that when "git commit" is run with the "-q" option, there are
> > > still, from time to time, messages that get printed. With the French
> > > locale the message is:
> > >   Compression automatique du dépôt en tâche de fond pour optimiser les performances.
> > >   Voir "git help gc" pour toute information sur le nettoyage manuel.
> > >
> > > From what I could guess, this is due to the fact that "git commit" calls
> > > "git gc --auto", but does not propagate the "-q" option if present.
> > >
> > > A similar problem was present some time ago with "git fetch" and was
> > > solved in the 2-line patch 6fceed3b . I guess that the same should be
> > > done for "git commit".
> >
> > Yes, I think so. A quick search through the list archive turns up [1],
> > which identifies and provides a patch for this issue. If I were
> > reviewing that patch today, I'd suggest the following:

Oh, [1] is an email from today. Clearly I am not finished reading my
inbox yet. Sorry about that.

> >   * break the change from a 'char **' to a 'struct argv_array' into a
> >     separate, preparatory patch.
> >
> >   * adjust the commit message of the second commit (which will only pass
> >     '-q' to the 'git-gc' sub-process) to indicate that there may be
> >     other locations
> >
> >   * fix those other locations that spawn 'git gc', if they exist, in a
> >     similar fashion
> >
> >   * in each of the previous two steps, add tests in the appropriate
> >     files in 't' to demonstrate that '-q' propagation works as expected.
>
> Junio identified a much better way to do this in the email below this
> one. Since it appears that there are multiple places that ignore
> '--quiet' when running 'git gc' as a sub-process, a helper function is
> certainly you want to be using.
>
> > I'm happy to do any and all of this, if you want, but you are also
> > welcome to submit the patches yourself.
> >
> > > Regards,
> > > Pierrick
> >
> > Thanks,
> > Taylor
> >
> > [1]: https://lore.kernel.org/git/20200506140138.650455-1-abhishekkumar8222@gmail.com/
> Thanks,
> Taylor
Thanks,
Taylor
