Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EBDC33CB1
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 05:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4602072B
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 05:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvg27tUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgAOFOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:14:32 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:38972 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgAOFOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 00:14:31 -0500
Received: by mail-pl1-f171.google.com with SMTP id g6so6339616plp.6
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 21:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jsNFLo6IFhDGrHfWBtmK4Ocu/h3HlJ7loJUAU78AHFA=;
        b=Kvg27tUC9CHxU8KhCEbcvylT4itroKPz/DcSqoiHDahKlciYtd6oUt6ZZybRYwb73v
         2xaUgWkJaQu+kPleZvyBDrmq0U8oCxtUqRmhRdD/Q+oDeEl3fAv0BfuIkYErnMM42GVY
         8ofk234F2EDMBHcaQuvgSuw0bVI44KkZu8Kgy3LvK0mT7rMPGPiqkHqyo6jisqeAWh5c
         md7nKhgu+ds3/clwWfZlYnp2DLTI+hvoEK4o8Io3Ppzr+KpnKgkIkYidU+g5PwXypJVk
         bgpek10VKs1uK30D5XVaPFIHpwEaLrgFbYfb+w8ljdS85y9evEakMt2jiaEOLIUp7f0q
         8nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jsNFLo6IFhDGrHfWBtmK4Ocu/h3HlJ7loJUAU78AHFA=;
        b=lSHfz9l5/l3t3F8POawg5A/RP4C978Dgq5TqbFbUNoOi7HVnNU/HmwvofGggnjlOih
         hjvniafwdSHq04S4ehI9uh5VKGp09j1SYaMnEdQiAtTnmd6OzuM71vS/DMmtn11KfQCq
         W/N+fzt3lMSS/zEImRJzHeOKWqZZSkGxtuNGGYL3KgkM8Rk7c9w8kwlWugABZfrXeM9Q
         u/g9Uk24HPNJkEK9weg2/pZ8peYR/yqbqTFKsI2bQZ166hL6ipq2clKlDHziK5FwyDUG
         lZuaZmCTvPdaHFcS3QbZXKhINg8x765S76tg31joX0iN+QVDzB7+zf00DVNZ2nDsd5OU
         jTSg==
X-Gm-Message-State: APjAAAWop49lbrFGN09f5mLLPALl5SvJv3kX0U3zKW2fQWPq0avpJknU
        VLgslIsnIgK2apR+Udn6i+M=
X-Google-Smtp-Source: APXvYqzLmkQ+Q2ks8zjGIW6Nu1xCR0cliwksfgW3ua5LlrH9AMb3den73ljRe6xLGl/Yd32Q30EQiw==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr35310486pjt.128.1579065271132;
        Tue, 14 Jan 2020 21:14:31 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id o14sm18741044pgm.67.2020.01.14.21.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 21:14:30 -0800 (PST)
Date:   Wed, 15 Jan 2020 05:14:29 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "FIGADERE, LAURENT" <laurent.figadere@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git , submodules and remove from historic question
Message-ID: <20200115051429.GB218782@google.com>
References: <HE1PR0202MB2634CD91D2750E199098FACAE6350@HE1PR0202MB2634.eurprd02.prod.outlook.com>
 <HE1PR0202MB263439EFAE785201C61495ABE6350@HE1PR0202MB2634.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0202MB263439EFAE785201C61495ABE6350@HE1PR0202MB2634.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

FIGADERE, LAURENT wrote:

> I am using git submodule features.
>
> So, by example, I have a repository top which include a sub
> repository sub-repo.
>
> I would like to re-write the whole historic on the top repository
> without the sub-repo.
>
> I tried to use git-filter command but I have an issue on sub-repo.

Thanks for reporting.  This looks like a real bug.

(Nowadays we encourage using https://github.com/newren/git-filter-repo
instead of filter-branch, but I'm interested because of the underlying
issues this report might be revealing.)

By the way, what version of Git are you using (you can find out by
running "git version --build-options")?  Do you have the
submodule.recurse setting enabled?

> Here the commands and outputs:
> [10:27:42] $ git submodule
> d3fc420ee38babe74d6e3838b5b2a946ee551fa7 sub-repo (v1.0)
>
> [9:55:48] $ git filter-branch --index-filter 'git rm -rf --cached --ignore-unmatch sub-repo' --prune-empty --tag-name-filter cat -- --all
> Rewrite 471a2c664466a364bfe5fdf774c7c0d7efe50396 (32/54) (3 seconds passed, remaining 2 predicted)    fatal: exec '--super-prefix= sub-repo/': cd to sub-repo' failed: No such file or directory

Hm, I'm not able to reproduce this.  I tried using

  git clone --recurse-submodules https://gerrit.googlesource.com/gerrit
  cd gerrit
  git filter-branch --index-filter \
    'git rm -rf --cached --ignore-unmatch plugins/hooks' \
    --prune-empty --tag-name-filter cat -- --all

What is the output with the GIT_TRACE=1 environment variable set?

Thanks and hope that helps,
Jonathan
