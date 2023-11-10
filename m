Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F21154BA
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sJad35ls"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B7118
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 15:27:32 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 283BF1BAB35;
	Fri, 10 Nov 2023 18:27:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PCl/RhD+vFcyxBY2oMiesqDUyIow23hUZhPfUX
	2ynno=; b=sJad35lsA2UwEF4ckvoNux1tmKiWuLnFpYbKF2CvjcbsMgvyLgVn1S
	++Dp0yURYB03lJqzWZi/mlP4TMIvCJBZQ/ZFtRGGqHyrSfluKoYp8PpCpj3qp/9H
	QYEqk1CMtBWTm1sMvXedj8zdeShxk93TBFNojbfRtWK5W8Q0tWL7o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F3BA1BAB34;
	Fri, 10 Nov 2023 18:27:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AE9E1BAB2D;
	Fri, 10 Nov 2023 18:27:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/4] contrib/subtree: stop using `-o` to test for number
 of args
In-Reply-To: <ZU4DiTQbKyuuT55k@tanuki> (Patrick Steinhardt's message of "Fri,
	10 Nov 2023 11:18:49 +0100")
References: <cover.1699526999.git.ps@pks.im>
	<b1ea45b8a8884d09ab070bb0f099834447d28938.1699526999.git.ps@pks.im>
	<20231109185515.GD2711684@coredump.intra.peff.net>
	<xmqq8r76zg1j.fsf@gitster.g> <ZU4DiTQbKyuuT55k@tanuki>
Date: Sat, 11 Nov 2023 08:27:30 +0900
Message-ID: <xmqqpm0hur31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B858A63A-8020-11EE-A21A-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Nov 10, 2023 at 08:02:32AM +0900, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> >>  # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
>> >>  process_subtree_split_trailer () {
>> >> -	assert test $# = 2 -o $# = 3
>> >> +	assert test $# -ge 2
>> >> +	assert test $# -le 3
>> > ...
>> >> -	elif test $# -eq 1 -o $# -eq 2
>> >> +	elif test $# -eq 1 || test $# -eq 2
>> >
>> > OK, this one is a straight-forward use of "||".
>> 
>> Yes, but why not consistently use the range notation like the
>> earlier one here, or below?
>
> I opted to go for the "obvious" conversion, if there was one easily
> available, to make the diff easier to read.

... and due to the limitation of "assert" we cannot do the obvious

	test $# = 2 || test $# = 3

and feed it to "assert" (and for equality with $#, = and -eq would
work equally fine, and = is much more readable, by the way).

OK, then.
