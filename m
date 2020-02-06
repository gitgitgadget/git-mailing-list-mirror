Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25419C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72F220730
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPcBF6mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBFA2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:28:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34378 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgBFA2A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:28:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so5057485wrr.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UcBvAkGT76732kSv5mO/fasB75XsgZoGxjBMJspjLAU=;
        b=hPcBF6mfLeOPvqwLwv1LJJdIkSVkUMFiHQPK69et8QfSDhCDo3zW00w6wzBTDh2HEn
         czbr3r8BKbvdsq8w/hfyTiftVm1L3PZY3qsgzWmOs13PlBDOc/8OdHrBmuMCKxilJu9e
         YGUJ8zLiWWNEvmnR0XH9IC6j2ETlvdQ97D6qhrA+f1jjkWeDC6ejMW64ZFnj0Yb3ordT
         L1cp2yKrLtWyzxrbSGgxlIKlI4DFv3DuDfNiYD1KeRKmFYS379TqWfPohNz2ML+6QN/2
         4VHaphn4gbLumhzqESBmI5NokbVA8f4o9vtJgmWxDbVH6yWLqQhN91tiE1rbu/XezwJE
         JUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UcBvAkGT76732kSv5mO/fasB75XsgZoGxjBMJspjLAU=;
        b=oOwLvtL0K5z8bqiLc/Kk8DpQGukB6jqQnOQOJ0IFnBihcDfWPeB9020sXFSLhoRK2s
         koMlbEMhbSLXXq5SqellI/zRJ9yagQXEaQbIiwjhqD3Up+5vcA/j9vSJ/aCg//dWGjIo
         nCuxrbTx8g1ZIPZsh+7JwSTwxEyYltFk3Sq0iSu7baGsRtXTZJaSj8xDZ96lLf11TJIF
         4lKsNOSM4NCKjOpck/3Xf3y7ftzSYXAVXOUa50QRLbWDEjaRhHikKq/OqCv3eiBGsqqf
         iW2LTQ+x6adHSICKGGu78aiP9/HKdXp1Kz4bJHlZS+oSkCF2BonPStITrLwZ3S8392wK
         OOUw==
X-Gm-Message-State: APjAAAXN9wMLXL9Tmbhjoww3EXJiReeoAOBi78nStegOeqgIW88jktes
        u/iKtJe2cBXUyAGSJqNVe5OFerjB
X-Google-Smtp-Source: APXvYqwScJQZx2Ro4jQXNARfhwEuFl7wWAcbT+3owtTF7/zkcu/54tuohbS9IEPApz9cYnEoWm/C2Q==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr61638wrs.309.1580948879118;
        Wed, 05 Feb 2020 16:27:59 -0800 (PST)
Received: from szeder.dev (x4dbd62a5.dyn.telefonica.de. [77.189.98.165])
        by smtp.gmail.com with ESMTPSA id b13sm2034147wrq.48.2020.02.05.16.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 16:27:57 -0800 (PST)
Date:   Thu, 6 Feb 2020 01:27:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200206002754.GM10482@szeder.dev>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
 <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
 <20200123141626.GB6837@szeder.dev>
 <20200123175645.GF6837@szeder.dev>
 <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
 <20200124120240.GG6837@szeder.dev>
 <nycvar.QRO.7.76.6.2001250133510.46@tvgsbejvaqbjf.bet>
 <xmqqeev8694x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeev8694x.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 01:01:50PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Do they have to shout that loudly in the name?
> >>
> >> We could rename these jobs to e.g. 'linux-clang-py2' and the like, but
> >> I think it would bring little benefit, if any.  In our Travis CI
> >> builds these Linux/OSX Clang/GCC jobs come from the build matrix,
> >> therefore the jobname is not visible on the Travis CI web interface or
> >> API, only in the build logs.  There are some pages on Azure Pipelines
> >> that do show the jobname (and some that could, but hide it instead),
> >> but it's just too convoluted (or sometimes even impossible, well, for
> >> me anyway) to get there.
> >>
> >> And if the requested Python binary can't be found, which will
> >> eventually happen with 'python2', then the non-zero exit code of
> >> 'which' will abort the build, no matter how the job is called.
> >
> > I am mostly worried about contributors whose PRs break for "magic"
> > reasons. If it is not clear where the difference between `linux-gcc` and
> > `linux-clang` lies, that can cause unintended frustration, and I do not
> > want to cause that.

I'm not worried about that.  If a contributor doesn't touch any of our
Python scripts, then I don't see why using a different Python version
in the build would cause any issues.  And if they do modify one of the
Python scripts, then they should make sure that their modifications
work both with Python 2 and 3 in the first place.

> So, what, if any, decision have we reached?
> 
> If linux-gcc and linux-clang labels are not visible, linux-clang-py2
> and osx-py3 would not be, either, so...

The 'linux-gcc' and 'linux-clang' labels are not visible on Travis CI,
because those jobs as part of the build matrix, and, consequently, we
can't set the a 'jobname' environment variable for them in
'.travis.yml'.  If we were to include additional jobs for the Python
scripts, then for those we can (and should!) set
'jobname=linux-python' or something, and that would be visible on the
Travis CI web interface, just like e.g. 'jobname=StaticAnalysis'.

