Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5FC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC8560EBC
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhKDR0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbhKDRZg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 13:25:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43659C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 10:22:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b4so5977745pgh.10
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVKqgaq4P88UdkW9FO2fgDSS/KNMS/nxUXQcrLtDQXk=;
        b=oukGy0HhLRxwRlaoKmnNmlbWbJsfk3SG3jEj8UT8XR6w2MSn6uhmnQzrAaPm4Ieho6
         5tok+Z/DAFjgfOla1RWYcaY5xtu+cugBHzc5v0h81cygFwW1JXfwqufaCEklKb2S74bg
         QPQS22VDrxk+LfnnRaLZjHlg8o6oeynVF29gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVKqgaq4P88UdkW9FO2fgDSS/KNMS/nxUXQcrLtDQXk=;
        b=3QU2GqGCCwARt8C0Re37QCbaRleRIRmMeSaEKKMB9i30Stoyb6S/Eo+v9UBg7Gx3zn
         YCHrw9hAt5cWLMqf313Zm6omliWh7koNZmbUbUm6oVBXoq6N+d22UJPUjOCBmoo7SY0U
         YER5xDNJIxx98pXhDMT7WL1J/jL75aM0skCE8B9VqDmVolQhFJKFaGzdcyFRrIvSyozu
         ocnwrx3hksR+pg8XOQ7egIVIJIXsqJknnLTXPnGRNJvaiv96ebaThowRYaaTXvFc+CCJ
         vYloPioBUXNSUEhV+U2rVdqGNcakC5znBY36+vbIEDtsmSySWzsgNXDRgGQ0FLLWUq4u
         JzDw==
X-Gm-Message-State: AOAM532YlwtcdONbCoSIJFLA6DQ2uKuv/p6Fqur91fP+AhBUhFO/gyhk
        j7rGr+39B2LWceOMO2HKmiXj1/F4MRz63g==
X-Google-Smtp-Source: ABdhPJwui8fCNYVV24r6K6rK0ziFEmOLlNxOJDGoDV8uS3/o8OhN29ywObyWe7EbARa7rVKPo9/10w==
X-Received: by 2002:a05:6a00:c88:b0:481:32b2:9b47 with SMTP id a8-20020a056a000c8800b0048132b29b47mr17552819pfv.45.1636046577570;
        Thu, 04 Nov 2021 10:22:57 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id w21sm5773514pfu.68.2021.11.04.10.22.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Nov 2021 10:22:57 -0700 (PDT)
Date:   Thu, 4 Nov 2021 17:22:48 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] ssh signing: verify key lifetime
Message-ID: <20211104172248.GB1419@dinwoodie.org>
References: <20211027080616.619956-1-fs@gigacodes.de>
 <CA+kUOakzQ5aEQf81rQULiz6FRdmCLnbhspt9e6behPS3sbZT8w@mail.gmail.com>
 <20211103194558.xqcsaljvcoontnal@fs>
 <20211104163142.GA1419@dinwoodie.org>
 <20211104165458.zphsk7jgdnyh7ybs@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104165458.zphsk7jgdnyh7ybs@fs>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 04 November 2021 at 05:54 pm +0100, Fabian Stelzer wrote:
> On 04.11.2021 16:31, Adam Dinwoodie wrote:
> > On Wednesday 03 November 2021 at 08:45 pm +0100, Fabian Stelzer wrote:
> > > On 03.11.2021 19:27, Adam Dinwoodie wrote:
> > > > On Wed, 27 Oct 2021 at 09:06, Fabian Stelzer <fs@gigacodes.de> wrote:
> > > > > This series adds key lifetime validity checks by parsing commit/tag
> > > > > dates from the paylod and passing them to the ssh-keygen operations.
> > > > >
> > > > > changes since v1:
> > > > >  - struct signature_check is now used to input payload data into
> > > > >    check_function
> > > > >  - payload metadata parsing is completely internal to check_signature.
> > > > >    the caller only need to set the payload type in the sigc struct
> > > > >  - small nits and readability fixes
> > > > >  - removed payload_signer parameter. since we now use the struct we can extend
> > > > >    this later.
> > > > >
> > > > As part of testing v2.34-rc0 on Cygwin, I've found this patch series
> > > > is breaking t4202, t5534, and t6200.
> > > >
> > > > Specifically, bisecting points to f265f2d630 (ssh signing: tests for
> > > > logs, tags & push certs, 2021-09-10) as breaking t4202 and t5534,
> > > > while responsibility for t6200 seems to be 9d12546de9 (ssh signing:
> > > > fmt-merge-msg tests & config parse, 2021-10-12).
> 
> Ok, i should have read this closer / checked the commit. The commit you are
> referring to is not part of 'this' patch series, but an earlier one which was
> indeed merged and part of the rc.

Ah!  That's at least in part on me then; I'd found the most recent
thread that looked like it was related to this patch series, and assumed
it'd be the one that was included, without checking the actual commit
contents.  Apologies!

> > For t4202-log.sh, the failing tests are "72 - setup sshkey signed
> > branch" and "75 - log ssh key fingerprint".
> > 
> > For t5534-push-signed.sh, the failing tests are "8 - ssh signed push
> > sends push certificate" and "12 - fail without key and heed
> > user.signingkey ssh".
> > 
> > For t6200-fmt-merge-msg.sh, the failing tests are "3 - created ssh
> > signed commit and tag", "7 - message for merging local tag signed by
> > good ssh key" and "8 - message for merging local tag signed by unknown
> > ssh key".
> 
> Could you send the full output of these tests directly to me?
> Best would be sth like the full output of
> "GIT_TRACE=1 sh t4202-log.sh -vx"
> and maybe for one test with the trash directory in a zip file (just run
> the test with -vix, it will stop at the first failure and leave the test
> files in place)
> 
> I don't have much experience on windows (especially not cygwin) but
> maybe i can spot the problem.

I'll send these to you shortly.

I don't have much experience with any of Git's signing functions, so
perhaps between us we might be able to get somewhere :)

> > > What openssh version are you using? (ssh -V)
> > 
> >    OpenSSH_8.8p1, OpenSSL 1.1.1l  24 Aug 2021
> 
> That should be recent enough for this to work.
