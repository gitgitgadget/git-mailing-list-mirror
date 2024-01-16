Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690C747C
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705445668; cv=none; b=mBNYg4WhOhtKFPeuEDEPIrYUobRq1ml3gl3A/lyAQjS1JubtAdTPA97c7aFeHfG0bdA3enjm4gyCBuDbUmkStLIMZdFc+TljIyog9+ypUpqbrnaZ6HiDL8iCjroZQll4Un00qrKTJKuiOQidaOBZQc/0zG6LKkCnRJdGJHkQNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705445668; c=relaxed/simple;
	bh=1PhhK76gPgvfMVILg2fdiq3t5Yfpqf7Qp50f/TtymME=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=dMCWmNzedliWLg8Shm81l4g1vGy6lVT16MEtftzfk+w/3H5ZD+7+PIFdK9LDB7/JMIgtgPbyanWNGP9FAp3C+JDvgqR4L/kq4s5bCnHn4mgnehlanaRaUrxIcOAT0G8PfX2txIpl+Oat7SCHZN1cKgMeRxc7UuZSDNojloCZeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xlanu04s; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xlanu04s"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D0641A5FE;
	Tue, 16 Jan 2024 17:54:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1PhhK76gPgvfMVILg2fdiq3t5Yfpqf7Qp50f/T
	tymME=; b=xlanu04sKniU5ICaSNtEMTSpLt2DmiwbXyU3nqtmtgLo8pNiW8cp37
	/8rZi+XgxU5dzuPAzJv2P6lhLelhtVMI6R73vnQtzHi+J7XANBqNKvgiieKbMANE
	9YHoYMQ1OJA6bD5chi+397WHIGHlcYG+opaj4DlTZQkU/jH41bynQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7695D1A5FD;
	Tue, 16 Jan 2024 17:54:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 027EA1A5FC;
	Tue, 16 Jan 2024 17:54:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/4] t0080: turn t-basic unit test into a helper
In-Reply-To: <a9f67ed703c8314f0f0507ffb83b503717b846b3.1705443632.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 16 Jan 2024 14:22:58 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<a9f67ed703c8314f0f0507ffb83b503717b846b3.1705443632.git.steadmon@google.com>
Date: Tue, 16 Jan 2024 14:54:21 -0800
Message-ID: <xmqqa5p4yjmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30CA2EA6-B4C2-11EE-A368-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> As such, it makes more sense for t-basic to be a helper item for
> t0080-unit-test-output.sh, ...

Up to this part was very understandable and agreeable, but I was
surprised to see ...

> ... so let's move it to t/t0080/t-basic.c and
> adjust Makefiles and .gitignores as necessary.

... this conclusion.  I somehow thought that t-basic part would be a
good test-tool subcommand, as it is run from the suite of shell
scripts for end-to-end testing CLI interaction.

Do we have any precedent to place programs placed under t/tXXXX/ and
get them compiled?

> This has the additional benefit that test harnesses seeking to run all
> unit tests can find them with a simple glob of "t/unit-tests/bin/t-*",
> with no exceptions needed.

And this motivation is very much understandable, and for that, as
long as it is outside t/unit-tests/, it would be good.  I just did
not expect it to hang under t/t0080/, inviting more unit test pieces
that are triggerable from the numberd shell scripts to hang under
random t/t[0-9][0-9][0-9][0-9]/ directories.


