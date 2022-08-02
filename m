Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85CC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 14:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiHBOfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiHBOfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 10:35:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93C5140F0
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 07:35:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so6853289pls.4
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=NqBAwfdybk2v+XAyCUloMyrWYtrPziiMmOJo6Uibe3w=;
        b=Fvxv13y/1YqcRFmxGUiCWYHl0QizMkOMtcsjvwv9Mykr/ZtGiiL0ldR0fgugqlfJzN
         mm43ldK7fMdDDOHxjTl+CYtUmcQ/gNS9bqLYgN865Oo8CYGlPGqtvAUYREs8nTV0rdd7
         6amxXcl8VT7ZjVOy4AbacyrwGW1eQhlPtMHNA7/QdCi3+pTE4GExoHFiCeZwe3Sylt/3
         EaevGrT7mD6SarJW+E3NOYKzfwqH9l9qhK6pa/+uvk5Y4Pw8Gj1PBy9zPC9JlxPfOVPx
         oVC5nz92YTUPWpZuWBOmDQjqAbWFehUtPYnEZkxs0pfbTtY4cTAKoAVh7w3ZJ2vmT4uu
         UHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NqBAwfdybk2v+XAyCUloMyrWYtrPziiMmOJo6Uibe3w=;
        b=VdjMNTC+r0HsZq0PZF9E4tG/fZivajoct4LSGs6y/x/+NAk9ooPJ2q6X9nySEAmPSv
         dYh4XZXOd8cD5i1QhKlfEM5EEj3s9VYJafAqWS86E9JsOsxxM228ZmGjksY7xy8U7cFM
         L8rsZRTResdtx6Bpz6zR1AHoJsUMKi7aw3FEKkvg+EA8Vr/Y+KH79gCTgxddfuB3Toav
         T3ZpIMdGIfCrJX73LIjJMvhaH+3V83W+W9vqy0QvP60LwluR7BzUDVkmiIThNkHuWOpL
         CLoSsPnOHogdMxc87+roP9zXj1KZgaPBTnlCz3wSnLoN8cv61gwToIv5fh4J3W6gGAUm
         mD7Q==
X-Gm-Message-State: ACgBeo0YuD+1SXnd2wxjtDULCGoUag/0C1WPTsIFXmOWqyHy/16ozxLI
        VT3+YIdWJl9KuiAcWIZ/V9xUToO38bbRoflj
X-Google-Smtp-Source: AA6agR7AVVJl2B4Gj9+2GOke50FjjjNN0e1xLGLc0vKXngOCbGlfRRSBsrQ59GjYmgSpXYrn4vx/ZQ==
X-Received: by 2002:a17:902:ea0b:b0:16d:d268:e4c5 with SMTP id s11-20020a170902ea0b00b0016dd268e4c5mr20593781plg.152.1659450906793;
        Tue, 02 Aug 2022 07:35:06 -0700 (PDT)
Received: from cosmos.melik.windwireless.net (melik.windwireless.net. [206.63.237.146])
        by smtp.gmail.com with ESMTPSA id y129-20020a633287000000b0040c52ff0ba9sm9401831pgy.37.2022.08.02.07.35.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 07:35:06 -0700 (PDT)
From:   David Chmelik <davidnchmelik@gmail.com>
Subject: Re: 'git clone,' build makes user non-writable files (should be
 option keep user-writable)
To:     git-l <git@vger.kernel.org>
References: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
 <YtPtQ6qsIviyTBF2@zbox.drbeat.li>
 <158251f2-9fa4-45b7-4c24-907c94602b6e@gmail.com>
 <CAPx1Gvc6ci1CjhL-zjwqkR=4o2yQTrT0V_Hb9bUBNuaBn47M8A@mail.gmail.com>
 <ccbc1e81-b406-9e73-7aa5-956ffae7074b@gmail.com>
 <CAPx1GvceFLRL_O5zYW98tPdNV9S_Y=fChJafsq+HGkEYixKsZA@mail.gmail.com>
Message-ID: <c0bc2741-092b-273c-ddf4-a2c9d90da6bf@gmail.com>
Date:   Tue, 2 Aug 2022 07:34:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAPx1GvceFLRL_O5zYW98tPdNV9S_Y=fChJafsq+HGkEYixKsZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/22/22 8:54 PM, Chris Torek wrote:
> On Fri, Jul 22, 2022 at 5:29 PM David Chmelik<davidnchmelik@gmail.com>  wrote:
>> On 7/22/22 10:40 AM, Chris Torek wrote:
>>> All true.  But Git has no control over, or affect on these: Git does
>>> not attempt to affect ownership or permission of any build products
>>> at all.  Git only attempts to affect the execute permission of
>>> specific files as directed by the committed file mode (and provided
>>> `core.filemode` is enabled).
>> Not even projects' .git* subdirectories?  They typically are/become
>> user-non-writable though deletable with several/many confirmations so I
>> usually sudo (recommended against).
> Ah, I thought you were (and I definitely was) talking only about the
> *build products*. The stuff inside `.git` itself: some of that, Git does set
> to non-writable.
Initially wasn't; don't know why took three replies to clear up 
(initially clearly specified non-root usage which others ignored and 
mentioned/focused unrelated root topic).

> There is no need to use `sudo` though: a simple
> "rm -rf .git" will blow away the Git repository itself.  However:
Still fewer confirmations with sudo (one rather than every single 
user-non-writable file).

>> I'd rather opt-out of .git* subdirectories for every clone.
> In that case, *don't run `git clone in the first place*. The purpose of
> `git clone` is to get you the entire repository. If you want a single working
> tree, use `git archive` to make an archive from the commit you want,
> and extract that archive to get the tree you want, without getting all
> the *other* revisions.
Seems much more complicated (and less-documented) and most popular git 
sites (though the #1 isn't Free/Libre/Opensource Software (FLS, OSS, 
FOSS, FLOSS) so is condemned) allow clone but not archive.  I know you 
can't control their mistakes and they should be irrelevant 
(unfortunately most projects use most popular/broken sites) but couldn't 
there be more (detailed and/or easier) syntax?
