Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FB4C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 12:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA032076A
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 12:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJNECw+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGIMnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGIMnu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 08:43:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5429C061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 05:43:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i3so1468503qtq.13
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RM+GVt/nwMaloE7bumtRuuHEfBN5bq4PTtqPIAwGX5I=;
        b=IJNECw+5rUq4pdYKX27bJevh+mELcikDjPhstbnpJ9pbW9+p0NvsOOaJa9TD4hTakF
         7MN7JyO/XI0/XufLJ5Tql1J0Mgj90se0JUCrk/X+ISEAOmHs3hmnsiE/x/0o4RRD+tn1
         0gVM9A9Za8S1ux1OIRlRyRlsWRg71NhSxWOcOlf0I6AUSOaUH1cUT79rBZCcjguIdeyc
         8nD0ri4QBdbldD7oHHqD/RaW/zaBESfypddg0GTm+PoezpjQsgaO+9Ylspl46jzePXuj
         wWndi50TBzs/TMl5D9d1GgtOeQCRsp1jxpjPVkAb9LcaRGEJNeQcvpXr2p1dlNDB8mN/
         hpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RM+GVt/nwMaloE7bumtRuuHEfBN5bq4PTtqPIAwGX5I=;
        b=I6j1sSLfJnK+sHxXNkS2Ci1VA5ABloyfOIKwyaU8wyLbhjlCd7utrQclSFzWLjBLbm
         XBngzrT5ylHlev6CSzsQ4PXCh9P8axJ5btNqdUwyl2AbVN4CGsOPWcU+SwhINMBj1Kws
         Y8LSsAMYRUHEXpvtTF34ukjCooxgrE+xroQkDkRzeZQZ/4nuT0mcteUIw318zE9bdltj
         8SaptYZaCSKLpYk/I+FZgn5Fxgj9ZHbqcXLKJuZhtnPDxECAGQxO0/RgaXQ8JuyipmyM
         NslDANShce3L4rjlQNW8FXC5UWFMljbDgnNPEs2BnMvDofLqUEqFj9AoTHtuQcfiBkKC
         i02A==
X-Gm-Message-State: AOAM53271378zeEPfZ6lF2esit9fKC10XC05z+hKc43TVQcKYkk2Ptg2
        EWGDhR4M5ib2hOEMy36GzFg=
X-Google-Smtp-Source: ABdhPJzwg+aJrFIzHpw2NQzYqQQZCQ7s76zUjoNcWE4vDeYMs0YrPOh8TupCGzn+kH/6E8w0Xh2COw==
X-Received: by 2002:ac8:4419:: with SMTP id j25mr67804100qtn.0.1594298629774;
        Thu, 09 Jul 2020 05:43:49 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d19sm3495585qko.114.2020.07.09.05.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 05:43:49 -0700 (PDT)
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
From:   Derrick Stolee <stolee@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
 <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
Message-ID: <d0d30dab-7883-199a-3beb-48c87cde3550@gmail.com>
Date:   Thu, 9 Jul 2020 08:43:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 7:21 AM, Derrick Stolee wrote:
> On 7/8/2020 7:57 PM, Emily Shaffer wrote:
>> On Tue, Jul 07, 2020 at 02:21:14PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> An expert user could set up scheduled background maintenance themselves with
>>> the current series. I have the following crontab data set up to run
>>> maintenance on an hourly basis:
>>>
>>> 0 * * * * git -C /<path-to-repo> maintenance run --no-quiet >>/<path-to-repo>/.git/maintenance.log
>>
>> One thing I wonder about - now I have to go and make a new crontab
>> (which is easy) or Task Scheduler task (which is a pain) for every repo,
>> right?
>>
>> Is it infeasible to ask for 'git maintenance' to learn something like
>> '--on /<path-to-repo> --on /<path-to-second-repo>'? Or better yet, some
>> config like "maintenance.targetRepo = /<path-to-repo>"?

Sorry that I missed this comment on my first reply.

The intention is that this cron entry will be simpler after I follow up
with the "background" part of maintenance. The idea is to use global
or system config to register a list of repositories that want background
maintenance and have cron execute something like "git maintenance run --all-repos"
to span "git -C <repo> maintenance run --scheduled" for all repos in
the config.

For now, this manual setup does end up a bit cluttered if you have a
lot of repos to maintain.

Thanks,
-Stolee

