Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF6C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiFCN4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244858AbiFCNz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:55:59 -0400
Received: from nmsh7.e.nsc.no (nmsh7.e.nsc.no [148.123.160.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE6393F4
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:55:57 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh7.e.nsc.no (smtp.online.no) with ESMTPSA id F005FE60FB;
        Fri,  3 Jun 2022 15:55:54 +0200 (CEST)
Message-ID: <09d485f5-e3f0-be10-7061-bff6ef09a99a@online.no>
Date:   Fri, 3 Jun 2022 15:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220601134414.66825-1-joak-pet@online.no>
 <20220602145935.10512-1-joak-pet@online.no> <xmqqilpiistk.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqqilpiistk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 00:49, Junio C Hamano wrote:
> Joakim Petersen <joak-pet@online.no> writes:
> 
>> Range-diff against v1:
>> 1:  e235caa7a8 = 1:  e235caa7a8 git-prompt: make colourization consistent
>>
>>   contrib/completion/git-prompt.sh | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>> index 87b2b916c0..dfd6cef35f 100644
>> --- a/contrib/completion/git-prompt.sh
>> +++ b/contrib/completion/git-prompt.sh
>> @@ -286,6 +286,7 @@ __git_ps1_colorize_gitstring ()
>>   	if [ -n "$u" ]; then
>>   		u="$bad_color$u"
>>   	fi
>> +	p="$c_clear$p"
>>   	r="$c_clear$r"
>>   }
> 
> Has this been tested?
> 
> It seems to break a handful of tests in t9903 for me.
> 

Oh, no I hadn't run the test suite, sorry. I must've gotten too caught
up in other parts of the submitting process and simply forgot to run
them. After looking into it, the reason why the tests fail is that $p is
no longer empty when it is not set, so $f is no longer empty, leading to 
both $z and $p being inserted into $gitstring. This causes there to be
three clear-colour sequences in the final output instead of the expected
one. Wrapping the clearing of $p's colour in a check for emptiness like
the other short state indicators fixes the tests. I'll submit a v3
shortly.
