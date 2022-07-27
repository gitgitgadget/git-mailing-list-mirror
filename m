Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA69C3F6B0
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 14:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiG0ObA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiG0Oa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 10:30:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050DE40BE4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 07:30:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 681F81BD904;
        Wed, 27 Jul 2022 10:30:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=nmQ+RZ7rlsfRfGNNmPYIlnFhdQQT58luGkQMRgLRV/U=; b=mMFr
        9FOQIVh9idm4fT7511nsLMkr5uYt6pSGvTq02lJEPddvAYpGwvpgSUM5vOBFf9pN
        w4XJ7ueCaI+i1SJKbVnoBVTXY0mMOGKgbuuZzNLEiKo8eRJKR0LW8/5pYSG8nL2/
        a7mnvxRYBPpB26+ihsm8TX0sdnavlwjuDYWmV2E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 608251BD903;
        Wed, 27 Jul 2022 10:30:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 196EC1BD901;
        Wed, 27 Jul 2022 10:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
        <d4dcb1f6-6076-3725-d479-7e9f1fece2a3@github.com>
Date:   Wed, 27 Jul 2022 07:30:51 -0700
Message-ID: <xmqqilnityp0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B80A7D24-0DB8-11ED-AF13-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>            - jobname: linux-leaks
>>              cc: gcc
>>              pool: ubuntu-latest
>> +          - jobname: SANITIZE=address
>> +            cc: gcc
>> +            pool: ubuntu-latest
>> +          - jobname: SANITIZE=undefined
>> +            cc: gcc
>> +            pool: ubuntu-latest
>
>> @@ -277,6 +277,12 @@ linux-leaks)
>>  	export SANITIZE=leak
>>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>>  	;;
>> +SANITIZE=address)
>> +	export SANITIZE=address
>> +	;;
>> +SANITIZE=undefined)
>> +	export SANITIZE=undefined
>> +	;;
>
> In both of these cases, we are breaking from the nearby pattern. These
> jobs could be renamed to linux-address and linux-undefined to match the
> linux-leaks job.
>
> Alternatively, we could rename linux-leaks to SANITIZE=leak, since the
> point is not to test the Linux platform but to use the additional runtime
> checks (and Linux is the fasted CI platform).

I tend to agree that in the existing linux-leaks job, the
"linux"-ness is much less important than the "leaks"-ness, so the
"alternative" might be slightly more preferable, but I do not mind
the renaming goes the other way, either.

Thanks for your good eyes and good taste.

