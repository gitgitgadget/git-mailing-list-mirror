Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BDC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 18:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbhK3Sla (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 13:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbhK3Sl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 13:41:29 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9001C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 10:38:09 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 193so27870042qkh.10
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 10:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fyTmvTSLXerM4vPvUcOE0TDhdTbV0QmsH+P19kTy18o=;
        b=II9tZwLlIy8J3qhUOQ4e8LpvW6sHJGDUj8RY4+cZH47aed+hz0hJ/fv44vEsDkCH7Y
         6kwrr/JxgputINOm/blDV363LJ6MDJXTcEzK3ELPrvRmmOiA6IwF1xZFO7pZRXeimf0q
         mPOmoIXrlMc+B+zSfIMdV9fiNKJ6O2tO5kWyc1bF4dSOvT7DbG/JpCEwm5H1XH/A9cE6
         AwUOFkdsBkEdMb5fipzEvBr4SRb11HQbyix8GDtVN9Uwx1vqPn+gIXTsUbQ7ljjRlY0A
         21DUN2NJn306DqhbyGjSHScmwwMaFSvM5AvKQt1NXjb4WUkMWizpmt8OZ2etbFRcvouw
         VGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fyTmvTSLXerM4vPvUcOE0TDhdTbV0QmsH+P19kTy18o=;
        b=tcjAWth7YVzXlqOl14dk04c64ZGot7IQPKU81xpylIpHLQDHpglYjBuo5GMibgR4Au
         WwsXRSgBxJmiRE/iwvirx2VITZ3Y69D4uIjMy04h4OaRuetA2vO+NkJJOkAQSQWPUxyu
         DII8uOHSaVavi+LqB1FdM7T08WkGCtd+Q+wfOFjwE48uPwd8kWfFLyQPe/i0x2rDP3TH
         EeXK4sO3pSnsnz/RwieN6wGuB/Bq19VKFiNJfFvRA/F2pB7MX00XQ/yRcigPmjWz88Y+
         pkPrccQPXxRSxHnAizI7MXEaGMGaMkqVb4UD0x5zuTcUpZpkV+Vzy4/FoJJB9O3apuoQ
         2Syg==
X-Gm-Message-State: AOAM530fJZy9lq786YXj/el1tKiZTjSdkV6aht45NwYW02hAmymAUHgl
        OlRcpsFPmR0TcBQGLlOLoHM=
X-Google-Smtp-Source: ABdhPJzkJt4oWoSS87I6BMANow4PKW7E8JNgWKbGyJMZOSxTU2R6CKyE9f1wHGU1yRt3cElm2gq9PA==
X-Received: by 2002:a05:620a:4502:: with SMTP id t2mr1157363qkp.193.1638297488998;
        Tue, 30 Nov 2021 10:38:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecc1:c98a:cda5:6f9d? ([2600:1700:e72:80a0:ecc1:c98a:cda5:6f9d])
        by smtp.gmail.com with ESMTPSA id x15sm8602135qko.82.2021.11.30.10.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 10:38:08 -0800 (PST)
Message-ID: <446c3677-140f-3033-138f-1ef9b1f546a5@gmail.com>
Date:   Tue, 30 Nov 2021 13:38:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <20211122033220.32883-6-chiyutianyi@gmail.com>
 <8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com>
 <CAO0brD0oPHMwGNQXpC2XVhU=fY7XrrtBeu-x8GmJndeVptJaBg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAO0brD0oPHMwGNQXpC2XVhU=fY7XrrtBeu-x8GmJndeVptJaBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30/2021 8:49 AM, Han Xin wrote:
> On Tue, Nov 30, 2021 at 1:37 AM Derrick Stolee <stolee@gmail.com> wrote:
>> $ hyperfine \
>>         --prepare 'rm -rf dest.git && git init --bare dest.git' \
>>         -n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <big.pack' \
>>         -n 'new' '~/_git/git/git -C dest.git unpack-objects <big.pack' \
>>         -n 'new (small threshold)' '~/_git/git/git -c core.bigfilethreshold=64k -C dest.git unpack-objects <big.pack'
>>
>> Benchmark 1: old
>>   Time (mean ± σ):     20.835 s ±  0.058 s    [User: 14.510 s, System: 6.284 s]
>>   Range (min … max):   20.741 s … 20.909 s    10 runs
>>
>> Benchmark 2: new
>>   Time (mean ± σ):     26.515 s ±  0.072 s    [User: 19.783 s, System: 6.696 s]
>>   Range (min … max):   26.419 s … 26.611 s    10 runs
>>
>> Benchmark 3: new (small threshold)
>>   Time (mean ± σ):     26.523 s ±  0.101 s    [User: 19.805 s, System: 6.680 s]
>>   Range (min … max):   26.416 s … 26.739 s    10 runs
>>
>> Summary
>>   'old' ran
>>     1.27 ± 0.00 times faster than 'new'
>>     1.27 ± 0.01 times faster than 'new (small threshold)'
>>
>> (Here, 'old' is testing a compiled version of the latest 'master'
>> branch, while 'new' has your patches applied on top.)
>>
>> Notice from this example I had a pack with many small objects (mostly
>> commits and trees) and I see that this change introduces significant
>> overhead to this case.
>>
>> It would be nice to understand this overhead and fix it before taking
>> this change any further.
>>
>> Thanks,
>> -Stolee
> 
> Can you show me the specific information of the repository you
> tested, so that I can analyze it further.

I used a pack-file from an internal repo. It happened to be using
partial clone, so here is a repro with the git/git repository
after cloning this way:

$ git clone --no-checkout --filter=blob:none https://github.com/git/git

(copy the large .pack from git/.git/objects/pack/ to big.pack)

$ hyperfine \
	--prepare 'rm -rf dest.git && git init --bare dest.git' \
	-n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <big.pack' \
	-n 'new' '~/_git/git/git -C dest.git unpack-objects <big.pack' \
	-n 'new (small threshold)' '~/_git/git/git -c core.bigfilethreshold=64k -C dest.git unpack-objects <big.pack'

Benchmark 1: old
  Time (mean ± σ):     82.748 s ±  0.445 s    [User: 50.512 s, System: 32.049 s]
  Range (min … max):   82.042 s … 83.587 s    10 runs
 
Benchmark 2: new
  Time (mean ± σ):     101.644 s ±  0.524 s    [User: 67.470 s, System: 34.047 s]
  Range (min … max):   100.866 s … 102.633 s    10 runs
 
Benchmark 3: new (small threshold)
  Time (mean ± σ):     101.093 s ±  0.269 s    [User: 67.404 s, System: 33.559 s]
  Range (min … max):   100.639 s … 101.375 s    10 runs
 
Summary
  'old' ran
    1.22 ± 0.01 times faster than 'new (small threshold)'
    1.23 ± 0.01 times faster than 'new'

I'm also able to repro this with a smaller repo (microsoft/scalar)
so the tests complete much faster:

$ hyperfine \
        --prepare 'rm -rf dest.git && git init --bare dest.git' \
        -n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <small.pack' \
        -n 'new' '~/_git/git/git -C dest.git unpack-objects <small.pack' \
        -n 'new (small threshold)' '~/_git/git/git -c core.bigfilethreshold=64k -C dest.git unpack-objects <small.pack'

Benchmark 1: old
  Time (mean ± σ):      3.295 s ±  0.023 s    [User: 1.063 s, System: 2.228 s]
  Range (min … max):    3.269 s …  3.351 s    10 runs
 
Benchmark 2: new
  Time (mean ± σ):      3.592 s ±  0.105 s    [User: 1.261 s, System: 2.328 s]
  Range (min … max):    3.378 s …  3.679 s    10 runs
 
Benchmark 3: new (small threshold)
  Time (mean ± σ):      3.584 s ±  0.144 s    [User: 1.241 s, System: 2.339 s]
  Range (min … max):    3.359 s …  3.747 s    10 runs
 
Summary
  'old' ran
    1.09 ± 0.04 times faster than 'new (small threshold)'
    1.09 ± 0.03 times faster than 'new'

It's not the same relative overhead, but still significant.

These pack-files contain (mostly) small objects, no large blobs.
I know that's not the target of your efforts, but it would be
good to avoid a regression here.

Thanks,
-Stolee
