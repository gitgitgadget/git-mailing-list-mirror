Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D30C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032A8214D8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0vWHZIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMWlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:41:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34045 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMWlL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 17:41:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so425331wrr.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 14:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQnWL3hA0thLMvJIqyXDYWUe/O3ZfWw2TDfaKXd2MRQ=;
        b=R0vWHZIMDQJpv0hSe/A3fEElQypRqisaBNdMuop5EJaGJtexa1fveBg+rqCpJE3HYl
         h/q7wggpi/w5XZ8xfJxI5FwtquNtOOekOKifaq9yAlJWYIyJKLimygD9DhslJPqWqYBh
         SEHEBxgWL7u/TKarhTLtmqVAOF7gL1VA7ywrHGkdRug0XNT/0RP4tacniKK24Z8cynlU
         mBMTB6lJV2dmytb6aA8IoMza/fw05lFTV2HSZ3lNwRO9SZ8t/GEYy5pK8ILGK3Makr6q
         H0AnVewfIGoa5wWJouiODvb871wnp+f9OmRIgAAkMhllsDioKZ6abmxK5BrFglbubGLr
         NQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQnWL3hA0thLMvJIqyXDYWUe/O3ZfWw2TDfaKXd2MRQ=;
        b=octS4+cclr3dgL7bxPENBQv2z9d5Te0Hg3qZjVmG979Gto2s/Z3NXrE350obLZlX1w
         KWRpXNnK99a5Zt+K1H0m9kon8q+Wcr5vb0z8Vucp4xF1IuMGIq4MetHIO0elNDLdDNq6
         s5dVWmFNb2P8Vnvxs18RGOQJV7qkLJf480IIRj/qqqFmR71YJ2Ai/VQRpzLIElaVwv/C
         /kRsFyF5/dIe03JUjE68mVY1auinq0oARVzZm9BmCk34NY7aY0J/WpIJ1KmZbUlC/RCn
         m1zssHdssjmKYETnAtWDRkjFjRmOkaA0eHwKo8KYgFXKdlrhEglL6IuCyjnp4eoo1wsw
         pYxA==
X-Gm-Message-State: APjAAAVr6N0fkex4QWK6nSAzqThVZsG/QIX0jGNyWTFoyGHdmzhm69FN
        GYM7oqh2lBf93hi/wwrLKF4=
X-Google-Smtp-Source: APXvYqzMBMVCCysWBdraTCdmx3hxzQr6Kjs5FZgNtx7y3vYBcmd21chZghisIFjp/rbuY1D+mdQSIQ==
X-Received: by 2002:adf:814c:: with SMTP id 70mr14581172wrm.157.1576276869658;
        Fri, 13 Dec 2019 14:41:09 -0800 (PST)
Received: from szeder.dev (x4db954a5.dyn.telefonica.de. [77.185.84.165])
        by smtp.gmail.com with ESMTPSA id f1sm12055189wrp.93.2019.12.13.14.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 14:41:09 -0800 (PST)
Date:   Fri, 13 Dec 2019 23:41:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Charles Diza <chdiza@gmail.com>, git@vger.kernel.org
Subject: Re: Regression in 2.24.1 wrt progress indication
Message-ID: <20191213224106.GN6527@szeder.dev>
References: <20191213172835.GA2315@349209-PHI-GMNO-CLAHS>
 <20191213173858.GA117158@coredump.intra.peff.net>
 <CADv8sCUDSu7deSP4Wqry_S0TXM90QQu3EO_X_5ZONkXPocUiZA@mail.gmail.com>
 <20191213223554.GA918826@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213223554.GA918826@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 05:35:54PM -0500, Jeff King wrote:
> On Fri, Dec 13, 2019 at 05:21:56PM -0500, Charles Diza wrote:
> 
> > > The bug in question typically showed due to the server side of the
> > > connection. Do you see it during a fetch (or pull) or push? If so, what
> > > server are you using? Is it possible that that server upgraded recently,
> > > and it has nothing to do with what version you're running on the client?
> > 
> > It happens during pull.  I've seen this when pulling from gitlab.
> > Reverting to 2.24.0 fixes the problem.
> 
> gitlab.com is running v2.22.2, which has the bug. And I see it whether
> my client is v2.24.0 or v2.24.1. 

Me too.

> Are you sure it comes and goes between
> client versions?
> 
> Note that it is impacted by your terminal width, as well (it only shows
> up if your terminal is lower than some width; 80 chars, I think).

88 chars.  8 chars of "remote: " prefix + 80 spaces.

