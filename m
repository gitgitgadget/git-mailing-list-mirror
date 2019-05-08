Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE85A1F45F
	for <e@80x24.org>; Wed,  8 May 2019 03:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfEHDxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 23:53:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57888 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfEHDxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 23:53:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EA7D14F065;
        Tue,  7 May 2019 23:53:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ElRIa30dtpo6aQjRN7tmBVGY0tk=; b=T8nzRd
        ay6B/Jvmp2t6cfTsGjLzd6pQEvNhiwqBkSlDHTG8zK6oOsxfSvgubp4b+FH5cyI0
        byS7pPVp3DlYPrtCWI8nM1OSwRY491MAkwkvR1FcC8OzyZzK6NuFzyLBsWCPc7we
        cADImdsJm6S4qdHrHd6swNcKkNIXlJSWm0R3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZaIGMiHIN6jcAY1PxW1xJxxhVDVL9pJi
        46qHkwut8G6zGL7PTFT8GfzdtywCI/Z4wRUfh4yyvEdYCOZo+t/UrwijJOdEOS7+
        Y42HNtmnBucHFKrACY+5ccYvAKCV+sUcmbTm1Jm4OC/9BhebOpoWhMr9LUQzRA4X
        xfjrji7OluM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4502414F064;
        Tue,  7 May 2019 23:53:43 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77E9314F063;
        Tue,  7 May 2019 23:53:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t6500(mingw): use the Windows PID of the shell
References: <pull.185.git.gitgitgadget@gmail.com>
        <ba78a47b873c5f044cbfb147b30a801cc90fb0ac.1557265888.git.gitgitgadget@gmail.com>
        <CAPig+cQG4+A+G+i+8RqpDAY2PveULVJ5iNR4HYEUPAd_4Ub04w@mail.gmail.com>
Date:   Wed, 08 May 2019 12:53:41 +0900
In-Reply-To: <CAPig+cQG4+A+G+i+8RqpDAY2PveULVJ5iNR4HYEUPAd_4Ub04w@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 7 May 2019 18:25:20 -0400")
Message-ID: <xmqqef59iou2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF07E812-7144-11E9-984B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, May 7, 2019 at 5:51 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> Let's fix this by making sure that the Windows PID is written into
>> `gc.pid` in this test script soo that `git.exe` is able to understand
>> that that process does indeed still exist.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> @@ -162,7 +162,15 @@ test_expect_success 'background auto gc respects lock for all operations' '
>> +       shell_pid=$$ &&
>> +       if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
>> +       then
>> +               # In Git for Windows, Bash (actually, the MSYS2 runtime) has a
>> +               # different idea of PIDs than git.exe (actually Windows). Use
>> +               # the Windows PID in this case.
>> +               shell_pid=$(cat /proc/$shell_pid/winpid)
>> +       fi &&
>> +       printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
>
> I wonder if it would make sense to abstract this away behind a shell
> function named shell_pid() which can be specialized for MINGW, much
> like the shell function pwd() is specialized on Windows.

It would be, especially when we need the next such invocation.  I'd
find it easier to follow if it were

	if test_have_prereq ...
	then
		shell_pid=$(cat /proc/$$/winpid)
	else
		shell_pid=$$
	fi &&
	...

simply because in each of the cases the mental burden gets smaller
(those trying to see what happens on MINGW do not have to recall
shell_pid was originally taken from $$ after seeing 'then'; others
do not have to wonder if lack of 'else' to cover the platforms they
are reading for is deliberate and shell_pid is the only thing
expected out of the if/then/fi construct)

And I would suggest doing such a rewrite when it becomes a helper
shell function, but what is written here is good enough until then,
I would think.


