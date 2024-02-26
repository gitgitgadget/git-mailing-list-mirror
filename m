Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12146136641
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991209; cv=none; b=nTYkuwP2DJupuFC23gkOCm9BhCL+NnHhYgCNruu5ve8+z/R7EjtlLfq7L20cxicV6mtAxiyK/Nv+jeeM/yCW+3IZWRLzEecWh4l13Es2bGBhYeX2JMxH5NkCgz0CdLESkdRqdKkv757lJOvGIYAloGASn/M8pByI0YibADuDSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991209; c=relaxed/simple;
	bh=rMDyqC84/A3GyRaUUvXP3fRyC9ZlAx2/J5vAOvlkPrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tt70+uIAhy9d+QmxweGmaECuHrK6aLwutfdFW/Q7ht+BG/G/R19tbImHyYDptGQXzyGkIVgxAdrijdI7TqJplTS4JalTQ8zDN8qN8bkTsOKmKDKIQtJ3mQbJ8rHl1g5c4eR7gGYxTGtcKkyeYIsm/ZpF4mZcYNoOZ7XvgrSuVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wiwTGDeN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wiwTGDeN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88C021C9D6A;
	Mon, 26 Feb 2024 18:46:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rMDyqC84/A3GyRaUUvXP3fRyC9ZlAx2/J5vAOv
	lkPrc=; b=wiwTGDeNMxjqvRXvq9y1+mkIAHEQnZr4nPKPVRVEQC9Glb6S5hmjr/
	e+B3obWVaBmALUjQs6u2/cTrJvT5gb7OsAzPMD5XeGmPPzpepLlEaCYCo+xUMdFQ
	us0t3cC+MtEMWwSbt8QKOdk9Qc3m/6zcvwK4vdFveOtzsylBtoo0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 80C201C9D68;
	Mon, 26 Feb 2024 18:46:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6FCE1C9D67;
	Mon, 26 Feb 2024 18:46:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>,  "'Randall S. Becker'"
 <the.n.e.key@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] builtin/index-pack.c: change xwrite to
 write_in_full to allow large sizes.
In-Reply-To: <026b01da6906$4d96f530$e8c4df90$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 26 Feb 2024 17:51:09
	-0500")
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
	<20240226220539.3494-2-randall.becker@nexbridge.ca>
	<Zd0S7aUIG1bhGkaX@nand.local>
	<026b01da6906$4d96f530$e8c4df90$@nexbridge.com>
Date: Mon, 26 Feb 2024 15:46:44 -0800
Message-ID: <xmqqa5nmkcuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4D0FEE48-D501-11EE-98EA-25B3960A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

>>The code above loops while input_len is non-zero, and correctly
>>decrements it by the number of bytes written by xwrite() after
>>each iteration.
>>
>>Assuming that xwrite()/write(2) works how I think it does on
>>NonStop, I'm not sure I understand why this change is necessary.
>
> NonStop has a limited SSIZE_MAX. xwrite only handles that much so
> anything beyond that gets dropped (not in the above code but in
> other builtins)

xwrite() caps a single write attempt to MAX_IO_SIZE and can return a
short-write, so anything beyound MAX_IO_SIZE will not even be sent
to the underlying write(2).  There is a heuristic based on the value
of SSIZE_MAX to define MAX_IO_SIZE in <git-compat-util.h>, and if
the value given by that heuristics is too large for your platform,
you can tweak your own MAX_IO_SIZE (see the comments in that header
file).

The caller of xwrite() must be prepared to see a write return with
value less than the length it used to call the function, either
because of this MAX_IO_SIZE cut-off, or because of the underlying
write(2) returning after a short write.  As long as the caller is
prepared, like Taylor pointed out, I am not sure why you'd need to
change it.
