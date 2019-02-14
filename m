Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B605E1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 16:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfBNQMW (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 11:12:22 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:27170 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfBNQMW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 11:12:22 -0500
Received: from [192.168.2.240] ([92.22.15.194])
        by smtp.talktalk.net with SMTP
        id uJcXgxaTTpXFjuJcYga21S; Thu, 14 Feb 2019 16:12:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550160739;
        bh=Mc88dUPX50+aVQW+9UHSyGAUKlIFtkxojKNJMVkZuXs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Py9vEffwcjIMdGV3jLrohRtaudBI5jAMB7Jshyq3cY4g7nJoO4t/pSeOP1EVK8Rv1
         7DDTYPGcH7gDHz1keujqRTt6Wkqd7bRAj0Xb9MDW5O6A1joeWU46WMyxtpouzZCLro
         eKLuvO7JtEz8jJdSIuiFz4YykG92FosP06iLZNVk=
X-Originating-IP: [92.22.15.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=SbQTfhO/oL0pg4h8lvBCaA==:117
 a=SbQTfhO/oL0pg4h8lvBCaA==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=vZxbLtyPAAAA:8 a=pGLkceISAAAA:8 a=2-v5lajo2_cr_fTPPGoA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=YIznc7gRMHvxYRuyG5Sm:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: fix regression in rebase.useBuiltin=false test
 mode
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqva1nbeno.fsf@gitster-ct.c.googlers.com>
 <20190213214908.9459-1-avarab@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <af4ce5d4-a788-25a6-0372-13206b161101@talktalk.net>
Date:   Thu, 14 Feb 2019 16:12:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213214908.9459-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKMfgKSapFSROq+ERAI9HmEh69s+6hWgL32356nn8piAtvn7C7n99xN+bXbV2hankS+cuCJb+8UWIiKyRwoNQfj2+x8pNso3ANL7eAyCKQ+FhmPF/pnA
 3QNgtITEMPsK8DpPzDU0G6fdtvjyIba6iXazhkpCL9Ld+LD6pHlcQAUBx1k/sPzrHqCYInsNK5lFKuBsaaKgLpHWdq27dAFkUr9IKrr31asejWM9Dgex4Cq3
 b4JwcVwwGczqJOAQsAVQz0yAIzyXCN4phTlHFV8R3T4mcw0w5ynSeXjTYpcKMSe8sYqcdv40c03Dibb5ewSltg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 13/02/2019 21:49, Ævar Arnfjörð Bjarmason wrote:
> Fix a recently introduced regression in c762aada1a ("rebase -x: sanity
> check command", 2019-01-29) triggered when running the tests with
> GIT_TEST_REBASE_USE_BUILTIN=false. See 62c23938fa ("tests: add a
> special setup where rebase.useBuiltin is off", 2018-11-14) for how
> that test mode works.
> 
> As discussed on-list[1] it's not worth it to implement the sanity
> check in the legacy rebase code, we plan to remove it after the 2.21
> release. So let's do the bare minimum to make the tests pass under the
> GIT_TEST_REBASE_USE_BUILTIN=false special setup.
> 
> 1. https://public-inbox.org/git/xmqqva1nbeno.fsf@gitster-ct.c.googlers.com/
> 

Thanks for doing this, when I wrote the original patch I decided it wasn't
worth updating the legacy rebase but forgot about running the tests with
rebase.useBuiltin off.

Best Wishes

Phillip


> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Wed, Feb 13 2019, Junio C Hamano wrote:
>    
>> [...]
>> It would however be long enough to declare victory _immediately
>> after_ the upcoming release and start the next cycle without the
>> escape hatch.  At that point we'd be committed to maintain only the
>> built-in version.
>>
>> The more important every-day features should still be covered by
>> tests, if the scripted ones are to be kept as escape hatch.  So to
>> me #1 looks like the only sensible choice at this point, if you want
>> to see a test cycle with USE_BUILTIN=false to fully pass (i.e. by
>> skipping the ones that are known not to pass).
> 
> Let's do this for 2.21 then and I'll re-submit the legacy removal
> patch after we start 2.22.
> 
>   t/t3404-rebase-interactive.sh | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 52fa41c707..b60b11f9f2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -149,10 +149,12 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>   
>   test_expect_success 'rebase -x with empty command fails' '
>   	test_when_finished "git rebase --abort ||:" &&
> -	test_must_fail git rebase -x "" @ 2>actual &&
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> +		git rebase -x "" @ 2>actual &&
>   	test_write_lines "error: empty exec command" >expected &&
>   	test_i18ncmp expected actual &&
> -	test_must_fail git rebase -x " " @ 2>actual &&
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> +		git rebase -x " " @ 2>actual &&
>   	test_i18ncmp expected actual
>   '
>   
> @@ -160,7 +162,8 @@ LF='
>   '
>   test_expect_success 'rebase -x with newline in command fails' '
>   	test_when_finished "git rebase --abort ||:" &&
> -	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> +		git rebase -x "a${LF}b" @ 2>actual &&
>   	test_write_lines "error: exec commands cannot contain newlines" \
>   			 >expected &&
>   	test_i18ncmp expected actual
> 

