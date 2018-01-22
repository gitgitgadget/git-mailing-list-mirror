Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7741F404
	for <e@80x24.org>; Mon, 22 Jan 2018 21:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750977AbeAVVZf (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 16:25:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55304 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeAVVZe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 16:25:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB4D5C9E43;
        Mon, 22 Jan 2018 16:25:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZZei2BHlf+AOqClJUGzM8hpKzpM=; b=rchEYp
        uTcIw40P3NXtByxlg2/C6a6Xx50JemjSlfQy7ywnBa8TWalQ5JAPt1cWLnUzFmfw
        pigDJxZyM7VgjKwPU/Bi88kVeP3o6JW3khG11Ik/YqiodLxAeQpYh6NWMn0IoBK4
        GH0am2PM5wAVyQc/3hFXt1bpGHITV2yU+SxMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hNC8LPf3YGKxmGgJMO2idDPvw/cgKJCj
        eousSqd0mun9deaVqkPdiYG85fcILleHxIy7lKDLDWIgNIX/gyuovCKPlPbTTw4J
        zmiPtoHooOiAtQkt3hzIWROW4XeLKCDJB8wjItdsHnU8Zz7mfOExplq7w0JT7pqQ
        aUyw8Z71Td8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D12C0C9E42;
        Mon, 22 Jan 2018 16:25:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42228C9E41;
        Mon, 22 Jan 2018 16:25:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
        <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
Date:   Mon, 22 Jan 2018 13:25:32 -0800
In-Reply-To: <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
        (Jacob Keller's message of "Thu, 18 Jan 2018 08:25:30 -0800")
Message-ID: <xmqqwp09lh6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C76C696E-FFBA-11E7-A362-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> The code looks good, but I'm a little wary of adding bud which
> hard-codes a specific label. I suppose it does grant a bit of
> readability to the resulting script... ? It doesn't seem that
> important compared to use using "reset onto"? At least when
> documenting this it should be made clear that the "onto" label is
> special.

I do not think we would mind "bud" too much in the end result, but
the change in 1/8 is made harder to read than necessary with it.  It
is the only thing that needs "a single-letter command name may now
not have any argument after it" change to the parser among the three
things being added here, and it also needs to be added to the list
of special commands without arguments.

It would have been easier to reason about if addition of "bud" was
in its own patch done after label and reset are added.  And if done
as a separate step, perhaps it would have been easier to realize
that it would be a more future-proof solution for handling the
"special" ness of BUD to add a new "unsigned flags" word to
todo_command_info[] structure and using a bit that says "this does
not take an arg" than to hardcode "noop and bud are the commands
without args" in the code.  That hardcode was good enough when there
was only one thing in that special case.  Now it has two.

In a similar way, the code to special case label and reset just like
exec may also want to become more table driven, perhaps using
another bit in the same new flags word to say "this does not refer
to commit".  I think that can become [v2 1/N] while addition of "bud"
can be [v2 2/N] (after all, "bud" just does the same do_reset() with
hardcoded argument, so "label/reset" must come first).




