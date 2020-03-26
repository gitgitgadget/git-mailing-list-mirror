Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3DC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CCB20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rc+FFWs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZVOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:14:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56333 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZVOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:14:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B758AC9631;
        Thu, 26 Mar 2020 17:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pdzPF0Hxzj8Z
        ChXwDJNL9SrKsd4=; b=rc+FFWs2rbHKcsRtW2O7EDW51AY5u5hRKfCeM4RcA1DW
        R88hFixqj7bW0QORVWjlFG/+vTHM9O1FBZ8gawaGBOT8m/T/lpfQUhDQsGC9sRlu
        VXe7qglHSL+mYyjg9ZLu+PXh9rf1rYebRzX1jCLDo4Vav0w+5DToqb9Jp36RXgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nIkK1z
        O6pDQnN366rvjTT1GWkIVnoZkFhZWfhA+ByW2PGw0/pp9ULkvG84O12I4aDuIQtD
        zLl5/DFgtJ6rJizZUUuEO/AEy+l7InYpP4plEbd0xrHhyh7TOb7r23A26C3KwhlC
        ZwQhTvprjdeVSPMpxlUQ0mC6xAAISPfCanWzc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFFACC9630;
        Thu, 26 Mar 2020 17:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F21BEC962A;
        Thu, 26 Mar 2020 17:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Andr=C3=A1s_Kucsma_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>
Subject: Re: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows
References: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
        <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 14:14:31 -0700
In-Reply-To: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Andr=C3=A1s?=
        Kucsma via GitGitGadget"'s message of "Wed, 25 Mar 2020 13:45:10
        +0000")
Message-ID: <xmqqmu82izt4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9DB6872-6FA6-11EA-BBD1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andr=C3=A1s Kucsma via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: Andras Kucsma <r0maikx02b@gmail.com>
>
> On Windows with git installed through cygwin, GIT_ASKPASS failed to run
> for relative and absolute paths containing only backslashes as director=
y
> separators.

> Subject: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows

Isn't it curious that there is nothing in the code that was touched
that is specific to GIT_ASKPASS?  We shouldn't have to see that in
the title.

Perhaps

    Subject: run-command: notice needs for PATH-lookup correctly on Cygwi=
n

    On Cygwin, the codepath for POSIX-like systems is taken in
    run-command.c::start_command().  The prepare_cmd() helper
    function is called to decide if the command needs to be looked
    up in the $PATH, and the logic there is to do the PATH-lookup if
    and only if it does not have any slash '/' in it.

    Unfortunately, a end-user can give "c:\program files\askpass" or
    "a\b\c" to be absolute or relative path to the command, but in
    these strings there is no '/'.  We end up attempting to run the
    command by appending the absoluter or relative path after each
    colon-separated component of $PATH.

    Instead, introduce a has_dir_sep(path) helper function to
    abstract away the difference between true POSIX and Cygwin, and
    use it to make the decision for PATH-lookup.

Having said all that, I am not sure if we need to change anything.

As Cygwin is about trying to mimicking UNIXy environment as much as
possible, shouldn't "GIT_ASKPASS=3D//c/program files/askpass" the way
end-users would expect to work, not the one that uses backslashes?

And if the user pretends to be on UNIXy system by using Cygwin by
using slashes when specifying these commands run via the run_command
API, the code makes the decision for PATH-lookup quite correctly,
no?

So...
