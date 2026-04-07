Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C41DED5C
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524352; cv=none; b=WcL12bYExC7HXrT/LsJ5j++KW+yXieGBmce2pPdR6qJtUQ4U7zNKBMizY1O5M7wDP7zs+uFOmhW8Y1HIh555PPVM2we8sA/mdmWNowie3TPy7jWmEc8kdkT9HoqZGAnFpWNlyq9pi22yP88y5yglVjWyh6osPONc8DthjJGdMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524352; c=relaxed/simple;
	bh=ZV5LqnW/HNwzkRbpxWmExCQHwI6hHoQyefoDLCQU70Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLkKLBUpNy3pKJvXqjAsJM0+9BNwCdNX5yleGw90N9kvJU8ZfJ9yPWScGTN1yEbNicq5MQ2hN6LJgIUwHklFjMDdmpPVd5aP1dxk1s4FzxWyGMjWWRIB7XKDk7slLgybuydqgCgZSn45E8jpQQi+wvCMCHkTjD7o4seIsp5+D58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=kIKTl6eo; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="kIKTl6eo"
Date: Mon, 6 Apr 2026 21:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1775524349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TXPVxeC1exxVhlaIFPfD0s0+ytlpzuNJov0eTXPrw0=;
	b=kIKTl6eo/wo9A6NiXXpFBRbosFmd3LsxOhmQG+Q7t35MOh6IBpASgktn55zIOT40Ru8f2f
	DgrNrvOhGcnKITOnzzx5+kSJoJlvUYWPCmBn9P3wKi9zRs7+EvB29BSKhm/hql9nBHs9HS
	MRkWOiGkulwpBIYuk7raL+1+lD70njE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [WIP PATCH] fast-export: emit deletions first
Message-ID: <k3qg4jodn425cjvorvdl4j24ik7c4jwmwudwsowe4doth7devn@f5xbrskansmj>
References: <20260406063607.15353-1-ray@ameretat.dev>
 <xmqqo6jwau34.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6jwau34.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On 26/04/06 10:15AM, Junio C Hamano wrote:
> In any case, it is a bit surprising that fast-export survived this
> long without having encountering the problem you are solving.  I
> wonder if fast-import handles such an output with some smart to
> avoid the issue?

I was surprised too. The case where this was encountered was a repo
that had a directory symlink, and promoted it to a real directory,
but the symlink turned out to be a red herring, it's purely path
prefixes.

fast-import itself just does things in the order given; you might
rename with copy followed by delete (though 'R'ename was added at
some point). It's on the stream author for this to make sense;
fast-export doesn't use this pattern.
