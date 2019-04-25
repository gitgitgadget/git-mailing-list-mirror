Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085961F453
	for <e@80x24.org>; Thu, 25 Apr 2019 00:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfDYAoo (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 20:44:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57812 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfDYAoo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 20:44:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78FDB147AC8;
        Wed, 24 Apr 2019 20:44:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sAfzOf+zCSYl
        pJsQqkIRlLvrQFw=; b=b0X1zNVE6owG3xmALsDTx4T6+ms5JZ2hKhfxJfI9u8ca
        8AkBNfmRZs2T2zXWdSZfTcEGRhskVryYia8u3e566nQR6/DUTPDprEo6Z0ioerxI
        q8W9Ocw0XNXuILPWigcfHOV/hLPdpkkEPMjwmk421WPDCwUB6VB+UVZ0LwbVTBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=k2RbTn
        6/ToZfasRwngDzC2uq5QLbvJReU9V+gSxt0ZfxuxPEw+yeALdYBxN6ZHu1bEbuUb
        3iZPzqPoLiuENsLkjWBPTK9Z7uSBaWcqoOM+WNbqfjWY9NOD7e33LKXuFMHo/Ezq
        9Po+ebcYn1SWkBdjY+ACZy+jnMLwN7ElO3E54=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70AFE147AC7;
        Wed, 24 Apr 2019 20:44:42 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9654147AC4;
        Wed, 24 Apr 2019 20:44:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use with -G
References: <87o94vs9cp.fsf@evledraar.gmail.com>
        <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
        <87mukfrnp3.fsf@evledraar.gmail.com>
Date:   Thu, 25 Apr 2019 09:44:40 +0900
In-Reply-To: <87mukfrnp3.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 25 Apr 2019 01:24:56 +0200")
Message-ID: <xmqqsgu6zzev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5022E530-66F3-11E9-9AB5-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I agree. I am a bit bothered by the fact that
>> `git log --oneline -Ux -G<regex> --pickaxe-raw-diff` outputs the
>> contents/patch of a commit. My expectation is that we have the
>> `log -p` knob for that?
>
> This is unrelated to --pickaxe-raw-diff, -U<n> just implies -p in
> general. See e.g. "git log -U1".

The reason why I found this exchange interesting is because I think
it shows a noteworthy gap between end-user expectations and what the
implementors know.

Stepping back (or sideways) a bit, pretend for a while that there
were no "pickaxe" feature in Git.  Instead there is the "patch-grep"
tool whose design is roughly:

   1. It reads "git log -p" output from its standard input, and
      splits the lines into records, each of which consists of the
      header part (i.e. starting at the "commit <object name>" line,
      to the first blank line before the title), the log message
      part, and the patch part.

   2. It takes command line arguments, which are, like "git grep",
      patterns to match and instructions on how to combine the match
      result.

   3. It applies the match criteria only to the patch part of each
      record.  A record without any match in the patch part is
      discarded.

   4. It uses the surviving record's "commit <object name>" lines
      to decide what commits to show.  It does the moral equivalent
      of invoking "git show" on each of them, and perhaps lets you
      affect how the commits are shown.

      Or perhaps it just lists the commit object names chosen for
      further processing by downstream tools that read from it.


So the user would be able to say something like

	git log -Ux --since=3D6.months |
	git patch-grep \
		--commit-names-only \
		--all-match \
		-e '+.*devm_request_threaded_irq(IRQF_SHARED)' \
                -e '-.*devm_request_threaded_irq(IRQF_ONESHOT)' |
	xargs git show --oneline -s

As an implementor, you know that is not how your -G<pattern> thing
works, but coming from the end-user side, I think it is a reasonable
mental model to expect a tool to work more like so.  And I think the
expectation from combining --oneline with -Ux was that the -U option
would apply to step 1, not step 4 (as --oneline is a clear
indication that the user wants a very concise final result).

Personally, I think the _best_ match for the original wish would be
to have that hypothetical "git patch-grep" read from "git log -L"
that is limited to the C function in the source the user is
interested in.

And until "git patch-grep" becomes reality, I would probably have
done

	git log -L<function of interest> -U<x> | less

and asked "less" to skip to a match with

	/(IRQF_SHARED|IRQF_ONESHOT)

and then kept hitting 'n' until I find what replaces them, as a
stop-gap measure.

By the way, I think your thing is interesting regardless, even if it
does not match the use case in the original thread (it actually may
match---I didn't think it through).

Because in the context of diff/log family, however, the word "raw"
has a specific connotation about the "--raw" format (as opposed to
"--patch"), I would not call this "grep the patch output itself,
instead of grepping the source (guided by the patch output to tell
what lines are near the lines that got replaced)" feature anything
"raw", by the way.


