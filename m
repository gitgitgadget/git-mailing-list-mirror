Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90694604C4
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846593; cv=none; b=WHurYGFbQF7gNuBxVMcqMFyl4+FWNZo8YedlTL5NQ/61IGvVKVwXYbB9WPEo0gm+XiMz033w6zI5pD/VGUxL63dVsVWESrJ81kyRXc0gJiyQLMpHI7YypHi6EBcECCHXjx+Wwv7KUb2pGxFNa1j8vNWTkdXoaNvPHxdZkRR5LpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846593; c=relaxed/simple;
	bh=i8ld5HtzeyeYWO2pGC5631Nlpy7oXvJ39SOh9/so1Cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qt8Toci9pkCwxteEwOPx9kQZcz92u9f9/GkL55ZRtpQA3gh2k7ctB27p4aj7UYoD4aXNzYJtuEqxQsEj/PAVK8J2XjtPw2410ag5riE69MgQcvV5PDf+tv+2F6eMb0FJCHlDwzzj7Uuvb9GhdW9IkWKxGArX/SsdQ7CyMHQMBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I3CDKceS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I3CDKceS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 12B0E18DE8;
	Tue, 13 Feb 2024 12:49:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i8ld5HtzeyeYWO2pGC5631Nlpy7oXvJ39SOh9/
	so1Cc=; b=I3CDKceS0N5e+mB4ZmZktL98ySMx4ihZ68yRIWXMmrACTJcQ7EXust
	xjK8IIER1pOg6QEmWQSKSgHppJE6O4KTAY5wExpK0LlVDU4rJRdPI8QOwVznwIRV
	NyUQJ9U7OYhTZIVrT2XkN/UxStI7oOZFdGgFDhbW4ZBqw46ASnqsw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0ACDE18DE7;
	Tue, 13 Feb 2024 12:49:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB83B18DE6;
	Tue, 13 Feb 2024 12:49:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Vincenzo MEZZELA <vincenzo.mezzela@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC][RFC] microproject: use test_path_is_* functions in test
 scripts
In-Reply-To: <cbb450b3-b333-4391-ac83-66c2daf0ae4d@gmail.com> (Vincenzo
	MEZZELA's message of "Tue, 13 Feb 2024 16:44:52 +0100")
References: <cbb450b3-b333-4391-ac83-66c2daf0ae4d@gmail.com>
Date: Tue, 13 Feb 2024 09:49:46 -0800
Message-ID: <xmqqy1bo5k5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 476C0530-CA98-11EE-91EA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Vincenzo MEZZELA <vincenzo.mezzela@gmail.com> writes:

> Approach:
>
> As far as I understood, The work consists in replacing the shell
> 'test' command in the test
> script under 't/' directory with the ones present in the
> t/test_lib_functions.sh as follows:
>
> - test -f --> test_path_is_file
>
> - test -d --> test_path_is_dir
>
> - test -e --> test_path_exists

One thing to note is that you'd need to make sure if "test -e" for
example originally written really means "we want to see something
there and it does not matter if it is a file or a directory" while
turning it into test_path_exists.  The operations that such a test
follows may be expected to create a file and never a directory, in
which case the condition the original code is testing may need to
be corrected first to expect a more specific type (e.g. "test -f").
The same comment applies for the other two.

Some tests check with "! test -f <path>", which often would want to
be turned into "test_path_is_missing", but you'd need to make sure
that is what the original test really meant to do.

A microproject is not about "doing the real work to help the
project".  It is a practice session to come up with a set of small
changes and explain them well, to send the result to the list to get
reviewed, to respond to reviews and possibly send updates, and to
repeat the cycle until completion.  So most likely you'd pick a
single file or two and do the above conversion, while leaving the
others as practice material for other GSoC participants.

Enjoy.

