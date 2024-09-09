Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FC16DEB4
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905867; cv=none; b=pi7Pr6I0EBaDbyXoZKQQw98OIFizXltvoYdGrvE+E3V68CI0RlQrOTwGUjXK9ggGksksXSLb5ywvwnhPRJRhK3nnNuF8CC/559ok6wWm/IFr2zxFruFGZxGF8XM7o94yuwDIsjYRGyA1k1M4tR/HXt0qAPQcttz01FeVNANpGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905867; c=relaxed/simple;
	bh=zLlv1wNCdHBz62mi8GtvB2UTjzrmM8zAgPPZwzlIMRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRaJLVUVZb/Z0UB/6Vp6sQAaSGxxMI3Q8HRYuQopg9O35yetc8pq1PXsVvaRQNhyM+IZvia4PytDNqdhjdOPjmF6gOdnaY9OPgZR0gxj0ASjs7teA47i2ewszkllsS1IepdlTcqCwCBi4zFdCKuXdfo7evJUJd+sd5QQhMTDMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sxr4/+Mj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sxr4/+Mj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B643295FC;
	Mon,  9 Sep 2024 14:17:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zLlv1wNCdHBz62mi8GtvB2UTjzrmM8zAgPPZwz
	lIMRk=; b=Sxr4/+Mj8P5+0mWKWv8GXzYlr5On7pWeQVi6gzyMIztahMpotoEPt/
	gwhPcQ8m4ZwfJ034FXgFtr2AnIeNRRZlfKNwZQue4y3e01dzD5zRJJmZSt2OJBmq
	p5mUjamslqYyWLtJvvl5vlsT808Wb4f4n90Z21WGCDSb50suXhwzk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4285D295FB;
	Mon,  9 Sep 2024 14:17:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99735295FA;
	Mon,  9 Sep 2024 14:17:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>,  rsbecker@nexbridge.com,  Edward Thomson
 <ethomson@edwardthomson.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 10/14] Makefile: wire up the clar unit testing framework
In-Reply-To: <9c74c5ae01989659c0347d2742f820d2161d274b.1725459142.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 4 Sep 2024 16:17:12 +0200")
References: <cover.1722415748.git.ps@pks.im> <cover.1725459142.git.ps@pks.im>
	<9c74c5ae01989659c0347d2742f820d2161d274b.1725459142.git.ps@pks.im>
Date: Mon, 09 Sep 2024 11:17:43 -0700
Message-ID: <xmqqfrq8r8s8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF49571C-6ED7-11EF-A83C-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
> +UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
> +UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> +UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> +
>  UNIT_TEST_PROGRAMS += t-ctype
>  UNIT_TEST_PROGRAMS += t-example-decorate
>  UNIT_TEST_PROGRAMS += t-hash
> @@ -2714,6 +2721,7 @@ OBJECTS += $(XDIFF_OBJS)
>  OBJECTS += $(FUZZ_OBJS)
>  OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
>  OBJECTS += $(UNIT_TEST_OBJS)
> +OBJECTS += $(UNIT_TESTS_OBJS)

What is the longer term direction we envision?  Do we aim to retire
the UNIT_TEST_* and end up with only the clar based tests?

At least until that happens, can we have "UNIT_TESTS" -> "CLAR_TEST"
or something that makes it less confusing?  Every time I see merge
conflicts around this area in the Makefile, I get puzzled and wonder
which one is which.

Thanks.


