Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68CC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352287AbiBKRqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 12:46:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352286AbiBKRp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 12:45:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB1D38D
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 09:45:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cz16so17516006edb.8
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=4590QOKXTGzBM4aear0cP0EFIPviVQtijkq6XPK5uXg=;
        b=e7lHWCXoAt2yPJbOYvJ+K9jC4Q7KPh9Jei5SiNJPOI4j6U5FGpS9WT8RhnL9/WMbgK
         IYuUZdCqUHONbgp27rKaX9igbprn7rBrJQyH4AKMA/fUVeJF6+uoDFyQrQBdbaZdXRk7
         pLmERIVWiwLyNA2TE9qtJCn7hYHueqEWf4DEqsmtYoK8Sw68SnVm5cvMk7yFh8vW7Erf
         Tg5Lp7YyD4c4UcB2OKr8zAcni/Q1I2MWh/eQDGqKPyLn6HvzFGRtibWQQdGqlIpQ7wV6
         4Ul/AYPrrC4bL/qODcuKZ9J9kplPv8IIA+gXcRZW6yizZteOxPXyjySJQWmivbJmbsxO
         XbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=4590QOKXTGzBM4aear0cP0EFIPviVQtijkq6XPK5uXg=;
        b=LKq/nZLXAvUGJ5nOYNFumj1ZU90TjmXAtXTv9gaJ9FKcrnYTDiJHJCcLUWdUcgaCpI
         uAc3+lNmgG/Nn6KEtCvoTILXjI3eAwglqZSbeCYFBwAUmliuE5q7INhncamQXFmv2Aht
         j40GrFEU3zqd8OVCmS73g0pleQxF9qqcDDh+1AZMQh36gJRu0v7B9hTZWo4oDdiF45m6
         1T9dYes9FdmBYRx5U6xarDMMELpOqEzzIEFdhhvfB9kAna2QA1uvAyXxkQ1c1b2s+aeC
         aTq0reljxnH5HeUpbO70IHe/XrgpZLgnrxM1d8Lz4wifayUcsi4kZW1sfBbNkRpZyHIe
         DPjA==
X-Gm-Message-State: AOAM533AKfOwSZebmm/+3cXFiT6NvNhEiOuH7cmeorM2eAnhoheTcSv1
        qIeJdQmhZtxhUBROSNiB/bo=
X-Google-Smtp-Source: ABdhPJzBDIekOPflnUQPuTQ9NxkOxDJulVIVfvF8fHRfJbO5SOY1SkDfK9XadxLIafdgSmOvjwGNNQ==
X-Received: by 2002:a05:6402:13cf:: with SMTP id a15mr3165415edx.274.1644601555275;
        Fri, 11 Feb 2022 09:45:55 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id hq28sm8134810ejc.204.2022.02.11.09.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:45:54 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --batch-command mode
Date:   Fri, 11 Feb 2022 12:45:51 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <9B08BF05-1C35-4C4F-9C76-CC34A8E7D0F0@gmail.com>
In-Reply-To: <xmqq5ypmwt1m.fsf@gitster.g>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
 <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
 <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com> <xmqq5ypmwt1m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 10 Feb 2022, at 12:05, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>> +	type=$1
>>> +	sha1=$2
>>> +	size=$3
>>> +
>>> +	mkfifo input &&
>>> +	test_when_finished 'rm input' &&
>>> +	mkfifo output &&
>>> +	exec 9<>output &&
>>> +	test_when_finished 'rm output; exec 9<&-'
>>> +	(
>>> +		# TODO - Ideally we'd pipe the output of cat-file
>>> +		# through "sed s'/$/\\/'" to make sure that that read
>>> +		# would consume all the available
>>> +		# output. Unfortunately we cannot do this as we cannot
>>> +		# control when sed flushes its output. We could write
>>> +		# a test helper in C that appended a '\' to the end of
>>> +		# each line and flushes its output after every line.
>>> +		git cat-file --buffer --batch-command <input 2>err &
>>> +		echo $! &&
>>> +		wait $!
>>> +	) >&9 &
>>> +	sh_pid=$! &&
>>> +	read cat_file_pid <&9 &&
>>> +	test_when_finished "kill $cat_file_pid
>>> +			    kill $sh_pid; wait $sh_pid; :" &&
>>> +	echo "$sha1 $type $size" >expect &&
>>> +	test_write_lines "info $sha1" flush "info $sha1" >input
>>
>> This closes input and so cat-file exits and flushes its output -
>> therefore you are not testing whether flush actually flushes. When I
>> wrote this test in[1] this line was inside a subshell that was
>> redirected to the input fifo so that the read happened before cat-file
>> exited.
>
> Yeah, very good point.
>
>> This test is also not testing the exit code of cat-file or
>> that the output is flushed on exit. Is there a reason you can't just
>> use the test as I wrote it? I'm happy to explain anything that isn't
>> clear.
>
> I admit I do not offhand recall what your tests did but help with
> this (and more) level of detail with an offer to collaborate is
> something I am very happy to see.  Thanks for working well together.
>
> One thing that I wasn't quite sure was how well failure cases are
> tested.  If we ask, in a batch mode, "info" for two objects and then
> "flush", does the asker get enough clue when to read and when to
> stop reading with all four combinations of states, i.e. asking for
> two missing objects, one good object and one bad object, one bad
> object and one good object, two good objects, for example?

This is a good point. We currently don't have tests that exercise these
combinations.

>
> Testing such combinations reliably is tricky---if the asker needs to
> react to different response differently, a test that expects good
> and then bad may not just fail but can get into deadlock, for
> example if the reaction to good response has to read a lot but the
> reaction to bad response is to just consume the "bad object" notice,
> when a bug in the program being tested makes it issue the response
> for a bad case when the asker is expecting a response for a good
> object, because the asker will keep waiting for more response to
> read which may not come.

Let me see if I understand you. What I'm hearing is that it's hard to test a git
processes (A) that read/write from/to pipes without knowing exactly how (A) will
behave. By necessity, the test logic will have embedded some logic in it that
assumes certain behavior from (A), which might or might not be the case.

This can lead to a hanging test if, say, it is waiting around for (A) to output
data when due to a bug in the code, it never does. Did I get that right?

I still see value in having a test that hangs when it doesn't receive expected
output from the git process. If we had something that detected timeout on tests
then this could catch such a case. But since we don't, then that means having
tests like run_buffer_test_flush() and run_buffer_test_no_flush() will run the
risk of being a deadlocked test if there is a regression of the code in the future.
While still providing value in showing that something is wrong, these deadlocked
tests can be inconvenient to debug.



