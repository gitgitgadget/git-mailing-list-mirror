Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C09C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348766AbiEZTi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiEZTiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:38:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14F5997A
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:38:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0708E1931EC;
        Thu, 26 May 2022 15:38:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UH8z547MN9HO
        U7v1I/vM+tts9jWdGvFc3X9hdKypCK8=; b=g+xSa/iG5xUCedTwM6RU5zXnzk3x
        GVNplUM/t5mclASw9PhoeJViqfZ2QzwRtJ1At6NNa1Jz0nzMTd6dc7LVNLbdn+Nl
        fMUvDVpZs3amzFHnwP0Aq3CdB46lW+Tz5/n+MxOGMDigkR+U4aupaOPDpQDbsKi4
        ZzynJ6My//mTBAA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F33231931EB;
        Thu, 26 May 2022 15:38:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADF6C1931EA;
        Thu, 26 May 2022 15:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: js/bisect-in-c
References: <xmqqzgj41ya2.fsf@gitster.g>
        <220526.86r14g3yya.gmgdl@evledraar.gmail.com>
Date:   Thu, 26 May 2022 12:38:48 -0700
In-Reply-To: <220526.86r14g3yya.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 20:54:36 +0200")
Message-ID: <xmqq35gwyth3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77588216-DD2B-11EC-A1E9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, May 26 2022, Junio C Hamano wrote:
>
>> * js/bisect-in-c (2022-05-21) 15 commits
>>  - bisect: no longer try to clean up left-over `.git/head-name` files
>>  - bisect: remove Cogito-related code
>>  - Turn `git bisect` into a full built-in
>>  - bisect: teach the `bisect--helper` command to show the correct usag=
e strings
>>  - bisect: move even the command-line parsing to `bisect--helper`
>>  - bisect--helper: return only correct exit codes in `cmd_*()`
>>  - bisect--helper: move the `BISECT_STATE` case to the end
>>  - bisect--helper: make `--bisect-state` optional
>>  - bisect--helper: align the sub-command order with git-bisect.sh
>>  - bisect--helper: using `--bisect-state` without an argument is a bug
>>  - bisect--helper: really retire `--bisect-autostart`
>>  - bisect--helper: really retire --bisect-next-check
>>  - bisect--helper: retire the --no-log option
>>  - bisect: avoid double-quoting when printing the failed command
>>  - bisect run: fix the error message
>>
>>  Final bits of "git bisect.sh" have been rewritten in C.
>>
>>  Will merge to 'next'?
>>  source: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
>
> This topic has outstanding regressions in CLI parsing. I.e. we'll now
> offer to start bisection where we previously errored out on invalid
> command usage. See my replies in that thread.

Pointers?
