Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848317556C
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726700568; cv=none; b=CbDkyLIita/G6WZXTIbOjiSov9yqzkEN++N3+QXE8zN8IwwYeFRCVfKxF8KYwycAdRhudx1HpmRvwH7BWvfqw5dww63sPbv5KJDz4rHK2zTEajsJTCyG4XhO9Z7q1UmbhXDuFaC8/gi/KONThb7fh0NUP5LCRXITraMojj3DnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726700568; c=relaxed/simple;
	bh=NSk35YNhr3jwziEqN8lfhxqpCtLSBr8zDRxLHtilRtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oy1J1LLQMFMAhA67tclBXMCQowJAGtbuihv82BjsS0ikC3NPdThcCFFBsUAi4yNWRyp+/elQ31ePTXJGPC7woQjvFPD6+unze1oUSXztsOyn95R2Sae5qkfubqYvoygPvXYoBuKFiKLcNcXNFYJ2LZNlSwzmqhDkRVNVa5cAgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PdHhZpPV; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PdHhZpPV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA43334FF5;
	Wed, 18 Sep 2024 19:02:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NSk35YNhr3jwziEqN8lfhxqpCtLSBr8zDRxLHt
	ilRtQ=; b=PdHhZpPV2SllxpA/hL7VJHo3IF68h1XcgDdRCkEOmSsw+rCG1UMNvj
	DiTX08G94S5aKeNeg1igH19OjvYyXerv0o485XgdaYsMSdnC6t0BMr0SYIo3qjbG
	1fRrWKFg+3xKRK4ey90h6jjxLMpvfqPsJVC/WUXcHe4NZ2MKeoeQA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E080D34FF4;
	Wed, 18 Sep 2024 19:02:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5802A34FF3;
	Wed, 18 Sep 2024 19:02:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 5/5] ref: add symlink ref content check for files
 backend
In-Reply-To: <ZuRz1_cHDnr_pWzo@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 14 Sep 2024 01:18:15 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <ZuRz1_cHDnr_pWzo@ArchLinux>
Date: Wed, 18 Sep 2024 16:02:44 -0700
Message-ID: <xmqqo74ka7l7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1DD502DC-7612-11EF-BE63-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> Because we consider deprecating writing the symbolic links and for
> reading, we may or may not deprecate. We first need to asses whether
> symbolic links may still be used. So, add a new fsck message
> "symlinkRef(INFO)" to let the user be aware of this information.

If that is the intention, the the documentation entry is somewhat
out of line.

> +`symlinkRef`::
> +	(INFO) A symref uses the symbolic link. This kind of symref may
> +	be considered ERROR in the future when totally dropping the
> +	symlink support.

    A symbolic link is used as a symref.  Report to the
    git@vger.kernel.org mailing list if you see this error, as we
    are assessing the feasibility of dropping the support to use
    symbolic links as a symref.

But quite honestly, I do not think it is necessary to deprecate (let
alone remove) the support for reading side.
