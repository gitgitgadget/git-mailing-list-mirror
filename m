Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6895DC34047
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E82420801
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQ/xL3x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRR2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60721 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRR2e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 316053E48C;
        Tue, 18 Feb 2020 12:28:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VXns+Y81MuKuLDj/94Su2h8ro/U=; b=IQ/xL3
        x6vlbhTXRhYLxs/5r/bPdn2CUjxLqCXxfp3zDwH1yGsZmTjyMwZcQBkAB95MkJGq
        g5sfhGxtz0pXeHVQxs06diEr0DxWgUZCdWi0PMzTGEZzTd381DqxTd9MvVugNv9g
        Iv9y8OFoibtszDYIgjK2gPh6tdEVe1ePc46vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h4tu63UeKmspgKkvreIAwEoNVkrOLEYq
        VDUcasIpm0jHG8BTgxIvU85euFSLLuon1pHDQIFh1ky7RpSPbTWmJby5EQD61eiL
        SpFo6attk0jj56qBpMPgh4yuDv3Zpj0lbcm2FuVK8yHyFhTpMW9T6ktsJaZEvGlB
        N8bafal8JVs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 291003E48B;
        Tue, 18 Feb 2020 12:28:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95A1D3E48A;
        Tue, 18 Feb 2020 12:28:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 06/15] rev-list: make --count work with --objects
References: <20200214182147.GA654525@coredump.intra.peff.net>
        <20200214182220.GF150965@coredump.intra.peff.net>
        <20200215004216.GA15192@syl.local>
        <20200215064818.GB1633703@coredump.intra.peff.net>
        <xmqqwo8mm7ii.fsf@gitster-ct.c.googlers.com>
        <20200218052438.GB1641086@coredump.intra.peff.net>
Date:   Tue, 18 Feb 2020 09:28:31 -0800
In-Reply-To: <20200218052438.GB1641086@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Feb 2020 00:24:38 -0500")
Message-ID: <xmqqsgj7kdog.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15F4DD60-5274-11EA-AE8A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Feb 16, 2020 at 03:34:13PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> > +	if (revs->count) {
>> >> > +		revs->count_right++;
>> >> > +		return;
>> >> > +	}
>> >> > +
>> >> 
>> >> Hmm. This puzzled me at first. Do you think that it could benefit from a
>> >> comment?
>> >
>> > What would it say (i.e., I'm not sure what confused you)?
>> 
>> I think the question reader had was "why *right*?"
>
> Ah. The answer is: because it's not SYMMETRIC_LEFT. ;)
>
> The counting code accumulates there by default when there are no side
> markings, so that's what it will report when there's no left_right or
> cherry_mark (which we know will be the case here, since we die()
> otherwise).

Yup.

	/*
	 * The object count is always accumulated in the .count_right
	 * field for traversal that is not a left-right traversal,
	 * and cmd_rev_list() made sure that a .count request that
	 * wants to count non-commit objects, which is handled by
	 * the show_object() callback, does not ask for .left_right.
	 */

Overkill?  I dunno.
