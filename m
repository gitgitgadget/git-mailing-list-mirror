Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3334F881
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778270; cv=none; b=f1XEGfZCrvvMfB0r7khALTqzlzf6V5qwl3jyKu2eEWy3L3xI+WJFg6daYSVCc7Hoot/vFjKKgyMrvQSTJ/2EPwKU7BC1oh/C5xUogK8B24wP9pF5fCvLRmIdZRsZ6MIMUiIlX0r2s3RLYGGBdhwstcNtI0b2Ncxhb9cClxCgqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778270; c=relaxed/simple;
	bh=zL0IVFo2o/CpndwFP9Izn3tSJWQTLCwj9yhxonexlNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ckNVAdkxDirE5t3hi/dhIG4WW8PAnB2rRek+HWMC8qHqJxTjQOgBHs0q0bkhT56szoAv+R63arkbTCz0YUYo2ykshQaNAbIqBYkKNfl/XeDMBpwmkdsNDg2UL3ek+BgpBfPlsfagyD5oh2UMO8DoMlqENepxuI7NMGp0kpJVZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NfQKZvBD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NfQKZvBD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F62F1E0DD0;
	Mon, 12 Feb 2024 17:51:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zL0IVFo2o/CpndwFP9Izn3tSJWQTLCwj9yhxon
	exlNk=; b=NfQKZvBDcJxYlM76+FYHo/3+Y/oAS82hCwCMrZOWFjSX608vOx5xGO
	/apc+FfCbNsM2FhJgigjS+6SorMlitxno78N3b+asckyGowY922X/XLVcjficbnh
	9xRyJrPW8c7MeMCTtoJ8ioZY9yW8DPI5cQ519AHiJy+C/W+pl17OE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 767AA1E0DCE;
	Mon, 12 Feb 2024 17:51:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAF151E0DCD;
	Mon, 12 Feb 2024 17:51:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 3/6] test-tool run-command testsuite: remove
 hardcoded filter
In-Reply-To: <ZcqgMgFx97DbH94y@google.com> (Josh Steadmon's message of "Mon,
	12 Feb 2024 14:48:18 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<e1b89ae93e930cd902d1527955d588c3d0c15490.1706921262.git.steadmon@google.com>
	<xmqqeddo6lkk.fsf@gitster.g> <ZcqgMgFx97DbH94y@google.com>
Date: Mon, 12 Feb 2024 14:51:04 -0800
Message-ID: <xmqqo7cl47qf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 346A3FAA-C9F9-11EE-9CD6-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

>> As we discussed in Peff's Makefile change that enumerates "which are
>> the unit-test programs?" Generally, $(wildcard) and readdir() to
>> slurp everything in a directory, including stuff that is an
>> untracked cruft, is not an excellent idea.
>> 
>> This is not an end-user facing program and we are in full control of
>> its input (most notably, "which ones should we be running?"), I do
>> not think it would be a huge issue, though.
>
> Would you prefer if I remove the default behavior of "run everything in
> the CWD" and require passing in at least one filename filter?

No preference either way at all.
