Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95628E0F
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739464; cv=none; b=Mrev+K4+DCllwCPnP6nPGNAniMv+DRBreZ9sJkcv2XNdaerUfjpdUfOAHvl2fbL7I2X5aSaG3wP5polpgTwPl0M40E08A8qQf6FuZClhHwg5NMOabN3ndQBNQ5RLc+yVaNzvm8TrvjLmMu1L15/hdFayrucdctw9HhJfRDRghvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739464; c=relaxed/simple;
	bh=6BjVasOeOP1R/aHHOSLFza/1QnaCGhFMXQwpf5zzCXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsrhFdmrB+3fmil5ee6oM8nxWOP1f4WukUkkavV+jcvPudWhjwef/dg7w27UCFQenxjL1fszwQmD+xhpk1ewsPjcjdHSJ9GnaqjIvcm4atZSbZoLNg8ke7v7GZEWgIJXPN2U6jmZEDYK/Pfbsg4Ww7YTNhVDyplPlOH74gBOIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SW/MTyP+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SW/MTyP+"
Received: (qmail 61702 invoked by uid 106); 14 Aug 2026 20:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6BjVasOeOP1R/aHHOSLFza/1QnaCGhFMXQwpf5zzCXA=; b=SW/MTyP+YvQW8OtnymFMsCk/B9UkyqvjjDz8az8xj0eyF+va1Z+6Xm39ovMHjv1iOWZeU78TPTluNGVVM3xsJyfoRE/hCnL4jYVziBY0W4A7wDvVLnTqMWjDzMeTB+K19vL1xdsJ2E5oLUqXCOahVGe5i2dUuvIUHro9Pif98MtWAaYSMd8UfXu80UduCUCYuozRMchbjPIZBr8SpGmex24lh0DZJvDRRInWfjrSl/eqxja3MGZnzaT3J/u335ujfZheF3Ycp0vljHGyMXxPEdpuHr48RSROpF8SoeTYtALJ0JI/eIwqEBXa45uKRz7u6JV7HhU/8wAXdtWl2CEdyQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2026 20:31:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 61856 invoked by uid 111); 14 Aug 2026 20:31:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2026 16:31:00 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Aug 2026 16:31:00 -0400
From: Jeff King <peff@peff.net>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] chdir-notify.h: Removed unused param 'name'
Message-ID: <20260814203100.GB2575854@coredump.intra.peff.net>
References: <20260814193849.1538-1-colinlewishinton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814193849.1538-1-colinlewishinton@gmail.com>

On Fri, Aug 14, 2026 at 12:38:49PM -0700, Colin Hinton wrote:

> the `name` parameter in `chdir_notify_entry` is only set to NULL.
> Dropped to simplify logic in `chdir_notify_unregister`

I think this makes sense. It is often helpful in cleanup patches to
summarize the history in the commit message. And then we can be sure
that the unused field is OK to be removed, and it is not simply a bug
that nobody is passing in the value.

It looks like these became NULL in the callers across several functions,
like 1f43ff2c7e (refs: unregister reference stores from "chdir_notify",
2026-06-25) and 0de2467e6c (odb/source-packed: start converting to a
proper `struct odb_source`, 2026-06-17). With hunks like this:

  -       chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
  -       chdir_notify_reparent("files-backend $GIT_COMMONDIR",
  -                             &refs->gitcommondir);
  +       chdir_notify_register(NULL, files_ref_store_reparent, refs);

None of those indicate why they drop the descriptive names in favor of
NULL.

I think ultimately the reason is that the only user of the "name" field
was chdir_notify_reparent(), when it produced trace output. That went
away in 5bf546755c (chdir-notify: drop unused `chdir_notify_reparent()`,
2026-06-25).

So those other patches were preparing for that world, though I think the
ordering is somewhat confusing (and I won't be surprised if there was
some intermediate state where turning on tracing might have caused a
segfault).

So AFAICT the patch itself is good, but it might be nice to give some
explanation in the commit message.

-Peff
