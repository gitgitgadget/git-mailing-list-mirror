Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D294FC43461
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EE761154
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhDGUxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhDGUxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:53:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B9C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 13:53:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so140833otb.7
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39IIcwxN3axjHErA2mOeSnila3jyITRxhbrA4RCEOhU=;
        b=HKc1kDqvPctWUWQIZOgmTNo97iGsp2RS7M62dCMjhZp+7nPtHJmbB3PeklpvDWK8af
         MBo1lVrT6EM44C760CQUGZp2fckMlnWdgD80tP+DH/j1JAfnS8xwFsO/d8lYvysoIRgv
         zXU3rYLS4SGeXEfF8CzL10WJ+eLLkY6S830UhARfsTRbqjVesj6jZ6vP2bfM3IQNPhW/
         ZeozU8smwJH6wSdjnc4EedhfqMGKo07hKrQMYiC9LaNw1i3QH7LfkSUmlQ9gPcMotSfO
         knomMWGamC6eofgp492A/myX22I0gGe0Whyqq1bvCrUWwyTnPs0aqensVvNhKTziHaUf
         eoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39IIcwxN3axjHErA2mOeSnila3jyITRxhbrA4RCEOhU=;
        b=ryHbVSgspOmSUzLPcMRs8mOqbt8/EBnuIdzBY7EgXHtNDUWhUIAbm0QkhK+VjnsCJz
         7hLQUsoQbD4+JMEhIhZHVz1zKeplw9F4Rtvpybyzvqkdl9AYzvX/465pYBZKAEnT6r1I
         b9q0HLSZFxTLyNLgkj1a5de7Babt/2MyvLJAN2U8g+sAOf3AL8dRbneh76hJeSvv3Poc
         3CaSxqeqj7+pNZIR20TbTt2t1a+Mj0aliv5ve62V4jy9tdjue9O2CT3ia9j6w4JznID7
         4nZFsUS7Lx1yfDx1tTAYScB4UUgN4vyy03ovlocMs92e6dtNa1F0BB75QCESBfc/5D9U
         /dbg==
X-Gm-Message-State: AOAM532kj3zFXrL7ZMl7jEKMS05Erre9RN3QsoAgyKSaDtCjrOsnb33/
        oLtAK/jEOCVpmKGccRZQbA9VmvDOOASyag==
X-Google-Smtp-Source: ABdhPJwGGTo+7bPKynhuGK3n0zX04SbS+qcqVPkeloIbRX9tubVhkOQh/5A1Tdg+S4FzmfcT+6K67A==
X-Received: by 2002:a9d:6e11:: with SMTP id e17mr4479358otr.222.1617828792902;
        Wed, 07 Apr 2021 13:53:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f1c4:b701:47c1:603f? ([2600:1700:e72:80a0:f1c4:b701:47c1:603f])
        by smtp.gmail.com with ESMTPSA id v65sm4580747oib.42.2021.04.07.13.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 13:53:11 -0700 (PDT)
Subject: Re: [PATCH 3/5] refspec: output a refspec item
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
 <87r1jmjxdg.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b3e00d3e-c782-9f2a-14e0-f576e50a7e55@gmail.com>
Date:   Wed, 7 Apr 2021 16:53:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87r1jmjxdg.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2021 4:46 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:
>> +	return buf.buf;
> 
> There's a downthread discussion about the strbuf usage here so that's
> covered.

And it's fixed in v2.

> But I'm still confused about the need for this function and the
> following two patches. If we apply this on top of your series:
>     
>     diff --git a/t/helper/test-refspec.c b/t/helper/test-refspec.c
>     index 08cf441a0a0..9e099e43ebf 100644
>     --- a/t/helper/test-refspec.c
>     +++ b/t/helper/test-refspec.c
>     @@ -31,7 +31,7 @@ int cmd__refspec(int argc, const char **argv)
>                             continue;
>                     }
>     
>     -               printf("%s\n", refspec_item_format(&rsi));
>     +               puts(line.buf);
>                     refspec_item_clear(&rsi);
>             }
> 
> The only failing test is:
>     
>     + diff -u expect output
>     --- expect      2021-04-07 08:12:05.577598038 +0000
>     +++ output      2021-04-07 08:12:05.577598038 +0000
>     @@ -11,5 +11,5 @@
>      refs/heads*/for-linus:refs/remotes/mine/*
>      2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
>      HEAD
>     -HEAD
>     +@
>      :

It should be obvious that taking refspecs as input, parsing them,
then reformatting them for output should be almost equivalent to
printing the input line.

The point is to exercise the logic that actually formats the
refspec for output. The test-tool clearly does this.

The logic for converting a 'struct refspec_item' to a string is
non-trivial and worth testing. I don't understand why you are
concerned that the black-box of the test-tool could be done
more easily to "trick" the test script.

> So the purpose of this new API is that we don't want to make the
> assumption that strrchr(buf, ':') is a safe way to find the delimiter in
> the refspec, or is there some case where we grok "HEAD" but not "@"
> that's buggy, but not tested for in this series?

The purpose is to allow us to modify a 'struct refspec_item' andproduce a refspec string instead of munging a refspec string
directly.

Thanks,
-Stolee
 
