Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F67C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DE9613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhEUWML (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUWML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:12:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B521C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:10:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i17so22370969wrq.11
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zd1ye0N9XTuEPN1HIFcO/dblbDhtb3Atjxghf4WVQpM=;
        b=HykH/jdpnWco4eLgkjG4HOAksllgj5MKY/InjhTmSHaP1Knl9WlHyDvBH0s/H71M7p
         TokW/4bIUE50JBPsXymcZd0C0pEcSGHIYU4ox4BMC9nlcuUNPlOVMxwcye1BTSpUydZV
         XMXc/zCau81I2T1xXGRr4qNbiRTZjEti3osfXEe9xIF5oygdZKgxSBw0crYBXoPgGqV8
         vTyD/dI81pfL2FTj2o6JFrKdW8YZAaITNcZlwnQcXw8jY3/9tlmmjk+6LZ7kmAJrE4fj
         nkPQYl3n8beFg8lvEr0owB13H0ppu9lFuFnijyWbRCRGZSLhwwo7eiH24fvcHxtXL4+2
         O4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zd1ye0N9XTuEPN1HIFcO/dblbDhtb3Atjxghf4WVQpM=;
        b=XGqlG0VnHAeulUUXqkEruVZCLFEzU2WConDAFisgj+hEGtMzP1czmDZVVl/ODvz/i0
         GhawH0qunHPIv8g6iq79vQOctMWmt92OkoGMqhWi2865Ny9dlaNCaQuj2Quz9cu+F6yF
         vuT43uJoNEWPJrYbBrk6L+rTLTHtF3hjqT0YS3d6YbhX5Cw1SQKr+iRLnHfbdF8qq41u
         na4SYDwzJBG8mpRENauHi6vl11wPONTRsoUS7ae2F7Qh5zAX4TkEz25ZTeIXzZUpsJ88
         c8LO4mU8x7pbqr3ODPJ5u10P3+icEt5+iZHupj37Ly8ABNaI6lakBWzTdPmNNCQ4fQWP
         3yyg==
X-Gm-Message-State: AOAM531SRqJuazt95D9hYFL/Y3PJWP8Uv6fHi/zyOvsbQy0YaQtInWxq
        qZkByLO19nlCnFnOqRoINbw9UFzEGtQ=
X-Google-Smtp-Source: ABdhPJx8XDTOpxfNlzPXclsxB38geBEYkS0T8xyIih2NHx/u7iiY3vPaTST8Sdwlq7wXTu9uU5X+7A==
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr11756607wrz.284.1621635045843;
        Fri, 21 May 2021 15:10:45 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.165.96])
        by smtp.gmail.com with ESMTPSA id k20sm3249595wrc.1.2021.05.21.15.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 15:10:45 -0700 (PDT)
Subject: Re: [PATCH] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net> <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net> <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
 <60a8243323625_77e4f208f8@natae.notmuch>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <636007b7-c079-f8a6-1b26-eb2a55505354@gmail.com>
Date:   Sat, 22 May 2021 00:10:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <60a8243323625_77e4f208f8@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05/2021 23:20, Felipe Contreras wrote:
> Igor Djordjevic wrote:
> > 
> > If I may, NO_COLOR approach seems to be rather straightforward to me, 
> > as per description on their homepage[1] - make all software supporting 
> > it behave as colors are an opt-in feature, thus disabled by default.
> 
> May I ask you how you interpret this?
> 
>   It is reasonable to configure certain software such as a text editor
>   to use color ... sparingly

Sure, but to make the point (hopefully) even more obvious, let me 
quote the whole part:

  It is reasonable to configure certain software such as a text editor 
  to use color or other ANSI attributes sparingly (such as the reverse 
  attribute for a status bar) while still desiring that other software 
  not add color unless configured to. It should be up to the user 
  whether color is used, not the software author.

I understand it exactly as (I think) it says - it is reasonable to 
allow (the user, not developer!) to configure certain software to 
(still) use color (fully or sparingly should not even matter, and it 
may depend on what kind of granular configuration software allows in 
the first place, if any), even if his (user's) general ("default") 
preference is to have no colors.

Thus color should be user opt-in - NO_COLOR turns all of it off by 
default (for all software supporting it), and user decides which color 
to turn back on through each specific software color configuration.

That last sentence should make it clear - "it should be up to the 
user whether color is used, not the software author".

So it shouldn't matter what does software author think about which 
parts of software should be (fully or sparingly) colored (by default) 
- NO_COLOR's idea is to give the ultimate power to the user to 
decide, and on a global level, starting with no colors by default, 
then allowing colors where desired, per each specific software config 
(instead of vice-versa, being required to turn color off per each 
specific software, where color is otherwise used by default).

At least that's how I understand all of it, making sense to me, but I 
don't mind discussing it further, if needed.
