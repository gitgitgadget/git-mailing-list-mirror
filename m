Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA0C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435BD24673
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 10:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwbuveFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfLFKlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:41:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLFKlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 05:41:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so7169582wre.10
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+J1NXwxLdr0TVue9uUP+d8gY/sWBOELBSPVSyeM7cvs=;
        b=fwbuveFOpHnlROOPW1Pr8kPx97Q/sv1ujfrOO5+DBvf9NThNj1+pZnc6imZzVDI/z6
         QAhuie+j6f5muqwK2ZXgzLQp71hVBNGzRUAwYmHr+RIXtS9+VZFcjCaj3zTXUiEfzIfq
         rhnYOVWrgAV9pEvuOIb0hCza3nqiPoeY8E8Qw5zFmbW9pFbUFSrY/SDYZEs81bSy5Oky
         v+8De98nubID0+fsrseZJXB6dx5V/mkfuvW5Ghkgio4rvW2lA4vXBEk8Bq7hBriO7XHZ
         tiT+s28I5z376HGcv79lze4Z4ni9BtLDYozXMajz+4aGeGiaKnn3S3pJgwFDXgl/SXKB
         M/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+J1NXwxLdr0TVue9uUP+d8gY/sWBOELBSPVSyeM7cvs=;
        b=agJBk20P17p9dE9w6snMyodk6DKit29bnvOaKw9ac32/NjaWlJrnZokrCP+VAup/YM
         63ehbWO/Q8z3Ohlb91Mp6nQYrNo1lBhdDyDHt9J9C8rGJuO/2bPKVTCFVMhJHJkdPm/C
         Z5YJPUadbXrmMxnphoX0A0NZJ0daB14Vf5ZJLJFi4LZ5aBUXfNoX5rMzvav+SSzSR0Bs
         qnDEJv9gRCKouP9uaX0KyNLkOvW1mVp4wAF8bRMKqYJFcKPUsWuNQqyyU4pcjwtdDD1L
         pNDXBfj1Y7pDtusG6itPtwwMclHfMsQvENZ6/52KxKZirNwSugM2o7oxyk/HE/wAYuN3
         js6w==
X-Gm-Message-State: APjAAAW25wTeO5C9+KnMi9K6sNjrlc4wNlHJPpfJX0Qc0NSu7YPAcZzl
        b5+KxENnKLP7pEPlGKgqqaI=
X-Google-Smtp-Source: APXvYqzqMI5QVCk6lkeJgWFJNldOyiWxWUzmj78ap3WlOyClpRgF8tgCKJ/8WSNuEVRG9yI3CBCKRw==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr15009835wru.181.1575628913255;
        Fri, 06 Dec 2019 02:41:53 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id x10sm15754519wrv.60.2019.12.06.02.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 02:41:52 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] rebase -i: extend rebase.missingCommitsCheck
To:     Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
 <xmqqmuc73gk7.fsf@gitster-ct.c.googlers.com>
 <580f1a75-be77-8720-b368-e87a70fe8fec@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bc1fdd40-0490-eb65-247c-189b16865db5@gmail.com>
Date:   Fri, 6 Dec 2019 10:41:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <580f1a75-be77-8720-b368-e87a70fe8fec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 05/12/2019 23:15, Alban Gruin wrote:
> Hi Junio,
> 
> Le 04/12/2019 à 22:51, Junio C Hamano a écrit :
>> Alban Gruin <alban.gruin@gmail.com> writes:
>>
>>> To prevent mistakes when editing a branch, rebase features a knob,
>>> rebase.missingCommitsCheck, to warn the user if a commit was dropped.
>>> Unfortunately, this check is only effective for the initial edit, which
>>> means that if you edit the todo list at a later point of the rebase and
>>> drop a commit, no warnings or errors would be issued.
>>> ...
>>>   rebase-interactive.c          | 57 ++++++++++++++++++++----
>>>   rebase-interactive.h          |  2 +
>>>   sequencer.c                   | 53 ++++++----------------
>>>   sequencer.h                   |  1 -
>>>   t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++++++++
>>>   5 files changed, 147 insertions(+), 49 deletions(-)
>>
>> This passes the self-test when tested by itself, but when merged
>> near the tip of 'pu', it breaks t3404.116, it seems.
>>
> 
> After a quick investigation, it comes from
> pw/post-commit-from-sequencer.  Since then, tests are expected to setup
> the editor and run the commands using it in a subshell.  So the fix is
> straightforward.
> 
> Perhaps I should take ag/sequencer-todo-updates, merge
> pw/post-commit-from-sequencer, rebase this series onto the result, fix
> the issue, and reroll the series?

If the issue is just using a subshell to set the editor then (assuming 
you're only adding new tests) I don't think you need to rebase - just 
change your tests and it should be fine when Junio merges it into pu. 
I'm sorry I've not looked at the latest version yet, I'll try and get 
round to it next week.

Best Wishes

Phillip
> Cheers,
> Alban
> 
