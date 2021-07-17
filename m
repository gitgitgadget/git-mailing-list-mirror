Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E9C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 10:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F9A613D4
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhGQKZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQKZd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 06:25:33 -0400
Received: from mail.aixigo.de (mail.aixigo.de [IPv6:2001:67c:13b0:ffff::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40B49C06175F
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 03:22:37 -0700 (PDT)
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id c9fca00a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 17 Jul 2021 12:22:35 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de ([172.19.100.218])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16HAMXAa2456770
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Sat, 17 Jul 2021 12:22:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1626517354;
        bh=fKbcoqveRva4cr6gRYHn+5VuZz7ll+lGmZyWuwsEA0w=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=sa/Ln0SlAyHpZjTB3wIsz4L9conJf+KisOO1OppTyrf6NhVpUT2uCMqWjspw2XSJY
         ylihGcw1CqmVufIQm8Phx9sbn0SBj/Q0BvwtUCg35yC+iOuAUnkGZAFfAqRYMGisl3
         abTypkgZNAAdlYkGXMYzAYrZl7ZjBdN+6EZXqCb8=
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
References: <60f1daa896f69_330208b1@natae.notmuch>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Subject: Re: When are you going to stop ignoring pull.mode?
Message-ID: <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
Date:   Sat, 17 Jul 2021 12:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <60f1daa896f69_330208b1@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/21 9:14 PM, Felipe Contreras wrote:
> Elijah Newren wrote:
>> It may be a worthy goal, but I cannot implement correct behavior if I
>> cannot determine what correct behavior is.
>>
>> You've only specified how to handle a subset of the valid combinations
>> in each of your emails, and from those individually or even
>> collectively I cannot deduce rules for handling the others.  Reading
>> the dozen+ recent messages in the various recent threads, I think I've
>> figured out your opinion in all but two cases, but I have no idea your
>> intent on those two (I would have thought --rebase override there too,
>> but you excluded that), and I'm rather uncertain I've correctly
>> understood you for the other ones (I really hope gmail doesn't
>> whitespace damage the following table):
>>
>>     pull.ff  pull.rebase  commandline            action
>>       *          *        --ff-only --rebase     fast-forward only[1]
>>       *          *        --rebase --no-ff       rebase[1]
>>       *          *        --rebase --ff          rebase[1]
>>       *          *        --ff-only --no-rebase  fast-forward only
>>       *          *        --no-rebase --no-ff    merge --no-ff
>>       *          *        --no-rebase --ff       merge --ff
>>
>>      <unset>     *        --no-rebase            merge --ff
>>      only        *        --no-rebase            merge --ff[2]
>>      false       *        --no-rebase            merge --no-ff
>>      true        *        --no-rebase            merge --ff
>>
>>      <unset>     *        --rebase               rebase
>>      only        *        --rebase               rebase[2]
>>      false       *        --rebase               ?[2]
>>      true        *        --rebase               ?[2]
>>
>>       *          *        --ff-only              fast-forward only[1]
>>
>>       *       <unset>     --no-ff                merge --no-ff
>>       *        false      --no-ff                merge --no-ff
>>       *       !false      --no-ff                rebase (ignore --no-ff)[2][3]
>>
>>       *       <unset>     --ff                   merge --ff
>>       *        false      --ff                   merge --ff
>>       *       !false      --ff                   rebase (ignore --ff)[2][3]

What about

          *       !false      --ff-only              ???

I think these are conflicting options, see [ ] (the ref without a 
number). This feels like saying oh, I want to rebase, but I want to 
fast-forward. What should happen with my local changes then? Could one 
argue that this should lead to the local changes being rebased on top of 
the remote?

>>
>> [1] https://lore.kernel.org/git/xmqq7dhrtrc2.fsf@gitster.g/
>>      https://lore.kernel.org/git/c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com/
>> [2] https://lore.kernel.org/git/xmqqpmvn5ukj.fsf@gitster.g/
>> [3] https://lore.kernel.org/git/xmqq8s2b489p.fsf@gitster.g/
>>
>> It appears you, Phillip, and I all had different opinions about
>> correct behavior and in a few cases though the documentation clearly
>> implied what we thought.  So, I'd have to say the documentation is
>> rather unclear as well.  However, even if the above table is filled
>> out, it may be complicated enough that I'm at a bit of a loss about
>> how to update the documentation to explain it short of including the
>> table in the documentation.
> 
> Yeah, now you are starting to see the problem.
> 
> How many more failed attempts do you need to go through before accepting
> that the approach you thought was feasible is in fact not feasible?
> 
> The solution is simple and self-documenting:
> 
>    pull.mode={fast-forward,merge,rebase}
> 
-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
