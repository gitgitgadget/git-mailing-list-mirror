Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA48662E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339326; cv=none; b=IK61MZPg0IO4JuWF9uOxp8nC8rauHUjdwQtPw7t6ElIxMS/uHV4L2gdbEzr5gzpWkIMu+X1WhnG1D6Sq18XBOE1xgVhDl7EZWVU1c31LnMBvZxx5Kb251JckSms3b6llecfOvweTG74ggGp+TX2luPaZQAhR6Uj5jF+shvLdbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339326; c=relaxed/simple;
	bh=oZ0gK1BfWQmkfBsNrsK06PoQGs7kz7T6FNdz3YzHIkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pOWak65K1r1U+gZc0Loaw3QnzkRO3hH8tq0qj70VFKRBsF/06+s6+gwcr2/vR+sW9gqJX77nnoZY0kT1epRgWzWqc+ewSWQ531TYYdSrMNoSkc1AAIr6CC5al72jdDOrhVIhWa3nvYgJat7uwBj26xqDo8WnfaF39vJZptw95rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jDIuMXCv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jDIuMXCv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4BA41DFB59;
	Wed,  7 Feb 2024 15:55:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oZ0gK1BfWQmkfBsNrsK06PoQGs7kz7T6FNdz3Y
	zHIkg=; b=jDIuMXCvqbYZKbPBiGEOBOzP3sIu18ja0TEFs8fi+ndfxhrtsJ5bJW
	tEmWGPvofp09mbt9bfyPrDVLm8XXwAnx8evWn3EqbqKZLRLjoF6gE3xEk4corNLo
	Z78Tx/j2FGBjIGxZNJmfXqBwXyD9HyXYKFmSlvnFYg+bVVwtBQKTI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCA1C1DFB58;
	Wed,  7 Feb 2024 15:55:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2750A1DFB55;
	Wed,  7 Feb 2024 15:55:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
In-Reply-To: <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 2 Feb 2024 16:50:26 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
Date: Wed, 07 Feb 2024 12:55:16 -0800
Message-ID: <xmqqsf246ll7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 329E7C88-C5FB-11EE-A1E3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> -UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
> -UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
> +UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))

Nice that we no longer need the special casing.

> diff --git a/t/unit-tests/t-basic.c b/t/helper/test-example-tap.c
> similarity index 95%
> rename from t/unit-tests/t-basic.c
> rename to t/helper/test-example-tap.c
> index fda1ae59a6..21e4848e78 100644
> --- a/t/unit-tests/t-basic.c
> +++ b/t/helper/test-example-tap.c
> @@ -1,4 +1,5 @@
> -#include "test-lib.h"
> +#include "t/unit-tests/test-lib.h"
> +#include "test-tool.h"

As the first thing both of these headers include is
"git-compat-util.h", so the ordering should be safe either way,
because everybody else in the directory seems to include
"test-tool.h" before including headers that are specific to the
subsystem it is testing, and "t/unit-tests/test-lib.h" in this case
is the header that is specific to the unit-test subsystem being
tested, it may raise fewer eyebrows if we swapped the order of the
inclusion here.

Other than that, looks good to me.

Thanks.
