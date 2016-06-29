Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA00020FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbcF2UpS (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:45:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751601AbcF2UpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:45:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 749FB2854C;
	Wed, 29 Jun 2016 16:39:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U8evB+jC9Yz42yrP7ZhNXT/BD9o=; b=w63E6z
	ZE8pelTDOZo18TTwwmrgq5hq1yEBc6wohmSu1rH6O9r9gaZ+TwNNCp+IsmVOd881
	qZp18Fv7jg1bpM7ttPKjk8xeqQUOWY1HVDwtA/JZVEW6Ysb+4vga0fMOsL1NSgzE
	mXoy1XKPiapm7xWzgoELdjOX6YuJ5L+xxnVUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDSIfaurc5Tj3H6M91BLDTd4ec+BF5Ut
	yUYRLlffhy3YK4umgKVRgkN1a8V2zxQRZTQA+vcjY1ixi6Ic3wK5DBLapy7A6Kgh
	Pq7pWa/DMu8xSUkAMu8oKQBkbXxBoe1GrwTYjuDUzxqf04zIyi52I8quJ9JUsF1R
	wN+e4O5O24E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D73F2854B;
	Wed, 29 Jun 2016 16:39:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9A4728549;
	Wed, 29 Jun 2016 16:39:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
	<CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
	<CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
Date:	Wed, 29 Jun 2016 13:39:17 -0700
In-Reply-To: <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
	(Stefan Beller's message of "Wed, 29 Jun 2016 13:20:37 -0700")
Message-ID: <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E1CC198-3E39-11E6-9EEB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Jun 29, 2016 at 11:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Wed, Jun 29, 2016 at 11:31 AM, Marc Strapetz
>> <marc.strapetz@syntevo.com> wrote:
>>> This is no RFE but rather recurring thoughts whenever I'm working with
>>> commit graphs: a topological index attribute for commit objects would be
>>> incredible useful. By "topological index" I mean a simple integer for which
>>> following condition holds true:
>>
>> Look for "generation numbers" in the list archive, perhaps?
>
> Thanks for the pointer to the interesting discussions.
>
> In http://www.spinics.net/lists/git/msg161363.html
> Linus wrote in a discussion with Jeff:
>
>> Right now, we do *have* a "generation number". It's just that it's
>> very easy to corrupt even by mistake. It's called "committer date". We
>> could improve on it.
>
> Would it make sense to refuse creating commits that have a commit date
> prior to its parents commit date (except when the user gives a
> `--dammit-I-know-I-break-a-wildy-used-heuristic`)?

I think that has also been discussed in the past.  I do not think it
would help very much in practice, as projects already have up to 10
years (and the ones migrated from CVS, even more) worth of commits
they cannot rewrite that may record incorrect committer dates.
You'd need something like "you can trust committer dates that are
newer that this date" per project to switch between slow path and
fast path, with an updated fsck that knows how to compute that
number after you pulled from somebody who used that overriding
option.

If the use of generation number can somehow be limited narrowly, we
may be able to incrementally introduce it only for new commits, but
I haven't thought things through, so let me do so aloud here ;-)

Suppose we use it only for this purpose:

 * When we have two commits, C1 and C2, with generation numbers G1
   and G2, we can say "C1 cannot possibly be an ancestor of C2" if
   G1 > G2.  We cannot say anything else based on generation
   numbers (or lack thereof).

then I think we could just say "A newly created commit must record
generation number G that is larger than generation numbers of its
parent commits; ignore parents that lack generation number for the
purpose of this sentence".

I am not sure if that limited use is all that useful, though.
