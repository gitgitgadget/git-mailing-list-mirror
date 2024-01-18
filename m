Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555B17C3
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540646; cv=none; b=FGgVFXyphow9YFus471m0XewXsXuNnP504WaoPUPCldjwVb9qTpmP/QRVoTrfQAnUXkMyPCDlaU02Pmw3mlZFUsoN9lCYcYHI4tCJcEUr6DHuBi2tlGrVP544qIK3/6c8pBKHadOCWFg6iElAp57oYjYu6RoBivcSVOBh5dbUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540646; c=relaxed/simple;
	bh=MvASGzva1h6BPWbyS1QE0RnkjjceeufZZXgS45NJVRg=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=FUBGd+HCQDh3ClVt9tQVCfruP6qzaYZg6uiS1D08QLRKB7mn1PHrF8kPROFqyuxifRcuq3ht7tm9Erd7GnZMCWQfpvHuta012hquWqF3rrvqlT4PvLbh59ipaYbsVIR+bh6gF+NnZSOak2YRyFXF4hMtOIOODeIqAG+gw/1hOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YodSxWEQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YodSxWEQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 62CDB31217;
	Wed, 17 Jan 2024 20:17:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MvASGzva1h6BPWbyS1QE0RnkjjceeufZZXgS45
	NJVRg=; b=YodSxWEQyFjr+07AblIMVyZs+O9ZtOJVJ5xJWj6FhMW1gfI7rFf1ZZ
	yr4z7jk1XwUWA1/SdD1ZCk6+wio3AlTNtJuQlND5YqVCmPrlsQg5QiOBZOsSRWAt
	0GuJOJVO5eWFhMCwKsONRr7m4tR2OoSLk/Bq5/cT54ITSO05GLIBA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B33F31216;
	Wed, 17 Jan 2024 20:17:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CEF8B31215;
	Wed, 17 Jan 2024 20:17:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 00/12] Group reffiles tests
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com> (John Cai
	via GitGitGadget's message of "Wed, 17 Jan 2024 19:52:23 +0000")
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 17:17:17 -0800
Message-ID: <xmqqv87rsan6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 52CCDBEC-B59F-11EE-8BD4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series groups REFFILES specific tests together. These tests are
> currently grouped together across the test suite based on functionality.
> However, since they exercise low-level behavior specific to the refs backend
> being used (in these cases, the ref-files backend), group them together
> based on which refs backend they test. This way, in the near future when the
> reftables backend gets upstreamed we can add tests that exercise the
> reftables backend close by in the t06xx area.
>
> These patches also remove the REFFILES prerequisite, since all the tests in
> t06xx are reffiles specific.

As we already have REFFILES lazy prereq, even _before_ we enable the
reftable backend, I think that we should start t0600 and t0602 with

	. ./test-lib.sh
	if ! test_have_prereq REFFILES
	then
		skip_all='skipping reffiles specific tests'
		test_done
	fi

which is more in line with the existing convention.  It is more
efficient than "forcing t0600 and t0602 to run always with reffiles"
when you have a CI job that uses reftable for all tests and another
CI job that uses reffiles for all tests.

> In the near future, once the reftable backend is upstreamed, all
> the tests in t06xx will be forced to run with the reffiles
> backend.

Presumably if there are reftable backend specific tests, they will
also be given names out of t06xx range, right?  And then they will
be skipped when the test is not using reftable as the default ref
backend, using the REFTABLE prerequisite in a similar way as shown
above for REFFILES, right?

Thanks.

