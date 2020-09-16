Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9140C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 04:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED4921D1B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 04:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hq9mNoqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIPEhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 00:37:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50350 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgIPEhx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 00:37:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CAB9DFB4C;
        Wed, 16 Sep 2020 00:37:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8fQO17UxEeqMukFTEda936nuNME=; b=Hq9mNo
        qBZK+/mN9otrRrNrn7dkGHgoiQTN6/l4d5mCDP88NMbwZ33bTNhDSoYu20YqIMI/
        Ko1Z0wjndYHS5/+k1M2BPTPrcwr22SzmmO24z+xX0s5SPcWOZDtveyP9QPdTR3PF
        ifxZybF7UuoA6uPfYjNfdeOfti7z5f5IvGvuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ykVNd1W+yd5J11mw0s/b8gYhSEGYvf0O
        fYIPi1GuxvMxSct/K6blZSQT/3pzXsEXbmh2Z8pDDmrfMjR0jICHRy5DYJXln+UV
        4szS47WLeQYv1DqQA4qIXS161qtWmu6EACzq3W+SalniMiwJFPw/El90oEr5jHxA
        AvX6QriDUeM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55426DFB4B;
        Wed, 16 Sep 2020 00:37:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B0FDDFB47;
        Wed, 16 Sep 2020 00:37:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] send-pack: check atomic push before running GPG
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
        <20200915095827.52047-2-hanxin.hx@alibaba-inc.com>
        <xmqqmu1qzrbo.fsf@gitster.c.googlers.com>
        <CANYiYbHYi70ZcjDTyQ++_+njuZMF=TksPepH+wP+zNmhBABNAg@mail.gmail.com>
Date:   Tue, 15 Sep 2020 21:37:47 -0700
In-Reply-To: <CANYiYbHYi70ZcjDTyQ++_+njuZMF=TksPepH+wP+zNmhBABNAg@mail.gmail.com>
        (Jiang Xin's message of "Wed, 16 Sep 2020 09:53:24 +0800")
Message-ID: <xmqqeen2xrok.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F8F317A-F7D6-11EA-A0B2-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>> > -
>> > -     if (!args->dry_run && push_cert_nonce)
>> > -             cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
>> > -                                            cap_buf.buf, push_cert_nonce);
>> > -
>> >       /*
>> >        * Clear the status for each ref and see if we need to send
>> >        * the pack data.
>>
>> This "Clear the status for each ref" worries me.
>>
>> The generate_push_cert() function RELIES on ref->status and filters
>> out the ref that failed to pass the local check from the generated
>> push certificate.  If you let the loop (post context of this hunk)
>> run, ref->status will be updated by it, so the net effect of this
>> patch is that it breaks "non-atomic" case that pushes multiple refs
>> and one of ref fails to pass the local check.
>>
>> IOW, generate_push_cert() MUST be called before this loop "clears
>> the status for each ref" by assigning to ref->status.
>
> The next block ("Finally, tell the other end!") is what we send
> commands to "receive-pack", right after some of the status are reset
> to REF_STATUS_OK or REF_STATUS_EXPECTING_REPORT by this chunk of code.
> So moving the generate_push_cert() part right before the "Finally,
> tell the other end!" part LGTM.

Sorry, I do not follow.  The loop in question is the one before
"Finally tell the other end".  The loop ends like so:

	for (ref = remote_refs; ref; ref = ref->next) {
		...
		if (args->dry_run || !status_report)
			ref->status = REF_STATUS_OK;
		else
			ref->status = REF_STATUS_EXPECTING_REPORT;
	}

and the patch moves a call to generate_push_cert() that looks at
remote_refs _after_ this loop, but generate_push_cert() function
uses a loop over remote_refs that uses check_to_send_update(), which
looks at ref->status's value to decide what to do.  Its correct
operation relies on ref->status NOT updated by the above loop.

The loop prepares the status field so that we can then read and
record the response against each ref updates from the other side.

The ref->status field is set to EXPECTING_REPORT, later to be
updated to REF_STATUS_OK or REF_STATUS_REMOTE_REJECT.  We can
clobber the original value of ref->status at this point only because
the loop depends on the fact that no check_to_send_update() call
will happen after the loop (because the ref->status field the
helper's operation depends on is already reset for the next phase of
operation).  The patch that moves generate_push_cert() call below
the loop, whether it is before or after the "Finally tell the other
end" loop, is therefore fundamentally broken, isn't it?

I do not think it would introduce such breakage if we teach
generate_push_cert() to pay attention to the atomicity, and that can
be done without reordering the calls in send_pack() to break the
control flow.

