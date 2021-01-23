Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C10C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3B233EB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAWJdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 04:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbhAWJdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 04:33:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6AC06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 01:32:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so11075832ejf.11
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 01:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5ACVhY9r+X+lyKNqbMbJeZlZsiOwLEGObPo4YXtsWpU=;
        b=D8Cll8k+0gwmQvHzCF2pKH3PimdZNtTOdsdsUFXOa8xM7iaNKyLHfXvp8+xBROcHEa
         8pzgdvONOoG/LFk7f3gm+sZ9AVbWEtTQZzee07Jx63CJuUWoknnU+sCBaRB8gMjjzRuB
         rlBZhKQKitjKWC8yBHAIqshV1P47J8efDRqaV2yiqJMt+yA4A6o1ABDhWmuxnvUMSSl/
         koOgZBx1KbmV/00UZmXSxh/O5pWHt0e3ecx6TFP1bap6Yo4mVNaXIe9/2LxeGXGW7Hb/
         UAaLL56BSlWZAvd61u2cnc12W+5W7faVcMQnveJCI+ztR18yDKSi0VR/DPlmjEzBAKi8
         5nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5ACVhY9r+X+lyKNqbMbJeZlZsiOwLEGObPo4YXtsWpU=;
        b=WMw02cDjNr9aLS9RbGIB+mdy2TmhpszF3kDb5GXhAz74XnPTm0hcYXnLeG8UUTbDC4
         Huk2UcG0J3nL3Lz7b1TMBWiT7a0JShgv+ePhgQqv23pgaeA94s8Xkpy9665nW/vs594C
         dmcADqSBKRq+2jI8Syt1G5Aws0Ry1W/Z2nqyqApK5ihJH+GwnWCfOq0mLBcQPP14OzDk
         d9VF7ONNhXM0sCl7A1Y7GsfwM72WuVPrl0MOQM1qgpAv9zCnnPcdhlrzzRZIPkYXizhq
         GSFXx/RgAbIhKS5Now7Eyx1sXqBx++nbcHeUWJWYf20BPUBxOzQA8dF5idh1PNAub2xR
         PwYQ==
X-Gm-Message-State: AOAM531j4ooD/RYSeb0ocR1rgAlqUGKbXyu5R1e2kzEvMIt98xEtVn3f
        YJYSnP0gvmE+KVLF2wTIqYGSQZgOmBw=
X-Google-Smtp-Source: ABdhPJzgvx7Tw7/1n8vJCIWkTXS00cUCClpdymBL7nXmny4RO9bKb9+U1RFBdmxKXBQNVK3RxRIwuw==
X-Received: by 2002:a17:906:494c:: with SMTP id f12mr128519ejt.56.1611394376437;
        Sat, 23 Jan 2021 01:32:56 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id q9sm5778513ejd.113.2021.01.23.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 01:32:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/11] tests: add a "set -o pipefail" for a patched bash
References: <20210114233515.31298-1-avarab@gmail.com>
 <20210116153554.12604-12-avarab@gmail.com>
 <xmqq5z3o5n8c.fsf@gitster.c.googlers.com>
 <xmqq1rec5ckf.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <xmqq1rec5ckf.fsf@gitster.c.googlers.com>
Date:   Sat, 23 Jan 2021 10:32:55 +0100
Message-ID: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 23 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...
>> The above have already !MINGW
>>
>>> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
>>> index 4f7e62d05c..7b5d92add5 100755
>>> --- a/t/t3600-rm.sh
>>> +++ b/t/t3600-rm.sh
>>> @@ -251,7 +251,10 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
>>>  		i=$(( $i + 1 ))
>>>  	done | git update-index --index-info &&
>>>  	OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
>>> -	test_match_signal 13 "$OUT" &&
>>> +	if ! test_have_prereq BASH_SET_O_PIPEFAIL
>>> +	then
>>> +		test_match_signal 13 "$OUT"
>>> +	fi &&
>>>  	test_path_is_missing .git/index.lock
>>>  '
>>
>> but this one does not.  Yet, we've been using test_match_signal on 13
>> without issues, it appears.
>>
>> And somehow with the lazy prereq on SET_O_PIPEFAIL, this part starts
>> to break, like so:
>>
>>   https://github.com/git/git/runs/1752687552?check_suite_focus=true#step:7:37042
>>
>> The output captured in OUT is 0 as we can see on #37032 in the test
>> log.
>
> Nah, it seems that t3600-rm's "match signal 13" is already broken
> without O_PIPEFAIL patch on Windows.  For example:
>
> https://github.com/git/git/runs/1753231308?check_suite_focus=true#step:7:36912
>
> This was introduced by c15ffae5 (rm tests: actually test for SIGPIPE
> in SIGPIPE test, 2021-01-16) in the same series.

Yes, not adding !MINGW here is a stupid oversight on my part, I can
re-roll with that added, which seems to be like it'll work & be
better. I.e. we'll actually test for SIGPIPE ...(read on)....

> I am not sure "actually testing for SIGPIPE" is more important than
> "make sure 'git rm' choked should not die with cruft", so without
> thinking too deeply about the issue, my gut reaction is that
> reverting is better than using !MINGW as other tests.  That is, no
> matter how "git rm" gets killed, it should not leave .git/index.lock
> behind, and the original already tests that.

I don't get it. I understand why we'd do any of:

 1. Keep my patch with !MINGW added. I.e. the intent of your 0693f9ddad
    (Make sure lockfiles are unlocked when dying on SIGPIPE, 2008-12-18)
    which added the test is to explicitly stress SIGPIPE, but we never
    actually checked it explicitly...

 2. Just remove/rewrite that part of the test. We have 7559a1be8a
    (unblock and unignore SIGPIPE, 2014-09-18) (the other test whose
    pattern I copied) now.

    That along with 12e0437f23 (common-main: call
    restore_sigpipe_to_default(), 2016-07-01) means we do this
    everywhere, so why test "git rm" in particular in this one place but
    not other git commands?

 3. Remove the overly specific PIPE test added in 7559a1be8a in favor of
    this "git rm" test. After all if we want to test the SIGPIPE pattern
    but sometimes we get SIGPIPE, sometimes we don't (MINGW), but we
    don't really care because we assume on some platforms it's being
    tested.

But not why we'd keep the test as-is now that we've dug up this old code
and found that since it got added we have a reliable way to test for
actually-sigpipe.

Just to maintain the coverage on MINGW? Wouldn't it be better to have
two tests then, one without the prereq to run everywhere, and another
identical one with the "trap" on !MINGW?

I don't really care and can re-roll in whatever way you prefer, I just
don't understand what I'd put as a reason in the commit message(s),
depending on which route we go...
