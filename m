Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F393C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C4560FE7
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhHFTIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhHFTIW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:08:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3773C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 12:08:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so8297093plr.12
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W+C4pVgnVcdUXH8kF7YQYCwK0f7qoxtVREIwpL4eE1c=;
        b=I3DpeZJcYkvFHLV4O4d1FUbAQWSLswRFLIgWv0HVkwImgx7D79YZw0H8FAoiJnIF8X
         Fqj9PKkzdp9ehy7fUA0Studf2twRnv9NoBGM69jLNVRfk7DVBAuFq3FRkp/OTogWhJ5f
         ln/tTVtIx7hTN3MznLTPr5Vhn0D5VMm3BxyOoX2ye0afF3dpV4AlGqOADGozb9eSo8qR
         5oAXOXsjSbZqLSLtwMRS9+RbImNSKSDPDN3KfkzDCGUQWdsW6u8KdIOkmDb/DLYcZRK7
         e/j+QVv/8OqiTdphHnRQZN1pwId12CPQ+KA4/eCJooorZmRlCHvf6+cU1U1gLwQTQ5ig
         +nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+C4pVgnVcdUXH8kF7YQYCwK0f7qoxtVREIwpL4eE1c=;
        b=T3Zk5UXLZotG8twE9weeE2ejsbRnFdXm5f2Wb9SppIbX/nzzxPXRD+eO+yK+FjAF84
         z99r+BqEMUqQQ2fLnRTJL4aMExctwsOJ7efMSUUMv1t1Zi88xsrjLsGOU4Skq6e1S6uP
         t9EkQY3HWh3XNH72iScH9y+2RMjj/J7HOUHFB55bjzHiM7wN2vaSN7KK5Uq4mbHMKYKo
         87QTTFQVMYxrU+ixf4Me3p5WETF0gSsvp7698OW/jTxs5etff+h1OFo0ThNjr7gYUlWB
         3G+5JTY++je86AAZrxGPFuykJ8gNo+XdotVgDB+ZFpuJj6wOrMo9QueyyEps370UdS8G
         Fdvw==
X-Gm-Message-State: AOAM530ROkxuTxXvzGiQqahvl1laMyczyEoxaMLNREFdPQOQvqhKSnP1
        KPhSWpJE0nRAGDGE4UWdD4I=
X-Google-Smtp-Source: ABdhPJwZcGSbh0V/a6V8b3tg2AKu3zZLuhI4EgkB5HdlEFjUgkZtvVywYcFraskm4g8udrKXoSFp+w==
X-Received: by 2002:a65:6708:: with SMTP id u8mr2963367pgf.334.1628276885331;
        Fri, 06 Aug 2021 12:08:05 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.189.105])
        by smtp.gmail.com with ESMTPSA id w9sm11241729pfg.151.2021.08.06.12.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 12:08:05 -0700 (PDT)
Subject: Re: [PATCH] submodule--helper: fix incorrect newlines in an error
 message
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
References: <20210710074801.19917-5-raykar.ath@gmail.com>
 <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
 <m28s1fuluy.fsf@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1f7c1d28-4482-b6db-17f0-edbc6934acda@gmail.com>
Date:   Sat, 7 Aug 2021 00:37:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <m28s1fuluy.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08/21 11:59 am, Atharva Raykar wrote:
> 
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> A refactoring[1] done as part of the recent conversion of
>> 'git submodule add' to builtin, changed the error message
>> shown when a Git directory already exists locally for a submodule
>> name. Before the refactoring, the error used to appear like so:
>>
>> [...]
>>
>> As one could observe the remote information is printed along with the
>> first line rather than on its own line. Also, there's an additional
>> newline following output.
>>
>> Make the error message consistent with the error message that used to be
>> printed before the refactoring.
> 
> Thanks for catching this and sending a patch!
> 
>> [1]: https://lore.kernel.org/git/20210710074801.19917-5-raykar.ath@gmail.com/#t
>>
>> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> ---
>>
>> Even with this patch, the error message is still not fully consistent with the one that
>> used to be printed before the refactoring. Here's the diff:
>>
>> 3c3
>> < If you want to reuse this local git directory instead of cloning again from
>> ---
>>> fatal: If you want to reuse this local git directory instead of cloning again from
>> 6c6
>> < or you are unsure what this means choose another name with the '--name' option.
>> ---
>>> or if you are unsure what this means, choose another name with the '--name' option.
>>
>>
>> The first part shows that it is additionally prefixed with 'fatal: '. While the 'fatal :' prefix
>> made sense in other cases, I wonder if it's helpful in this case as the message being
>> printed is an informative one. Should we avoid using 'die' to print this message?
> 
> I had initially implemented that message as an fprintf() with return for
> the same reason, but Junio suggested we die() instead to keep the
> conversion more faithful to the original [1].
> 
> Although now that I think of it, it feels like a tradeoff between
> faithfulness to the original code and faithfulness to the original
> behaviour. I also think this change is fairly inconsequential and easily
> reversible so I am fine with it being done either way.
> 
> [1] https://lore.kernel.org/git/xmqqk0n03k84.fsf@gitster.g/
> 

I remember this discussion. But ...

   A git directory for 'subm' is found locally with remote(s):
      origin        /me/git-repos-for-test/sub
   fatal: If you want to reuse this local git directory instead of cloning again from
     /me/git-repos-for-test/sub
   use the '--force' option. If the local git directory is not the correct repo
   or you are unsure what this means choose another name with the '--name' option.

... I'm not able to understand how the 'fatal: ' prefix in the _middle_ of this
information message would help the reader in any way :-/

If it had occurred at the beginning of the message that would've been different
and likely useful too. I'll try sending a re-roll with a new change that moves
the fatal to the beginning of the message and see how it goes.

>> The second part of the diff shows that there's some small grammatcial tweaks in the last
>> line. While I appreciate the intention, I'm not very sure if this change is a strict
>> improvement. I wonder about this as the original sounded good enough to me and thus it
>> feels like the change in message is triggering unnecesssary translation work. Should
>> we avoid the change? Or does it actually seem like an improvement to the message?
> 
> I don't think that extra 'if' was intended. I think it's better to avoid
> the change I inadvertently introduced.
> 

I guess I spoke too soon. Regardless of the additional "... if ..." in the message,
the conversion might introduce translation work as the variable substitution varies
between shell and C. There isn't much we could do about this. I'm not sure if
translators use any strategy to avoid redundant work during conversions like these.
Jiang Xin (Cc-ed) might be able to shed some light.

That said, I'll still revert the extra 'if' as you say it was introduced inadvertently.

-- 
Sivaraam
