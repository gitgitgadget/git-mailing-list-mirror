Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBF4BAA0
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950586; cv=none; b=o5aqKdN3lMQKnHHFpv8bd1s1HXoHknIy2WX6NEH6ndixBkInWAUpPanoc+cGAtKhG4Uw1oUkXtH0ndwrWQ79vF0IhMyE5PBwNZXUP/EQ3FZOfePrHmlmX+mdHZWFjDkjJImwTgQQyfLv94xnG4TFW5IPTSRPNrjfpFffnSidhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950586; c=relaxed/simple;
	bh=FafFUV9G5JPX51f/uJZl2upOXO0UIidobmQOcsxyX3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vkr7RPBGdm2Za67so04sevQuqt1XZiXR4gfNAzjDu2W+/YDKJsIj5n4KLbM11xIy1EtodLXUtsWWMLoIniBWEoEVEBErwY/oFnAMrJQ+pfwT+HjMr0WjDN244khHl+qhEp92dUvcAr2AYXqMcq3Egxc0HCGkqb6zUGPcDS1RAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TSyQsWXy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TSyQsWXy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B22B2A398;
	Mon, 22 Jan 2024 14:09:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FafFUV9G5JPX51f/uJZl2upOXO0UIidobmQOcs
	xyX3U=; b=TSyQsWXyFiGpqxglzg3T1RfAOTyp/gkRWWMYtZshLFZ0MDmjEANAKP
	vNQ3FY4WC9VWan8yGvUfOiCoJ9mf2zWWkjRJ6M7qRRINLX6lE0Ml813BnV8QRa4o
	8aHPGhm8fItVxjXPMkGRBMm+DFUbkAJw7kLQXQSHQdukrtsN/bUVw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 542E92A397;
	Mon, 22 Jan 2024 14:09:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E08442A396;
	Mon, 22 Jan 2024 14:09:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap3519@gmail.com>,
  Jeff King <peff@peff.net>,  Phillip Wood <phillip.wood123@gmail.com>,
  Chandra Pratap <chandrapratap376@gmail.com>
Subject: Re: [PATCH v4] tests: move t0009-prio-queue.sh to the new unit
 testing framework
In-Reply-To: <pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Sun, 21 Jan 2024 19:28:45
	+0000")
References: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
	<pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com>
Date: Mon, 22 Jan 2024 11:09:39 -0800
Message-ID: <xmqqwms1tcb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB510CE2-B959-11EE-BEBD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

> diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
> new file mode 100644
> index 00000000000..d78b002f9ea
> --- /dev/null
> +++ b/t/unit-tests/t-prio-queue.c
> @@ -0,0 +1,98 @@
> +#include "test-lib.h"
> +#include "prio-queue.h"
> +
> +static int intcmp(const void *va, const void *vb, void *data UNUSED)
> +{
> +	const int *a = va, *b = vb;
> +	return *a - *b;
> +}
> +
> +
> +#define MISSING  -1
> +#define DUMP	 -2
> +#define STACK	 -3
> +#define GET	 -4
> +#define REVERSE  -5
> +
> +static int show(int *v)
> +{
> +	return v ? *v : MISSING;
> +}
> +
> +static void test_prio_queue(int *input, int *result, size_t input_size)
> +{
> +	struct prio_queue pq = { intcmp };
> +
> +	for (int i = 0, j = 0; i < input_size; i++) {
> +		void *peek, *get;
> +		switch(input[i]) {

Style: in this codebase, a flow control keyword followed by a
parenthesized stuff always get a single SP before the parenthesis.

		switch (input[i]) {

There are similar style violations in this patch with if().

> +		case GET:
> +			peek = prio_queue_peek(&pq);
> +			get = prio_queue_get(&pq);
> +			if (!check(peek == get))
> +				return;
> +			if(!check_int(result[j++], ==, show(get)))
> +				test_msg("failed at result[] index %d", j-1);
> +			break;
> +		case DUMP:
> +			while ((peek = prio_queue_peek(&pq))) {
> +				get = prio_queue_get(&pq);
> +				if (!check(peek == get))
> +					return;
> +				if(!check_int(result[j++], ==, show(get)))
> +					test_msg("failed at result[] index %d", j-1);
> +			}
> +			break;

OK.  So this one checks as we go.  I am not sure how easy to grok a
breakage diagnosis with these giving the same message, without
giving any context of the failure (e.g. when we are fed

	INPUT  = 6 2 4 GET 5 3 GET GET 1 DUMP
	EXPECT = 2 3 4 1 5 6

and for some reason if the first GET did not yield expected 2 but
gave us, say, 6, we only see "left: 2, right: 6" followed by "failed
at result[] index 0", and nothing else.  

If it said something like "We pushed 6, 2, 4 and then did GET" to
give the reader a bit more context, it would make it easier to see
why we were complaining, i.e. expecting to see 2, instead getting 6.
But perhaps that is too much to ask to this code?

I dunno.  Those who wanted to see an easier-to-diagnose output may
have better ideas.

Thanks.

> +		case STACK:
> +			pq.compare = NULL;
> +			break;
> +		case REVERSE:
> +			prio_queue_reverse(&pq);
> +			break;
> +		default:
> +			prio_queue_put(&pq, &input[i]);
> +			break;
> +		}
> +	}
> +	clear_prio_queue(&pq);
> +}
> +
> +#define BASIC_INPUT 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP
> +#define BASIC_RESULT 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10
> +
> +#define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
> +#define MIXED_PUT_GET_RESULT 2, 3, 4, 1, 5, 6
> +
> +#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
> +#define EMPTY_QUEUE_RESULT 1, 2, MISSING, 1, 2, MISSING
> +
> +#define STACK_INPUT STACK, 8, 1, 5, 4, 6, 2, 3, DUMP
> +#define STACK_RESULT 3, 2, 6, 4, 5, 1, 8
> +
> +#define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
> +#define REVERSE_STACK_RESULT 1, 2, 3, 4, 5, 6
> +
> +#define TEST_INPUT(INPUT, RESULT, name)			\
> +  static void test_##name(void)				\
> +{								\
> +	int input[] = {INPUT};					\
> +	int result[] = {RESULT};				\
> +	test_prio_queue(input, result, ARRAY_SIZE(input));	\
> +}
> +
> +TEST_INPUT(BASIC_INPUT, BASIC_RESULT, basic)
> +TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_RESULT, mixed)
> +TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_RESULT, empty)
> +TEST_INPUT(STACK_INPUT, STACK_RESULT, stack)
> +TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_RESULT, reverse)
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	TEST(test_basic(), "prio-queue works for basic input");
> +	TEST(test_mixed(), "prio-queue works for mixed put & get commands");
> +	TEST(test_empty(), "prio-queue works when queue is empty");
> +	TEST(test_stack(), "prio-queue works when used as a LIFO stack");
> +	TEST(test_reverse(), "prio-queue works when LIFO stack is reversed");
> +
> +	return test_done();
> +}
>
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
