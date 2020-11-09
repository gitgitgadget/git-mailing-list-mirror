Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BF3C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68707206A1
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XriH8XuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgKIXWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:22:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52079 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 18:22:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC6949324B;
        Mon,  9 Nov 2020 18:22:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g3fvLnMr/rXB9ic1MYxySbKM4so=; b=XriH8X
        uFbovRg3zMsnFbleA7y/ffRWycBroegxWu1aJ4ccmB+m1qiNz4QTp2wt8uA2wcge
        ezfLmk2etPwE4oM6C+o0SeZoYPrGYQHu1Or3XZ4XsS41sxfzduIx/cRoLwTll5sp
        0LzWzyll0c20Sf901DlfxF2SLqWcWSTeHVMs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h/y9Q3AwoqT12wE/lx2fW4K78QrETEUG
        NXSnDJVumQSSp8EKf8Cpk2L/Hkmi47gHzUS200RnKXN1yeShEd+ekpseF2ecFf3o
        JNzw0iKO1wRDyna9NsWIpXndsqbhwWr2jVm4dQ34KEY4ZtTQ6MVDBfZtiPOm/xY1
        1PFvrGsX1NY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2B9E9324A;
        Mon,  9 Nov 2020 18:22:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5789E93249;
        Mon,  9 Nov 2020 18:22:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] t5411: consistent result for proc-receive broken test
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
        <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com>
        <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
        <20201109231246.GA677345@coredump.intra.peff.net>
Date:   Mon, 09 Nov 2020 15:22:32 -0800
In-Reply-To: <20201109231246.GA677345@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Nov 2020 18:12:46 -0500")
Message-ID: <xmqqk0uu9kuf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71E5E760-22E2-11EB-B139-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I.e., I think the bug is in receive-pack's run_proc_receive_hook().

I thought that this was merely to work it around and give the
particular test a reliable failure code, though.  Either way,
receive-pack will get a failure when the hook fails (either the
failure message from the hook, or unexpected EOF), so no matter what
this patch does around this area, it would not affect interactions
with real-life hooks, I would think.

> It
> cleverly ignores SIGPIPE exactly to avoid dying during the write phase,
> but then it proceeds to call packet_write_fmt(), etc, that will die on
> any error (going to extra effort to emulate sigpipe, no less!). So we
> die and take our sideband muxer with us.
>
> So instead of this hunk:
>
>> > @@ -79,9 +82,15 @@ static void proc_receive_read_commands(struct packet_reader *reader,
>> >  		    *p++ != ' ' ||
>> >  		    parse_oid_hex(p, &new_oid, &p) ||
>> >  		    *p++ != ' ' ||
>> > -		    die_readline)
>> > +		    die_readline) {
>> > +			char *bad_line = xstrdup(reader->line);
>> > +			while (packet_reader_read(reader) != PACKET_READ_EOF)
>> > +				; /* do nothing */
>> > +			if (die_readline)
>> > +				die("die with the --die-readline option");
>> >  			die("protocol error: expected 'old new ref', got '%s'",
>> > -			    reader->line);
>> > +			    bad_line);
>> > +		}
>> 
>> This part is different from the previous one in that it slurps all
>> the input before dying evein in die_readline case.
>
> I think the patch really ought to be in receive-pack, converting
> packet_write_fmt() and packet_flush() into their "gently" forms.

That would be a real fix, not "work around flakey tests".  Yes, the
hook driver roughly mimics run_and_feed_hook() and I suspect it
started from copy-and-paste from that function, so we might need to
review that original copy, too.

> And when we see a write error, close our pipe to the hook, set errmsg to
> "hook failed to run" or similar, and then jump to the "cleanup" label,
> where we'll wait on our sideband muxer to finish (which in turn will
> wait pump any remaining data out of the hook's stderr).
>
> Optionally we can pump the hook stdout to see if it gave us a better
> message, but I think if write() failed, then all bets are off. The hook
> broke protocol; a well-behaved hook that wanted to pass along a specific
> per-ref message to the user would actually read all the input and then
> report on each ref).

Yup, sounds good.
