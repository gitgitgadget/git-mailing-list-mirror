Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URI_HEX,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496DC636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D75613D0
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 13:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhGQNnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhGQNnz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 09:43:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E7C06175F
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 06:40:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m2so15419085wrq.2
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=deKeaLHB1L42zie3VlFtGeCSeGXb6LG3rBFTeDJS0ik=;
        b=mzdCcZTPdFPDeCPDwgu7tI49AmgEn9gLOgyr15DBEZ0cANpU+hG7TOiI0zMQmsA6PS
         bbx4cW5kKyBF8twHhTQLIy94jdzfly8H622rR7JN0ajzDDTSnqveIsSznsSWnoeNsBuI
         97sFErCxCP3EWNIwZl2ZD8sl6pNi0gjp69WPnra62SB5hpEhpIzDdFx4RehsHbSQz89+
         QGMRqwkyYv1bS+JoTiHlTd9GuHLkV/hSm1Va/X6nRfKFwUnb4WYH0mpR3M7C7ef7neWs
         xNh4XVoI0UKWGHXdhH1dYnDH0gLqYrfHhfG1aLI8ec+hjGwhjQeedaPp8XmNXSjhR8Ps
         TlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=deKeaLHB1L42zie3VlFtGeCSeGXb6LG3rBFTeDJS0ik=;
        b=Lt31uSYkc4uzwGj66p/xmqTqTf6QVJT5/6VGofZVMtvb424IkuyzmHg/kjP0JI1M5r
         ij5uuQTjHwN5j51F153WqJWr66YH8xVlDzhTtTyD38bOTUbfusB6M+7AhDuLS+dQ25FY
         A5ykFJgtQ/sRosgYHoIYOLVXuS+uKpyBI4srEO5oA0ak5UV6/RbWqd/vtDn2h1gOHnZG
         hagX+52KB98PWH3vGPOpNWgQ/IyetkZRhkTd2SvKBlK1RyZ3V0dFm6JOuT6wVmGYVEAV
         dmKj9NxDun1F+5kAM/8T3Rsf7vMsDUcy0scj5kowtQypndGJoJhlo1fHHhd/hyEkI75J
         Vk7Q==
X-Gm-Message-State: AOAM531yX+rgI74m2eo9jqCDb9I/mYZX5X+9hsBf5BLyia/y+sxSotkq
        JKDQ5+TQlC2YN8MAr7Xw2is=
X-Google-Smtp-Source: ABdhPJxG9HSJZqgugRu6JluXX42iJuLVwDLZwlOAeZd46G0gcs5CsmeocrvJx6FYqeWMHp8FTqLmew==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr18715983wrs.347.1626529257131;
        Sat, 17 Jul 2021 06:40:57 -0700 (PDT)
Received: from [192.168.1.240] (141.2.7.51.dyn.plus.net. [51.7.2.141])
        by smtp.gmail.com with ESMTPSA id d15sm13692882wri.39.2021.07.17.06.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 06:40:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, Luca Weiss <luca@z3ntu.xyz>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
 <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
 <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
 <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
 <16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com>
 <YPHe/W7+Oh63NpB0@coredump.intra.peff.net> <xmqq8s26q9ot.fsf@gitster.g>
 <YPH1qKMPOqhCzp4Y@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <693954a7-af64-67c5-41b9-b648a9fe3ef2@gmail.com>
Date:   Sat, 17 Jul 2021 14:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPH1qKMPOqhCzp4Y@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/07/2021 22:10, Jeff King wrote:
> On Fri, Jul 16, 2021 at 01:34:58PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> I think we still end up calling cleanup_message() on the result before
>>> using it as the final message, and that will fix any missing newline.
>>> But we feed the intermediate state before then to the hooks (which is
>>> exactly where one might expect to use interpret-trailers).
>>>
>>> I'm not sure if we should be doing a preemptive call to
>>> cleanup_message() before feeding the hooks (we'd still need to do the
>>> final one, to clean up whatever the hooks return to us). I guess
>>> probably not, because I think that would remove comments, as well. So
>>> adding in just the missing newline is probably better.
>>
>> To be quite honest, I think this patch is a half-way solution and I
>> am not sure if it is better than either of the two "purist"
>> extremes:
>>
>>   * If the hooks want to see messages with as little loss of
>>     information from the original as possible, we should give them
>>     without clean-up (which you pointed out above) *and* without this
>>     patch.
>>
>>   * If the hooks want to see messages as canonicalized as people
>>     would see in normal "git log" output, we should be passing the
>>     full clean-up to lose even comments and in such a case there is
>>     no need for this "always terminate" patch (we'd instead do far
>>     more).
>>
>> Between the two approaches, both are purists' view, I'd prefer the
>> former, but from that stance, the conclusion would become that there
>> is no need to do anything, which may be a bit unsatisfactory.
> 
> Yes, I agree with all of that (including the "as little loss of
> information as possible" preference).
> 
>>> Since it will usually be added back in by cleanup_message() anyway, I
>>> think it's OK to just add it preemptively. The exception would be if the
>>> user asked for no cleanup at all. So making it conditional on
>>> cleanup_mode would work, whether -F or not.
>>>
>>> I suppose that does mean people turning off cleanup mode would get a
>>> message without a newline from fmt_merge_msg(), though, which is perhaps
>>> unexpected.
>>>
>>> So maybe just keeping the newline there, as you suggest, is the best
>>> way.
>>
>> Hmph.
>>
>> If the user tells us "refrain from touching my message as much as
>> possible" and feeds us a proposed log message that ends with an
>> incomplete line, I would think they expect us not to turn it into a
>> complete line, and I would think doing this change only when cleanup
>> is in effect would make sense.  This is especially true for users
>> who do not let any hooks to interfere.  They used to get their
>> incomplete lines intact, now their incomplete lines will
>> unconditionally get completed.  I am not sure if I would want to
>> defend this change from their complaints.
> 
> Right, what I was suggesting was:
> 
>    if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
> 	strbuf_complete(&msg);
> 
> which would cover that case. But Phillip mentioned that our own
> fmt_merge_msg() does not include a newline.

I mentioned that we remove the newline that is added by fmt_merge_msg(), 
not that there is no newline added by fmt_merge_msg() - maybe I wasn't 
clear enough. In builtin/merge.c:prepare_merge_message() we do

	fmt_merge_msg(merge_names, merge_msg, &opts);
	if (merge_msg->len)
		strbuf_setlen(merge_msg, merge_msg->len - 1);

This has been the case since the beginning of the builtin merge[1]. I 
assume it was trying to emulate the result of a command substitution in 
the shell version.

Best Wishes

Phillip

[1] See 
https://lore.kernel.org16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com/ 
for more details of my archaeology on this.

> So it would not be the user
> feeding us an incomplete line, but rather Git feeding it. And that was
> what I suggested should be corrected (which I suppose would be in
> addition to correcting lines from the user).
> 
> However, I see a call to strbuf_complete_line() at the end of
> fmt_merge_msg(), so I am puzzled about what he meant.



> 
> -Peff
> 
