Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E944C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A5F60C51
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGZRqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZRqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:46:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4BC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:26:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ca5so1712280pjb.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4b/tbcMYUEZURgqol1/0VA8ooLiFSc1+E5IHv+ZjYvo=;
        b=CXYcCiAMKcaIoe78+EQZA7aWDj/7vE3x1nXjKKXYZ/pHy+RWZyTxitWBgr5RROuvBE
         sMA0Qg6VQwndaEWqoXh0XQZFv9e5DxJakqbQvoA4n8HH/W1ksnRgdSGDDp6+90PvK+sO
         AOU9yCsnskfhIu2JbPOyhNvb6Q0djxXaBxErTws2LOlXcBNXg8dN8QKgPn5L/TOBaI3G
         u18XqcnrWzsMYpqVlf10n37WpPN+htU/L1kOEpgB1QF9QyIOkftzW4IOXtF+rUGHxbSJ
         TTsFytOxyKv+aeO861KiZgb9yn5FQY0ThiCoNZbbBmRWqhZTg3RVWNLfk/JuQnzSB34v
         L5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4b/tbcMYUEZURgqol1/0VA8ooLiFSc1+E5IHv+ZjYvo=;
        b=uC6zfxadni5VirMas77VJH1nFeLPW/E4imCb9p1f4WCpo7UZIl7rDBdYuIOdKbbGkN
         Vx4lZUYn6IsRFE1Mwi01UkeLslZMlg0MhqEiVgj/JVttp21WmXGaxIpPH+WtvMu7pwIW
         gGSGvunAZZbuNWg0+EFUd/ntjdUUnNc7l/J0yBG6Nw+CRaqk8m7UoffREtlBVV/3HKJf
         3//VGZ2w46qbgqQrY3MOo2BlMVNp3pDPp8mH3g3TYYDwCr8B8DPfijIgTtfU9mD/kA3N
         27CIw7dMXmShndnZMdq2HO+Em8ongSPMiZwngWuIAFU1sWS2dP8KnsdXco5zOSEpBx6+
         EjuQ==
X-Gm-Message-State: AOAM5308QzDI7nZ1S1OGzDmOtZWYx28wjuCWDIS1IzvHFEKkDKXOqCeh
        EYwuQJJdzd3zPYpmTLm7B0AJ4DB8uXUd1g==
X-Google-Smtp-Source: ABdhPJwQk9PbVVPA4qM/WDPga+JYzoElNQzfsxqtqln1CfQ4A4dwO5oyraHVWL9QXV49bJlXRzoVwA==
X-Received: by 2002:a63:206:: with SMTP id 6mr3413049pgc.167.1627323998942;
        Mon, 26 Jul 2021 11:26:38 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.87.178])
        by smtp.gmail.com with ESMTPSA id x14sm725340pfa.127.2021.07.26.11.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 11:26:38 -0700 (PDT)
Subject: Re: [GSoC] A small survey + My Git Blog, week 10
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, avarab@gmail.com,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b07fe877-f0ba-9a20-47b2-16c8efaa447c@gmail.com>
Date:   Mon, 26 Jul 2021 23:56:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva and Shourya,

On 25/07/21 5:52 pm, Atharva Raykar wrote:
> Hello all,
> 
> Week 10 of my Git blog can be found here:
> https://atharvaraykar.me/gitnotes/week10
>

Nice blog!

> Thunderbird is more like what I am looking for, which has a convenient
> GUI with loaded batteries, while still being more configurable than Apple
> Mail and actually handling threading properly. This is what I currently use,
> but my laptop is unhappy with it, as it eats up around 40-50% of the CPU
> usage in the background. It also eats up more battery, almost as much as
> my browser. This is apparently a bug that’s been unresolved for many years
> now. Git developers reading this: if you have personal recommendations
> for something that is easy to use but also lightweight, please do let
> me know! (and it needs to work on macOS)

That's bad. After a long time of switching, Thunderbird is what worked for
me too (after some config tweaks, of course). Evolution was close but it
had some bugs with the composition window. Otherwise Evolution was good,
light-weight and is well suited for plain-text emails. But looks like
it only works for Unix-like distributions[1]. So, its not an option for
you.

I don't own a Mac and haven't used one for personal use. So, I don't
have great recommendations. Anyways, light-weight reminds me of mutt[2].
But its likely one of the non-GUI clients that might also need a bit of
configuring.

In case you could consider alternative solutions for filtering e-mail,
there's the filtering option of Gmail[3] which could help. You could
filter emails based on certain criteria and send them to specific
folders[4] which could help you with managing emails to an extent.
I heavily rely on this feature to keep my Inbox clutter-free to
an extent.

[1]: https://en.wikipedia.org/wiki/Comparison_of_email_clients#General

[2]: http://www.mutt.org/

[3]: https://support.google.com/mail/answer/6579?hl=en

[4]: https://www.gtricks.com/gmail/organize-gmail-by-sending-emails-directly-to-a-folder-label/

> I just use a straightforward { editor + MUA + git } stack and go with the flow!

For me it has mostly been this but with some help from tools. Many
people have found GitGitGadget[5] useful for sending patches to mailing
list based workflow from a GitHub PR like interface (Thanks to Dscho!)
You could've heard of it before but you could give it a try and
see if it helps improve things for you :-)

I've heard there's git send-series[6] which says that it helps
with managing patch series. I haven't used it myself, though.

These are some tools that come to mind. I believe others could
likely provide better insights.

[5]: https://gitgitgadget.github.io/

[6]: https://github.com/felipec/git-send-series

> Have a great day!
> 

Thanks! Hope you have a great week ahead!

On 26/07/21 11:15 pm, Shourya Shukla wrote:
> Le dim. 25 juil. 2021 à 17:52, Atharva Raykar <raykar.ath@gmail.com <mailto:raykar.ath@gmail.com>> a écrit :
> 
>     Hello all,
>
>     Week 10 of my Git blog can be found here:
>     https://atharvaraykar.me/gitnotes/week10 <https://atharvaraykar.me/gitnotes/week10>
> 
>     As for the "survey part", jump to the section here:
>     https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-workflow <https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-workflow>
> 
> 
> Your links are not opening. Could you please look into that?

Shourya,

Interestingly. They're working fine for me. Could you elaborate
on what you're observing on clicking those links?


-- 
Sivaraam
