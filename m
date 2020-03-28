Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A6C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8033F206DB
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 16:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlB1zlWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1Qz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:55:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36957 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1Qz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 12:55:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so10217370qtu.4
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BYc2bs22Q33xQq9DYcjDXHF+MPXzmLM3HP3gnVfLL0g=;
        b=TlB1zlWKp45KA9paPURPkyjzhVlsTKnbLkhfBXLzEHxEbas7SpaL8hsWzAl5iYTBlb
         3JVECzRtTvj2mPjSMU5nxJoZYjpEe80PbqsVN5DzO6VrC/35X7UZrfvGGgfrRoQNaPRY
         ga/oBbM8m89QmIu7Ye+hm8KBK01eKK+MrYfMAyj3k5AvTowi+h5t+4c9RpMW3F+8Phu5
         2ZJozH9YK300lktP1FFm71SmQY/a0DD4pk8OSuVlQPpfAHMTIpWicysM3AO8qkmNOGJw
         KgXbzKXi5yjamHZTsyFupGMYGm5tGHbI6NscmwkBjEph51wD3kVyw3Eb3c5ZGuLIzMm1
         y0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BYc2bs22Q33xQq9DYcjDXHF+MPXzmLM3HP3gnVfLL0g=;
        b=Y03wncsGnILQ/cRPHztswyW7VAfsvwivDEwjk1ZBaWNKLLYdszbLm5lqiPRoFlSH11
         Lwo7vLANERq3m8j9ECRYX78FdngompPyazroc4U2ivUO/IIRbtvo21rUJ64MdY9dqhV5
         JCyAIomod2jUpzLkFEE71zcotow6R1+dROYitbvGTC5+H1sD8gmZNdC536tf+JCK33gP
         EP4VmGHtlKbMJu5RniZcaej3AdDAinZkEuPG02K6ml0VyWvZKKN2tjAB/di0QHwlHzgW
         QlUqs+MFR3KUQvdNx4n9UOEJydrZ5bZ4XmTXaQvsVJZ7wBCBdYpYHWAyXmkueyNSiX6I
         kEGw==
X-Gm-Message-State: ANhLgQ0vALJ7SBwh/MUNBI20HmBngMoPvZFjyfWipROHaw5r0pBtt/++
        7MAqPfV3W2HEEMd4h/uX1DE=
X-Google-Smtp-Source: ADFU+vuIzwBhAtsZvU45K3Rs3WeZTXSl373jBq01PAZ5zij4nIUPKVfMj8vsKm3D7jOvse6oRcQF2w==
X-Received: by 2002:ac8:1968:: with SMTP id g37mr4649297qtk.322.1585414528335;
        Sat, 28 Mar 2020 09:55:28 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u34sm6773087qtj.60.2020.03.28.09.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 09:55:27 -0700 (PDT)
Subject: Re: [PATCH] pull: avoid running both merge and rebase
To:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Norbert Kiesel <nkiesel@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com>
 <20200328155627.GB1215566@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <afb593c8-ba46-fe8f-8853-d0b727186af0@gmail.com>
Date:   Sat, 28 Mar 2020 12:55:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200328155627.GB1215566@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/28/2020 11:56 AM, Jeff King wrote:
> On Fri, Mar 27, 2020 at 09:51:40PM +0000, Elijah Newren via GitGitGadget wrote:
> 
>> When opt_rebase is true, we still first check if we can fast-forward.
>> If the branch is fast-forwardable, then we can avoid the rebase and just
>> use merge to do the fast-forward logic.  However, when commit a6d7eb2c7a
>> ("pull: optionally rebase submodules (remote submodule changes only)",
>> 2017-06-23) added the ability to rebase submodules it accidentally
>> caused us to run BOTH a merge and a rebase.  Add a flag to avoid doing
>> both.
>>
>> This was found when a user had both pull.rebase and rebase.autosquash
>> set to true.  In such a case, the running of both merge and rebase would
>> cause ORIG_HEAD to be updated twice (and match HEAD at the end instead
>> of the commit before the rebase started), against expectation.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>     pull: avoid running both merge and rebase
>>     
>>     Cc: Norbert Kiesel nkiesel@gmail.com [nkiesel@gmail.com], Jeff King 
>>     peff@peff.net [peff@peff.net]
> 
> I'm not sure how cc is supposed to work with GGG, but it clearly didn't
> here. :)

Angle brackets would work instead of square brackets:

	Cc: Norbert Keisel <nkiesel@gmail.com>

for example. Personally, I drop the names and only use email addresses
so I don't make this same mistake.

-Stolee
