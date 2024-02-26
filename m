Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB23130E3E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982304; cv=none; b=Pit1vt8SPpZG/Y7D34Y58P112F3WXL7LPM5jQFzc8vPdlYdNeyE9T4Hgcgea2XY346UxdSkxLZoYvCKbLRrn9AOoFMO71BIitJlzBTPqq1Hn6D3Na41XgNRbizntlexIqdzqG/iUBtjymGfU6k0l7FJYSMse6/rHIfl2MKDf8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982304; c=relaxed/simple;
	bh=0WFfV2nl6FZ6ZYS53LXERiRpSMAQwHe3PPsmX7G7pCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQGUkpNx6H2GRxRW3+Yq/0ODhZkuxqvIMKT1eIBehXkWJCKy+Z5KE84Qz/UxH1cGw1Td+NUOY4utCBFsZYnV7lAgJtQhCgcqp5CYh2lghX/AWYQjGwPmFtqi5Zg3Pf/HkDn/7pEMf88xIsoFjcFSYDVg6Me7U2MsuGLrSjHHiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AJmv9Rg3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AJmv9Rg3"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF9351C8B31;
	Mon, 26 Feb 2024 16:18:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0WFfV2nl6FZ6ZYS53LXERiRpSMAQwHe3PPsmX7
	G7pCA=; b=AJmv9Rg30muLM3xydawC6fBr7QS2fWVTf5mcDL4vbwrc0rurF7LSPc
	CM2ueAFyajQsgDJhg/Qc7cKHhJSkHZ2QmQvnITN+91Y7zf6kWjRxNpadV7TSlrQ6
	k+KBYNpHW18dBLvnjPRCF0TCscxUTwKNznt4pMsf99mD1phSsSFFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D6A781C8B2F;
	Mon, 26 Feb 2024 16:18:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45E6D1C8B2E;
	Mon, 26 Feb 2024 16:18:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <jeffhostetler@github.com>
Subject: Re: [PATCH v2 14/16] fsmonitor: support case-insensitive events
In-Reply-To: <b6cfe94a-adcf-04fa-2ed8-dfd4f0fdc77a@jeffhostetler.com> (Jeff
	Hostetler's message of "Mon, 26 Feb 2024 15:41:08 -0500")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
	<xmqqjzmvt5d3.fsf@gitster.g>
	<b6cfe94a-adcf-04fa-2ed8-dfd4f0fdc77a@jeffhostetler.com>
Date: Mon, 26 Feb 2024 13:18:19 -0800
Message-ID: <xmqqy1b6kjqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90E0D49E-D4EC-11EE-B001-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'm not happy about this (and no, I haven't had time to measure the
> perf hit we'll take), but right now I'm just worried about the
> correctness -- I've had several reports of stale/incomplete status
> when IDE tools change file/directory case in unexpected ways....

Of course, it is a good discipline, and I fully support the
direction, to focus on the correctness first.
