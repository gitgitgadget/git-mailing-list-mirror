Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A6C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813662077D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTX64IN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJUNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:13:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60107 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJUNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:13:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECEF16B6E9;
        Fri, 10 Jul 2020 16:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9X3e/lwg4o0Wsx9+hD0dXuBQOBA=; b=KTX64I
        N0PDzkXdAL4ehsNtkmqBOol2A4ZiXefOoWBBfGaZkJES/KMR3exWbQIwSsruz6MW
        muLfxDMp6OKv13VcDmJ5eqir54BfMQ4bcrdp2JXjvpcwDff6Np6Jj4vKkM6/DHEc
        96eqUFcFPmqSA7AqR4j3u9wI55OJgPartp85w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hn/xgVwH2JuUZJ2XkVm7DZj5QfzQVM/x
        fU/qLb7q0MuaEzR2u8Ol+g6mHojNIt/QoDrv6w7uVj7QzS+Mml0SL3hHWVrCPBw0
        RtJerQfkELp7dZY9M6zK5auYdhKfplcKuRPBC6fxbFo7EkRG8MN/5B59M1pypEiR
        AbnnBMEcVxc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4DAC6B6E8;
        Fri, 10 Jul 2020 16:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73D436B6E7;
        Fri, 10 Jul 2020 16:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Zach Riggle <zachriggle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: --function-context shows wrong function in chunk
References: <CAMP9c5k5kLSqhCh9400iLdZ=+-nKonavOYpBSs_NHdaVVJ_ycQ@mail.gmail.com>
Date:   Fri, 10 Jul 2020 13:12:56 -0700
In-Reply-To: <CAMP9c5k5kLSqhCh9400iLdZ=+-nKonavOYpBSs_NHdaVVJ_ycQ@mail.gmail.com>
        (Zach Riggle's message of "Fri, 10 Jul 2020 13:38:30 -0500")
Message-ID: <xmqqk0zbt9h3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEF193FA-C2E9-11EA-8DEA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zach Riggle <zachriggle@gmail.com> writes:

> When using --function-context, the function that is claimed at the top
> of the diff does not match the actual function.
>
> Note that the change exists in main, but the hunk header
> (terminology?) shows other_routine.
>
> $ git --version
> git version 2.27.0
>
> $ git diff -b --function-context
> diff --git i/example.c w/example.c
> index d87b59b..346e2a7 100644
> --- i/example.c
> +++ w/example.c
> @@ -4,5 +4,5 @@ int other_routine() {
>  }
>
>  int main() {
> -
> +    puts("Hello, world!");
>  }
>
> Zach Riggle

I think it is possible to modify the "find the line that match
xfuncname pattern" logic to start scanning backwards from the first
actual change (i.e. the blank line in the preimage of the patch
inside "int main() {" function in your example) and make the hunk
header say "int main() {" instead of "int other_routine() {".

I however doubt that such a change makes any sense.  In fact, I find
the sample output above both quite logical and also even desirable.

It is logical because the first thing we see in the hunk, "}", is at
the end of "int other_routine() {" function; it does not conclude
the "int main() {" function.  Saying "int main() {" there on the
hunk header line would be misleading and confusing.  It sends a
wrong signal that there was such a line _before_ the first line we
see in this hunk, which is definitely not.

It is desirable because it gives more information than saying the
illogical "main".  The reader can see what the routine before the
beginning of main function we see in the hunk is.  In the above
example it may not matter, but if we see "return -1;" at the end of
that function and a call to other_routine() from main(), e.g.

        @@ ... @@ int other_routine() {
            return -1;
        }
        int main() {
        -   int i = other_routine();
        +   int i = other_routine() ? 1 : 0;
            printf("%d\n", i);
        }

it would be more informative than having "int main() {" there.
