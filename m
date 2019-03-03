Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9599C20248
	for <e@80x24.org>; Sun,  3 Mar 2019 19:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCCTLw (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 14:11:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51514 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfCCTLv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 14:11:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so2617504wmi.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=olTJruIXwQiPce7hOJCVnaKZdxZ4iyqnq7lqWlZCHb0=;
        b=dY28WVAFxgI//bbdIjy4NxXdbCfvCzEC5m/b7VGBJhBXI7RwptAy2ex/AMJjkaHTp9
         QYiw9Fhc4AHaZBxn9rNsgJUHR2wRRAiEHFOBz3WqLrrTFOY18tp3vTanexckfnUjLtlJ
         SVJKPuoBvKI0O6mHysHH0FZtZfZKhLbu9v8W/tGKEx9Qk/HwFJIGttGROpBnJX01DNIS
         lXbQGU6GBHiIQQwfzSI+6niL/xutOgGk/9nsQ8JPT+zUAppN4dSLsCyojzmA9B2Lq409
         nx9Vt9AHpxMS6C+rvX8A///HQFM3gQQ2LvHYA3gxa3UcJUqDoSYuVmDCDMS8D3u2x8hW
         C5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=olTJruIXwQiPce7hOJCVnaKZdxZ4iyqnq7lqWlZCHb0=;
        b=nHT0BKAutKWCK0rE7jaMMJq1FrgpRA478ja+6DylYYC0A0lJKagtXkcZwij95rzDEX
         Bx8/Rs0g7IHRK/g7AvW8FBth7utK4Ib4VNxNJfku1HktRbElZW04pdOeukTB1I45OQ2h
         CXJfDCu0HNYT3zNgbcmg9mM2HCGnO/3qgKrOJgQ5NNHjh0rX5kWcE5BPqnUA0oSQYBzk
         3uy7dqViYRC7aR57DU9YZna5Kbiuts1TjTFRNw234vwZCsaW5xAlj7pY0SFwud0e2P4/
         +Ueg3J7bXmB2Q5+TOYDR0QVgCh2vS1tdBS7bDGxqsvrRqwPGvISqJeYOHn5SJqUyGBpF
         5D/g==
X-Gm-Message-State: APjAAAVl43pjp5DAhzH5Tdz31ySEY9NSvIfwyGoGVpYRgLDf+zLqK5O8
        trgqEMbUjMiOdHFFeSsPrWM=
X-Google-Smtp-Source: APXvYqy9K48E4F1iyG+NcPRyr3ELbeaFVyuZsPedPG0vcwnW5FfmZkVAQ7CAunaDT8w6LuqNvZdvRQ==
X-Received: by 2002:a1c:dc8a:: with SMTP id t132mr9876323wmg.48.1551640310114;
        Sun, 03 Mar 2019 11:11:50 -0800 (PST)
Received: from [192.168.2.201] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.googlemail.com with ESMTPSA id o12sm17074693wre.0.2019.03.03.11.11.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 11:11:49 -0800 (PST)
Subject: Re: [PATCH 1/4] built-in rebase: no need to check out `onto` twice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nazri Ramliy <ayiehere@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
 <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com>
 <7b1282bf-4b94-5725-00df-2dc63eaa93f0@gmail.com>
 <nycvar.QRO.7.76.6.1903011415220.41@tvgsbejvaqbjf.bet>
 <22878dbe-d9f0-4737-3a49-ece695c2d0c2@gmail.com>
 <xmqqef7o3fl8.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f38ebc4c-f0a6-c57b-1d0e-8208ff638a73@gmail.com>
Date:   Sun, 3 Mar 2019 19:11:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqef7o3fl8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 03/03/2019 01:35, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Thanks for explaining, it all makes sense to me now
> 
> It would be necessary to make sure that it all makes sense to all
> future readers.  Are they patches good enough as-is for that, or do
> they need some updates before I take a look at them to pick up?
> 

I've just re-read them and I think they're fine as is, though the first
 paragraph of the first commit message might be clearer if "HEAD was an
ancestor and" was changed to "HEAD was an ancestor of onto and".

Best Wishes

Phillip

