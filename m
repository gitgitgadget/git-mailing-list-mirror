Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C7C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 16:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48245208C4
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 16:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PsYPeefu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRQjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:39:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59801 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 11:39:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB7575B50C;
        Tue, 18 Feb 2020 11:39:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TjlWIQxboiFQ9wtsum9BKT25nT8=; b=PsYPee
        fuhnTMoCQLepMrgcYEZMJxbz8nxDkVZbBk8Ew5G1MnyfFHK+oDGomL9SqYQteZSI
        ni3OhNdtgjjRlgzY4x6SbWvd0uNuvdO38pTbVIlrjMEIKj7AuqXho1ofYgzEBr7Q
        w68iO0W8H89GCzffMHjQf+UUcVl3ip6tFgI2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xIJ0jqFnjM8JJgZs29o6RkAlJQT26I+h
        4XsG8cJAhWZ8nrjMKTIn1LUD9In71lNO/qbwJueuHXbKPgN84AHOObZM0CHl9NJm
        zP+K9rpBCjMfm6Mqpejq4iVZ4W3SjqhLbwy9yR7PUFkkpX/g/GgOfw9+zRPLlZFQ
        BpiFejbwdNQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0F375B50B;
        Tue, 18 Feb 2020 11:39:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A4DE5B509;
        Tue, 18 Feb 2020 11:39:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] mingw: workaround for hangs when sending STDIN
References: <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com>
        <pull.553.v3.git.1581962486972.gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 08:39:44 -0800
In-Reply-To: <pull.553.v3.git.1581962486972.gitgitgadget@gmail.com> (Alexandr
        Miloslavskiy via GitGitGadget's message of "Mon, 17 Feb 2020 18:01:26
        +0000")
Message-ID: <xmqqy2szkfxr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45A0C422-526D-11EA-A5D1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> Explanation
> -----------
> The problem here is flawed `poll()` implementation. When it tries to
> see if pipe can be written without blocking, it eventually calls
> `NtQueryInformationFile()` and tests `WriteQuotaAvailable`. However,
> the meaning of quota was misunderstood. The value of quota is reduced
> when either some data was written to a pipe, *or* there is a pending
> read on the pipe. Therefore, if there is a pending read of size >= then
> the pipe's buffer size, poll() will think that pipe is not writable and
> will hang forever, usually that means deadlocking both pipe users.
> ...
> Chosen solution
> ---------------
> Make `poll()` always reply "writable" for write end of the pipe.
> Hopefully one day someone will find a way to implement it properly.
>
> Reproduction
> ------------
> printf "%8388608s" X >large_file.txt
> git stash push --include-untracked -- large_file.txt
>
> I have decided not to include this as test to avoid slowing down the
> test suite. I don't expect the specific problem to come back, and
> chances are that `git stash push` will be reworked to avoid sending the
> entire patch via STDIN.
>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---

Thanks for a detailed description.

I notice that we saw no comments from Windows experts for these
three rounds.  Can somebody give an Ack (or nack) on it at least?

I picked obvious "experts" in the output from 

    $ git shortlog --since=1.year --no-merges master compat/ming\* compat/win\*

Thanks.
