Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73AA203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbcGVRBP (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:01:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752161AbcGVRBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:01:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC27B2CAC6;
	Fri, 22 Jul 2016 13:01:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y4EFuNdnAgKL/+TADG7gkAl2dSE=; b=FrUh2K
	pQqavQfUpQw0u75QkXZlnDJpJ0IxkpmC/6fDWUEoGC0N+UAKFB4NjHwDPV97F527
	sSE6E+UpcOsPqPYy93CtarkfgiqeFHBzae7oNkCnjF+J5vsfY0s8ciiy6ellznOE
	6Lwdbf+QPcufOCDUTPfAgWoLMM1+kbt2q4Fdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W8pyOJ2EZCg9tWPpUyagrWfBE2tw3Irr
	7jE9Ycbz0Sgb9PJKwRgQBajyAlOFTPrM30KoO/SD7f03/FR0u6Rh+/Pp3ZMXbR6w
	dGmuJbiugsT/zX09tEY1SLxEKgg63N1wRWlOF64HM1SbsCKd3pCVnXIN7f5WswOx
	xu8ryHk8qr4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2C372CAC5;
	Fri, 22 Jul 2016 13:01:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F1672CAC4;
	Fri, 22 Jul 2016 13:01:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	peff@peff.net
Subject: Re: [PATCH v1 3/6] Per-file output for Porcelain Status V2
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
	<1468966258-11191-4-git-send-email-jeffhost@microsoft.com>
	<xmqqh9bkc7xx.fsf@gitster.mtv.corp.google.com>
	<57911B5B.9090604@jeffhostetler.com>
Date:	Fri, 22 Jul 2016 10:01:10 -0700
In-Reply-To: <57911B5B.9090604@jeffhostetler.com> (Jeff Hostetler's message of
	"Thu, 21 Jul 2016 14:58:35 -0400")
Message-ID: <xmqqinvxboa1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4D0B2FA-502D-11E6-ACA4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>> +	case DIFF_STATUS_DELETED:
>>> +		d->porcelain_v2.mode_index = p->one->mode;
>>> +		hashcpy(d->porcelain_v2.sha1_index, p->one->sha1);
>>> +		break;
>>> +
>>> +	case DIFF_STATUS_COPIED:
>>> +	case DIFF_STATUS_MODIFIED:
>>> +	case DIFF_STATUS_RENAMED:
>>
>> Can RENAMED or COPIED happen here?
>
> If we don't report renamed or copied for unstaged changes, then no.

The question was "do we report such cases"?

>>> +	if (!d->index_status) {
>>> +		if (d->worktree_status == DIFF_STATUS_MODIFIED ||
>>> +			d->worktree_status == DIFF_STATUS_DELETED) {
>>> +			/* X=' ' Y=[MD]
>>> +			 * The item did not change in head-vs-index scan so the head
>>> +			 * column was never set. (The index column was set during the
>>> +			 * index-vs-worktree scan.)
>>> +			 * Force set the head column to make the output complete.
>>> +			 */
>>> +			d->porcelain_v2.mode_head = d->porcelain_v2.mode_index;
>>> +			hashcpy(d->porcelain_v2.sha1_head, d->porcelain_v2.sha1_index);
>>> +		}
>>
>> Can there be "else" clause for this inner "if"?  When
>> d->index_status is not set, but worktree_status is not one of these
>> two, what does it indicate?  The same for the next one.
>
> For a normal entry (not unmerged) when X is ' ', Y can only
> be 'M' or 'D'.  The only other value for Y is ' ', but then if
> both were ' ' the entry would not be in the list.  So I think
> we're OK, but I'll document that here.  And below.

Good.

>>> +	memset(stages, 0, sizeof(stages));
>>> +	pos = cache_name_pos(it->string, strlen(it->string));
>>> +	assert(pos < 0);
>>> +	pos = -pos-1;
>>> +	while (pos < active_nr) {
>>> +		ce = active_cache[pos++];
>>> +		stage = ce_stage(ce);
>>> +		if (strcmp(ce->name, it->string) || !stage)
>>> +			break;
>>> +		stages[stage - 1].mode = ce->ce_mode;
>>> +		hashcpy(stages[stage - 1].sha1, ce->sha1);
>>> +	}
>>
>> You did assert(pos < 0) to make sure that the path the caller told
>> you is unmerged indeed is unmerged, which is a very good check.  In
>> the same spirit, you would want to make sure that you got at least
>> one result from the above loop, to diagnose a bug where the path did
>> not even exist at all in the index.
>
> Would that be possible for a conflict/unmerged entry?

It is possible to exactly the same degree as it is possible you
would get !(pos < 0) answer from cache_name_pos() here, I would
think.  The assert() you have up above is protecting us from either
a broken caller to this function that gives an it that points at a
merged path (in which case the assert is violated) or a breakage in
cache_name_pos().  Making sure the loop finds at least one unmerged
entry protects us from similar kind of breakage that violates the
expectation this code has from the other parts of the code.


Thanks.
