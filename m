Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3213C913
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563569; cv=none; b=Mj5KDB9zrqrk/I1rpQp6G58d0HDs+1wBcqo/Ka6NBn5f/FGcDXyYov1K9rm6o0q37zL8whF2wiyot6VqAE9YONCokl1SktO3yFbLQhqNOzRv3iy0XX8Y+1eBaaduS2Xsf807Hal4h9EcMN6VQTyQ5cZRkftXfO9jDCwE1bqarVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563569; c=relaxed/simple;
	bh=5/KelMztiR3ohcLeLFm5ghThs5m7T6l/2ICvBTT032Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XJX8GQZ2vzSCn2L2Ujd+YiNi0MrdewVLj2OagHe0X6Wsy4y5gLNCmIVBwcsUYkge12DwDphldrixnWUJzBkZ2CJoOqwIPnu/NNybyfPAFtEJGjL6iYAry7vH7MNKw+XULPG+4VPzD4bTaiAM3Nq17Q7iGcjRONz6HSr16iCa8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a6Vu84fo; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a6Vu84fo"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E2C934801;
	Fri, 19 Apr 2024 17:52:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5/KelMztiR3ohcLeLFm5ghThs5m7T6l/2ICvBT
	T032Y=; b=a6Vu84fogBh80k4tsu56VtWvrlTgvFtCsM6CGAK6OW8qeW5x+lrrHM
	7RdP1vYnETYVMDA/h5nPH4SWh+OafiCZufL5KXo6At9QwyrldMGYUJLrTI3V2/g3
	fg4tzbGKM+RKHbZPOQDm5bXuRjmyjdB9jOGloAQhIfdQL5RyXCsI8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9777634800;
	Fri, 19 Apr 2024 17:52:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16EBB347FF;
	Fri, 19 Apr 2024 17:52:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 2/8] trailer: add unit tests for trailer iterator
In-Reply-To: <e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Fri, 19 Apr 2024 05:22:27
	+0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 14:52:42 -0700
Message-ID: <xmqq5xwd58b9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26E4DCE6-FE97-11EE-8D5D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +UNIT_TEST_PROGRAMS += t-trailer
>  UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o

Totally offtopic, but does it bother folks who are interested in
adding more unit tests that they do not seem to interact very well
with GIT_SKIP_TESTS environment variable?

> diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
> new file mode 100644
> index 00000000000..147a51b66b9
> --- /dev/null
> +++ b/t/unit-tests/t-trailer.c
> @@ -0,0 +1,175 @@
> +#include "test-lib.h"
> +#include "trailer.h"
> +
> +static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
> +{
> +	struct trailer_iterator iter;
> +	size_t i = 0;
> +
> +	trailer_iterator_init(&iter, msg);
> +	while (trailer_iterator_advance(&iter)) {
> +		i++;
> +	}

Unnecessary {braces} around a single-statement block?

> +	trailer_iterator_release(&iter);
> +
> +	check_uint(i, ==, num_expected_trailers);
> +}
> +
> +static void run_t_trailer_iterator(void)
> +{
> +	static struct test_cases {
> +		const char *name;
> +		const char *msg;
> +		size_t num_expected_trailers;

This is more like number of lines in the trailer block, not
limiting its count only to true trailers, no?

> +	} tc[] = {
> ...
> +		{
> +			"with non-trailer lines in trailer block",
> +			"subject: foo bar\n"
> +			"\n"
> +			/*
> +			 * Even though this trailer block has a non-trailer line
> +			 * in it, it's still a valid trailer block because it's
> +			 * at least 25% trailers and is Git-generated.
> +			 */
> +			"not a trailer line\n"
> +			"not a trailer line\n"
> +			"not a trailer line\n"
> +			"Signed-off-by: x\n",
> +			1
> +		},

It is OK to leave it num_expected_trailers in this step and then
rename it when you update this "1" (number of real trailer lines)
to "4" (number of lines in the trailer block).

I wonder if you'd want to make more data available to the test.  At
least it would be more useful if the number of true trailer lines
and the number of lines in the trialer block are available
separately.

The interface into the trailers that is being tested by this code is
"the caller repeatedly calls the iterator, and the caller can
inspect the iterator's state available as its .raw, .key and .val
members and use them as it sees fit", so you could check, if you
wanted to, the following given the above sample data:

 * the first iteration finds no key/value pair (optionally, the
   contents found in the .raw member is as expected).
 * the second iteration finds no key/value pair (ditto).
 * the third iteration finds no key/value pair (ditto).
 * the fourth iteration finds key="Signed-off-by" value="x".
 * there is no fifth iteration.

but the current code only checks the last condition and nothing
else.  I dunno.
