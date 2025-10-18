Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED127A130
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781088; cv=none; b=MlTvsgVfC+DabKZttFOp1egEAPfiCa4wR92YUHumtEFNN3mmXPIj9bPq5lxFcPW5LBr4zVu9LT9OhApWOoAzZqtBUsNYTTNE5nPk1gxxjOaiJ5QYd39WuFwW0+AAT7n/rGwyp+/VNcOSj5zBSJLFA8TlYfIR2BtLXshk8amqN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781088; c=relaxed/simple;
	bh=1eetwjb3AR2vQ5S7XzYbQWuNrx1lbT0cDrOf89yyxqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDjk6l2B7OdGK9fXn9F5YYaU1eh+2tD6kXnafkCmAxMd/8HutNHUEagE8WdFKqRw8n1a2x22kNt4AYa1VhdOrPkoXCY4LiuDftExo5v4WDc7J4vAtm21ImRyMWfbrpdDrBWuR0rZe3yKIqwSCnUyu4fXDSbEKoYA93baqLiLH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ecctTCv8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ecctTCv8"
Received: (qmail 261255 invoked by uid 109); 18 Oct 2025 09:51:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1eetwjb3AR2vQ5S7XzYbQWuNrx1lbT0cDrOf89yyxqw=; b=ecctTCv8ZymfJn3TF8O5KukRbeSi3z9f8HwpxBuDI0Rw9Yr4VCFB4YluedsScRe4ElQC3NZPHEz93B79h9drNha6Zr2Gp6u1BizaG3aXEEJIrlk220IsFzueOElQdvVHg7h1cmg4ZswiP0/+LMddLmOTUWiSXLtTUpMBEtQFubo5/aCpGd0lgTHhZKq14oFgJc6D6rZQ1zdMUcZwiHA8/kgRBjQQsr4Lcz52t08JLoNwGt4s9i78aB4JEZXqmDRzTnmBOmRpU6GKuvTdWUe3bu5ZufxUI6P/cSQwli5assmmtfR3Mft/qJtTaR+/sw/GAFgozc0GpbGD+v3eDNuR2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 09:51:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 409777 invoked by uid 111); 18 Oct 2025 09:51:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 05:51:25 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 05:51:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Collin Funk <collin.funk1@gmail.com>, Xi Ruoyao <xry111@xry111.site>,
	git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to start
 with ENAMETOOLONG
Message-ID: <20251018095125.GE1060824@coredump.intra.peff.net>
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
 <87o6q6nux7.fsf@gmail.com>
 <20251017070912.GA4068463@coredump.intra.peff.net>
 <xmqqbjm51l3a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjm51l3a.fsf@gitster.g>

On Fri, Oct 17, 2025 at 10:42:17AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > AFAICT, ssh-agent does not quote the path in its output. So for example:
> >
> >   d='/tmp/has spaces'
> >   mkdir "$d"
> >   HOME=$d ssh-agent
> >
> > will produce:
> >
> >   SSH_AUTH_SOCK=/tmp/has spaces/.ssh/agent/s.IcPuGe26YY.agent.6PtD3uhM4O; export SSH_AUTH_SOCK;
> >
> > which is nonsense to eval.
> 
> So if $d were
> 
>     d='/tmp/has rm -rf in it'
> 
> would that produce some interesting side effect?

Yep. Somewhat terrifying, though I guess if an attacker controls your
$HOME environment variable you probably have bigger worries.

-Peff
