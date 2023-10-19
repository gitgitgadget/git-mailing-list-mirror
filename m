Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC236B17
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DGrp3KRZ"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6519112
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:55:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 045251C9823;
	Thu, 19 Oct 2023 13:55:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=shqb9TC28mj5c9yCeHl0jZSZBI3kV7Dm+YhpFy
	XwUVE=; b=DGrp3KRZ6OMy8+3traWHf7I+1G3+8eYLdt9CAkj8zm3UZIVwmcHuZK
	/89SXhG8SvO1W8Swf1DauKlE4dYdbnJWFg455CQN2q40VzKFIFZIDujVkCBMPWQn
	AYJU/4RkahTN7wx9EjRBBezUFRbokFWkGcwIHxSpkx2Xw55iqtpHc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E27FD1C9821;
	Thu, 19 Oct 2023 13:55:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07D521C9820;
	Thu, 19 Oct 2023 13:55:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han-Wen Nienhuys <hanwen@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 00/11] t: reduce direct disk access to data structures
In-Reply-To: <CAFQ2z_Om724+o+EG1FAhC9VrvJECnQ5UA+Z04Rzycpi_mXvMHg@mail.gmail.com>
	(Han-Wen Nienhuys's message of "Thu, 19 Oct 2023 12:13:12 +0200")
References: <cover.1697607222.git.ps@pks.im> <xmqqbkcwuetq.fsf@gitster.g>
	<CAFQ2z_Om724+o+EG1FAhC9VrvJECnQ5UA+Z04Rzycpi_mXvMHg@mail.gmail.com>
Date: Thu, 19 Oct 2023 10:55:08 -0700
Message-ID: <xmqq8r7yxzsz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A542318A-6EA8-11EE-A972-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Han-Wen Nienhuys <hanwen@google.com> writes:

> I think it would be really great if there were separate unittests for
> the ref backend API. Some of the reftable work was needlessly
> difficult because the contract of the API was underspecified. The API
> is well compartmentalized in refs-internal.h, and a lot of the API
> behavior can be tested as a black box, eg.
>
> * setup symref HEAD pointing to R1
> * setup transaction updating ref R1 from C1 to C2
> * commit transaction, check that it succeeds
> * read ref R1, check if it is C2
> * read reflog for R1, see that it has a C1 => C2 update
> * read reflog for HEAD, see that it has a C1 => C2 update
>
> Tests for the loose/packed backend could directly mess with the
> on-disk files to test failure scenarios.
>
> With unittests like that, the tests can zoom in on the functionality
> of the ref backend, and provide more convenient coverage for
> dynamic/static analysis.

Yeah, I agree that something like that would really be great.
