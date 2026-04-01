Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972E23A984
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071530; cv=none; b=ldW6AYz7dnN2pYEv6NY4QoMyty4o8YUWZOLwfCBZx/Zd8thxbKs0U4Q8e9VXAWKTWsExJpQdk0tmqKaLiB87sYXuh0k97GmVTMaEC6K1ncrBTB+qpamQbCXXs3eMVV3aAAImZ7Fb9TVA4A896ql4gAcCBFO8+mMKFWZaT78846k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071530; c=relaxed/simple;
	bh=QTQjAhcwIcG8lI+cGbK0SU/nyUPv+vVpEZDeKb0Rvm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrBdoUOxDL/UmC43zjgOZ2ohpG3e1MQQlR4vgzbGcy+F+++FUmfCmtvOkwjqKFDKq5E2ndBhDYkuCQkLKlg99kAlOymviVB5hlH+UXdzTtbuuJzm9RS945y1ZKt97ui85uS6luEDyLSE3joij7JZ+tPtuHczjTfyR7EHvpyp4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HOjTVvBI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HOjTVvBI"
Received: (qmail 214615 invoked by uid 106); 1 Apr 2026 19:25:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QTQjAhcwIcG8lI+cGbK0SU/nyUPv+vVpEZDeKb0Rvm8=; b=HOjTVvBIH68kIAvCzGBk1oFG+XCI/+eMdTYaWNFQRBNERyay3XvAClOBbH6GoFh7IogYumNAOVAWXck0l8Lxdsf6J1vPdQU43Ua4lQUV9XarZkMWard7rF66g+KmkIjlJLFvZ7c3jdYIADuPWxlVnZwNkZ5vhMy6B9PR/p7nHOPTzDbvslPma+orp8tuio/KgTM7RwBDF2ThdSe16iuUDplYueqJ6F4KM0uoMrT6qE8DCiYzpJ/Jn+fhXF/+G+y8cBGV94yzp/bwOnSZ2qbHkOMiFSqYXiCmBViSibqv8QvQutH1tzSxp8q4apRL3t1fQ+TkXSmSalrtl/M4mA8CpA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Apr 2026 19:25:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 342826 invoked by uid 111); 1 Apr 2026 19:25:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2026 15:25:26 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Apr 2026 15:25:26 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <20260401192526.GB2905896@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>
 <20260330230130.GD41843@coredump.intra.peff.net>
 <acxJ/NfLNloCv3o+@nand.local>
 <acxPyXnV8HtxtEHl@nand.local>
 <20260331231713.GA2325145@coredump.intra.peff.net>
 <ac08qYDcQ7z/2/bC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac08qYDcQ7z/2/bC@nand.local>

On Wed, Apr 01, 2026 at 11:41:29AM -0400, Taylor Blau wrote:

> I think the latter of these two makes sense to me.
> 
> I'm not necessarily of the opinion that the strset API should *never*
> have DUP/NODUP semantics like the string_list API does. But I do think
> that we should punt on taking something like this up as long as
> possible.

Yup, I completely agree.

-Peff
