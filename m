Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C23546F5
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252412; cv=none; b=cX8MOhgzeJ4v7oc6ckvyuYD/tYyC485oxLyzqAf0kbRUQj3/SOQG/nF1OaE/+xXuRxNKYx3N/FRpfmqwyzsxRhnUkl01EVRTGmKgfcOcoNaZTIYH0zGx7Ukg2hh2E3Qh56CiI4gZdKhsq64/2uSA5sS0+qI4nrwiqW7WiSIHshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252412; c=relaxed/simple;
	bh=V3IKcD7gB5c4b99/R8ITkw6g8TgrNLKfVFhB1wZr834=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ViHuYXzPbgyqOtw+fOvoRNcT8tbbbwlBCAHZZWOTw2G9NVg22jQpeOjZpBegfACbWaS2g/hi8oyxQd73IrlZgBEi5TCAYpzl4WY0mL3Kw0hFE2H45zOmCwFVQhBQYedEKYxEwmKHEqhCnPFGUKCJ9WgCmdIKt6INlod80Hhu/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=47P4z4Fs; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="47P4z4Fs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781252408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yZCWsiuDFCbpcY0Bw+bAjFzslZsG1DDfuhAj0N/etf8=;
	b=47P4z4FsA9abfcUN6lGEwggDpphoaFehFluCmddGrqaI74vwjE/7hYL7W9xtBhGx1YZi4b
	kh1tWPrKFJ/Rzh2uXCkcz36mIxuuVU0eTWAsj3VKunYCWGaC1nlNs7Zr+C/wpYVIAW+7vQ
	RITwtPe/EIQKpo5WvhBG5/0OeMGAigM=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] replay: refactor enum replay_mode into a bool
In-Reply-To: <airORumUxyTsN7Bz@denethor>
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
 <20260610-toon-git-replay-drop-merges-v2-1-5714a71c6d83@iotcl.com>
 <airORumUxyTsN7Bz@denethor>
Date: Fri, 12 Jun 2026 10:19:40 +0200
Message-ID: <87h5n8yxur.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> Naive question: Do we expect there to only be two replay modes in the
> forseeable future? I suppose if other modes were added in the future
> this change would essentially be reverted.

The enum was mainly used to determine "direction": PICK to apply commits
forward, and REVERT to apply them in opposite order. But it's a bit
twofold, because REVERT also applies the inverse change. At the moment
--onto and --advance use PICK and --revert uses REVERT. There could be
added more options in the future, but I don't expect any of them to add
a new mode. And if there is ever a new mode needed, I think it's better
to re-add the enum then, or maybe a second bool makes sense then, who
knows...

-- 
Cheers,
Toon
