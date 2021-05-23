Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E37C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 11:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C0B600EF
	for <git@archiver.kernel.org>; Sun, 23 May 2021 11:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhEWLwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 07:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhEWLwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 07:52:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B9C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 04:50:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so9570140pjb.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jhpKAoDEp9UXIZPXT6+W8HnUAsuAYwJWNd+qmWRqb0Y=;
        b=rny98n2B1OBWv1UUMB7LOlae2zP8T//AeN1SVyEqCAH/LhskZvN1/tnupwA4J6W7ed
         2aI2jaQe8dDEEbFj4sk15M7OeZzVuBpBMHOrdpFc8l2mfG3CWigG+euzGKuB0wpM+r9q
         aphF5Dqdqpd0jQ89v4xgGz6cbVqCv7SfPw8qbpwbXSI3FU3sv3Caz0MJenh7HwbciL6X
         xQatgACLkyxMiFPdhbV2i8uC0WiaXVlNkafL3QmuH7hacVDY2RjDplViskUHhksOAa1M
         DAL2a5r614yQuvi1Z+DvxJqS/rTANZ2qM7oB/wTxnfbMEZsQ3BArarN5VKePuOYUOa/L
         yVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jhpKAoDEp9UXIZPXT6+W8HnUAsuAYwJWNd+qmWRqb0Y=;
        b=Y82ugXJ432myQEbBsRucWXkKhnW1OU9Rz3bhkBPd2w6nAl774IiMP8mBuwWA0QUfjh
         D9hgBkiY2N0bxkITNo1XRd3r1jkFZTy9sbR0ouc99Ci+SJl2kkWw9pkS2ELgsmGUECa0
         MdV+zt/Kpz+Cm0CcxeF3gf0JKWdbZtt+BvL+ScblnK5M2XFJ9/Dn4P11x73Z/BiFEwjk
         oQ5OSySIhTUiWbGaFbIVJAkWs5eiFtl5zk5oXREq8V7Y+IxAE10yfQgNWZjIiXzecUae
         5BEEeyGlDK8GVmkvTaFNJ/+zZbrIFnIU6mkwJ7PTtbbqmFV9G18iRr0Jkg0iQ3YXos8b
         xakg==
X-Gm-Message-State: AOAM533gMIKiE6SUlctN1GeH+DO8GoV0QMGssN6jnViUlwvAMzEB5t2Z
        +g3z5opIulLRKsjjdOP5QjPTvCJUZBm76H7Z
X-Google-Smtp-Source: ABdhPJzWUK5G5h0H/waDXO6DwXk5aF2feMjTpPKUjAyH6z6aIhStgUI1I00RXhLod6YDtjU+utPiTA==
X-Received: by 2002:a17:90a:e50e:: with SMTP id t14mr20049407pjy.101.1621770645480;
        Sun, 23 May 2021 04:50:45 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id s23sm12489318pjg.15.2021.05.23.04.50.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 May 2021 04:50:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] My Git Dev Blog
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <f1fca31b-17b8-9dbb-4d46-dda8c44645c1@gmail.com>
Date:   Sun, 23 May 2021 17:20:41 +0530
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <89EAC320-9B0B-4E16-9433-FE80B1A1DF81@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <f1fca31b-17b8-9dbb-4d46-dda8c44645c1@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-May-2021, at 13:40, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> Hi Atharva,
> 
> On 22/05/21 23.42, Atharva Raykar wrote:
>> Hi all,
>> As is tradition, I have started my weekly GSoC blog :)
>> Here is week 1: https://atharvaraykar.me/gitnotes/week1
>> I shall be sharing my progress, thoughts, experiences and any
>> information that might help future contributors in my blog.
>> After my GSoC period, I hope to convert it into a blog that
>> will help pull in and guide new contributors to Git development.
>> Any kind of feedback will be appreciated!
> 
> You said on your blog that you switched your development environment
> from Linux (what the distro you used previously?) to macOS. Why did
> you make the switch?

No special reason for this. My old Linux machine was due for
an upgrade, and a new M1 Macbook has since taken its place.

> Next, you mentioned that you set up emacs config for Git developers
> (ones that contribute code to git.git). Since I use (r)vim instead
> of emacs as my editor, what are similar configs for vim?

I don't really use Vim that much and I am not that familiar
with how to configure it. Sorry, I don't think I can be of
much help here. I also don't want to share tips on my blog
that I won't be making use of.

> And finally, you said that you had to deal with "header not found"
> errors. I asked these questions:
> 
>  1. You mentioned that in order to link against gettext on non-standard
>     path, you did:
>> ./configure "LDFLAGS=$LDFLAGS -L/opt/homebrew/Cellar/gettext/0.21/lib" \
>>     "CFLAGS=-I/opt/homebrew/Cellar/gettext/0.21/include"
>     Why did you use full path to gettext? I suspect that you can instead
>     use `LDFLAGS= $LDFLAGS -L/opt/homebrew/lib \
>     CFLAGS=-I/opt/homebrew/include`, because when you install a library
>     using homebrew, it will symlink the library location from homebrew
>     standard hierarchy (/opt/homebrew/{lib,include}) to actual location
>     (/opt/homebrew/<User>/<package>/<version>/{lib,include}).

Thanks a lot! This was helpful and did work out for me. Since
I am new to macOS (and homebrew), I did not know about this
hierarchy. I finally decided I would update my post to use
this along with a Makefile-only approach recommended by Philippe.

>  2. Can these procedure above for linking Git against libraries at
>     non-standard locations (such as /opt) be applicable also to Linux
>     systems? Try to adapt that procedure on your Linux system (if
>     available), with custom-compiled newer version of any of Git
>     dependencies (such as gettext).

I'm not too sure, and unfortunately I don't have my old Linux
system to verify this.

> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

