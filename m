Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BB9C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED57E20717
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWEcoNWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLPTLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:11:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37304 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPTLC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 14:11:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so3407004qky.4
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j6ow5j+wCs3ExZH0Z7nmCWRR9TbHcE0OJzKWaYgw2Pw=;
        b=KWEcoNWJM4dhDvpYvbUkkGux9B04lVZQ+mZOXI2oYrmDiqsJudL4JHgantAeWx+WC+
         h+giYow43umMbFyIoVHwT4P7pPOdfMGaArFWHl2xHod4klVSRrK2lIJg8w+WHFAumkJY
         +IBGlf715ytQuwcf0BDMuT+IJI1ep1fZk8+bq4wStcbkK+Six/u1MqYf53930qnM62Lf
         BgqKjldmHw2PSC6Poq2DCY1Wzc6lsg3SQQ1+Y3ID4A2/0CJ/GdwS6BMJEfuBMrUjLhFG
         uJG0aqSkvg4/4bu2hHBzgPZPtxvC5oIjnXlF/6M9RlyGCB10dfc3paPoC05pNvbfHdiz
         Gcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j6ow5j+wCs3ExZH0Z7nmCWRR9TbHcE0OJzKWaYgw2Pw=;
        b=b9v63f5UPWABMtknf5TEOp2EQixnHSILjcVQ0o+wen6LjhSABt7mr7PcV3e+EYVqXX
         +TqNdibcYkEtsmCf36DDOOXcrC8pB8cCM54/LPQF0ZVDVcucn9Grxl02IcFLqPSo1tO0
         xTcwwjAMjZA9l+di/837EuiYn0cgGnIXxucldDm6Z+clBw934ozHM3JHIsY17Djfx3oK
         tE6dbvtlEzkaTaoXnKrnzCmojYVTzqvPuEpjxhoaHzJAeRgHVUhwiQGpnaJbIRuijOgq
         z75CE+ZQ0OYXzmkLH6PBwCAgRFCKPqkAG2WDGUfoFT9jnb/U6niRiUkUHel9rxuKSS2E
         +uzw==
X-Gm-Message-State: APjAAAVoAnRGEveVgpoG4xkbdZcZZuJy0tCq87HkRxy2/BSyMyp1GHh+
        6hIL4pNnc7Rhcog2yOz8ngv7EpcbiBw=
X-Google-Smtp-Source: APXvYqzG/8sClIH9nk2DlUhgoecjpql0KO1B7UKYHaRYP7iaslSWqL2JtNnDv8dBS1TyN0zDEYfAow==
X-Received: by 2002:ae9:dc82:: with SMTP id q124mr963232qkf.20.1576523461567;
        Mon, 16 Dec 2019 11:11:01 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id z4sm4825617qta.73.2019.12.16.11.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 11:11:00 -0800 (PST)
Subject: Re: [PATCH v3 1/4] git-p4: yes/no prompts should sanitize user text
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
 <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
 <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>
 <20191213014537.GA13064@generichostname>
 <xmqqsgloj9fd.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1912152125390.46@tvgsbejvaqbjf.bet>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <0ce91fe5-df41-b4de-6e74-036c346df577@gmail.com>
Date:   Mon, 16 Dec 2019 14:11:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1912152125390.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/15/2019 3:30 PM, Johannes Schindelin wrote:
> Hi Junio,
>
> On Fri, 13 Dec 2019, Junio C Hamano wrote:
>
>> Denton Liu <liu.denton@gmail.com> writes:
>>
>>>> @@ -4170,3 +4175,4 @@ def main():
>>>>
>>>>   if __name__ == '__main__':
>>>>       main()
>>>> +
>>> Spurious trailing line. Perhaps we could make GGG error out on
>>> whitespace errors before submissions are allowed?
>> I think you are asking the tool for too much support.
>>
>> It may help a lot more if we gave a Makefile target (or two) that
>> the contributors can run before going public.  Perhaps
>>
>>
>> 	O=origin/master
>> 	upstream-check::
>> 		git log -p --check $(O)..
>>
>> that can be used like so:
>>
>> 	$ make upstream-check
>> 	$ make O=gitster/next upstream-check
>>
>> That way, those who use format-patch+email without GGG or those who
>> push to a shared repository to be reviewed among the peer developers
>> before going public would benefit, not just GGG users.
>>
>> Hmm?
> I'd like that a lot, _and_ I think GitGitGadget could learn the trick of
> running that `Makefile` target and report failures back to the PR
> _especially_ because GitGitGadget knows the base branch of the PR.
>
> In my opinion, there is a lot of value in having GitGitGadget doing this,
> as new contributors are likely to miss such a helpful `Makefile` target.
> For example, I vividly remember when I contributed to cURL for the first
> time and had totally and completely missed the invocation `make -C src
> checksrc` to help me get the code into the preferred shape.
>
> Ciao,
> Dscho

Same here for me.  My entry point into submissions was through GGG.  The
more suggestions it can offer prior to "/submit"ting code the easier it
would have been for me and the less noise I would have brought to the
mailing list.

- Ben

