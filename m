Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B2BC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4AE20836
	for <git@archiver.kernel.org>; Fri,  1 May 2020 16:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWiiLFK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgEAQvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 12:51:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61750 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgEAQvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 12:51:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9732AC26AF;
        Fri,  1 May 2020 12:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y+0rMI1DT1Ou4F152AseWN4KgrM=; b=cWiiLF
        K9MxYP0J0m98Ib/ZHD8z6i2wJQtVZQWHM/7bZbWQzmyc8RfON41l9fDs+oJLDx+5
        PfrzvgB1BnrcNEJtoNUk/O//h27Px6CtvJb6TVq0Mxo5cFE8bexVxlGpNG4JlMRO
        c8nBHlQhzMxWD0YmIkuv7cZt4Sg1nnZOxZObk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lIyyZDpFuHzgxd7OF1u/u2f1n1qzej58
        BzwpCRo2RWq03aUMLbhQtfvwtAVMpjWTs9ES+x68nv5IoWeVdTr+ljUeSsjmLfi3
        m1XTpcHaW4lp8IjxtWJN7KnXNYvidt+qvEEk111tsmQ8HsiGj4yznxmZlmnxb+R4
        hcXxDVdoKTM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F5C1C26AD;
        Fri,  1 May 2020 12:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AECE8C26AC;
        Fri,  1 May 2020 12:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1.1] lib-submodule-update: pass OVERWRITING_FAIL
References: <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
        <f0d8dcf7dc52fe5ad2f1e173cd744bfdeb55eb45.1588242122.git.liu.denton@gmail.com>
        <xmqqpnbor9ng.fsf@gitster.c.googlers.com>
        <20200501093554.GA49619@generichostname>
Date:   Fri, 01 May 2020 09:51:01 -0700
In-Reply-To: <20200501093554.GA49619@generichostname> (Denton Liu's message of
        "Fri, 1 May 2020 05:35:54 -0400")
Message-ID: <xmqq8siboayy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1AA2190-8BCB-11EA-ACBB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Does this commit message increase the clarity?
> 
> 	lib-submodule-update: pass OVERWRITING_FAIL
>
> 	We are using `test_must_fail $command`. However, $command is not
> 	necessarily a git command; it could be a test helper function.
>
> 	In an effort to stop using test_must_fail with non-git commands, instead
> 	of invoking `test_must_fail $command`, run
> 	`OVERWRITING_FAIL=test_must_fail $command` instead in
> 	test_submodule_switch_common().
>
> 	In the case where $command is a git command,
> 	test_submodule_switch_common() is called by one of
> 	test_submodule_switch() or test_submodule_forced_switch(). In those two
> 	functions, pass $command like this:
>
> 		test_submodule_switch_common "eval \$OVERWRITING_FAIL git $command"
>
> 	In the case where $command is a test helper function, increase the
> 	granularity of the test helper function by marking the git invocation
> 	which was meant to fail like this:
>
> 		$OVERWRITING_FAIL git checkout "$1"
>
> 	This is useful because currently, when we run a test helper function, we
> 	just mark the whole thing as `test_must_fail`. However, it's possible
> 	that the helper function might fail earlier or later than expected due
> 	to an introduced bug. If this happens, then the test case will still
> 	report as passing but it should really be marked as failing since it
> 	didn't actually display the intended behaviour.
>
> 	While we're at it, some helper functions have git commands piping into
> 	another git command. Break these pipes up into two separate invocations
> 	with a file buffer so that the return code of the first command is not
> 	lost.
>
> 	This patch can be better viewed with `--ignore-all-space`.

It may be better, but not all that much.  I think it comes from the
design that this change is hard to understand.  Anybody who wants to
write more of these tests would need a much better guidance than
"just use OVERWRITING_FAIL=test_must_fail where you would normally
write test_must_fail and you'd be OK", as that is not what is going
on.  Before doing so, they would make sure that the place where they
are tempted to write test_must_fail MUST be called by these three
wrappers, or this guidance does not apply, for example.

>> If we have given up the "single-shot environment export" for
>> compatibility reasons (which is a sound decision to follow), we
>> should make sure it is clear to our readers that we are not using
>> that shell feature.  I.e.
>> 
>> 			export OVERWRITING_FAIL=test_must_fail &&
>> 			$command replace_sub1_with_directory &&
>> 			unset OVERWRITING_FAIL &&
>
> Makes sense. I would drop the export, though, because $OVERWRITING_FAIL
> should only be handled within the shell environment. We're never calling
> any external commands that need to know about this variable.

Yup, not pretending that this affects anywhere outside of shell by
exporting is a bad idea.

> On a tangent, I got a response[1] from the dash people about the
> "single-shot environment export" propagating past a function. It seems
> like in the most updated version of POSIX addresses this and it's up to
> the implementers whether or not variables propagate past a function
> invocation.

Yes, it is the reason why we discourage the unportable use of the
pattern in our tests.
