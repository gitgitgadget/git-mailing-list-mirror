Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ADDC433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA824611EE
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 22:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhDCWlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbhDCWlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 18:41:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5612CC061756
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 15:41:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y2so6041350qtw.13
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BUoyRR1qpEZXacevGBAA4CXHhrKFK25zlK979atazVU=;
        b=vAZbxDNUW2gbk309pWkFPZl4WLoTys+N2C0OJpv+R1zK2LRHLzKS24WHkvtjnlFLWI
         77cYhv1Uzg0HV7eNB8/aywOT8rJEsaAi4dktSz3FDUbW20iQ9h16R4i7VIlGiXgMZXrB
         AU/GDXX2mYTsCr0zv89SN5PqFHd3lVzqd4b30ICnAloaTn7fe9BJ7dAgZZjl9d/3NkCb
         moiXLtSSoY40heqd+I13/4b+BBLAfFCR+l05lphxrk4z9ogXWRA3RUpeyDuIKzZrVsfc
         f6kyJ31E32k+1igk8PhBLriFn2Z7bjRBy98BvZj3gbdkQLHXZZcCs0j83KE8YAV8khcV
         N5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BUoyRR1qpEZXacevGBAA4CXHhrKFK25zlK979atazVU=;
        b=Q78TBhvuzcJgfElBthF1gYI6RVDin+VJnpdRo0xR0KKrd0gVZaOIx+ibD5G/l4yLXk
         xR386+q3wEaZq8iHhbtEfHpq3JRpcWWHFkdpt4q1gEBmSb3mrakInNtsxEU5P/LvK6An
         wdlGcQLF5F/C8ejOtunapnC6ZlnYaEWeMbwiDxdihIhoMpSlwsKHO2CXKNlTt5PFvvDQ
         Ffxxfrqdyu/l3pTbZvaXdvteZZFYNEnd4r2RthnqYAs2wRe8tUVS6j68RCZYtz7pu1Q4
         NkVigHyUIkBjfEwAmbTqNKTLwtIfVYJjpSokS/Nvk7Ke2FRtyYY6U/+7ODZHuB94ZTqp
         RmeQ==
X-Gm-Message-State: AOAM530NDqj9wzQCSm4rYXzJ5dEPPOxlgF+iPzKFX+8SWx9aT5WAYZ+o
        IBtq/M4nmWeSTTQY1RZCTSr9xMoNSoKESQ==
X-Google-Smtp-Source: ABdhPJylBScfK1M7CZCJXBZy/U46oP6n911btk33Jur4MaT+Vfd+GwjocknI1D/MZni4c8ZXJKeHJg==
X-Received: by 2002:ac8:5e8a:: with SMTP id r10mr17340848qtx.13.1617489671159;
        Sat, 03 Apr 2021 15:41:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:856d:2d1e:ab38:1383? ([2600:1700:e72:80a0:856d:2d1e:ab38:1383])
        by smtp.gmail.com with ESMTPSA id b198sm10318227qkg.10.2021.04.03.15.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 15:41:10 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Tom Saeger <tom.saeger@oracle.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
 <CAPig+cRxjLObLvF9kUAuftCxQ+iiFEisagDBWpAAPwdVMUATKQ@mail.gmail.com>
 <20210403202142.w4b25fhptcaguxyx@brm-x62-17.us.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ce278cd-5faa-c3fc-d2cf-6ee99259b21f@gmail.com>
Date:   Sat, 3 Apr 2021 18:41:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210403202142.w4b25fhptcaguxyx@brm-x62-17.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2021 4:21 PM, Tom Saeger wrote:
> On Fri, Apr 02, 2021 at 06:32:56PM -0400, Eric Sunshine wrote:
>> On Fri, Apr 2, 2021 at 4:43 PM Derrick Stolee <stolee@gmail.com> wrote:
>>> I have a branch available [1], but I'm seeing some failures only
>>> on FreeBSD [2] and I can't understand why that platform is failing
>>> this test. The current version (as of this writing) does not do
>>> the substring replacement technique, and hence it just gives up
>>> on exact matches. I will try the substring approach as an
>>> alternative and see where that gets me.
>>>
>>> [1] https://github.com/gitgitgadget/git/pull/924
>>> [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534
>>
>> The "+" in patterns such as `+refs/heads/\\*:refs/prefetch...` is what
>> is throwing it off. FreeBSD `grep` doesn't seem to like it, though
>> it's not clear why. Escaping it the same way as you escaped "*"
>> doesn't make it work. Replacing "+" with catchall "." does work, so
>> that's one way to fix it.
>>
>> However, all the escaping you need to do in these refspec patterns to
>> pass them to `grep` is ugly. A much better solution may be to change
>> the `grep` in test-lib-functions.sh:test_subcommand() to `grep -F` to
>> force it to match literally. That way, you can drop all the backslash
>> escaping, including those in front of "[" and "]". A cursory audit of
>> callers test_subcommand() seems to indicate that none of them pass
>> regex patterns, so using `-F` is probably safe and a good idea.

Yes, this is an excellent idea. Thanks.

>> By the way, the `coccinelle` check is also "failing", correctly
>> suggesting that you change:
>>
>>     strbuf_addf(&replace, ":refs/prefetch/");
>>
>> to:
>>
>>     strbuf_addstr(&replace, ":refs/prefetch/");
>>
>> in `builtin/gc.c`.

Good point! I'll get that, too.

> Was curious - so rolled all Eric's feedback into a patch.
> 
> This passes 'make test' and 'make coccicheck' locally, not sure about FreeBSD.
> 
> Stolee - can you squash this onto your PR and try it if you agree?

I made my own version of a patch before seeing this one, but
thanks for working on it.
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 6348e8d7339c..e9a1cf3e227a 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1652,9 +1652,9 @@ test_subcommand () {
>  
>  	if test -n "$negate"
>  	then
> -		! grep "\[$expr\]"
> +		! grep -F "$expr"
>  	else
> -		grep "\[$expr\]"
> +		grep -F "$expr"
>  	fi

Specifically I would use "[$expr]" here so it includes the
terminating characters of the JSON array that we are testing
against. It can be important that we have the complete set
of arguments, so these brackets are important.

Thanks, all. I'm taking a look at a mechanism for doing this
without munging the raw string directly, as Junio mentioned.
It might require adding an output format method in the refspec
API, but that's probably a good thing, anyway.

Thanks,
-Stolee
