Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF82224F6
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905192; cv=none; b=QTnxURIJEzK2EjWfjrioegIRKfBpPx6FYeITCyfIkwssMJJ/tahC12DgSoCBwgadFkudQTK7Cd7GWnuy6nCVfCkTwxWDqxve6m+hSCq6i99JrJACtdOceI7ChDKbb6YLVdzexQDWMV86cZbTJrcL+/VeZanvHjJJfQagSiKVovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905192; c=relaxed/simple;
	bh=HHplnm1ilSW136k8Kz4OlitIxBNi7ng8hT0ZSx6hQJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfMr7JpWSkTohNih3yM21XCM9ibcIgQvFiM+wbr4VSolH8pPeBd+aI1LnN++cJT6+xSkm837EjlMbY4oOME8W55e329UnzWuiCZ7Mov9ECXf+EI3uRTBzbfFXyQuvU0T/xDxhkrYltvNDNY8ugTSPLaUDlRe+WF7kKYBrCNnMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dFLEJJyr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dFLEJJyr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69A4120CD4;
	Mon,  9 Sep 2024 14:06:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HHplnm1ilSW136k8Kz4OlitIxBNi7ng8hT0ZSx
	6hQJY=; b=dFLEJJyrs2DHY1Nzore80BRp8n//ZjNPlB/oH53GzSZO8q8L5qzRo0
	i2w6ki7vP5Mn/zpqkeAzuv9Z/PF7phu2EVwyAHTkMAqP6wMXL1X7nn6WQ3cBGh8F
	n6jtAesXalA+ZcVW6B264uo+NeISGe8++s6Y8lMbUQbHqAuOWh1Ls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 606D220CD3;
	Mon,  9 Sep 2024 14:06:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C56BB20CD0;
	Mon,  9 Sep 2024 14:06:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
In-Reply-To: <pull.1785.git.1725890210.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Mon, 09 Sep 2024 13:56:46 +0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 11:06:27 -0700
Message-ID: <xmqqjzfkr9b0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3C77D0B8-6ED6-11EF-B68B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> One way to find some improvement in these repositories is to increase the
> window size, which was an initial indicator that the delta compression could
> be improved, but was not a clear indicator. After some digging (and
> prototyping some analysis tools) the main discovery was that the current
> name-hash algorithm only considers the last 16 characters in the path name
> and has some naturally-occurring collisions within that scope.

Yes, as I explained in the other message, this "collision" is an
integral part of the design to allow us gather candidates together
that may yield good deltas among them.  In addition, header files
whose names end with ".h" tend to share a bit comment at the
beginning of them in many projects, and the proximity (not
"collision") of the hash value is used to make them delta candidates
with each other.

I do agree that considering files at the same path from different
(but close-by) revisions as the prime candidates is very important,
but if you spread the "collissions" very thin by using "uniform
distribution", I am afraid that you'd end up discarding anything but
the blobs at the same path, which may go too far.  Having name hash
value that are close by no longer has any meaning in such a system.

I hope you can find a solution that strikes a good balance at the
end of the series (I saw only the first step), but I suspect an easy
way to avoid the downsides you observed is to use both.  Compare
with a handful of blobs taken from nearby commits (the original
object order is roughly in traversal order, and you can take
advantage of that fact) from exactly the same path (using your
"uniform distribution") before comparing with the blobs with close
value (of the current function) like the current implementation
does, may go a long way.

