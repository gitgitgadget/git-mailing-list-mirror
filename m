Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D2EC9
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574485; cv=none; b=aKa7f3DGnP44SOay9CRExGMzCk7PizMsKiT910NBglJ7bVMrrWYxPCiaYDaVyG2Gm5FtCzRl4g8OwIedDU15NXXKrc2qqf3jwZLjG1mJykl1Gyz0IxbFo6Qh2o7qHAdN4RlK2cEcWOBH4PNM7uLqFIqV2YO4VGWdPA6kGviq534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574485; c=relaxed/simple;
	bh=5HLDwc92UAIr/wOOb43l7Xx61zQQLxtFdE2GlZ+pI40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=liFhV5U4XlH9b9P8e7j7vRnMLM7YT+fDqmBwuf4kJePsP9mu89PqcB8ad9XLNhPmVwgUhturF6VQQpF+pZbw5KuZKtNX4+5qjKaOImg9vA9sPIxnvB41c+/kpUhGBFIMVr/FL4zFOMQ0bTt8FXOXkDG9u+x4FZ6pzOQy3PsBiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bj/GHrqk; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bj/GHrqk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A67C1DA130;
	Mon, 29 Jan 2024 19:28:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5HLDwc92UAIr/wOOb43l7Xx61zQQLxtFdE2GlZ
	+pI40=; b=Bj/GHrqkKWPDXzVP6nvHe7uU1Ewl4+p+BYL7EuyR3378UZ7uM/MNdO
	gNR5VQIWRlwe9u1IXo7i3JgRD1iLjrxRoNdOeByQsWWM3bEElIIZldqE2tnDAJ+s
	231KN1c33XUM8HXed09a9AOGz8a0y34H3eX6iUF/Qi+G5ht+83Vgc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA8451DA12F;
	Mon, 29 Jan 2024 19:28:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65B781DA12D;
	Mon, 29 Jan 2024 19:28:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: Jeff King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
In-Reply-To: <CA+kUOanDydgCEax9RFu_xVXkx_LeiSPOoWiUpwAg=EVQxSDJRw@mail.gmail.com>
	(Adam Dinwoodie's message of "Mon, 29 Jan 2024 21:31:11 +0000")
References: <20240129031540.GA2433764@coredump.intra.peff.net>
	<20240129031933.GB2433899@coredump.intra.peff.net>
	<ZbeLcrjIYd4d7PaB@tanuki>
	<20240129174918.GA3765717@coredump.intra.peff.net>
	<CA+kUOanDydgCEax9RFu_xVXkx_LeiSPOoWiUpwAg=EVQxSDJRw@mail.gmail.com>
Date: Mon, 29 Jan 2024 16:27:59 -0800
Message-ID: <xmqqeddzfywg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C673960-BF06-11EE-BF28-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Adam Dinwoodie <adam@dinwoodie.org> writes:

>> Hmm, good point. It seems like the answer should obviously be "yes", but
>> Windows CI seemed to pass all the same (and I checked that it indeed ran
>> the unit tests). Do we only get the $X suffix for MSVC builds or
>> something? Looks like maybe cygwin, as well.
>
> Cygwin will automatically append ".exe" when doing directory listings;
> a check if the file "a" exists will return true on Cygwin if "a" or
> "a.exe" exists; a glob for "a*" in a directory containing files "a1"
> and "a2.exe" will return "a1" and "a2". This causes problems in some
> edge cases, but it means *nix scripts and applications are much more
> likely to work without any Cygwin-specific handling. I *think* this
> logic is carried downstream to MSYS2 and thence to Git for Windows.

Interesting, especially that "a*" is globbed to "a2" and not
"a2.exe".

> As a result, I'm not surprised this worked without handling $X, but I
> don't think there's any harm in adding it either.

OK.

I wonder if something like this is sufficient?  I am not sure if we
should lift the building of t/unit-tests/* up to the primary Makefile
to mimic the way stuff related to test-tool are built and linked.
That way, we do not have to contaminate t/Makefile with compilation
related stuff that we didn't need originally.

 t/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/t/Makefile w/t/Makefile
index b7a6fefe28..010ce083b1 100644
--- c/t/Makefile
+++ w/t/Makefile
@@ -6,6 +6,7 @@ include ../shared.mak
 # Copyright (c) 2005 Junio C Hamano
 #
 
+include ../config.mak.uname
 -include ../config.mak.autogen
 -include ../config.mak
 
@@ -42,7 +43,9 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
-UNIT_TESTS = $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
+UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
+UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$X,$(UNIT_TEST_SOURCES))
+UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual


