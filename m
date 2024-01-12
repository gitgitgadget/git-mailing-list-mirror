Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B8182A1
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="heErX92z"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E90F28D4F;
	Fri, 12 Jan 2024 17:44:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oFbqaEHj/HPzZm/+jI1BU89yU0kmHBy8NtsWou
	Bq2V4=; b=heErX92zQZ7BuM8L/hXuvZmjVN/0uzrGK3+Pc0RxtdeluJFe05tM1g
	psv4pGuZFbLd7bQhIIKHtVGbLWwNlkNCtU8OKqzjtZt+i4RBQOxFheu1R6NhaBCF
	Su+IJu96Oa+RDiP7rnQW0kxk6cSHomn5ojfjAlhKwK/U/TyZlmxAg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 49C9F28D4E;
	Fri, 12 Jan 2024 17:44:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6A49D28D4D;
	Fri, 12 Jan 2024 17:44:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Achu Luma <ach.lumap@gmail.com>, =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH] Port helper/test-advise.c to
 unit-tests/t-advise.c
In-Reply-To: <20240112102122.1422-1-ach.lumap@gmail.com> (Achu Luma's message
	of "Fri, 12 Jan 2024 11:21:22 +0100")
References: <20240112102122.1422-1-ach.lumap@gmail.com>
Date: Fri, 12 Jan 2024 14:44:37 -0800
Message-ID: <xmqqmsta6uju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2B4CA57C-B19C-11EE-BAC0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Achu Luma <ach.lumap@gmail.com> writes:

> In the recent codebase update (8bf6fbd00d (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
>
> This commit migrates the unit tests for advise_if_enabled functionality
> from the legacy approach using the test-tool command `test-tool advise`
> in t/helper/test-advise.c to the new unit testing framework
> (t/unit-tests/test-lib.h).
>
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).

In the light of the presense of work like this one

  https://lore.kernel.org/git/c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com/

I am not sure if moving this to unit-test framework is a good thing,
at least right at this moment.

To test the effect of setting one configuration variable, and ensure
it results in a slightly different advice message output to the
standard error stream, "test-tool advice" needs only a single line
of patch, but if we started with this version, how much work does it
take to run the equivalent test in the other patch if it were to be
rebased on top of this change?  It won't be just the matter of
adding a new TEST(check_advise_if_enabled()) call to cmd_main(),
will it?

I doubt the issue is not about "picking the right moment" to
transition from the test-tool to unit testing framework in this
particular case.  Is "check-advice-if-enabled" a bit too high level
a feature to be a good match to "unit" testing, I have to wonder?

Thanks.

