Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92C56776
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620422; cv=none; b=BCVnj+6mUADVB6uMcyPp6+KNyz+fuTaoIiYeSqewiYvrYLxt0baBphLzlp0Du/cAvqLhWYoS8SEdf9XgypQ7DdJn7mng+Bm97sKOxBr8qR3W8ftbum0HeRtvndYHjT53vXKXWwwt4mDyvH6B6ddlrm/bkFC+IidOigAa2N9/LYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620422; c=relaxed/simple;
	bh=yY1LGVhgFsBc8tZKv5W1lS3WBldCU2o9VE0rkxmuYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLmrtuqqMgPGf05bjFl0uuTMpdiJxE0PXT/c9LNCabv0MHCHg/q4rEDVC2m5GRKyQ764MnWR3n9r1P2Af/5g0syCXdldkQ5CXM+vJJNCqJWtRjg4oAifNCtChPq+xl3Eqq5GUHqMWjHsZzzfDE3rGp83SSqK6WIm0n/2zA4gzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3126 invoked by uid 109); 28 Mar 2024 10:06:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Mar 2024 10:06:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4437 invoked by uid 111); 28 Mar 2024 10:07:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Mar 2024 06:07:03 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Mar 2024 06:06:58 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 2/4] doc: allow literal and emphasis format in doc vs
 help tests
Message-ID: <20240328100658.GA883510@coredump.intra.peff.net>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
 <202ed891463c134904b89a0d746d85bb62338d52.1711318739.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202ed891463c134904b89a0d746d85bb62338d52.1711318739.git.gitgitgadget@gmail.com>

On Sun, Mar 24, 2024 at 10:18:57PM +0000, Jean-Noël Avila via GitGitGadget wrote:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> As the new formatting of literal and placeholders is introduced,
> the synopsis in the man pages can now hold additional markup with
> respect to the command help.
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  t/t0450-txt-doc-vs-help.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
> index cd3969e852b..e47599cbf26 100755
> --- a/t/t0450-txt-doc-vs-help.sh
> +++ b/t/t0450-txt-doc-vs-help.sh
> @@ -59,7 +59,7 @@ txt_to_synopsis () {
>  		-e '/^\[verse\]$/,/^$/ {
>  			/^$/d;
>  			/^\[verse\]$/d;
> -
> +			s/{empty}\|_\|`//g;

It looks like this doesn't work in the macos CI jobs. E.g., this run:

  https://github.com/git/git/actions/runs/8460326247/job/23178326007

produced output from t0450 like:

  +++ diff -u txt help
  --- txt    2024-03-28 00:14:15
  +++ help   2024-03-28 00:14:15
  @@ -1,5 +1,5 @@
  -`git init` [`-q` | `--quiet`] [`--bare`] [`--template=`{empty}__<template-directory>__]
  -         [`--separate-git-dir` _<git-dir>_] [`--object-format=`{empty}__<format>__]
  -         [`--ref-format=`{empty}__<format>__]
  -         [`-b` _<branch-name>_ | `--initial-branch=`{empty}__<branch-name>__]
  -         [`--shared`[`=`{empty}__<permissions>__]] [_<directory>_]
  +git init [-q | --quiet] [--bare] [--template=<template-directory>]
  +         [--separate-git-dir <git-dir>] [--object-format=<format>]
  +         [--ref-format=<format>]
  +         [-b <branch-name> | --initial-branch=<branch-name>]
  +         [--shared[=<permissions>]] [<directory>]

I think the issue is that "|" alternation is not portable. In GNU sed,
doing "\|" with BRE is enough, but in BSD sed you need to enable ERE
with "-E". I'm not sure how portable that is (we do seem to have at
least one instance in t6030, so maybe it's OK). The most basic
alternative is just splitting it like:

  s/{empty}//g;
  s/[_`]//g;

-Peff
