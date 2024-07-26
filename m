Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C029176248
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979837; cv=none; b=ZanrGMZq8bz1ObFcrgrdC+MaPl5uQ+g/4TVwfVPEgS5fVnC2/hC3b42ZyJ1NhQp4aRtHlAlk9nON1QpkPfpyMCApsV6QAjB9L+ND0abEZDbZ35hCJ/15gvoZ9iYY1QS2eTPD0l+ThNKWdhY61dmR3JoLH+6vVdyP2hPUUS9PDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979837; c=relaxed/simple;
	bh=3wWEd6g3mDFOeTxzLydNM2hIeMqulxMDEV7IDCXdlOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uonM1CVM+6iq/+0SHHmHV+jyXt0xXKwhU4uXHa8wUVBq1c361twntGpOvZ5yP4PVSZD0KjonAijSZSrDcwA02tJOYXQ7D/mJxbsdFPAb9k9gMY9l1eWzLzFVM1GsLA1peXg4i6xTn/3vlmv88AJ5Qw+GYnBO3+ezGxX9IlgBt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=p5iIAJwE; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="p5iIAJwE"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501B81F7A9;
	Fri, 26 Jul 2024 07:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721979835;
	bh=3wWEd6g3mDFOeTxzLydNM2hIeMqulxMDEV7IDCXdlOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5iIAJwEnDiOxNZOBeWEwWLillEaeiThWFdL4+M/vyJkXEpbcF/DWh44AIbdM8Y0z
	 1Kms9QnIXYdFkwKFpvLW4JuF7ZG6jZORDb40GhJ7zvqBVgmJpsKHc/NguadOZtvzGt
	 5H9d9OSDfuVuN+DWvGFgAjCImZL0TwC/BxJBKxsI=
Date: Fri, 26 Jul 2024 07:43:55 +0000
From: Eric Wong <e@80x24.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 03/10] packfile: fix off-by-one in content_limit
 comparison
Message-ID: <20240726074355.M208461@dcvr>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-4-e@80x24.org>
 <ZqC86t7YpVhdmLh_@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqC86t7YpVhdmLh_@tanuki>

Patrick Steinhardt <ps@pks.im> wrote:
> In practice this doesn't really fix a user-visible bug, right? The only
> difference before and after is that we now start to stream contents
> earlier? And that's why we cannot have a test for this.
> 
> If so, I'd recommend to explain this in the commit message.

Right, it's just for consistency with the rest of the code base.
Will update the message for v2.
