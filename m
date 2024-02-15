Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800B23CE
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707975128; cv=none; b=cA9h7NuczTZ0fH5jEDwYr+oMlZL0/eS5r97MDAFsuJumbrelU5BJPestYZ6rMzlmuB75n/zKLUwiwJFOihsrmU7DVCU4JgPRzZRsEsCYHO4+aztG1dlxXuTsE+LVUDVlRAq7SPBA4eduDC8GeYjvW3l8vCruDh8fzLQGODn6/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707975128; c=relaxed/simple;
	bh=0pvw+blAJhJGD2HCT60qAWXDs5iZCzeSXUtS26AcANw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7mxtPUyY7WGO5gql0H5qV53PzX1OYaBSiMXtRgZBDrKuOWifdujdTDfaA2bnQceA2sY4qIgwGqq5+prBXTZ73gDRlO1wQ6dGpausI5xdrQ19mVnjpUWiFXfp7vwE0yd6Wobl9V0O2pgNanPryFx7s15Y3HYq09Ced9BSqYonbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18234 invoked by uid 109); 15 Feb 2024 05:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Feb 2024 05:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11910 invoked by uid 111); 15 Feb 2024 05:32:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Feb 2024 00:32:08 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Feb 2024 00:32:05 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs/reftable: fix leak when copying reflog fails
Message-ID: <20240215053205.GE2821179@coredump.intra.peff.net>
References: <02f7a97a451927f9a7ee06f3c5ea5af4c4eb6645.1707369907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02f7a97a451927f9a7ee06f3c5ea5af4c4eb6645.1707369907.git.ps@pks.im>

On Thu, Feb 08, 2024 at 06:26:14AM +0100, Patrick Steinhardt wrote:

> When copying a ref with the reftable backend we also copy the
> corresponding log records. When seeking the first log record that we're
> about to copy fails though we directly return from `write_copy_table()`
> without doing any cleanup, leaking several allocated data structures.
> 
> Fix this by exiting via our common cleanup logic instead.

Thanks, this looks obviously correct to me. :)

-Peff
