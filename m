Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415DC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E735205CB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwR27/+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgEMSpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732817AbgEMSpN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:45:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E66CC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:45:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e6so11370208pjt.4
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMh+khVDhJ1YZZf8EEmdGT25/fybjoaGpak9eWN+qnE=;
        b=gwR27/+uewZ/OmUvyT8ei5x4Nk1yL03IMUhp7Jtn890/0D4nnqtx2f1FxPABJV+gjm
         xCtGLGIUe51zOVXJ6qs97m3MCjDjqwI0rqlJk5sjVpYVgV1XF3/oUhNeDpk2esOYUxvu
         0UGKdevq/XHHjX+8MhR7Ov7eCCllyw+qkpRUNckCUGWVgpR2entr8KbPwlhf3GWZWe8C
         b8kSP0Ry10B512vnQdFf3zc0NkqJcvHYemwqQoUPJ5ssk4J7qVM1iKsSTTJSsR9sPXoE
         ZgHC/9c0yyvyigI+V3y9V/yhFBx5ejcxEwNhE9zxqU0FBkbMZPkKDTKQ47Lmb+Csi7X3
         ajDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JMh+khVDhJ1YZZf8EEmdGT25/fybjoaGpak9eWN+qnE=;
        b=CzzzI6qnIYL/7UhTN4PmfVT0NqA7oPFdahDdNskbzFBzkEcvrMaKn+UjVKwcYNOQ6e
         RcGfuvfy75Z5CJEITqqBCUKSyPwQeN7H6QlUbODTHtmZaBoanIO5y2GgdihR3+9eGfVK
         NrkEuQLsj8zrwKJlHQeXCeaPjyhwW13aScQfXFfjrx570tWv0bKzXbE3lyiD9t451e21
         Z7RJduW9LlRo/tunIlgh/aaeRr/H0th6JHIRwDU0Bl1K8dkH5a+/mBOdv5hZLwD8aDAw
         c/U5nGcrYx8jngiSNJ2ArGVln619EAdJxIojq93sUo1LSAnPNV9semuBnAf4jHc2NaS2
         6Lfw==
X-Gm-Message-State: AOAM532lYsiJtYGVlLnKE8dQVnJrxnKHwaMXq0FvaY8UCRSoT3HX6Ads
        5XIaWU166j8KMyhQWcGEi5VRrw==
X-Google-Smtp-Source: ABdhPJy+zmPpBXCGkkhbRnyUDwjCIqdDxic2RlBq446V/kbf9a+tPZEVWBseksNLciF4QmKeWYCLlg==
X-Received: by 2002:a17:902:fe09:: with SMTP id g9mr471806plj.301.1589395512617;
        Wed, 13 May 2020 11:45:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a200sm217434pfa.201.2020.05.13.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:45:12 -0700 (PDT)
Date:   Wed, 13 May 2020 11:45:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] help: add shell-path to --build-options
Message-ID: <20200513184507.GA196295@google.com>
References: <20200512234213.63651-1-emilyshaffer@google.com>
 <20200512234213.63651-2-emilyshaffer@google.com>
 <20200512235924.GC6605@camp.crustytoothpaste.net>
 <xmqqo8qswhpv.fsf@gitster.c.googlers.com>
 <CAPig+cRGrExRsucs8pmmiP+Zc2CmR3AU=8ACuiyH9tkz9JSCgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRGrExRsucs8pmmiP+Zc2CmR3AU=8ACuiyH9tkz9JSCgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 01:10:36AM -0400, Eric Sunshine wrote:
> 
> On Wed, May 13, 2020 at 1:02 AM Junio C Hamano <gitster@pobox.com> wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > > [...] A value of "/bin/sh" doesn't
> > > necessarily tell us very much on Debian (or on macOS, for that matter).
> >
> > Good point.  Perhaps readlink(3) on it, then?
> >
> > lrwxrwxrwx 1 root root 9 Mar 11  2018 /bin/sh -> /bin/bash
> 
> That wouldn't help on Mac OS:
> 
>     $ ls -l /bin/sh /bin/bash
>     -r-xr-xr-x  1 root  wheel  618448 Mar 18 22:04 /bin/bash
>     -r-xr-xr-x  1 root  wheel  618512 Mar 18 22:04 /bin/sh
> 
> Although /bin/sh is neither a hard link nor a symbolic link to
> /bin/bash, nor is the file size the same, it is nevertheless Bash (in
> some form or another).

Hum. It seems some useful things exist like $BASH_VERSION and
$ZSH_VERSION, but I'm not terribly excited about the idea of making a
list and checking each one in bugreport (as it's sure to be
nonexhaustive). I found a few more heuristics in a SO post[1] but this
approach generally looks like a pain, and somewhat unreliable.

Most other alternatives I found with a cursory Google involve checking
the name of the shell, which I think will have the same issues as
checking $SHELL:

 - `ps -p $$` for info about the current process (didn't reveal bash when I `cp
   /bin/bash ~/bin/nish && ~/bin/nish`)
 - `echo $0` since it's coming from the command line, of course will be
   the same as $SHELL

I suppose if we wanted to do the heuristics it'd be a better experience
for us, the bugreport receivers, to have the bugreport library collect
the heuristics and try to make a guess, rather than just dump all the
heuristics and let the humans try to remember which shell has $PS4 and
which shell has $version and so on. But to me that sounds prone to rot
at best.

 - Emily

[1]: https://stackoverflow.com/a/3327022
