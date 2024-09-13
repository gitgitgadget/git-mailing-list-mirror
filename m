Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465B5811A
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249778; cv=none; b=FPQCPoUAEQiHoR1We1mAUU+2LtRMu4TEXsuJ3sq8RfyF/UDDY3P22OOqkLJuKbq5GJA8HTpOeH18FtpfGs297F3kZ+L50fGY5VGvWTPBR+iPXBWs/hlwAnKkZTsAD/JMlUnKGmuEBdTaoD+0S8MPpjHlBwvTH8kedbPOKgBkFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249778; c=relaxed/simple;
	bh=RPUiRURFYkjdoG76XC3gIZ/cYukEKNk1bNn1Gt5bskU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQHcUGWrkWFxiLLAVpD8+9XQ5ccGJSFpYPDqYY1F9ay1KcmEujzq5wHgfU/CKlEv04HABQauQtSpFgn+C9LmOYvlRmcimlV3hz4RzZ/z3/U088GDBXzfcVsJhP5E7VmlxFcxcUxm8vqjch0hoCVUhgQ/2QVhX42KmuCxlGuYwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zb7Znr44; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zb7Znr44"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F84C2044E;
	Fri, 13 Sep 2024 13:49:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RPUiRURFYkjdoG76XC3gIZ/cYukEKNk1bNn1Gt
	5bskU=; b=Zb7Znr44HdYnj0cErGozJ8diWcelVbzoyQcxm6Zu4kcghgC2dwCzi7
	/O5xCSnpOtBr1L+hYGlLPepzHaWt7fSI+QVldbrlTGJhJ/nI6yYLj4If27wT56UY
	j4ugJTSEV+pATVj6X/HTfmNn1whFmZ1WiE1pSgcNyiWSjfAAJ84eU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 672542044D;
	Fri, 13 Sep 2024 13:49:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5A952044C;
	Fri, 13 Sep 2024 13:49:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] remote: check branch names
In-Reply-To: <4915a1ba-eda9-435b-b615-4f78c7fe25f7@gmail.com> (phillip's
	message of "Fri, 13 Sep 2024 16:09:58 +0100")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
	<xmqqfrq686n5.fsf@gitster.g>
	<4915a1ba-eda9-435b-b615-4f78c7fe25f7@gmail.com>
Date: Fri, 13 Sep 2024 10:49:33 -0700
Message-ID: <xmqqy13vxx3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 89C3B7D6-71F8-11EF-AE94-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

phillip.wood123@gmail.com writes:

> Thanks for the patch, I'll re-roll based on that. I wonder if we
> really want to support "@{-N}" when setting remote tracking branches
> though - should we be using INTERPRET_BRANCH_REMOTE instead when
> calling strbuf_branchname()?

Perhaps.  Users try to use "-" in surprising places, though ;-)

