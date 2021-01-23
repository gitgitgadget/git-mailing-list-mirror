Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C65C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC122CB9
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 07:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAWHhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 02:37:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62034 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhAWHhw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 02:37:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB903ABC3D;
        Sat, 23 Jan 2021 02:37:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RgX8ksQ2R7sCfGf3CLzBri5nfqo=; b=rALUDb
        oVrx/pdKteST9Ob5KG4Pi0fKZAVoO3wjhWzB37Z3sgBTeBdbyB773FtXNqoM+ORl
        V5maJp/5pS7dsGkxTSCw0Top6RLuzfB7bEg+7EDiO0nV/+xVYpQy7G6h24uG0G29
        9ktO++jnZ1Wlwz3easX6lLqqKfSKTW9SWo2Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nz8vOwdHc7Om9PDoeKWNJSzeY2EwxYbJ
        eJlJgq7NoieOZgEU1vapFHNnFh43WSMWg0E8zOYedZ5tgNHB2yI45KEOs0qRhcpU
        eLPPFSLE5gWDUqEWP9BjKrAFxjeN+GJuRyTW9zQkrw7cZotBfI5c9iIfdh6u5Tst
        Li1JsWVIK9M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E24D3ABC3C;
        Sat, 23 Jan 2021 02:37:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A03BABC3B;
        Sat, 23 Jan 2021 02:37:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/11] tests: add a "set -o pipefail" for a patched bash
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-12-avarab@gmail.com>
        <xmqq5z3o5n8c.fsf@gitster.c.googlers.com>
Date:   Fri, 22 Jan 2021 23:37:04 -0800
In-Reply-To: <xmqq5z3o5n8c.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 22 Jan 2021 19:46:43 -0800")
Message-ID: <xmqq1rec5ckf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA5D04C8-5D4D-11EB-A457-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> The above have already !MINGW
>
>> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
>> index 4f7e62d05c..7b5d92add5 100755
>> --- a/t/t3600-rm.sh
>> +++ b/t/t3600-rm.sh
>> @@ -251,7 +251,10 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
>>  		i=$(( $i + 1 ))
>>  	done | git update-index --index-info &&
>>  	OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
>> -	test_match_signal 13 "$OUT" &&
>> +	if ! test_have_prereq BASH_SET_O_PIPEFAIL
>> +	then
>> +		test_match_signal 13 "$OUT"
>> +	fi &&
>>  	test_path_is_missing .git/index.lock
>>  '
>
> but this one does not.  Yet, we've been using test_match_signal on 13
> without issues, it appears.
>
> And somehow with the lazy prereq on SET_O_PIPEFAIL, this part starts
> to break, like so:
>
>   https://github.com/git/git/runs/1752687552?check_suite_focus=true#step:7:37042
>
> The output captured in OUT is 0 as we can see on #37032 in the test
> log.

Nah, it seems that t3600-rm's "match signal 13" is already broken
without O_PIPEFAIL patch on Windows.  For example:

https://github.com/git/git/runs/1753231308?check_suite_focus=true#step:7:36912

This was introduced by c15ffae5 (rm tests: actually test for SIGPIPE
in SIGPIPE test, 2021-01-16) in the same series.

I am not sure "actually testing for SIGPIPE" is more important than
"make sure 'git rm' choked should not die with cruft", so without
thinking too deeply about the issue, my gut reaction is that
reverting is better than using !MINGW as other tests.  That is, no
matter how "git rm" gets killed, it should not leave .git/index.lock
behind, and the original already tests that.  The patch tried to
make sure it dies with signal #13 (and fails the test on Windows)
before it even looks at the leftover index.lock file, which feels a
bit backwards.


