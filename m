Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647FC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 08:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA606115B
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 08:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhDPIbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPIbG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 04:31:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D4C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 01:30:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y4so3370876lfl.10
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=74Zz13W/qu4eXnQN/KhpQxnrSUIGkZPG7qtxLg/Wqaw=;
        b=MP5Q8n2TKSERcjukN7XlWa6KdushxibOx07NkZ50fYxXNB/0jZrB2SgEmv1kgOtTPt
         j5piqPmurz4sHuVY/BgGC71eFqdwM9ffDpsJUMBJUwXuUvEQZ5/H/dDH07No1Gls4P4P
         ONqn5sV/y2B0K60hfr2kOYgl/e3FgYEjJfNVnFAZe+7+d1ttYZrXS7U1waqsxKl7lEpC
         yh+HRLhpcar9oSCPQMCrQIpICb8/HjzeayAiZAAeJGoGq9+bgUbgqbW4N/WzdEqfdhaf
         c8XZXenjaNcM4GyoK59fPJ7oR8bdCqzX6CN0urkoiutKQnLHFHbYrqvYhwRUafRQPcnc
         4lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=74Zz13W/qu4eXnQN/KhpQxnrSUIGkZPG7qtxLg/Wqaw=;
        b=Ef+Ei42ebmtljIoL7FDQ0rFSrigSSwX9W/RdyOMFXLnNg2G81fGxJ+/P05OgsSnK3y
         +aiC+CrAmfgiwSLHiabRw9zt1K3lTDFk8pWsqZXn2gbx52U4zYjgudy85Ct1DESQmAVT
         Y+saBiIhxFAImyp73SCSa86rHIBAtCZEBX+YEh1HHDKDdXAIdz0QAT/atlV8iiyt40eB
         9D2uru2yIFjfq8hIDeXWCUWI3moMlJrOVW/8Oxp0n3Q4rfwpivKcAMISU9w51dVa5tTH
         Y+CqOZSe1kV2pT+Abzyix8uoFtySovw1DjpoWqK5vTHzNDdN7kbHy3drrlK5qwqi/NXx
         iRDg==
X-Gm-Message-State: AOAM532yvuHzXX7qgAl0O6LthChgggXcFyQ25BM49mPZgK2AciReMFbT
        3WmR9TtAePAo9k1nRIAAezyiA8yeOf8=
X-Google-Smtp-Source: ABdhPJw9FGC8IQClT6NlBqS2OjuW3lOkBVXrhoPAiW5dnGefPkFd9a0IU46gwfWVHyUVafYIZPv1jw==
X-Received: by 2002:a19:808f:: with SMTP id b137mr2311892lfd.162.1618561840135;
        Fri, 16 Apr 2021 01:30:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u12sm920795lff.126.2021.04.16.01.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:30:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/5] diff-merges: introduce log.diffMerges config
 variable
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210413114118.25693-1-sorganov@gmail.com>
        <20210413114118.25693-5-sorganov@gmail.com>
        <xmqqpmyvpacr.fsf@gitster.g>
Date:   Fri, 16 Apr 2021 11:30:38 +0300
In-Reply-To: <xmqqpmyvpacr.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        15 Apr 2021 13:21:40 -0700")
Message-ID: <87im4mbpht.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 04ce884ef5ac..4d732d6d4f81 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
>>  	test_completion "git config log.d" <<-\EOF
>>  	log.date Z
>>  	log.decorate Z
>> +	log.diffMerges Z
>>  	EOF
>>  '
>>  
>> @@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
>>  	test_completion "git -c log.d" <<-\EOF
>>  	log.date=Z
>>  	log.decorate=Z
>> +	log.diffMerges=Z
>>  	EOF
>>  '
>>  
>> @@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
>>  	test_completion "git clone --config=log.d" <<-\EOF
>>  	log.date=Z
>>  	log.decorate=Z
>> +	log.diffMerges=Z
>>  	EOF
>>  '
>
> $ sh ./t9902-completion.sh -i -v
>
> ends like the attached.  Is there a prerequisite patch I am missing,
> or something?

To me these completion tests don't work as expected unless I "make
install; make test" resulting Git version rather than simply "make
tests".

I have been told this by SZEDER Gábor <szeder.dev@gmail.com> earlier in
the discussion of these patch series:

<quote>
It might be related to a bug in the build process that doesn't update
that auto-generated list of supported configuration variables after
e.g. 'Documentation/config/log.txt' was modified; see a proposed fix
at:

  https://public-inbox.org/git/20210408212915.3060286-1-szeder.dev@gmail.com/

</quote>

Looks like that's it?

For reference, I've checked all the commits in the series with this
script:

#!/usr/bin/env bash

while read -r rev; do
    git checkout "$rev"
    make clean > /dev/null 2>&1
    commit=$(git log --oneline --abbrev=6 -n1 $rev)
    echo "Make $commit"
    if ! make prefix=$HOME/git -j8 all >/dev/null 2>&1; then
       >&2 echo "Make for commit $rev failed"
       exit 1
    fi
    echo "Install $commit"
    if ! make prefix=$HOME/git install>/dev/null 2>&1; then
       >&2 echo "Install for commit $rev failed"
       exit 2
    fi
    echo "Test $commit"
    if ! make test; then
        >&2 echo "Test for commit $rev failed"
        exit 3
    fi
done < <(git rev-list --reverse "$1")

-- Sergey Organov
