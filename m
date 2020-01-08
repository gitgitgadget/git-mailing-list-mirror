Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F8AC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 14:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F9F20692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 14:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnqNXKBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAHOdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:33:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33740 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgAHOdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 09:33:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so3673821wrq.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 06:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+nkYy6FQjByV+DZxkObGWjm3Y4yyJ+y7tp4hKe7bEbY=;
        b=GnqNXKBdFWmsgwuYbW3ln5hoMMcOL4gl9d8YnyR9PtUJ2m8UCUWRWhBPGeQGPIhqMN
         4jZCyZqKQaqb79oUfkymHCZhe1xcCUrVeRyYc68X1+UlGCwD/2MPB/snoJf7Wnk9rxby
         +GSsgMxa6CV0efkr3eylKhoEGBHGVvN2+gkgPow3ygFdUUxq3jOqJ1Cw5VUCnScMDm+c
         YMCtKzGaa0QDQgOJIKIdbjpxLfHegm4341QUhnXaLt2+PIy3Q0kuy9prpnsPQFhk99xf
         FwuSEk2qOVTDWPgyZtZMYlROeiaFM/s9B0Ur9E7lDto1RPmwXXR97eJuwfpsBSg8TCm1
         jmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+nkYy6FQjByV+DZxkObGWjm3Y4yyJ+y7tp4hKe7bEbY=;
        b=jp2B2vb20UUpnFNDUoSr9hyssYoYs1bupKvQf1l70PUB+a6NeWH4JU2aYY8VEj7owp
         CzeYwU4fWBq+KguGm0Zi0o2n2PQhfHe+lQQ4aUGE+PW+XQPgvF6+Aq63ikgEMixZD1Cx
         lfjFgu/C0kU/J2Vf/wsbqd5ImyZkw/+QpU5tbtJP3vRmQJZL8rxIwwTPSi/do+MV4k5u
         2ehbiNE+TP6v+AxuvP3pPf6Vdxo1VqIjvYBO31Y2uY4pNiMejcRBmoGUjDtnyyT95dLQ
         uIzkGl5o2bIkAwGvO7NolubiCDXrWG+a+rZ4dEujkTo26KKneBsnn+GUbka5Ez1uJ6ZV
         XNcQ==
X-Gm-Message-State: APjAAAW9Gg2iyhKA617h2w9gR4KR5Rz/WBZ/T7P9LnoYJvOIJbWPs/3k
        UiYhrQyLFufOD4sfaSJLFH8=
X-Google-Smtp-Source: APXvYqx+b7ntp4dM8H504JcUXk2gSBWJm4AspBUVTrAmnQ8ul1KWr/9mNQIebPGngynUGXDHxdWF7Q==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr4784275wrt.339.1578493977816;
        Wed, 08 Jan 2020 06:32:57 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-145.as13285.net. [92.22.7.145])
        by smtp.gmail.com with ESMTPSA id x14sm3836299wmj.42.2020.01.08.06.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:32:57 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/15] rebase: add an --am option
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
 <8f2fa083-114a-011f-1480-ae0ebd67d814@gmail.com>
 <CABPp-BEoTb6LVXThEM4zoKxVOnzBNs7y-Mk+oFbb6BUzCo3RHg@mail.gmail.com>
 <xmqqy2uj3u3q.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9ac52ef1-c1cb-45aa-178a-ec5a282bd761@gmail.com>
Date:   Wed, 8 Jan 2020 14:32:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqy2uj3u3q.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/01/2020 20:11, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> However, I thought of this option before Junio suggested a
>> rebase.backend config setting, so we could just rely on that instead.
>> Thus, getting rid of the "--am" flag in detail would mean:
>>    * I need to redo the test changes in this series to use "-c
>> rebase.backend=am" instead of "--am"
>>    * It will be slightly harder for users to use the escape hatch in
>> one-off cases during the transition
>>    * We need to figure out the right way to reword the documentation
>>
>> The first two are pretty minor, so that probably means I just need to
>> come up with some good wording for the documentation (suggestions
>> welcome...)
> 
> It probably is a good idea to keep --am (and possibly --[no-]am) as
> long as rebase.backend option exists.  A configuration variable that
> changes behaviour without allowing it to be overridden from the
> command line is not a good idea.

I view this change in the default backend as similar to the rewrite in C 
in that it is an implementation detail we're changing that should be 
transparent (and beneficial in terms of performance) to the user. There 
we provided a configuration variable but not a command line option to 
control if it was used or not. I don't see it as something the user will 
want to change from rebase to rebase but perhaps I'm missing something.

Best Wishes

Phillip
