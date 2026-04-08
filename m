Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B683D7D88
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670047; cv=none; b=JwwfL2CYd38MAJIFKwbL/A37Y6o2vHgFNAubt1QqO+XyQvQxYURzK6jdPXMrBLb0AfEqCiIa5DLwbV3ayJ+b3vsqDxbZnYYyXsyI+H3VrUPnl4F955fhT5WnMJaJG3LQcxmtNpNTl4oCOYB/313400RnBaus+6gOxfW+DxG39qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670047; c=relaxed/simple;
	bh=PBrTljG+AVc2Euqw++JwzS7wl2qPI2fYrQWhBd+uYD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOkZ1deJNvgD2OIx1jKqfryd4DPEM6T6BxLVialJL7AimwerA0hCwqO5XW3Q28OVKtiVgUStM5zhpvH2VlmR4xhtBnXkCIDWkFaZlGKGWzJYXlSnHUOML+jvmjw2uhh8GU+DpyXoW8c37LBM+1AKZ9sXPLkDhNARu8teZG/xEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K++DKfvG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K++DKfvG"
Received: (qmail 284019 invoked by uid 106); 8 Apr 2026 17:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PBrTljG+AVc2Euqw++JwzS7wl2qPI2fYrQWhBd+uYD4=; b=K++DKfvGPh1AvEOkeuMt2qa8y3W0FGVAt/UOZGeF4c72H+j6QQO7mFIzlIyoAhQcO592swo/Aqr4wMtvrcIz4HgzOu+n2FhmMopy8qLw17QltFqCbv58Nyt6NH0vekkdQdHwagO+n8aRoLvK7bhw1dzOLQGs8sqwYKmaczVOb7LI4d1Rhv+eDAawd3ppUoUneFNqaAABf1YN9c6WtH9gIRg7+A3OltL7GIW9CUosH6ssqajAOOVFaa/6DlF2cZmQW+sw2ZbgCdtShm0Q/qy7cxq+4IblCxyZiDrceXuVb2ly08Muw5Wd88BV5/e3ozvdeqe0732rVwX/C37YFF7e+A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 17:40:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 466488 invoked by uid 111); 8 Apr 2026 17:40:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 13:40:44 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 13:40:43 -0400
From: Jeff King <peff@peff.net>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] archive: document --prefix handling of absolute and
 parent paths
Message-ID: <20260408174043.GC2850002@coredump.intra.peff.net>
References: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>
 <20260408160005.193621-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408160005.193621-2-pushkarkumarsingh1970@gmail.com>

On Wed, Apr 08, 2026 at 04:00:06PM +0000, Pushkar Singh wrote:

>  	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
>  	rightmost value is used for all tracked files.  See below which
>  	value gets used by `--add-file`.
> ++
> +The <prefix> is used as given and is not normalized. It may
> +include leading slashes or parent directory components (e.g.,
> +`../`). Some archive consumers may treat such paths as
> +potentially unsafe and adjust or warn during extraction.

Thanks, this reads fine to me.

-Peff
