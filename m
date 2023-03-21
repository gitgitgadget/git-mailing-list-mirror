Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA54C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 19:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCUTVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUTVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 15:21:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6984DBD8
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:20:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so5271910wmq.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679426444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhke8L9DPEfG1i/Yp8cFbv3mW9j135AF7Yywzzqj+7o=;
        b=EDdLGk4nrtt65WCHKaHGfvFymueLK4clMMpNZ55nswGKYM7Y/Yp5HWpayycBE+Tmgp
         kkkqpdZq8cQ3dwA9957wimT71smCBTcsoj/OVeyf+Pmky4UtBUCQDEDEUoDqGuzRB6Da
         2vpE81Sv2UX0AgU2M96G5MffKe7sx7SQ4sC4pDaEcCqCcR3VjnDBwuepGDPXFCN0KKmV
         NwTseiAHx+1pUVWL501JlaRkzTObFFbmppJTHdELw+5Y5N/Ll7b2ye9Nt8IBHWnUg2Cb
         jLHOqLLgyi2AsCseq1qS75fuhXXIZRy9kSkHu9UMCV2p9Pnlss1P7kqvfAKBwCGtcHJR
         rbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhke8L9DPEfG1i/Yp8cFbv3mW9j135AF7Yywzzqj+7o=;
        b=FxfS8sOsbgRXZT4nQTSMpkgnCrtDSAIflZTxMLqxV652+dRcm+nVsq/l9EtAoknzsk
         cYo8mdFCS3qAd0pPBuHrYbcIOaaBgaggdokhXMnPjBWxM3ULDWdUFcvOci366D0452hm
         xA+VgwnoP0AFKsnnhxnzyTWKbebY8c1mZU/jPIK8rZCjEA5d+O893Xb42iNT0RJi4/Uj
         Xp5bPEDPXBH8OMtNrn96nBiQ7AIQdbMoWikTeufn4XodCuiNVqDku7njbCUrpyvKm9XX
         Z1+Wr0Os/GlI3nFRGKvbk7bb+ity+OSLmLUru56a5eopepWOvsUOqwkyfkNUwPK9izAw
         gC9Q==
X-Gm-Message-State: AO0yUKWPqULXDbFc13pO39VsP5lw6UbDgKRpfe1Q+VzK+n1Ch1m1I3J3
        wYhXJ43UZBVpc6C9Q+Ba+u9avA==
X-Google-Smtp-Source: AK7set8G2nyLF3A9HTKMc21SvjmWJ2FUg60m9M9P6KCwdWpk5KLNuygU2WH4DWsZfG/TwPbfixdNYQ==
X-Received: by 2002:a7b:c4d5:0:b0:3ed:aa63:43b5 with SMTP id g21-20020a7bc4d5000000b003edaa6343b5mr3184726wmk.32.1679426444072;
        Tue, 21 Mar 2023 12:20:44 -0700 (PDT)
Received: from ?IPV6:2003:f6:af34:4e00:6429:c3:675c:eafb? (p200300f6af344e00642900c3675ceafb.dip0.t-ipconnect.de. [2003:f6:af34:4e00:6429:c3:675c:eafb])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c3acf00b003ede2c59a54sm8239027wms.37.2023.03.21.12.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:20:43 -0700 (PDT)
Message-ID: <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net>
Date:   Tue, 21 Mar 2023 20:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Suspected git grep regression in git 2.40.0
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>,
        Stephane Odul <stephane@clumio.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
 <xmqqttyejc7y.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqqttyejc7y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21.03.23 17:33, Junio C Hamano wrote:
> [jc: on the CC: line, summoned a few people who may know a lot more
> about pcre than I do]
> 
> Stephane Odul <stephane@clumio.com> writes:
> 
>> We have a CI pipeline on a private repository that started failing
>> consistently while running `git grep -P` commands. The command
>> fails with an exit code of -11 and is failing pretty
>> consistently. With prior versions of git there is no issue
>> whatsoever, but with 2.40.0 it always fails on the same
>> call. Other git grep calls are fine, but that one is failing
>> consistently.
>>
>> I was not able to reproduce locally but my main machine is an M1
>> MacBook Pro, the CI pipeline runs under Kubernetes in AWS and the
>> container is based on Ubuntu 20.04 with the git client installed
>> via the PPA.
>>
>> The error is for this pattern `git grep -cP '^\w+ = json.load'`.
>>
>> As a workaround we tried to download and install the microsoft-git
>> v2.39.2 deb package since it allows us to downgrade, but then the
>> git grep commands just got stuck.
> 
> One "grep -P" related change we had recently between 2.39 and 2.40
> was
> 
>     50b6ad55 (grep: fall back to interpreter if JIT memory
>     allocation fails, 2023-01-31)
> 
> The code tries to figure out at runtime if pcre engine has
> functioning JIT by making an extra JIT compilation of a sample
> pattern and when it fails with a specific reason, fall back to
> interpreted pattern matching.  The change made the code to emit a
> bit more detailed information when it fails, but a controlled exit
> from the codepath should give $?=128, not 11.
> 
> So the above commit may or may not be related.  It could be that the
> version of pcre library linked to Git 2.40 and older Git you are
> running in your CI environment has been updated.

I don't think it's that commit. I just tried the pattern here on a system that
would require the interpreter fallback and one that wouldn't and both didn't
error out (Debian bookworm/sid; libpcre2-8: 10.42-1).

Looking at the history, though, another commit stands out:

  $ git log --oneline --no-merges v2.39.0..v2.40.0 -- grep.c
  fb2ebe72a374 grep API: plug memory leaks by freeing "header_list"
  891c9965fbc0 grep.c: refactor free_grep_patterns()
  50b6ad55b04d grep: fall back to interpreter if JIT memory allocation fails
  acabd2048ee0 grep: correctly identify utf-8 characters with \{b,w} in -P

Commit acabd2048ee0 suspiciously matches the pattern with its "\w" mention.
Looking at the diff gives:

        if (!opt->ignore_locale && is_utf8_locale() && !literal)
-               options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
+               options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);


So maybe the PCRE2_UCP option isn't supported by the system in question or it
forces PCRE2 to do a verification it didn't do before?

The exit code of -11 could relate to PCRE2's error PCRE2_ERROR_UTF8_ERR9 (-11)
strengthening the suspicion it's related to that change. It's described as:

  PCRE2_ERROR_UTF8_ERR9   5th-byte's two top bits are not 0x80

Maybe the input data isn't valid UTF-8 encoded?

Stephane, can you pin point the file that the grep is failing on and verify it
is indeed a valid UFT-8 encoded file via:

  $ iconv -f UTF-8 your_file > /dev/null && echo OK || echo "Not valid"

If this prints "OK", we need to investigate further. However, if it prints
"Not valid", a broken file encoding is probably the cause and we should
revisit the above change and think of alternatives, as this might be seen as
a regression (even though the file isn't strictly valid UTF-8).

Thanks,
Mathias

> 
> Does it make a difference if you disable JIT by prefixing the
> pattern with (*NO_JIT)?
> 
> Thanks.
