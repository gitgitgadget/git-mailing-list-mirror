Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4722E62A7
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744320952; cv=none; b=iKC8fwhzyC5gj+xzbEGxkE3qyneH4MkzMIOErP3ybB/lUU3N9xIgB+nkJR8Pp29TqfXEcumJnT3zrZHdEG9xq+cK8z8a4/0eeHMvEmDUtG54zPslD0STmHIWhfQlLbfn4gnY0R22P2FZs/aK66I1r9uHtd0prPleRwW3SJMlWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744320952; c=relaxed/simple;
	bh=SNxwfNGS6ViSqWDBFQMSoHddt9LH0Ic6g35oin+Au7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cij65R/7TL5AmiCDLIQiTde/zyl7ne0DhJB2yp/oWHWCdtYY2zEq/R2aEsvQ6X7V7mIlRYL2H4dDhhx58xZ22BErzbwKU9RdpUKjWYQg2K0KeHXT0KwbGzeEReyb39L8iPkhEGJ5NaHN+6MO5k7pXkrJ48Mp7N1kOm9myKzl3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ahiMMwDP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ahiMMwDP"
Received: (qmail 30222 invoked by uid 109); 10 Apr 2025 21:35:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SNxwfNGS6ViSqWDBFQMSoHddt9LH0Ic6g35oin+Au7Y=; b=ahiMMwDPlZ2YypHgxeHjMCYmLYh3TsyMU5MGtZTSLBOJLdKVzmE4JpH6RrE7FuEil5VjIikiTDqW74ZC+0royuRYQCS6FBnvJoEjDKybdbs+nbpbuSzVOHbbDe8uGynHqKyOdXT6EmEJnX28UKTeq9bGnENo6NuiA7GjXkcL0iTsATP+fbGvxxSiJ2m30EaSgSNmJw87bGxOzQEGKNEjqlyh+uC4FHVM8fFh4R2o3KXceIsaiBa5rNepBvOs9K/hzy+fqsQFkX3qQTihTOkFCSdRo4hxDal5uhPVFEbsqMylM99qAXjRSPuqprWwjNCA7+GrSWjMxeuKMpoHMjvSVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Apr 2025 21:35:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17093 invoked by uid 111); 10 Apr 2025 21:35:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Apr 2025 17:35:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Apr 2025 17:35:42 -0400
From: Jeff King <peff@peff.net>
To: Nikolaus Rath <nikolaus@quadrature.ai>
Cc: git@vger.kernel.org
Subject: Re: 'safe.directory' setting ignored for some operations?
Message-ID: <20250410213542.GA3168175@coredump.intra.peff.net>
References: <CAPzgaL2Q4v0LMSek=osugTDCDww9D-Tg+tDsFhFvRSVXFR8g6Q@mail.gmail.com>
 <CAPzgaL1NH_GofMko6f2Auz4e1TjTJNH0w4-ph8np04QRfT_R7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPzgaL1NH_GofMko6f2Auz4e1TjTJNH0w4-ph8np04QRfT_R7A@mail.gmail.com>

On Thu, Apr 10, 2025 at 02:21:01PM +0100, Nikolaus Rath wrote:

> It seems to me that the 'safe.directory = *' option is ignored for
> some operations:
> 
> ---snip--
> $ git --version
> git version 2.43.0
> 
> $ git config --get-all --show-scope safe.directory
> command *

You're getting "command" here, but I don't see any "-c". Presumably
you're setting GIT_CONFIG_* in the environment yourself?

> $ git status -v --untracked=all --ignored
> HEAD detached at e116555
> [...]
> nothing to commit, working tree clean

You don't show us the repo here, but presumably this is one you don't
own, and the config is working as expected to allow the operation to
proceed.

> $ git clone -v --no-checkout --
> /builds/coreinfra/grafana_terraform/.git
> /builds/coreinfra/grafana_terraform/tmpus18hzbs
> Cloning into '/builds/coreinfra/grafana_terraform/tmpus18hzbs'...
> fatal: detected dubious ownership in repository at
> '/builds/coreinfra/grafana_terraform/.git'
> To add an exception for this directory, call:
> 
> git config --global --add safe.directory
> /builds/coreinfra/grafana_terraform/.git
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.

Here you are running afoul of the environment-clearing that happens when
Git internally "switches" to another repo. The "clone" command is run in
your newly-made repo (which is "safe"), but it would then run
"git-upload-pack" in the remote repo to act as the server side. We clear
out many Git-related environment variables when switching between
variables, including GIT_CONFIG_*.

  Side note: clearing out the config has been a subject of debate over
  the years, but one of the main reasons we do it is to be consistent
  with non-local transports, which do not pass environment variables at
  all. Which is good for some config, but can be annoying for others, as
  seen here.

So I think things are working as intended. You can get around it with
either of these:

  - set the config in your user ~/.gitconfig, which will be read by the
    child upload-pack command

  - tell clone to pass the config to upload-pack, like:

     git clone -u 'git -c safe.directory="*" upload-pack' ...

-Peff
