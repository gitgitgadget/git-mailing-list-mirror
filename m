Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B553C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9D6206A5
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii6NxcyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfLPNxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:53:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39538 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfLPNxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 08:53:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so1469622qko.6
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YrwmzdJA47quop0r99pCqtnS4ym9b1svwOx6pjYeBMo=;
        b=Ii6NxcyKBEYfPrROeLrM3Zs49/dwB0bsQRp99F2a4w+Jt7SBE+kWokMUb3hqDgMdG6
         Eh3+y/ikqDB0R5lornwPdj/b2dZNbcq/pGrDvqmBqJfIjEx6t0itIJGlq/Bpn2f10Kai
         id/O/71eh5etX6Yhq+5jZyJZ6eYws2E+5valr1EH54wYBxsm/7Y/MEvYGAGaU4lHwRpG
         NeR+CGZFckKlAI/zkXB12s55Vrtx6dOZjsKkaDOLTtTdXK15zQt2zRMPbECVa6piF5JY
         o6i7dU1Q0mC+HbaP+837+SBuz1YqcLEg9IKLGeth2N/CmOLTPimEe4RfGirdI+RmJeiI
         Hnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YrwmzdJA47quop0r99pCqtnS4ym9b1svwOx6pjYeBMo=;
        b=DM7xwn0t5hOQ4wfTH7xEFSdjwsMYnBbbf13TL1eB3hA6qcl1gHMxi1e+iMb61IIOWg
         TxwvyLC1C7OqDkn+ZXS0zZAjg9obtd9JQq8DnMuyaJ1TJsArKzYBUdWqAHE9l/A0+hmX
         LDOVlPjAjFBRTS0S/Cf6FidD8eIT5McXHJQ6mJ71IsT872e1PFCn6MQfVWvXUA8ykjcL
         LR5OgILi3cPh7YJAAXsWBvDGnu/BnbFVw8hR5esCPhTItdkKhyXDU90Ae5C3tfDNA3is
         n+N6A+fkXlWE4rbyRocTf0bEE81yHCyWGQhJAqPfBkAQYW4mUU9viIlW/v8uHunAwnyD
         OZTw==
X-Gm-Message-State: APjAAAUioq2Kfod/s1f6EtH7v23GdTSJGFSjmxzvnPiDDbP2+jRMK0Kf
        cs1U4jJ/ncqaXFQHQ3XdIAA=
X-Google-Smtp-Source: APXvYqwdogRRjEjC6aYKZ/aHje0NbelzrGx7RauUhNvlaXP5XrAuj2cW9bBKtWmVE+i7qd5cz9aTIQ==
X-Received: by 2002:a05:620a:2094:: with SMTP id e20mr26109499qka.315.1576504397638;
        Mon, 16 Dec 2019 05:53:17 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id r80sm5989971qke.134.2019.12.16.05.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 05:53:17 -0800 (PST)
Subject: Re: [PATCH v4 1/4] git-p4: yes/no prompts should sanitize user text
To:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
 <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
 <6c23cd56842e76e5c11f32ba59fd7729769ab4b7.1576245481.git.gitgitgadget@gmail.com>
 <20191213225444.GA31452@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <750db524-8c99-dd9c-9fef-5936ce548edb@gmail.com>
Date:   Mon, 16 Dec 2019 08:53:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213225444.GA31452@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/13/2019 5:54 PM, Denton Liu wrote:
> Hi Ben,
>
> On Fri, Dec 13, 2019 at 01:57:58PM +0000, Ben Keene via GitGitGadget wrote:
>> From: Ben Keene <seraphire@gmail.com>
>> ...
>> Thanks-to: Denton Liu <Denton Liu>
> Thanks-to: Denton Liu <liu.denton@gmail.com>?
>
> Anyway, it's probably not worth a reroll. Aside from that, all the
> patches look good to me from a Python perspective.

I was /so/ close!  I'll reroll it anyway.

>> Signed-off-by: Ben Keene <seraphire@gmail.com>
