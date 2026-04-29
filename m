Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69D27A462
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450105; cv=none; b=IlowUgH1gHdd8z/NTAcr+GuUpnGO/0SWCe+DNyqmSZYNRmfjqSLh03dwXeJrZtyM7497VAFeoiPfWqJRBjpHajl6SzReChL/LY8HhEXfz22Pukz5KcBBUK8AUfAxeSVknYpR5b9QHN4PnBIqqIQ/sP/+Vtb5u70eXk1MoyQP4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450105; c=relaxed/simple;
	bh=KmMsDAbD3KLkKyf80DiLe8Z5EieZd7xlKh0uRyJRw9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwtJOrJJdkJLEYlvMg9BnT0OPRLcohUyawzGRXewrT0lAx/lu/Vuy0xlJCaoJ6tfmZ55tny8P4I6A6/Eph4wX8QHOIjXTklUEfAf5pzVCD/QWep6mhvpjjDObmxfOfTQtqO4yXSlQCgq+ooO+D6gCIJUl+qagOZhMJiWmCuTMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gsA5VZLG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gsA5VZLG"
Received: (qmail 485857 invoked by uid 106); 29 Apr 2026 08:08:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KmMsDAbD3KLkKyf80DiLe8Z5EieZd7xlKh0uRyJRw9M=; b=gsA5VZLGjSxhEzlYxcFzfKJ1OpFymRG1R7SkVQRZulBa7muFcBsMFlqwQZXlrlq/az5KO/GB0HHXubUWhiXlslZobncEKHHbLlq5mXa+mox+usBjLcYewpfot/Quu2jGAl4DtOVUQmGO58f6X6KPhO0ZoQzoOayXrHbEei+kJVIHjFff9IFQYwHAUzm/LC/g5us03gFJmLqplyQFfp9Drnk0HxmXtujO4P+GZcw6j2fzL0tppkDhoOuW7PyHd1N+NB701QXUvnv0DKzDL7nCWFPJU/b1l4+8dFQ+QwztL0IXOzrSZv6o+96LliAkQuFnFFV/DkdEK/H9+pNOgd/lWQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Apr 2026 08:08:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1099768 invoked by uid 111); 29 Apr 2026 08:08:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Apr 2026 04:08:22 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Apr 2026 04:08:21 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 10/16] repack-midx: extract
 `repack_fill_midx_stdin_packs()`
Message-ID: <20260429080821.GA1269182@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
 <44f522ea04df5176ec332b60a38d1eab9b649c30.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44f522ea04df5176ec332b60a38d1eab9b649c30.1776803827.git.me@ttaylorr.com>

On Tue, Apr 21, 2026 at 04:37:42PM -0400, Taylor Blau wrote:

> This simplifies `write_midx_included_packs()` and prepares for a
> subsequent commit where the same helper is called with `cmd->out = -1`
> to capture the MIDX's checksum from the command's standard output,
> which is needed when writing MIDX layers with `--checksum-only`.

This should be --no-write-chain-file now, right? It's not used in the
code here, so it's just a commit message fixup.

-Peff
