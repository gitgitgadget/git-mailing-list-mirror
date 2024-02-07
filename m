Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED82033E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707348393; cv=none; b=ZB5IFIGt5SJt3TRki+tryt1D42oe68/TSR/V6Vmqjua2WHBQ6PBgGiqqf29qg5sDZtk2n6jv9bIaiNU6lz/VgKQO3G1ALNEMxjLf16kyaEF5q2rxkq/kKpuNCFj/bfCmbu7o80eKljIrhgQNbh3M7UX6pHwvbwcI3nYzWqBPBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707348393; c=relaxed/simple;
	bh=U9HTDf609Dmg0UXJqKYdsnXA7/wxNpWPkl9XjxEosmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QtthN326qydNW/+v6LbcOvGVqFqJAU8xJSJs+O0Tzu4ZclsseEBztjG9grak52/HPoGm0zvAIeLR4c7ZE2OHOgngGARlPeLbx+RJt8TAiPkrX/brpkF2X2FaLhWQIi2etuN0d9mikw+X3Eh8QlazhQ1DGzwvjoBJGfnvpgfI6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RFJoX+vg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFJoX+vg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 917601DA756;
	Wed,  7 Feb 2024 18:26:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=U9HTDf609Dmg0UXJqKYdsnXA7/wxNpWPkl9Xjx
	EosmI=; b=RFJoX+vgiNsqlVcweJteneFmHJru50B5GqfGdZ4F9Fvv84bb01R9FK
	LTuRC6NkjkQbm19VX/xZ1DXN8szmpqS9YF+T99Zyny/UVK31BcvMpLwfse6RKZnn
	loNBcKe/yRWw+I+lslOpVLib7QL5Le6ns89nBk/uhVzsYsOnTv0Gg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 85E5F1DA755;
	Wed,  7 Feb 2024 18:26:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B94B41DA752;
	Wed,  7 Feb 2024 18:26:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 6/6] t/Makefile: run unit tests alongside shell
 tests
In-Reply-To: <20240207224350.GA537799@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 7 Feb 2024 17:43:50 -0500")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<cd7467a7bd51fbc01c999ee1bd7688770b1d11e5.1706921262.git.steadmon@google.com>
	<xmqqzfwc6lle.fsf@gitster.g>
	<20240207224350.GA537799@coredump.intra.peff.net>
Date: Wed, 07 Feb 2024 15:26:28 -0800
Message-ID: <xmqqle7vrh3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 524F4F52-C610-11EE-B980-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Not if they share the same command-line options. If you use something
> like "--state=slow,save", then the first run will write the list of all
> tests to ".prove", and then the second will run every test mentioned in
> .prove (in addition to the unit-tests provided on the command-line).
>
> You should be able to work around it by passing "--statefile". I _think_
> it might be OK to just do that unconditionally. Something like:
>
>   prove --exec $(TEST_SHELL_PATH $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
>   prove --statefile=.prove-unit-tests $(GIT_PROVE_OPTS) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
>
> and then it's just a noop if GIT_PROVE_OPTS doesn't use --state. But I
> haven't played with it myself.

I do not think it warrants such complexity.  The wrapper script is
fine.
