Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E9AC54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B2A206D6
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFIIt8jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD0UER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0UEQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:04:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB14C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:04:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t11so14912085lfe.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MGhmE7hpVZIOifwwxWh0jXlW9KWhxJPwQ5nV3fy9IEA=;
        b=RFIIt8jYtnNhEsCAMJan2F8ZpEoOyRrO8133jSk2Ad9W51gfFaE03zFhJ9a2nrwuho
         UlF0LRbgYckoLZrPMVpNGwOdsIGX1axhhGlGnnwkmSke9YXRV8kqhLIF02olfRQry2CD
         ZPCcaV5CCAQWDaNgS/GrTcXNSjuagN0K9X1mweW7RZtw1iLgtuNOPQWBPZX50+kW6qbr
         j3s4NBp2SgrDdYm8lK4lj05qF0Sqa7B6IS0pAXvuB3nXE98U1mqdwVqzjpy4UWX6T4+0
         kBlH0uzX+92GgzQvAM7NW8WY+eW1gTDkVCjTW9iHgTC7qOfTzfZDbv4SC+jVXBsmlaxz
         lxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MGhmE7hpVZIOifwwxWh0jXlW9KWhxJPwQ5nV3fy9IEA=;
        b=LYk7z/nRn9F9OcxdoF+DQ719Cz3qjtPWeeYmw8AGUbMuoxnb8aTa5CJeBkmah6tlaT
         4j6rbdlgEdAhzt26hTYe6ZAmU0CqGql02x47434LZ6CFvkM1JqtHjFjeNUvijsANyRg6
         BbBBVvr2uqR0RgNJ+HnPgrTYUHNsJDe81nWXPAJ8M9YaCnZM/3nDC5oZYWl+y0gxNfl0
         4bRlNb+vfgdeNisxE4HpOc43MzZb2Bt+6IVkg82+GkL6vcPzxbGQYhgvukkpQLzS5L5G
         Jv9XOCQrfIyypZIaoHNgJkgLbEpJBbK3PHJMa5e//fubIWcTO9gk41WXunMdDKmnJEoE
         u26g==
X-Gm-Message-State: AGi0PuYRpwcxj2plM1cy8OgatzFU5Urx3G932SC7CmpHZWtnpBS988NC
        Iq9lYQXSJEWn7ZpS+LhYUNM=
X-Google-Smtp-Source: APiQypKDZNqA5Dcsx16Gc0ZeK+7oz1MmssjlJRcfXDXWvEHH3tT6T/yO0GgAWseiEPhQd3Bcq0KXtw==
X-Received: by 2002:a19:5f4e:: with SMTP id a14mr16787744lfj.57.1588017854789;
        Mon, 27 Apr 2020 13:04:14 -0700 (PDT)
Received: from leopardus ([2a02:a31a:a043:8cf0:ca8:e44f:8895:44f4])
        by smtp.gmail.com with ESMTPSA id k6sm11922359lfm.91.2020.04.27.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:04:13 -0700 (PDT)
Date:   Mon, 27 Apr 2020 22:04:12 +0200
From:   Mateusz Nowotynski <maxmati4@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        mattr94@gmail.com, bwilliams.eng@gmail.com
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
Message-ID: <20200427200412.GC2223199@leopardus>
References: <20200425235716.1822560-1-maxmati4@gmail.com>
 <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
 <5c1005a7-273e-fab0-0d0d-78bd0d3d13f6@gmail.com>
 <20200426200845.GE6421@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200426200845.GE6421@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 26, 2020 at 08:08:45PM +0000, brian m. carlson wrote:
> On 2020-04-26 at 19:32:05, Mateusz Nowotyński wrote:
> > On Sat, Apr 25, 2020 at 05:16:56PM -0700, Junio C Hamano wrote:
> > > You can prepare a pretend-home directory for the use of your tests
> > > and point the environment variable $HOME to it while running your
> > > tests.  See how we do this in our test suite for inspiration---it
> > > all happens in t/test-lib.sh, I think.
> > 
> > This is what we do currently but the problem with this solution is that
> > it breaks other software that also uses HOME as base path for their
> > data. For example asdf version manager.
> 
> I know nothing about the asdf version manager, but if you're relying on
> it for programs, those programs should end up in PATH, and when invoked
> appropriately in those locations, those programs should just work,
> regardless of what $HOME is set to.  If they don't, that would be a
> defect in asdf, since the Unix expectation is that programs in $PATH
> should generally function without regard to the setting of $HOME.  From
> my cursory poking around at the repo, it looks like it should do this
> just fine.
> 
> So you can set $HOME to a temporary directory and still use asdf as long
> as your don't reset $PATH.  Or, if you want to specifically load asdf
> programs first, you could do something like this:
> 
>   #!/bin/sh
> 
>   . "$HOME/asdf/asdf.sh"
>   export HOME=$(mktemp -d)
>   # Run tests here.
> 
> Regardless of your tooling, you definitely want to reset $HOME in almost
> every nontrivial shell testsuite, since many users have configuration
> files or data storage that you wouldn't want to use.  For example, if
> you generate a new GnuPG key on every run, the user won't appreciate it
> if you import it as one of their private keys.
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

To be honest I also don't know how it exactly works and I personally
don't use it. I think it adds to the PATH just thin wrapper not binary 
itself. I guess it's done that way because it looks for .tool-versions 
in current working directory and then fallback to $HOME/.tool-versions.

Regarding reseting HOME we are aware that we cannot do actions that 
have sideeffects outside test directory so we just won't generate/import
GnuPG keys.

--
Regards, Mateusz

