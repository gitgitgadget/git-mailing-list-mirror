Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CF4C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 13:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D112064C
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAFNfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAFNfI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 08:35:08 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC09C061358
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 05:34:28 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p187so2729967iod.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57gDlBHcpfICKOGeut+Ppu/28OEjYZEgUYglIzt09ls=;
        b=ufWPz9eINPM/PZNlANEXS7CQz46SSBhbSXCT1SO36EIS+Kj39FRpo8R3pPDPVsaEV3
         Z8Uz5jwASosbeYl3TsM32FoVNTHPUQgcQ1bTVH5Vc0WmVQ3idnSjZm+efDjdMFkDTram
         Mxtl+rCxwgo5elpIGyhT1I6PZTlCDw7nBb09zlsl0a3sf7WLfBAuHulORWjEgASIr/PP
         +J2xwBKsjmsVx5W4lrm92/29fTLlnJXJtjG1/52YztTPYQNPrzkhLFZDkBCoMwaZbPIE
         ypsYecFHHLd1r8eZ2tZEmfzN+GLQ9LOzaEkIwmVJvH9OHg4/5lnMB/z6wdgLaPYkEWau
         rrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57gDlBHcpfICKOGeut+Ppu/28OEjYZEgUYglIzt09ls=;
        b=Vph3XF9ANmUWc57yLHmLLfBwvn1xZms+AbO1DPuhq7tlXRcmA9wU9gQtQVYgZCs61a
         3mo2XiC8324zKEVnpT/v/xFzjldSZHWN1LDi9JYzAqJjvZ1vB6ldQ/zXl9I0z8yL13Ea
         cSx57VXXOFqu4BX+Y6oby/Cvo+nkfcuyWOfYipQeKFulywddTy0IvcKMlPbtpzglodhU
         C+t/yP6bUtsod3SoqTqK+Qg37aXdWgWCXBb5Jc6ehuNRPeMzpVL5xb+OnM0nbHuZYqI2
         ZD19+hoMRspAKZQKLf9ouQH8Sb+SwP6IED6JEOx0d8TCkaRo0ah4ZbrD7YzqS8W/8b61
         G0xQ==
X-Gm-Message-State: AOAM5318zc1ZLYm73ed+fVOa9Bzb3viexB8JPSYhePJV3nSJF3IJ5RgH
        R2OdVzNQeTGkV3Dc2tpDYKQ=
X-Google-Smtp-Source: ABdhPJylZ7lBgorLQdtfVhPxmQXIOo2q/aOIDgyW/K5WOWQWvkqhSDeg1cZ9wtJbxWkFfjCekLrC+A==
X-Received: by 2002:a05:6602:106:: with SMTP id s6mr2955639iot.17.1609940067771;
        Wed, 06 Jan 2021 05:34:27 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id d199sm1333224iof.46.2021.01.06.05.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 05:34:26 -0800 (PST)
Subject: Re: [PATCH v2] mergetool--lib: fix '--tool-help' to correctly show
 available tools
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
 <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
 <20210106131651.GQ8396@szeder.dev>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <11b3c261-14e6-0293-02a6-92bd1ea680d2@gmail.com>
Date:   Wed, 6 Jan 2021 08:34:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106131651.GQ8396@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gábor,

Le 2021-01-06 à 08:16, SZEDER Gábor a écrit :
> On Mon, Dec 28, 2020 at 07:41:44PM +0000, Philippe Blain via GitGitGadget wrote:
>> To prevent future regressions, add a simple test that counts the number
>> of tools shown by 'git mergetool --tool-help', irrespective of their
>> installed status, by making use of the fact that mergetools are listed
>> by 'git mergetool --tool-help' on lines starting with tabs. Prefix the
>> `git config` commands used at the beginning of the test to remove the
>> fake tools used by the previous test with 'test_might_fail' so that the
>> test can be run independantly of the previous test without failing.
> 
>> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
>> index 70afdd06fa7..ebd3af139e5 100755
>> --- a/t/t7610-mergetool.sh
>> +++ b/t/t7610-mergetool.sh
>> @@ -828,4 +828,14 @@ test_expect_success 'mergetool -Oorder-file is honored' '
>>   	test_cmp expect actual
>>   '
>>   
>> +test_expect_success 'mergetool --tool-help shows all recognized tools' '
>> +	# Remove fake tools added in previous tests
>> +	test_might_fail git config --unset merge.tool &&
>> +	test_might_fail git config --remove-section mergetool.mytool &&
>> +	test_might_fail git config --remove-section mergetool.mybase &&
>> +	git mergetool --tool-help >output &&
>> +	grep "$(printf "\t")" output >mergetools &&
>> +	test_line_count = 30 mergetools
>> +'
> 
> This new test fails when the topic 'pb/mergetool-tool-help-fix' is
> built and tested in isolation, because 'git mergetool --tool-help'
> lists only 29 tools instead of the expected 30.  The reason is that
> 'pb/mergetool-tool-help-fix' doesn't include commit 6bc9082c0f
> (mergetools/bc: add `bc4` to the alias list for Beyond Compare,
> 2020-11-11), which added that 30th tool (and is already part of
> v2.30.0).

Indeed. The branch I submitted is based on v2.30.0-rc2, but Junio based
pb/mergetool-tool-help-fix on v2.29.0-rc0~165^2, so the number of supported
tools is "wrong".

> 
> It also makes me wonder whether this is the right way to test this
> fix, because we'll need to adjust this test case every time we add
> support for a new merge tool (which arguably doesn't happen that
> often, but since we are already at 30 it doesn't seem to be that rare
> either).

Yes, it does. I thought about that, and I came to the conclusion that it
was the easiest way to prevent a regression like the one this patch is fixing.
I tought about doing it a different way, like having the test count the available
mergetools itself, and comparing the number of tools shown by '--tool-help' with
that number, but I chose not to do that because it seemed to be more complicated
(and would end up kind of re-implementing what '--tool-help' does, in a way...)

If you think of another of how we could test it, I can try it.

Cheers,

Philippe.
