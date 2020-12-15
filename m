Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC47DC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A959522CB9
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 22:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgLOW2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:28:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56653 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbgLOWYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 17:24:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA26CF4073;
        Tue, 15 Dec 2020 17:23:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VloHtPKc+cnSjF+TZjSrqoAUdlI=; b=ZFSNWw
        Lz3UK7DqSeQAb+Jp8s4pP4ccYUSEe/aCsJyRjkMcwApEmWWhz+FwjmU/DGMarekU
        HxyLI+rwPUqiTJeBcAAoXS/rWyovD47MwUgg67tEYmBFWJDKBMOE13kfjNXHPT/O
        Td2PaqPDWbsZjvsb7G7szDNSz3tbcam/px63M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=USZn2eReYo7YBqd59E2XS1oVilW2tHoL
        q4XX9CuDy2QjwginQHDdDshrGHFox4ommfde/3PHahb1z9uyrpQqy/HHPaswD3M6
        M2gHn4fdiHXF2IlyVJxoegrnpBqGhwN9xG0e+DQPViqyP8HlA1cARNcLfe72AyZD
        h/mz+c/CYaI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2B95F4071;
        Tue, 15 Dec 2020 17:23:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF648F406F;
        Tue, 15 Dec 2020 17:23:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stuart MacDonald <stuartm.coding@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug report] includeIf config is not displayed in normal
 directories
References: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
Date:   Tue, 15 Dec 2020 14:23:17 -0800
In-Reply-To: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
        (Stuart MacDonald's message of "Tue, 15 Dec 2020 10:52:35 -0500")
Message-ID: <xmqqczza7lpm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2226C0E2-3F24-11EB-A63A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stuart MacDonald <stuartm.coding@gmail.com> writes:

> Hello,
>
> I've seen this thread:
> https://public-inbox.org/git/F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com/t/#u
>
> and respectfully disagree with the conclusion. Conditionally included
> configuration can contain items like core.sshCommand that are required
> for git clone while in a normal non-git directory. These should be
> displayed properly so users know what configuration they are operating
> with.

I have a feeling that this just repeats what was said in the quoted
thread.  It is a chicken-and-egg problem that cannot be solved by
use of [includeif "gitdir:*"] pattern, as it won't kick in until
your $(pwd) is associated with a git repository, and before "clone"
or "init", your $(pwd) that is a newly created directory won't be.

> Also, conditionally included config is acted upon despite not being
> displayed. This makes tracking down problems much more difficult.

> $ mkdir ~/work/git-bug-test
> $ cd ~/work/git-bug-test
> $ git config --show-origin --get-all core.sshCommand 
> OBSERVE A: There is no output

This is expected, as [includeif "gitdir:*"] is used and there is no
gitdir associated with the current location (yet).

It _might_ be possible to give "git config" a new option
"--pretend-as-if-cwd-is-the-root-of-a-git-working-tree" and teach it
to read ~/.gitconfig while pretending $(pwd)/.git exists and is a
gitdir, but it won't be as simple as exporting GIT_DIR=$(pwd)/.git,
I suspect.  A lot of other things would break by actually not having
a real repository there.

> $ git clone --recursive git@github.com:git/git.git
> OBSERVE B: The clone succeeds

This may be an unexpected but is an understandable behaviour.

First the command has to create an empty repository with an initial
configuration file, and at that point [includeif "gitdir:*"] match
would notice that there is a gitdir at $(pwd)/.git; by the time the
command actually starts talking to the other side, the repository
specific configuration can be picked up.

> $ cd git
> $ git config --show-origin --get-all core.sshCommand 
> file:C:/Users/stuartm/.gitconfig-work        ssh -i ~/.ssh/id_rsa.stuartm_github
> OBSERVE C: The configuration item is displayed

Of course.  At that point, you have a full fledged repository there.

> $ cd ..
> $ git config --show-origin --get-all core.sshCommand 
> OBSERVE D: There is no output

And you are outside any repository, so there shouldn't be any gitdir
in effect to influence [includeif "gitdir:*"] matching.

Another option, as Peff suggested in the old thread, would be to
introduce a separate [includeif "cwd:*"] match, but I do not know
how well it would fly.  with that, you may be able to

	[includeif "cwd:/home/stuart/work/*"]
		path = ...

I think that may be cleaner than the "pretend we have already a
git-dir here" hack I mentioned earlier, but I didn't think things
through.

THanks.

