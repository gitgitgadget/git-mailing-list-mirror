Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A21FE101
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764476; cv=none; b=ah7Z13Yd6DkRv32DVUIsqyj9wupoTlbxU2TfTGKDg3GF7+1ylYMhZ0ENBPDX/KLhCjpdKO5qkiHa7nVNKYzh2lAIYAqkZrgJs8lisRYhGAnyS5zG/zbMpHjL2omJYVPpu7Wh/ackFKpAc7zYE8CQYWOl2HLZScHGRLaVGJ+Klg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764476; c=relaxed/simple;
	bh=V4xbz5igGKpmTO7A6Cxatgpx9d5d84+21GJRFqu7qtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puNo2JvyrdIU57qzprgM4Zrp0yu4M5YuOLEsmueQdjB/uvVI9sR3GNTXVfdpJl/FH4eviqmXdqSivf8D7+/n4yxqguhePJEy7bLeg94DTTbknK3MpiE5wGJ0ygSEQhNajzO/iD6nH8ChH1MiECCurFrFpQTjbjKrKV3RlaXvtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eiGhy+ai; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eiGhy+ai"
Received: (qmail 17340 invoked by uid 109); 4 Nov 2024 23:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=V4xbz5igGKpmTO7A6Cxatgpx9d5d84+21GJRFqu7qtI=; b=eiGhy+aiflTfrgjyuIlnxOmDqr9Z45f+9GvFgqoDrpIL0fTgxxV+EW5UpYSMUWoszl6FNeH10THI6+TM4cBCtRBLghK1hI1PdcefkghebYT2hH8FglI38aBOa0uPipRhsn3lCBkvWUapYckY5ZXGzl7i7+Y5Jid7qOj76unx4S++zmAqtIN5rCJYvtPnDB49OUPqank2A3X94ZlIvz8qfA/HlBsJto5PMfgWuwcbmDE4gRU4rxG/xmFgsI7WUEtfRk+KKT7n+1i2CQhP88Q/FvAuWa0AnPI++wkgmPog1FxCFjz5+qzqEhLG2w/1peODq73z7AyjQA01ochzsKm/8g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 23:54:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18676 invoked by uid 111); 4 Nov 2024 23:54:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 18:54:33 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 18:54:32 -0500
From: Jeff King <peff@peff.net>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: git format-patch escaping issues in the patch format
Message-ID: <20241104235432.GB3017597@coredump.intra.peff.net>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>

On Mon, Nov 04, 2024 at 08:24:14PM +0100, Christoph Anton Mitterer wrote:

> 2. The format-patch for that looks already suspicious:
>    - The From line is not escaped (as some variants of mbox would do,
>      some properly some, causing corruption by the escaping with >
>      itself).

As you note, the mbox format is not well defined. :) The variant with
">"-quoting of "From" lines is often called "mboxrd", and you can get it
with the "--format=mboxrd" option.

>    - What the format may think of as a separator after the commit
>      message (namely the ---) cannot be used as that either, as a ---
>      in the commit message is again not escaped.

For this, though, I don't think there is any solution. The receiving
side of "git am" does not know of any unquoting mechanism. So even if
you wanted to quote it, you could not get a lossless transmission of the
commit message.

This does occasionally cause confusion. Especially if you include an
unindented diff in your commit message, which similarly (and
intentionally) triggers the "---" detection. But I think it's one of
those things that just doesn't come up often enough for anybody to have
cared about trying to address.

-Peff
