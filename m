Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81D1A3164
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493240; cv=none; b=RiZJ4dI5Dj5EWzqVyPrHcsKQuPHUFsilFHa1B56gaPSV0bj+T54xomM7jT0wzm0nSKEm6nwNVGf0bEpB3No+fvquQbIwV7UQrcFB02Rp79GU15wVLd9Ix9/1nSb3CXhzmyHrZCVBMs5sUwlol6b4yq4cOIY/p96+Fmg1BdsXqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493240; c=relaxed/simple;
	bh=nKRAu6RR59AJOJM8H2ZEdZSuxme/95uSyIPF+/wHkFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+utDgS+e1yJ33Py6dPS9JLO6q/ihLAcGykP2Ej93APFqnTkaCK81oTccZOKecSCjQSScBZB8mvJW4X79+Cf0XQUigcwGJeKFclbGqIgxTd01le3zlkP4oIbYXwuj6ZaZYiq1UaFCK/vb2ENd8kSurrmH/Kiy+CQxEM8YkZvLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DlNnUEt8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DlNnUEt8"
Received: (qmail 346918 invoked by uid 109); 26 Oct 2025 15:40:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nKRAu6RR59AJOJM8H2ZEdZSuxme/95uSyIPF+/wHkFk=; b=DlNnUEt8sPlB8MxPPg6BeJ754mQGCawOKsZMtlDCZT44GLyP0nGDFKYAjvFdtO5auRprzKhRRxZdSH7k/n/Kys+f2QGRRjw3svSRA0iJ8h1/jYFlRFwhKh7N77wBd9vo5UcghOUx9HLL7gKTQwoQ25XpdEaDRqRM1g49OjgZ6sSOw4gr8gGZpJHn7sFJg+e/QegNuaiQ8fakjc6P+Y7HaP0NlfnRfUMIdWDWMBVLJong4TrsvUKbzT5GdaY1pIIeWMpeUeLEKUwWxhOMLbjVv3V8xUMWFRxL6dPE6Bz+Hzrf1A5/ofKQmBNpUCEAiAcvy5TuZlDIy/4e0bGvushLAg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Oct 2025 15:40:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 542508 invoked by uid 111); 26 Oct 2025 15:40:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Oct 2025 11:40:36 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Oct 2025 11:40:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 0/2] fix "foo**/bar" matching "foobar"
Message-ID: <20251026154036.GA2173430@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
 <20251026152614.GB2095501@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251026152614.GB2095501@coredump.intra.peff.net>

On Sun, Oct 26, 2025 at 11:26:14AM -0400, Jeff King wrote:

> Me too. I wrote it a few different ways before ending up with the "==
> 1", just because it made the diff smaller. But let me do it as two
> steps, which I think will make it all more clear.

Here it is. Maybe excessive to split it up, but each patch is quite nice
to read now. :)

  [1/2]: match_pathname(): reorder prefix-match check
  [2/2]: match_pathname(): give fnmatch one char of prefix context

 dir.c              | 18 ++++++++++++------
 t/t0008-ignores.sh | 11 +++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

-Peff
