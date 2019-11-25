Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F185CC432C3
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57E920679
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGRG2j3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfKYOnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:43:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42593 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfKYOnK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:43:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so18370480wrf.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wcRpGKgAo26qB+UHetY1y5xPFQKpsuB1ezq3o1a2VsE=;
        b=FGRG2j3ohNTqrRxE4XqZHBisLhJLQjAkLXWPuIPHrKDSAcgw4h1cqHB2ViRDXBp975
         dxzVxug9H1nr8A8SfBykYAZ+bt2ejNIMkvUZqhHTAMTPwxv3JSPGZGphjIdBllu5yJGG
         F3EyHamyicz5V+G0Pau8/CdI+pqjgNVVYeTudquLJy+q3Tdtxj4cYTWDD43jWRMELbKe
         7YLtLPG41wV9lpWxP++uqt0R8BfIGv4ouRaAPFL4ZMK3t5gE7ZnN75YdjoE496WlSxlE
         /Xqmu1hUR9BvbBneX+IenHVTBA+9utv4W58Z6UxVCeClD4mQ6beeTsbi13BDcdunuRJj
         FcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wcRpGKgAo26qB+UHetY1y5xPFQKpsuB1ezq3o1a2VsE=;
        b=VZ9LcO+5x08n0rWCJXf4MWrt8dNeRm3bjSoAxetdowNl7W8vUzaCeuZ3P7hdWqSPTD
         5qoBH8HQyGINaB6sE302h1Iw/Xxeb460h1wZXWWmiNlSXoVmk50p/VlrdM+abyBM0Mpz
         juxxTK5GckStZILFMKjGDUnVgxNFZQz7SeuDg+oaWx8L/D8Ki+fDglsSc4dc6DzupcHr
         2mTpi2uoTNaiiy2SIKCTdGniNBuZyJ8vUT7Wt7n8vQpeKQrIkl24V5u7QxFGlyHgyDcU
         IKe+HhRYwdoik25EXDybazO2SFUD6jvzvsurxtj8eA8WFpZ72mUxw/9RJukTre4l8p+8
         kH0w==
X-Gm-Message-State: APjAAAVFNX7SIey55nOxuRD572KhXup705Tmt5f/3opBpJMMP4Pmq8PJ
        2wPoXfVa+RbNjbUrAKWcNuQ=
X-Google-Smtp-Source: APXvYqx2Yam9BYZogaW1pXxCl01uX9g75FdYyRBeHrcpfySvQZOqPZbKnsGDRRzeDdwIgXCgjAI1CA==
X-Received: by 2002:adf:dc11:: with SMTP id t17mr15593404wri.294.1574692989024;
        Mon, 25 Nov 2019 06:43:09 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id n17sm10121452wrp.40.2019.11.25.06.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 06:43:08 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3429: try to protect against a potential racy todo file
 problem
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
 <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
 <20191124211021.GB23183@szeder.dev> <20191125131833.GD23183@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5a43a071-a3c2-770e-bca4-3e73aff96e48@gmail.com>
Date:   Mon, 25 Nov 2019 14:43:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191125131833.GD23183@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/11/2019 13:18, SZEDER Gábor wrote:
> On Sun, Nov 24, 2019 at 10:10:21PM +0100, SZEDER Gábor wrote:
>> To notice a changed todo file the sequencer stores the file's stat
>> data in its 'struct todo_list' instance, and compares it with the
>> file's current stat data after 'reword', 'squash' and 'exec'
>> instructions.  If the two stat data doesn't match, it re-reads the
>> todo file.
>>
>> Sounds simple, but there are some subtleties going on here:
>>
>>    - The 'struct todo_list' holds the stat data from the time when the
>>      todo file was last read.
>>
>>    - This stat data in 'struct todo_list' is not updated when the
>>      sequencer itself writes the todo file.
>>
>>    - Before executing each instruction during an interactive rebase,
>>      the sequencer always updates the todo file by removing the
>>      just-about-to-be-executed instruction.  This changes the file's
>>      size and inode [1].
>>
>> Consequently, when the sequencer looks at the stat data after a
>> 'reword', 'squash' or 'exec' instruction, it most likely finds that
>> they differ, even when the user didn't modify the todo list at all!
>> This is not an issue in practice, it just wastes a few cycles on
>> re-reading the todo list that matches what the sequencer already has
>> in memory anyway.
> 
> It can be much more than just a few cycles, because the total number
> of parsed instructions from all the todo file re-reads can go
> quadratic with the number of rebased commits.
> 
> The simple test below runs 'git rebase -i -x' on 1000 commits, which
> takes over 14seconds to run.  If it doesn't re-read the todo file at
> all (I simply deleted the whole condition block checking the stat data
> and re-reading) it runs for only ~2.5secs.
> 
> Just another angle to consider...

I know dscho was keen to avoid re-parsing the list all the time [1] 
presumably because of the quadratic behavior. (He also assumed most 
people were using ns stat times [2] but that appears not to be the case) 
Could we just compare the text of the todo list on disk to whats in 
todo->buf.buf (with an appropriate offset)? That would avoid parsing the 
text and looking up all the commits with get_oid()

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/alpine.DEB.2.20.1703021617510.3767@virtualbox/
[2] 
https://public-inbox.org/git/alpine.DEB.2.20.1704131526500.2135@virtualbox/

> 
>    ---  >8  ---
> 
> test_expect_success 'test' '
> 	num_commits=1000 &&
> 	test_commit_bulk --filename=file $num_commits &&
> 
> 	/usr/bin/time -f "Elapsed time: %e" \
> 		git rebase -i --root -x true 2>out &&
> 
> 	grep "Executing: true" out >actual &&
> 	test_line_count = $num_commits actual &&
> 
> 	# show the elapsed time
> 	tail -n2 out
> '
> 
>    ---  >8  ---
> 
