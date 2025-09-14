Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25B8C11
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757836263; cv=none; b=QPcDbZx6ZI5f5bWEfKekQxFFRX8oKCPqUNSEF9PXZJJypDEFs0GWOPodW32+YKR5uw5PAeaq/RXwksKo2hWGgrgUe4I2ty9vg/Qc9Bvo3jT8Fd5rB2O/yiPSrn2IjcB41K1B003h1Lxp6BhHNMWpVyP1GqW1HDLrZlUHZSqzVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757836263; c=relaxed/simple;
	bh=VYwuXdjEGyN1bvjYe+q6ucJ8/Q5Sc8T/OCMZbixduJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsAyalzShuMapbcv91RVK2ewKTjhBJx9yMnm8Dp+N6xYczhuGYcD2mBRifloUuS7KO7JXl5sRgKYIGy3qJSqeFad9aWIb3XBjuZy0+LkMA8dfQ1ipAzIj3EGZAgjEY8WoCU+elLrSqdje20JpphF2HesPkRmz0caFRB06njADoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=HBThvTwE; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="HBThvTwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FKZMXU2MZ8y/QliuuXjTx0dx/BmMR+8eAOXb7ZCL7v8=;
  b=HBThvTwEdZ8dd/PgjMGcXZkTI5Yvu+agzhDyIRYv3RN5ip0Gle9x4Z2I
   5nxK1IRSt6ZM9NkpcBMz1bNYgJx9rZSEc0XL1mRpIzE4xkNTkeumlUaWV
   t3nQVbEa+VAMw2DRPLQYTACAJMkuF0+/dyqixoPOiKp+2GKcrcmwH3Z86
   Q=;
X-CSE-ConnectionGUID: zScagblbSkmcA/y4dxd9Bw==
X-CSE-MsgGUID: JTOibweFSHWwWTCW/px7jg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,263,1751234400"; 
   d="scan'208";a="238936873"
Received: from 91-168-152-151.subs.proxad.net (HELO [192.168.1.16]) ([91.168.152.151])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 09:50:57 +0200
Message-ID: <d44109a1-0ff5-49f8-885b-9aae195ec492@inria.fr>
Date: Sun, 14 Sep 2025 09:50:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another
 worktree
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
 <20250913141327.2775228-2-gabriel.scherer@inria.fr>
 <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
Content-Language: en-US
From: Gabriel Scherer <gabriel.scherer@inria.fr>
In-Reply-To: <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for your feedback -- I fixed the sort order, and will try to 
reword the commit description as suggested.

On 13/09/2025 22:55, Kristoffer Haugsbakk wrote:
>> +			advise_if_enabled(
>> +				ADVICE_BRANCH_USED_IN_OTHER_WORKTREE,
>> +				_("Use --detach to avoid this restriction,\n"
>> +				"or --ignore-other-worktrees to ignore it."));
> 
> I don’t know if `--detach` will “avoid” the restriction.  (In fact
> `--ignore-other-worktrees` might be the one that *avoids* it (turns it
> off)?)
> 
> Technically the only point of being-on-a-branch is to be able to advance
> it.  You know that.  But does the advice-receiver?  Because they might
> use the hint to get what they want immediately.  Then later wonder why
> all the work they did on the branch “had no effect”.

In my in-progress version of the patch, the reworded advice is as follows:

fatal: 'foo' is already used by worktree at '/home/gasche/Prog/foo'
hint: If you want to proceed anyway, try again with 
--ignore-other-worktrees.
hint: Changes to the branch will also impact the other worktrees.
hint:
hint: If you want to detach HEAD at that branch, try again with the 
--detach option.

(The last part is shown when ADVICE_SUGGEST_DETACHING_HEAD is enabled,
and reuses the existing wording for that advice.)

