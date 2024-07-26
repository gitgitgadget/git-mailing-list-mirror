Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF523A8
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006748; cv=none; b=JzmyBSh1mn2oM4TAfMdpehR9bzSRGAPUvEN+Uco900wBfwLbiM388WDtXijZ1Eb3k1WLELRuTx3AQvHcwtDGjpH9nXNPll1nbqX7QdLsRgmGxF27iRJfxXvf4hEuxvMeBbovae1+X5MNGQC1Qke+LVL1z1tXKJGtiAK0uRjXSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006748; c=relaxed/simple;
	bh=EZ7HtwWrOMAa0Z1N0VmEzgGtmaXx2TfVTbzavyLm1G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XO5s5tnyjiNJEZdJsC78XgJW9d6wRWdr47bkFEha+P/HrfjuFTefoPVk6V7DCnGitQV1yx+dfhsid1E8mF6mSUOrNmSVHkTkYnE2dJeduaxHUzob1KkMeB6HSLXIduknRba0Z1I9LpT5A21bbH7nMUV5L7UltLbI1Ezdj8ARqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R1ZIFCVA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1ZIFCVA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A324E25DA1;
	Fri, 26 Jul 2024 11:12:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EZ7HtwWrOMAa0Z1N0VmEzgGtmaXx2TfVTbzavy
	Lm1G8=; b=R1ZIFCVA1NayyyGaqojURCh7+nRH71+DFS4TlzWX6x/CFmJ/duzyx2
	Wi9mBOD+HKKTmLvNtIURNrjFMdUFeTb+wBTOB8q78fitAwaKU2WQdLxgfx+fOVd0
	WZq5SaEa9CMqkaFrnLp0rX2Y0jrVMjHXWJyEqsnTzfBPOI+hnEgQ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B62425DA0;
	Fri, 26 Jul 2024 11:12:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15DDF25D9F;
	Fri, 26 Jul 2024 11:12:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Haritha
 <harithamma.d@ibm.com>
Subject: Re: [PATCH v3] Fix to avoid high memory footprint
In-Reply-To: <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
	(Haritha via GitGitGadget's message of "Fri, 26 Jul 2024 06:27:14
	+0000")
References: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
	<pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
Date: Fri, 26 Jul 2024 08:12:15 -0700
Message-ID: <xmqqa5i4yypc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 722A4314-4B61-11EF-8C21-92D9AF168FA5-77302942!pb-smtp20.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

Another thing.

> Subject: Re: [PATCH v3] Fix to avoid high memory footprint

This does not tell us much about what area had problem under what
condition.  "git shortlog --no-merges -200 master" may give us good
examples of how we typically write the title of our commits.

In the case of this change, ideally we should be able to tell that
this is about tracing the conversion codepath.

    Subject: [PATCH vN] encoding: return early when not tracing conversion

or something, perhaps?
