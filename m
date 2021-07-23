Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E42C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4EB60720
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhGWLgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhGWLgg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 07:36:36 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9E3C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:17:10 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d2so1473411qto.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zPcSd7IsshDnMhgZwMCaL7dKkxYrKxFAHtm9mAW4a4=;
        b=J3xfK8gxQbzQlQLGE7tTnULBlb6WnHMX16v6O3HdoWpr6aQ5aTcpmHiyqg9EHtyYAH
         jGhgW2R0OeJBBSMDIvNe64fB5ZfDP3tUvGYOvCgX5Y7whmhZxVJapVpm34GC/NN9pbs/
         zwYR0y7urWSJlFnlHwlSaHHy9oBZeJebRJQbYPSlWe4h6ejo183hdy1JrccFphJ9GU9S
         o9hfcJON5ZvJzoWLLibyJa+GFGSLEc9uxQyQ74KHK2VH1ZEWsHG9P2IRfV1twGKf6pdg
         LZGpLS1fJu2J4ido0ZSAnqioox9g8gLy5Yojjrt1bYN79fcnC4eNWjZNUBAfp6qbMvAc
         /RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zPcSd7IsshDnMhgZwMCaL7dKkxYrKxFAHtm9mAW4a4=;
        b=aSvgTCzS5pTkix9z7/exjKhslwRAgLunu+9qP5LMDl8Ac8z03plWSfe+EkWDNlgbn2
         7g9iRcK8USjOXKczllW5r8RuZDgM0IUUyUJJlBY55fCJpwLaxud8aqPjFp2Tx6XPIBcK
         eOA8RX0cGxt4K9hYECmjIukLsfTl7qviHXWHMQOohNw+mwQR54m08dZbGJOxsNqdH5OB
         1T4DH9oGkrcJqOaHQxmXqCNu7xhTOW/3MbNVWR9Q6NKlVTq46L3CdmDdk28+pl5kIAz4
         bWzQMygs8vKkGHj1AqGQHdXTPhwcF+jCuWqZe0FP3rCH8DN+ul5uP0iTH6Jo7VDOpS76
         qUiQ==
X-Gm-Message-State: AOAM533XA9v90hiyL+57kgxiFsnF78jUnLfxl2blyk3veWF4ve5K1m0q
        DEClVhLE/eIMeTWUHnVprNY=
X-Google-Smtp-Source: ABdhPJyDHELiFLL9QJJsOdxC8C5rF1CNJIdIBYR+RqNV+IyVkrrOQBrYyytKFY/ICadi+AOxkAtdow==
X-Received: by 2002:ac8:6994:: with SMTP id o20mr3729587qtq.21.1627042629218;
        Fri, 23 Jul 2021 05:17:09 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x14sm6159460qts.13.2021.07.23.05.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 05:17:08 -0700 (PDT)
Subject: Re: Regression in 'git pull --rebase --autostash' since v2.32.0
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
References: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
 <60f330c09ee05_25f220867@natae.notmuch>
 <1329d238-e38a-7c8b-d468-500a0ae38bbb@gmail.com>
 <60f39a72c9c8e_2fb208b3@natae.notmuch>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <4b20a7ad-5e1e-802f-021b-a4580e5138fe@gmail.com>
Date:   Fri, 23 Jul 2021 08:17:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <60f39a72c9c8e_2fb208b3@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

Le 2021-07-17 à 23:05, Felipe Contreras a écrit :
> Philippe Blain wrote:
>> Le 2021-07-17 à 15:34, Felipe Contreras a écrit :
> 
>> The fix I suggested in [1] seems to fix both cases, but as I wrote there
>> it still leaves two code paths that might trigger the bug. I'm not familiar
>> at all with the code for these two code paths, so I'm not ready to send
>> a formal patch; I thought I'd send the diff anyway if you or Denton (or anyone
>> else) wants to start from there.
> 
> Unfortunately I'm not familiar with the `git merge` code either, I've
> only been modifying the `git pull` code, so I would also be starting
> from scratch if I tried to fix that myself.
> 
> But I think that's where it should be fixed.

I've just sent a patch series that fixes it:

https://lore.kernel.org/git/pull.1002.git.1627042470.gitgitgadget@gmail.com/T/#t

Cheers,

Philippe.
