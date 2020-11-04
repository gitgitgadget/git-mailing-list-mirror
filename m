Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642FC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49F1221E2
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMk6wL2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgKDORR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgKDORR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 09:17:17 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E5C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 06:17:17 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h12so12234262qtc.9
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AC54I7OuDzbolVAWhCCuNRtN+wvrhSnPzLyGm+95BDs=;
        b=gMk6wL2Oat/fXOXAT5F6Io15nFbfo4Iy4Z0xAXwccAy5I9WxnYb4b2AVPy6aFXjyBn
         ToSQLFSRDs0GZE63gM35jDZ1cV/rQ11DDcjdv3jTyUqlEPWbCqLwW64aZXYcu/RyxMTU
         h7SMwjeoUWX6TI3VLrlIfHUbEqGPXV9xI61ZTa9lzczfJ0Na1iYG96aCKSIAFd1+H87k
         q4+VLHEAn94JlsoLjDLEHvU+PgJZNX93up3fEg9xHMOPO89EIzKtIKHua3igQih6Ri/L
         BV8jUBUNUy9+gKjltIZWeLEDCwO7fUmyiUEPoHTuwG+qlvJ6k7/SgOIN7Q6TKBgXj3Xz
         oq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AC54I7OuDzbolVAWhCCuNRtN+wvrhSnPzLyGm+95BDs=;
        b=rlyksFSbM3HEZJ4HmE3il51plzxcwBmMw/eTKTqaWSNqjG31JvePPoFMjbrzFAStT7
         OygiRRy5W5yi+edjDzgI4KWeegMEi2Mf2qzpXrvXehoI2CZNM1vJN0kkP4G6NxxlV2g2
         3/Fa5hj744SgIG0+gO9tHYJD34eCnzldZINooJFtPhQQBpltIG6MkxLObP340YmqEX3/
         VPeR9x4/0cav11uoNsiiUJB2zeoFlg1FGmdSifeuJzwxYdBD4L5wq4ymNbDm3suZ61mr
         zay7SUgXozKtF7cOFfXpV43NFko+W57iSlPsej/wLGlTkzG4ZxtRLZW1Year3/ZOSn5b
         ssbw==
X-Gm-Message-State: AOAM5306YJT0iKHSLl8d1lI3KPUQqxxHKfAFE/J6sUtunAoQBmk+2JZk
        t1sohvmYNNMOQ0uamkR6q2c=
X-Google-Smtp-Source: ABdhPJyPGMBJjjw+7M79tvhp5AwjbdWgi+nD7B9j7zhHyaRd4XLpGIk/bYvbP28SxkqD4PWXoXi5ZA==
X-Received: by 2002:aed:2321:: with SMTP id h30mr19338751qtc.213.1604499435990;
        Wed, 04 Nov 2020 06:17:15 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id o2sm2584258qkd.12.2020.11.04.06.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 06:17:15 -0800 (PST)
Subject: Re: [PATCH 2/3] maintenance: use launchctl on macOS
From:   Derrick Stolee <stolee@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <832fdf16872cbfee4a5e15b559b2b40dabd545f4.1604412197.git.gitgitgadget@gmail.com>
 <CAPig+cR1zSqY_y02JBdtjh_+9Pp2dOtGrHHmf-ah5sU6Lhzp6Q@mail.gmail.com>
 <e493b759-4565-e7d2-4a19-dee23c651119@gmail.com>
Message-ID: <51d193c0-ef0c-aa5c-56c6-388499eaf2a7@gmail.com>
Date:   Wed, 4 Nov 2020 09:17:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <e493b759-4565-e7d2-4a19-dee23c651119@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 4:21 PM, Derrick Stolee wrote:
> On 11/3/2020 1:45 PM, Eric Sunshine wrote:
>> On Tue, Nov 3, 2020 at 9:05 AM Derrick Stolee via GitGitGadget
>>> +static int remove_plist(enum schedule_priority schedule)
>>> +{
>>> +       const char *frequency = get_frequency(schedule);
>>> +       char *name = get_service_name(frequency);
>>> +       char *filename = get_service_filename(name);
>>> +       int result = bootout(filename);
>>> +       free(filename);
>>> +       free(name);
>>> +       return result;
>>> +}
>>
>> The result of get_service_name() is only ever passed to
>> get_service_filename(). If get_service_filename() made the call to
>> get_service_name() itself, it would free up callers from having to
>> remember to free(name), thus reducing the likelihood of a possible
>> leak.
> 
> You're right. In an earlier version I thought I needed to add the
> name in the XML, but it turns out I did not.

As I go through the effort to remove get_service_name() I find that
actually the name is used in one place in the XML file:

+		   "<key>Label</key><string>%s</string>\n"

This "Label" should match the filename, I believe. I can still
be more careful about how often this name is actually required.

Thanks,
-Stolee
