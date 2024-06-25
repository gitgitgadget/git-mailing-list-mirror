Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21C2E3F7
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321609; cv=none; b=J7sGNZKbCXyQJkO/QocJwLKa3+UO4wLQNjc9BPtTLH6vxjQSCMURTc5l+tLEdzBiVwY9VutzRXRF+SNKZ0JI4IkgbZMipCMNMVfAADCgC4Yi/YR1UkBaAX1VlV7ed1EBD781SrXJE67oZNahWBiGbNJO2ZjIVcMjyXieAnLPPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321609; c=relaxed/simple;
	bh=/zH1UK0ri/c/ffeZTebzuE0VQ0pO8zh1623x0kANxPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmkcag+K4llYxDAUl2a0zFSnxRtaKbOdK+qYYROklbh9JCtXTbw0/QSTVpmTpKNiGSERgJJkEWDJH+Hk2v1AI2jgckL4+AzMAFF/nSIgUpL0IhfuaRwY990N++u1qPHbKPqXh7907V2s4a/bxvpZdQG1c5qf6WFnAuopsrW8FKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10689 invoked by uid 109); 25 Jun 2024 13:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Jun 2024 13:20:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10811 invoked by uid 111); 25 Jun 2024 13:20:02 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Jun 2024 09:20:02 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Jun 2024 09:20:01 -0400
From: Jeff King <peff@peff.net>
To: Ryan Vu <ryanvu87@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: gitconfig - interaction between credential.helper and includeIf
Message-ID: <20240625132001.GA535756@coredump.intra.peff.net>
References: <CAF4erGWF+Lx=K09yFhd_abC2M5b5Ab0vM2uehkdVmridmsHqDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF4erGWF+Lx=K09yFhd_abC2M5b5Ab0vM2uehkdVmridmsHqDg@mail.gmail.com>

On Mon, Jun 24, 2024 at 10:59:33PM -0700, Ryan Vu wrote:

> I created the following files:
> 
> ``` ~/workspace/.gitconfig-workspace
> [credential]
>     helper = store --file ~/workspace/.git-credentials-workspace
> ```
> 
> ``` ~/.gitconfig
> [credential]
>     helper = store
> [includeIf "gitdir:~/workspace/"]
>     path = ~/workspace/.gitconfig-workspace
> ```

credential.helper is a multi-valued config key that forms a list, and
Git will try each one in sequence. So in your ~/workspace repositories,
you've configured _two_ helpers: a vanilla "store" and one with the
--file option.

You can reset the list with an empty string. So putting:

  [credential]
  helper =
  helper = store --file ~/workspace/.git-credentials-workspace

in your .gitconfig-workspace would do what you want.

-Peff
