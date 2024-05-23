Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754813CF98
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460948; cv=none; b=pB4I+cl+zxLJunmD/i7jI6VEwLNxmupqrKKU2w7A4eZTJSrZ8mD87TtAxEHEtomz997QXqsQN/bF97fOXzJyNdDMiH+p7rTmqjmR9uVm4szpaDa2y924e8EREzwwpN0UdnVWC0Y+wxdSQPQ3NwBSKjDXOVtbkI74q52qZRKptSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460948; c=relaxed/simple;
	bh=uwNM5j762karlp57bbLBrBNzGFChzcX+PxdBO98cFic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrJBqfJWv91aDJqwARGtwvyU4rkki+qcOoqbFStwZZb1WucbkY7/GV5vb3yHrmdghoKTAz+AXnFMj8mMskZ2fTm4XcqK/wgtU98Wd3xFWxQz7u+FdFBXEJsSIvnWTVhVw3B0W+HozvkcSVCnDj22CeXedlwdaI3wqceG3wLL3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31342 invoked by uid 109); 23 May 2024 10:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 10:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29208 invoked by uid 111); 23 May 2024 10:42:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 06:42:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 06:42:24 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 25/30] t/test-lib-functions.sh: support `--date` in
 `test_commit_bulk()`
Message-ID: <20240523104224.GD1308330@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <890f6c4b9deb9e3bf02aa180c7ad4ced7f7b6a80.1716318089.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <890f6c4b9deb9e3bf02aa180c7ad4ced7f7b6a80.1716318089.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:02:59PM -0400, Taylor Blau wrote:

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 862d80c9748..16fd585e34b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -458,6 +458,7 @@ test_commit_bulk () {
>  	indir=.
>  	ref=HEAD
>  	n=1
> +	notick=
>  	message='commit %s'
>  	filename='%s.t'
>  	contents='content %s'
> @@ -488,6 +489,12 @@ test_commit_bulk () {
>  			filename="${1#--*=}-%s.t"
>  			contents="${1#--*=} %s"
>  			;;
> +		--date)
> +			notick=yes
> +			GIT_COMMITTER_DATE="$2"
> +			GIT_AUTHOR_DATE="$2"
> +			shift
> +			;;

This gives all of the bulk commits the same date. Which is kind of
unrealistic. Conceivably you'd want to be set the starting date at some
old spot, and then tick forward from there. It may not matter much in
practice, though.

-Peff
