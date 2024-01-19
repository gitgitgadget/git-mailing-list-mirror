Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A95465E
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705703335; cv=none; b=QJrCO3QxMK4/qwMAFT2zTj/h/mhCNh2JQ1J2lQ1PShLMpzfnVENkd2b+5LCj56gG2DdvwdCmoo/NaLY9pD2I3iSI5R/BoBYJh4FXZHC2rw6yv6OfcG9JlAvuULjQJZwOyzFzwz0+vEn/omjQJSipBw9gVszanPOaiMab9vgb44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705703335; c=relaxed/simple;
	bh=j1U4fpSxprPItUQusVEmuvP/cpQODFypGD9TKXgxLFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VaKzJdluDXueW0G7tF7pc8OcN9umqgMbnQ/skNDSCyipHlGV6FsACnFSFGoHs2ucZFRm4HEqJ7D7YNvNCSacQAwSU9Fob7i+6HlP0ikWqIaB2XGAgdZTYNeqgy6+ayEGRde7fF7Alde6bqTQAODZvDp0OqYAUgseXQ6MlyztG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qTLg33JS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qTLg33JS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 714EC1D7183;
	Fri, 19 Jan 2024 17:28:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j1U4fpSxprPItUQusVEmuvP/cpQODFypGD9TKX
	gxLFE=; b=qTLg33JSO1e1kgJku1WJ0z2Ok8SGD12HFEiRGV1FzzKgCH2BLM1DMj
	CLBQVm2XLQ4FlZFcVCMOSPQKaEGrJoU2CzcH65rRrBcac4keWuBpALBSEknsGo/h
	fE4vZAzp6sKodMxWavAa30L6vwTYWzRzTIKjr/0AHfVICmBqD3Sbg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6817C1D7182;
	Fri, 19 Jan 2024 17:28:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCF121D7181;
	Fri, 19 Jan 2024 17:28:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Run limited fuzz tests in GitHub CI
In-Reply-To: <cover.1705700054.git.steadmon@google.com> (Josh Steadmon's
	message of "Fri, 19 Jan 2024 13:38:11 -0800")
References: <cover.1705700054.git.steadmon@google.com>
Date: Fri, 19 Jan 2024 14:28:50 -0800
Message-ID: <xmqqil3phs9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1F60BAC2-B71A-11EE-95E4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Add a simple smoke test in CI to make sure that the fuzz tests can build
> and execute properly. While we already compile the fuzz-test objects in
> the default make target, we don't link the executables due to these
> requiring clang-specific support. However, this means that the fuzz
> tests have been vulnerable to unnoticed build breakages as the code that
> they link against has changed over time.
>
> Adding this CI test should make such build breakages more visible more
> quickly.

Nice.

> Josh Steadmon (2):
>   fuzz: fix fuzz test build rules
>   ci: build and run minimal fuzzers in GitHub CI
>
>  .github/workflows/main.yml          | 11 +++++++++++
>  Makefile                            | 17 +++++++++++------
>  ci/run-build-and-minimal-fuzzers.sh | 19 +++++++++++++++++++
>  oss-fuzz/dummy-cmd-main.c           | 14 ++++++++++++++
>  4 files changed, 55 insertions(+), 6 deletions(-)
>  create mode 100755 ci/run-build-and-minimal-fuzzers.sh
>  create mode 100644 oss-fuzz/dummy-cmd-main.c
>
>
> base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
