Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009771974EA
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172569; cv=none; b=UIlz8VQ85LRLA8ive8tgxcP1AJ4twbBfiOtGJNS8Ks09KYseC31JcU9zwvCP1xwA4UK5dIHDSGnoD19D5kLY1AiRGEVsPaQYmhlN8f+inO7YSjqOqjaE50N+onunmhJWHU9boxvniC5zQ/U45LWj07o2gFLhOiNn/NupgQikCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172569; c=relaxed/simple;
	bh=s+TiBObkUiF5yw0akWrqkhq5apblctOj0wIOALVDZx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ooz0bufPhfpTLnfiAqi5Rqe3DfeCr9tZMR6MhKY2NNvjQDcam2cQ6rLuKfPb0eh8EMYqWX6J2smlSVZIf2RuhaG3eYy6AY1hOC0bxhELOYz7eME4RNZ+i/bVCq0c1S6bSlacAcIq/Pi5penuQnpGPbZGQ4eCMOdE+VjpWxK8n1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tO6J3AaA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tO6J3AaA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D09B818AA3;
	Tue, 20 Aug 2024 12:49:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s+TiBObkUiF5yw0akWrqkhq5apblctOj0wIOAL
	VDZx4=; b=tO6J3AaAqi3cIo9JZ3nzdesJZjHRGCt08k1msxcaUps32QT3u1+jWq
	QWyaHzUxUI4/K//NC4496XwNEiyeonWRON5YBBZIdjwdFPRNBFdpmkjWQe6kdFXX
	6Z0xYChN/b/UuFWgjF3fbFnNMM+hlzNrbKZW5K0G5ckZKJyAzvlCA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C62F918AA2;
	Tue, 20 Aug 2024 12:49:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3640E18AA1;
	Tue, 20 Aug 2024 12:49:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
In-Reply-To: <ZsIM2DRDbJsvNjAM@ArchLinux> (shejialuo@gmail.com's message of
	"Sun, 18 Aug 2024 23:01:44 +0800")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <ZsIM2DRDbJsvNjAM@ArchLinux>
Date: Tue, 20 Aug 2024 09:49:23 -0700
Message-ID: <xmqqed6j9m24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27BC3596-5F14-11EF-8B0A-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> We implicitly reply on "git-fsck(1)" to check the consistency of regular

"reply" -> "rely", I think.

> refs. However, when parsing the regular refs for files backend, we allow
> the ref content to end with no newline or contain some garbages. We
> should warn the user about above situations.

Hmph, should we?  

If the content is short (e.g., in SHA-1 repository it only has 39
hexdigit) even if that may be sufficient to uniquely name the
object, we should warn about it, of course.  A file that has
64-hexdigit with a terminating LF at the end may be a valid file to
be in $GIT_DIR/refs/ hierarchy in a SHA-256 repository, but such a
file in a SHA-1 repository should also be subject to a warning, as
it could be a sign that somebody screwed up object format
conversion.

But a file that has only 40-hexdigit without a terminating LF at the
end?  Or a file that has 40-hexdigit followed by a CRLF instead of
LF?  Or a file that has the identical content as a valid ref on its
first line, but has extra stuff on its second and subsequent lines?

What does the name-to-object-name-mapping layer (aka "get_oid" API)
do when they see such a file in the $GIT_DIR/refs/ hierarchy?  If
they are treated as valid ref in the "normal" code path, it needs a
strong justification to tighten the rules retroactively, much
stronger than "Our current code, and any of our older versions,
would have written such a file as a loose ref with our code."

"What are we protecting us from with this tightening?" is the
question we should be asking ourselves, when evaluating each of
these new rules that fsck used not to care about.
