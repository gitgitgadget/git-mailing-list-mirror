Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB561DDA6
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849439; cv=none; b=B1f1xrs8SmKg3l8cgHUe7wQ9txyWpVR0WDhhBFxTcCqgjpluo00Lzt9ZFhewNtoDDQaApKFrlZ6zWtJWgvqijAQ+G48UQFcyucjzLpISeNkBajEhYg9diYN3U9duD9v9deHovGAYGqe8weOyrPnIHliUwmUELmLYOn1uo3SFxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849439; c=relaxed/simple;
	bh=JcU1bkePJtbjVtrCIHYyxvFOKmDl0xz95SVGZTx16FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aVxK5mwdaR8cHD67DzEJWQiiBbBOWGtt6KvPryIM4YkTv3Lp/FTdvMoZ4eD4EH1/Gu6ObtrllecyJQpQMctFzB8btyDPIEMBIxN/GgxznawmcgZCS4H0bRiCfiKggAA8L2t+cDVP418mKBscQdCkWfdQkSh85BFIYP2rnKhIT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uwHAUDpr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uwHAUDpr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54ADA1C5D8C;
	Tue, 13 Feb 2024 13:37:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JcU1bkePJtbjVtrCIHYyxvFOKmDl0xz95SVGZT
	x16FA=; b=uwHAUDprRmJRxfjU4YvniMxc8VbeUZlHwmFKZslAIsmpuAoIYV7Dh+
	R1ncm9nS329FKMWfc/FFw5ugweUaTb+2jNbYP8rWE7ys+9Ead3FMvK81NsNkoNB4
	fSSLqHlKHx3iJ87uxM2rKzFiBqjEK42nZZ7sviyr2FEghDjAb6NKM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B65B1C5D8B;
	Tue, 13 Feb 2024 13:37:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABA8E1C5D8A;
	Tue, 13 Feb 2024 13:37:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/12] The merge-base logic vs missing commit objects
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 13 Feb 2024 08:41:36
	+0000")
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 10:37:14 -0800
Message-ID: <xmqqplx05hyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8F6E6E4-CA9E-11EE-A329-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I am deeply sorry both about the length of this patch series as well as
> having to send it in the -rc phase.

You do not have to ;-), but thanks.

Also outside the scope of -rc, there were some untied loose ends in
the missing tree thing before we can move to a new topic, if I
recall correctly.

Speaking of -rc, the project would be helped by your expertise a lot
if you gave a quick Ack on the make_relative() thing [*].


[Reference]

 * f6628636 (unit-tests: do show relative file paths on non-Windows,
   too, 2024-02-11)
   https://lore.kernel.org/git/xmqqle7r9enn.fsf_-_@gitster.g/
