Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4860C2D0F9
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA20206F5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgEMFKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 01:10:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38659 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgEMFKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 01:10:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1so5109621wrt.5
        for <git@vger.kernel.org>; Tue, 12 May 2020 22:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7hSs/s2XqwWOJm4KDrYzN9OHOgBHWBN5UWASDZrxnI=;
        b=UBXkUVPwBs824uat2tlJ9E5+rIMJe9Dk6I8LgyT57yRMvQdbfW7gSnjXIMk5X7lJkR
         BrnIaQKRy4LXrXVnzAdgyR7X1SiGK7mMQkEYqLCwfgWwS1FMb92N9/mOyJpSGdTHsnQf
         /g5HcseX4LCnCOh/ukWhv+nxN12yHFia51i7AWz5hr8R+ZYeCpnWeXu14zI5Jpm4ukxD
         8XJYdHdrxpdZ1vPDZkYQ6nM1wVHdTISKGgnLO18XKVFBCakLTMjTcc5M9D6if8wq+OB+
         5MaATytqdqY48QJvCzPeK/DIwb3x4cnjrbBF2qgnYIjk7I6UorUiug7XMk5ofYzwC1hR
         8ILg==
X-Gm-Message-State: AGi0PuZOjwQTTz35ELJKcIwwoiJn+isJlzWmT6zvgWSe3XesAGaxcmIE
        iU5N2pB8CQDAMB9wQO/aHW6eMgdsuG9m4KAmJ6o=
X-Google-Smtp-Source: APiQypLLFWJZemJqxMQiDmXvZE/TqK5EmRBnhdwm/UhwSZ7QvUiolLZdMeMUh+EB2BOQ+qnQio68vkpe5B+VlNKo1OU=
X-Received: by 2002:adf:f651:: with SMTP id x17mr30122179wrp.277.1589346648064;
 Tue, 12 May 2020 22:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200512234213.63651-1-emilyshaffer@google.com>
 <20200512234213.63651-2-emilyshaffer@google.com> <20200512235924.GC6605@camp.crustytoothpaste.net>
 <xmqqo8qswhpv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8qswhpv.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 May 2020 01:10:36 -0400
Message-ID: <CAPig+cRGrExRsucs8pmmiP+Zc2CmR3AU=8ACuiyH9tkz9JSCgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] help: add shell-path to --build-options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 1:02 AM Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > [...] A value of "/bin/sh" doesn't
> > necessarily tell us very much on Debian (or on macOS, for that matter).
>
> Good point.  Perhaps readlink(3) on it, then?
>
> lrwxrwxrwx 1 root root 9 Mar 11  2018 /bin/sh -> /bin/bash

That wouldn't help on Mac OS:

    $ ls -l /bin/sh /bin/bash
    -r-xr-xr-x  1 root  wheel  618448 Mar 18 22:04 /bin/bash
    -r-xr-xr-x  1 root  wheel  618512 Mar 18 22:04 /bin/sh

Although /bin/sh is neither a hard link nor a symbolic link to
/bin/bash, nor is the file size the same, it is nevertheless Bash (in
some form or another).
