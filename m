Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985B67C5B
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705447117; cv=none; b=ZahQXNPQufVQ4lrkuhZe1c2Tl5CieXQ0e+hoV+Ioq/v1iq78VUfEAWDYlg9cja+e7LXHJoiZMZunFOstCAGe4reZG5q3GYH4pXjsKbQ4zo9s8F/mjtMaSiebVrud/SnJKTuHw6O4EOx0ST+G+wzmgd8uYT7OHFRzf+h3fKM3wa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705447117; c=relaxed/simple;
	bh=AajQ8FyMIvvA+hwCNmAutGPp3rOPCMbQmolDFpS+okE=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=QTvhm+J8vXT4TGXwkJOtsk4WE8SEEALVcw/9tPn9+ylIw6srG0o9HLEgQbuqjyTSY5tG639wDMmTvjVdoesQwYUlAu9rYrnjQZUrGW7+sfPs/Aaopb/kz5Lks1A9GPJrcEQo5B6gx26eMtUMAWOBEUdGiQwlI7xjmnX8kKxnI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pxA67Qyw; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pxA67Qyw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F6652801B;
	Tue, 16 Jan 2024 18:18:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AajQ8FyMIvvA+hwCNmAutGPp3rOPCMbQmolDFp
	S+okE=; b=pxA67Qywk2ekLlOdf2bUT0RJJ4TQowh8FtNMT9FTHoDOqH13rbL/D9
	CGmS4Wj9D9jIFXG8gSYa7Fe5OEkRdD4RsRLMEXwkDU9dLTp28PJvjRoK+bd2jraC
	mlkjYAncImZwGnPWfpSOIrLg/LBrkQBQtYIn4CiUeJ4/kmirMpCjE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 777682801A;
	Tue, 16 Jan 2024 18:18:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADF7A28019;
	Tue, 16 Jan 2024 18:18:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/4] test-tool run-command testsuite: support unit
 tests
In-Reply-To: <5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 16 Jan 2024 14:22:59 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
Date: Tue, 16 Jan 2024 15:18:29 -0800
Message-ID: <xmqqv87sx3y2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8FB01004-B4C5-11EE-9553-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Teach the testsuite runner in `test-tool run-command testsuite` how to
> run unit tests, by adding two new flags:
>
> First, "--(no-)run-in-shell" allows the test-tool to exec the unit-test
> binaries directly, rather than trying to interpret them as shell
> scripts.

Makes perfect sense.

> Second "--(no-)require-shell-test-pattern" bypasses the check that the
> test filenames match the expected t####-*.sh pattern.

This one I am not so sure.  Do we still have situations where
erroring out when fed a non t[0-9][0-9][0-9][0-9]-*.sh script is
problematic?  IOW, do we need to keep it as conditional?

	... goes and looks ...

Ah, this variable/option is misnamed and that is what invited the
above nonsense question out of me.  The logic this option disables
does not "require" (and error out if the requirement is not met); it
is used in a loop over "ls *" and "filtering" files out that are not
the numbered scripts.

But that confusion makes me wonder if non-script side of tests would
also want some filtering in the longer run, even if the directory we
feed to "test-tool run" happens to contain nothing but what we want
to run right now.  I wonder if we instead want a variable that holds
a pattern used to match programs readdir() discovers and skip those
that do not match the pattern?  Its default value may be something
like "t[0-9][0-9][0-9][0-9]-*.sh" but alternatively you can give,
say, "*" to pass everything, or something like that.

> With these changes, you can now use test-tool to run the unit tests:
> $ make
> $ cd t/unit-tests/bin
> $ ../../helper/test-tool run-command testsuite --no-run-in-shell \
>     --no-require-shell-test-pattern

This makes me wonder why we want to do the readdir() loop ourselves.
Instead of saying --no-require-shell-test-pattern there, wouldn't it
be simpler to say "*" right there, and have testsuite() run the test
programs named from the command line?

But that is orthogonal to the enhancement we have here.

