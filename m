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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC31C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912D8610D0
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhG0NKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhG0NKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:10:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F3C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:10:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so4819961pjd.0
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vsggki+36C6ko5ReUx+Bga/kqPexs1KZfa2HbLdb5ck=;
        b=XwnJvivyrDOl6zGm5m5g63TLUS2t+SglVmZZPTUJ71sXTriyYmpERU7OOZsrG3eSn8
         RcRJa5MRiZhCzgxK6/Jw0OH+b8uvdrjktmWjdi8LKtuIeEufKUtnHoFWsHRctuBEPbp+
         bVRWetzJ/PNGCUn8181q+cO6HVdUICsufp09Ooto+uc8krTjPJbGeMOQnnmw7TB0bDGl
         pLexiJ3BhJZ4DS8krjfaugYpJtx2AfBzODNNDH4L6PxD/q1xvRxqKCt+14F7wzRQn8VZ
         vNduQkn/YRSIfmls812dm6+W8DE1c/GzEb924dn28SHfK7kfy/6okDrhRaWUmqZUyrDS
         Ryww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vsggki+36C6ko5ReUx+Bga/kqPexs1KZfa2HbLdb5ck=;
        b=D8YHSJbdfxg+Uz4VArkBh3MdKDI7IKuPCPxOWimpsCD2x7Ikcqek4I/CGX/QfJDEg3
         dy8xLi6+WmmpPuuKKUMDbBs6abxeA8bVJroSNnsFJJF4uZ6Z+EaB9eetXuW4e/7YIxUy
         2XHTSEPPG4kcqdd0UQsWBaXDRdTzMrKUjBBwNbIxwAwEGWc5B5NS9C4WVFL0QZclhJk9
         HdemZcKNjHOyy45ylajrF5hoEBHqYgOq9mN/2INhBq5it6IHXu9O5h2EWPOthe/95hgL
         FNdO3ecnFCVOuicbnTOaHrAuwJRzrLV/++CJuDwJcIkhYiZYHrB+u+h2J+BGjFnxVfwG
         ngLA==
X-Gm-Message-State: AOAM533DT7qYvdB+qQBIM+HQCqxctWfI+BM1MJvnBYIkflCxJi8wTR4h
        aTO/YON3dE9p8F1PWVzBGl0=
X-Google-Smtp-Source: ABdhPJyjOh+Km9FusDVQPKWdJAOa39po6zNfCw+l+4XoS1/Lu2PbSDpCbK/x74yfWb4h5n+j43XuDQ==
X-Received: by 2002:a63:e513:: with SMTP id r19mr23250031pgh.30.1627391447047;
        Tue, 27 Jul 2021 06:10:47 -0700 (PDT)
Received: from [192.168.0.46] ([119.82.121.47])
        by smtp.gmail.com with UTF8SMTPSA id x26sm3699690pfj.71.2021.07.27.06.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 06:10:46 -0700 (PDT)
Message-ID: <ad8c8e8a-156e-bb10-0305-91fcd595b732@gmail.com>
Date:   Tue, 27 Jul 2021 18:40:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0
Subject: Re: [GSoC] A small survey + My Git Blog, week 10
Content-Language: en-GB
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, avarab@gmail.com,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
 <b07fe877-f0ba-9a20-47b2-16c8efaa447c@gmail.com>
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <b07fe877-f0ba-9a20-47b2-16c8efaa447c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/21 23:56, Kaartic Sivaraam wrote:
> Hi Atharva and Shourya,
> [...]
>> Thunderbird is more like what I am looking for, which has a convenient
>> GUI with loaded batteries, while still being more configurable than Apple
>> Mail and actually handling threading properly. This is what I
>> currently use,
>> but my laptop is unhappy with it, as it eats up around 40-50% of the CPU
>> usage in the background. It also eats up more battery, almost as much as
>> my browser. This is apparently a bug that’s been unresolved for many
>> years
>> now. Git developers reading this: if you have personal recommendations
>> for something that is easy to use but also lightweight, please do let
>> me know! (and it needs to work on macOS)
> 
> That's bad. After a long time of switching, Thunderbird is what worked for
> me too (after some config tweaks, of course). Evolution was close but it
> had some bugs with the composition window. Otherwise Evolution was good,
> light-weight and is well suited for plain-text emails. But looks like
> it only works for Unix-like distributions[1]. So, its not an option for
> you.
> 
> I don't own a Mac and haven't used one for personal use. So, I don't
> have great recommendations. Anyways, light-weight reminds me of mutt[2].
> But its likely one of the non-GUI clients that might also need a bit of
> configuring.
> 
> In case you could consider alternative solutions for filtering e-mail,
> there's the filtering option of Gmail[3] which could help. You could
> filter emails based on certain criteria and send them to specific
> folders[4] which could help you with managing emails to an extent.
> I heavily rely on this feature to keep my Inbox clutter-free to
> an extent.
> 
> [1]: https://en.wikipedia.org/wiki/Comparison_of_email_clients#General
> 
> [2]: http://www.mutt.org/
> 
> [3]: https://support.google.com/mail/answer/6579?hl=en
> 
> [4]:
> https://www.gtricks.com/gmail/organize-gmail-by-sending-emails-directly-to-a-folder-label/

Thanks for the information. I do use the filtering of Gmail, but I
remember back when I used a non-GUI client I had all sorts issues with
mapping the newly made Gmail directories with folders on my system. I
believe you have to configure one each time, which is fine when you
don't have to do it too, often but I had given up after the third time.

>> I just use a straightforward { editor + MUA + git } stack and go with
>> the flow!
> 
> For me it has mostly been this but with some help from tools. Many
> people have found GitGitGadget[5] useful for sending patches to mailing
> list based workflow from a GitHub PR like interface (Thanks to Dscho!)
> You could've heard of it before but you could give it a try and
> see if it helps improve things for you :-)

I appreciate the utility of GitGitGadget, and I thought I'd end up using
that when contributing, but I found email to be simpler and more
intuitive (at the time, it felt less intimidating to use).

> I've heard there's git send-series[6] which says that it helps
> with managing patch series. I haven't used it myself, though.
> 
> These are some tools that come to mind. I believe others could
> likely provide better insights.
> 
> [5]: https://gitgitgadget.github.io/
> 
> [6]: https://github.com/felipec/git-send-series

Thanks, I'll check these out.

