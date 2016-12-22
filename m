Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72EC1FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941844AbcLVSTd (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 13:19:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58512 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941315AbcLVSTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 13:19:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70EDE59BD4;
        Thu, 22 Dec 2016 13:19:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9cnELKvBuN9UVrKbD43nq1v/LSk=; b=iOUZzL
        v7Q04M0qIhLHjIEe+vHhOy2buoa1fA0q7OPMXSsjrqMcrS86TiUHCqDVSw2wTS2f
        O5oIaWvRD/49HxPBf/xlec7ZF3oB0A9fhJ+C8MndGEQqaumN7qlU0TO6DSoTpFhL
        GyDIofMMrOGW172lvz+q15iTG1la9MNMss84c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HwT9vfS0imA+MQ7QA3MKaL9BgW3MP44b
        nfPZ/R6SB6nXxh+f6X4KJdicTkz/Y5YZc0NhHiNT4w2LnUBWM0UTouTUgbamZ7lF
        PFOiLBiC1xpsq6N1oqjdiH27lQhXniLKIZ9sjYj0XVFPFgARs8Ky3gAVDjI2LVci
        MPPi9Ps9F2Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61D9659BD3;
        Thu, 22 Dec 2016 13:19:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7C3359BD2;
        Thu, 22 Dec 2016 13:19:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 0/3] Really fix the isatty() problem on Windows
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
        <cover.1482426497.git.johannes.schindelin@gmx.de>
        <xmqqd1gjhn0u.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 22 Dec 2016 10:19:26 -0800
In-Reply-To: <xmqqd1gjhn0u.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 22 Dec 2016 09:49:37 -0800")
Message-ID: <xmqq37hfhln5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CACBC00-C873-11E6-B82C-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> ...
>> - fixed the confusing commit message by using Junio's suggested
>>   replacement
>
> Sorry, but I didn't mean to "suggest replacement".  I was just
> testing my understanding by attempt to rephrase the gist of it.
> ...
> Your "use this opportunity to actually clean up" above suggests that
> the answer is the latter, but if you took my "summary of my
> understanding", it is likely that that fact is not captured in the
> resulting log message.

So using the original log message in v1 and what you wrote in the
message I was responding to as references, let me try a real
"suggested" one as penance.

I need to ask one clarification on what you wrote before completing
that effort, though.

>> And incidentally, replacing the previous hack with the clean, new
>> solution, which specifies explicitly for the file descriptors 0, 1 and 2
>> whether we detected an MSYS2 pseudo-tty, whether we detected a real
>> Win32 Console, and whether we had to swap out a real Win32 Console for a
>> pipe to allow child processes to inherit it.

This has subject but not verb.  I parsed the above like so:

    Replacing the previous hack with the clean, new solution (which
    specifies explicitly for the file descriptors 0, 1 and 2
     - whether we detected an MSYS2 pseudo-tty, 
     - whether we detected a real Win32 Console, and 
     - whether we had to swap out a real Win32 Console for a
       pipe to allow child processes to inherit it
    )

So the entire thing is a noun phrase "replacing with a new patch",
and I take that as the subject of an unfinished sentence.  What did
that subject do?  Replacing with a new patch allows us to do "this
wonderful thing", but what "this wonderful thing" is not clear.

Subject: mingw: replace isatty() hack
From: Jeff Hostetler <jeffhost@microsoft.com>

For over a year, Git for Windows has carried a patch that detects
the MSYS2 pseudo ttys used by Git for Windows' default Git Bash
(i.e. a terminal that is not backed by a Win32 Console), but it did
so by accessing internals of a previous MSVC runtime that is no
longer valid in newer versions.  

Clean up this mess by backporting a patch that was originally done
to compile Git with a recent VC++.  Replacing the previous hack with
the clean, new solution, which specifies explicitly for the file
descriptors 0, 1 and 2 whether we detected an MSYS2 pseudo-tty,
whether we detected a real Win32 Console, and whether we had to swap
out a real Win32 Console for a pipe to allow child processes to
inherit it, lets us do XXXXX.

As a side effect (which was the reason for the back-port), this patch
also fixes the previous misguided attempt to intercept isatty() so that
it handles character devices (such as /dev/null) as Git expects it.
