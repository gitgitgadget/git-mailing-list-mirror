Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB7C47085
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8599361244
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhEWIMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhEWIMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:12:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B95C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:11:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 69so13095163plc.5
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lwVEYdtu88y6qqKnYErzxxXorpXskoyUZjj57zVQFvY=;
        b=pVhD52BMILMg6RM+DkRNQDNpGREpMXyC2m+8aRx7/6UqnqhefnBNY+tWC0RUQS3kKn
         tmsDrZJT0ax5rWri2qt99Z4arPDNZq54RhgFp8nzs9UYdrTQEs6DbxgogsERpTX6dUeC
         jKuqHhbMG5OktgExh+1XRisbebB4a+BYZkGb4MbG1lpmJZXaezOCCzHws/2ySUfPj7+d
         guQZEX5okHv4jZWvQA1x2eeYj86FJ2ZBOvaXHd0QkyxIyHK2DvFNGIt3pWKpekiJjtW0
         PmIOVRdZJ2zRqd4LFWzprlhuj6Vmg+F0q56gBfD3HRM//7Lv1UfBUugfsg8OC/X7AV/N
         p5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwVEYdtu88y6qqKnYErzxxXorpXskoyUZjj57zVQFvY=;
        b=ftvH6xNqulk9R4oz0K+KoyRlt3GeD1oIdrL/Kw+VfUt2r6if/eCxX4M0vwinKfExhn
         CX62db35H5WsC4VpvNRY7MR+NKBQBX3i1PrEiGHVVW61dmcA/1U8GGWG916bOzSCpb1T
         WdU6+7agZPychrRr+a05ekpxM/avC5aES7GTq+eeJvMmM5ah647ZEyCFVoQF0IXYjAQI
         F1sswF7jn4ra9BnTyA2r+967ZmKrHRp2DQAIBXvVwEk69rVy5QqJaKtm2iTwnOD3Q5xp
         IVLY1qQhTP0WR94LPG6jMrffSWtfBRRE/iX9UxxN4JncsE8jCeYwzwcZhtM0Z/2V+C52
         ai/Q==
X-Gm-Message-State: AOAM533k943glNicduy+sSwr/K4QatG0YJULrQ2MNFEkKFfXxGXolbe7
        6cYP57i2MrMgL9PDhkk4e/4=
X-Google-Smtp-Source: ABdhPJwTv512xqTNX9/pvkYDd5XzOAtn3+8R9nGGGKXeL/HfGIa1UszcorIcFt5koXnH23ioaHe20Q==
X-Received: by 2002:a17:902:c3cd:b029:f1:57d0:4de5 with SMTP id j13-20020a170902c3cdb02900f157d04de5mr20050460plj.53.1621757463846;
        Sun, 23 May 2021 01:11:03 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id y76sm6403421pfb.74.2021.05.23.01.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 01:11:03 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog
To:     Atharva Raykar <raykar.ath@gmail.com>, git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f1fca31b-17b8-9dbb-4d46-dda8c44645c1@gmail.com>
Date:   Sun, 23 May 2021 15:10:57 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 22/05/21 23.42, Atharva Raykar wrote:
> Hi all,
> 
> As is tradition, I have started my weekly GSoC blog :)
> 
> Here is week 1: https://atharvaraykar.me/gitnotes/week1
> 
> I shall be sharing my progress, thoughts, experiences and any
> information that might help future contributors in my blog.
> 
> After my GSoC period, I hope to convert it into a blog that
> will help pull in and guide new contributors to Git development.
> 
> Any kind of feedback will be appreciated!
> 

You said on your blog that you switched your development environment
from Linux (what the distro you used previously?) to macOS. Why did
you make the switch?

Next, you mentioned that you set up emacs config for Git developers
(ones that contribute code to git.git). Since I use (r)vim instead
of emacs as my editor, what are similar configs for vim?

And finally, you said that you had to deal with "header not found"
errors. I asked these questions:

   1. You mentioned that in order to link against gettext on non-standard
      path, you did:
> ./configure "LDFLAGS=$LDFLAGS -L/opt/homebrew/Cellar/gettext/0.21/lib" \
>      "CFLAGS=-I/opt/homebrew/Cellar/gettext/0.21/include"
      Why did you use full path to gettext? I suspect that you can instead
      use `LDFLAGS= $LDFLAGS -L/opt/homebrew/lib \
      CFLAGS=-I/opt/homebrew/include`, because when you install a library
      using homebrew, it will symlink the library location from homebrew
      standard hierarchy (/opt/homebrew/{lib,include}) to actual location
      (/opt/homebrew/<User>/<package>/<version>/{lib,include}).
   2. Can these procedure above for linking Git against libraries at
      non-standard locations (such as /opt) be applicable also to Linux
      systems? Try to adapt that procedure on your Linux system (if
      available), with custom-compiled newer version of any of Git
      dependencies (such as gettext).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
