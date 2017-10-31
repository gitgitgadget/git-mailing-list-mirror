Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E08420437
	for <e@80x24.org>; Tue, 31 Oct 2017 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdJaGZJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 02:25:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53540 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750916AbdJaGZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 02:25:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05849A98C2;
        Tue, 31 Oct 2017 02:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EApFjba5XoUFvwmYXmy5Iehsozg=; b=umgqep
        fwwJ57LFokuUD2pj8qgAIs/8hrvWqVB0mX2x75znJM0kDhI7lm/vovBC0rJKwUJV
        PrWRCbWbXF8mnNap9QaqR1YIL7Rc6MAusCe+1S9ZWPgCKTUKDu3T+wprsTf0KynK
        +CTv0wqWmeGHtWfhsalxwJXUUZNFomiGkti68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SfU10ykhgwTutnLzxWhPapu5dcPimXdI
        lZrSdtWKLyZh4Ot8N95lmYmHpzMqVkCvI1vNvgOWs/XdGab+BvjmpTl+/MZ+imxt
        GPUtJN+fHL3Urz40NA4TM92ODP4S5CD4xmwm6lcyK8Wl7XNoJQUSeevxiWpwUo+A
        eg7oNxXbuDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2A6AA98C1;
        Tue, 31 Oct 2017 02:25:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77729A98C0;
        Tue, 31 Oct 2017 02:25:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-7-sbeller@google.com>
Date:   Tue, 31 Oct 2017 15:25:06 +0900
In-Reply-To: <20171031003351.22341-7-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Oct 2017 17:33:50 -0700")
Message-ID: <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D42C640-BE04-11E7-AEC3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index c924c945ba..3d618b2445 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -3,7 +3,7 @@ git-describe(1)
>  
>  NAME
>  ----
> -git-describe - Describe a commit using the most recent tag reachable from it
> +git-describe - Describe a commit or blob using the most recent tag reachable from it

If I am not mistaken, this series is about describing a blob as a
tuple of a recent commit-ish and a path in the tree in it.  Blob
never reaches anything, so "desribing blob using X reachable from
it" is a mere nonsense.

The original is not great in that it ignores the "--contains" mode
and referring to "tagged commit" merely as "tag" for brevity, but
at least it made some sense.

> @@ -24,6 +24,16 @@ By default (without --all or --tags) `git describe` only shows
>  annotated tags.  For more information about creating annotated tags
>  see the -a and -s options to linkgit:git-tag[1].
>  
> +If the given `<commit-ish>` refers to a blob, it will be described

Perhaps this step should update the SYNOPSIS so that the command
takes not just commit-ish but a blob too.  Given the difficulty in
coming up with the single-liner description of what it does we saw
above, I suspect that splitting SYNOPSIS out into two very distinct
operating mode might make it easier to read.

    SYNOPSIS
    --------
    [verse]
    'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
   +'git describe' [<options>...] <blob>...

Then this additional paragraph can say "When describin a <blob>",
without using a (technically nonsense) phrase "if <commit-ish>
refers to a blob", which is never true.

