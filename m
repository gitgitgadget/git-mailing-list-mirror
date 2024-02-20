Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E2612C0
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457069; cv=none; b=uU83d2fChV0FWpOq6nlL20ndD3FG+57SOBCNPtZuyiZvfL0wyTSEI+/lC6cpMWFkJ3dR5kK341KvYlRzvuavuYR73eTET4h3CcVViAxu15JEX7qPfnjoj2usadopQmrJpGrTF18riMDFln/VXjoJURVDZ5QCX7L/JjKt5pPcUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457069; c=relaxed/simple;
	bh=8T/EM/lf7sqLbO8aUDFZJpOCE8e2YIz2uzdbEak6NR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L9+lkxxtZDjSSFfxu4ftmVyZ/Jrb7ukuucfkSC0pKu1ZiP8Apat59ezOJPg3WZyN/eFw4dML6nNh2kflEFzMiUC/EoBQHRAXPXek2y/4K0smAYDYGyeGXEJjNnNt1z64KhkN0g3K/P/FMH+vXbvjzUL4sy/cAEpIN4NxNxBuh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ROVqlMFs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ROVqlMFs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02CE91EA188;
	Tue, 20 Feb 2024 14:24:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8T/EM/lf7sqLbO8aUDFZJpOCE8e2YIz2uzdbEa
	k6NR8=; b=ROVqlMFss+HEbvIv/4N/BgB6FtNhA1uiKtb8Jrl+819wF0FXEMH19H
	Xu8hnt8qScipKsd8XJ1KS/OWoZuCH04lczIf2Td9ERs81afY3cnEcNFC6326qLLp
	aW0fha+X+KRD+STDjGYS8B2afls8OVYVSsSvSni3AmsQxJ435XYdc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE7CD1EA187;
	Tue, 20 Feb 2024 14:24:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 608041EA186;
	Tue, 20 Feb 2024 14:24:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 06/12] fsmonitor: clarify handling of directory events
 in callback
In-Reply-To: <b379b92f-407a-c4b3-ee65-a7fa6e7dff74@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 20 Feb 2024 13:56:01 -0500")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>
	<xmqqil2rzdvo.fsf@gitster.g>
	<b379b92f-407a-c4b3-ee65-a7fa6e7dff74@jeffhostetler.com>
Date: Tue, 20 Feb 2024 11:24:25 -0800
Message-ID: <xmqqjzmzndli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9143F90-D025-11EE-A0FB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'll split this into 2 commits.  One for the refactor and one for
> the new return value.

And the latter one that makes the return value richer contains the
caller that makes use of the returned value?  That's great.  It
would make it very much easier to read the resulting commit, as the
presence of the callers and how they use the returned value would
make it self evident why it makes sense to return the number of
entries invalidated.

Thanks.
