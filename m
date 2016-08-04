Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3366620193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966116AbcHDTjl (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:39:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965711AbcHDTjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:39:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B98530146;
	Thu,  4 Aug 2016 15:39:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CHhwwp90aTXBffl6SfzRNnBPuOU=; b=yEpAf6
	0YekrnndDlvzQgB8LznTfyIFDhw0xpgF6N1nqGWbftbz5ny+mBxyecD+aBmTGD9Z
	LOhppZZf0ASsHQHyQRJU3NMf5Wzg+Q0pgkSxWY8ONMWrPanb6QwXIkgQpptM5knX
	fLyhExADll1fOarlMKCOmQHJKIfCSwzbvZPnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iMUUg2pnMCQor/4GATfrvbYDUvLfHLPj
	/RKsxaPqsIJHVq+wWOP5MJp/v3gaeZ6HDhCrSyLhHf3r1aGSl0Ws86gwiXti6b3m
	RvYnTTwaPCweLrBNvaUsBwGZDT6HHm0hv7bgwa8YlncgPTG7s21zxxcXeGetWCIR
	yeUmA/JVm2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0130130145;
	Thu,  4 Aug 2016 15:39:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 722BF30144;
	Thu,  4 Aug 2016 15:39:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
	<CA+P7+xo6q0pveVQdt1mynfsWq75DzBXsbPcgVYdd5s8rpO+97A@mail.gmail.com>
	<f7f35993-39a8-b788-d2a7-d030ac442b9b@alum.mit.edu>
Date:	Thu, 04 Aug 2016 12:39:30 -0700
In-Reply-To: <f7f35993-39a8-b788-d2a7-d030ac442b9b@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 4 Aug 2016 00:36:54 +0200")
Message-ID: <xmqqd1lo2uj1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AB6253C-5A7B-11E6-97F7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> +       }
>>> +       /*
>>> +        * We have reached the end of the line without finding any non-space
>>> +        * characters; i.e., the whole line consists of trailing spaces, which we
>>> +        * are not interested in.
>>> +        */
>>> +       return -1;

Not related to Jacob's review, but "the whole line consists of
trailing spaces" made me read it twice; while it is technically
correct, "the whole line consists of spaces", or even "this is a
blank line", would read a lot more easily, at least for me.

> I was implicitly assuming that such lines would have text somewhere
> after those 200 spaces (or 25 TABs or whatever). But you're right, the
> line could consist only of whitespace. Unfortunately, the only way to
> distinguish these two cases is to read the rest of the line, which is
> exactly what we *don't* want to do.

Hmm, why is it exactly what we don't want to do?  Is it a
performance concern?  In other words, is it because this function is
called many times to measure the same line multiple times?  After
all, somebody in this file is already scanning each and every line
to see where it ends to split the input into records, so perhaps a
"right" (if the "theoretical correctness" of the return value from
this function mattered, which you wave-away below) optimization
could be to precompute it while the lines are broken into records
and store it in the "rec" structure?

> But I think it doesn't matter anyway. Such "text" will likely never be
> read by a human, so it's not a big deal if the slider position is not
> picked perfectly. And remember, this whole saga is just to improve the
> aesthetics of the diff. The diff is *correct* (e.g., in the sense of
> applicable) regardless of where we position the sliders.

A better argument may be "if the user is truly reading a diff output
for such an unusual "text", it is likely that she has a very wide
display and/or running less -S, and treating such an overindented line
as if it were a blank line would give a result that is more consistent
to what appears on her display", perhaps?
