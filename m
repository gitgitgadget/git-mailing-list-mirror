Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D251A254F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576979; cv=none; b=QT93QXomcvot/f2CwARrSe7D4OMWj3cCvFSfoWNT8bipptdyIX8Yr3xkdlCrV72TGYcynMwvmPEbAzeb+vorp/CJ+oV9a5Q+zwnYHKgQzap35TTrQW1w5nBpWQK4pborp++lhxRB1TzBLY2b8qRGIML+qxNGDJ3lBs0QhJizlgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576979; c=relaxed/simple;
	bh=gWlG0Oer5yT8MfImu+Tku2v3qf3ajwFl1RSnc2soBMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkHynHcYGdr1Ounjwc95q8YB4PkAampj6HWJsRzGPSwanoFUKnIJZ9tY/EwxhoMnPbOnUSOt7br2/+wgbdLpDsfNYDI543yNVgwKVVuI2nfDfi7RASa3klagCLNrD1x60LEpgIy+XBPcETxFvSwLvb3JBGJiItEdOxa74S8QgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bj1nXi+w; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bj1nXi+w"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B5F336F6F;
	Tue, 13 Aug 2024 15:22:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gWlG0Oer5yT8MfImu+Tku2v3qf3ajwFl1RSnc2
	soBMk=; b=Bj1nXi+wwqX4fg/Om7CroaX+61/xRpd3uW6aMaBxAU66vIKOTEXzvJ
	vtq3PxnY3IBvqT/2kBqXEvcXNENxT3V1QBlDNvwo0ltvhfasXd/iIDrDLNSzxBSS
	nk8l4sFASE9MiDf4n0nOimS9I+vHm3eZ6WTo23suIPyIxY2T6x8oQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 634D536F6E;
	Tue, 13 Aug 2024 15:22:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7FF436F6D;
	Tue, 13 Aug 2024 15:22:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate t0110-urlmatch-normalization to the
 new framework
In-Reply-To: <20240813172432.55487-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Tue, 13 Aug 2024 22:54:21 +0530")
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
	<20240813172432.55487-1-shyamthakkar001@gmail.com>
Date: Tue, 13 Aug 2024 12:22:52 -0700
Message-ID: <xmqqh6bo448j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7030B920-59A9-11EF-B7BC-BF444491E1BC-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> With the addition of this unit test, we impose a new restriction of
> running the unit tests from either 't/' or 't/unit-tests/bin/'
> directories. This is to construct the path to files which contain some
> input urls under the 't/t-urlmatch-normalization' directory. This
> restriction is similar to one we have for end-to-end tests, where they
> can be ran from only 't/'.
>
> Addition of 't/unit-tests/bin/' is to allow
> for running individual tests which is not currently possible via any
> 'make' targets and also 'unit-tests-test-tool' target is also ran from
> the 't/unit-tests/bin' directory.

Sorry, but I do not quite follow.  The above makes it sound as if
the 'bin' subdirectory is something that never existed before this
patch and this patch introduces the use of that directory, but that
is hardly the case.  What does that "Addition of" really refer to?

Do you mean "we cannot run the tests from arbitrary places, and we
allow them to be run from t/, just like the normal tests" followed
by "in addition, we also allow them to be run from t/unit-tests/bin
directory because ..."?

I wonder if we should get of t/t-urlmatch-normalization/ directory
and instead hold these test data in the form of string constants in
the program.  After all, you have the expected normalization result
hardcoded in the binary (e.g. t_url_high_bit() asks the checker
function to read from "url-1" file and then compare the result of
normalization with a hardcoded string constant), so having the test
data in separate files only risks the input and the output easily
drift apart.

As a side effect, it would make it easily possible to run the tests
anywhere, because you no longer depend on these url-$n input files.
It of course depends on how burdensome the limitation that we can
run the tests only from a fixed place really is, but it generally is
not a good idea to have these random sequence of bytes in small
files that nobody looks at in a repository in the first place.

Thanks.
