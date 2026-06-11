Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B42BD58A
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157749; cv=none; b=pzyPP1TjES4V+pmWuA3oQkExhw/cYbEp99RzjVXaigklumpfHgvOwuR80vLpabVZF9K0xDS/HOAKJ8CGISWjKUMxO9f3ys/vOj52pBSFy8ZGveg8w9/cDIGfxp6tuDg6+R4rty3WqRdKPp86Nk0ENUkSbiiQPLTUd1cbfLDzZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157749; c=relaxed/simple;
	bh=hxFnnJDdURy0t1u7YNB8ARBVdB7IiOkKA4nC7s04aZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPvSAi0i7SZp3G+YRn5JTF+DZZTS18kVAr7EP0ymamD55w1hf/4UFvT51xKfbLCnpcE8Y7YrjtsCFaHJbOTFHZr84tAsq3TrtkBmiQk1EJuF7iKBqoBJrjUCcZhBBsLFWBYGXudB8FamP9xQOO+Rv1xabNaxJk9iEiqouf+frhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U0Ts+0Wl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U0Ts+0Wl"
Received: (qmail 106087 invoked by uid 106); 11 Jun 2026 06:02:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hxFnnJDdURy0t1u7YNB8ARBVdB7IiOkKA4nC7s04aZQ=; b=U0Ts+0Wlg+fmp13h1qKYxTnzTUBPY46I4ECvhyatPtXtAs6BAS/YySOL2T5KqPkt/JIg2YeaTPLbzBbyNtsBlw9awSCImHjb29nliAeCGgVeT0wzWii3CWIsfyGiLU85W0kOiRuh4jcUG8YmBplzNePBqVs1+V1xbjUtKBV9kN7eJfH2zYd4LuZu1y78kIKzXCdSOu7d8cqu8di1pmRXPbb1f0eJadgNOrdCz36VBFlPwKan+WpJOpLRYpXo8418oWh4A0sUM2xu0J/Nl7k9YIWwjbGhSPJ2v7HrAIzKUGCpynkDwfDJM+3LrhFk/VNUKp6V40QqxTqNP1aa6+fgJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 313420 invoked by uid 111); 11 Jun 2026 06:02:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:02:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:02:26 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] doc: config: terminate runaway lists
Message-ID: <20260611060226.GB2187173@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi>
 <20260610225513.6269-2-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610225513.6269-2-taahol@utu.fi>

On Thu, Jun 11, 2026 at 01:55:11AM +0300, Tuomas Ahola wrote:

> There are many places in git-config(1) where paragraphs that should
> logically come after a list are instead appended to the last item of
> the list.  This is a well-documented quirk of AsciiDoc, and can be
> mitigated by enclosing the list in an open block:
> 
> 	--
> 	* first item
> 	* last item
> 	--
> 	+
> 	New paragraph after the list.
> 
> Fix the issue accordingly.

Makes sense. We've run into problems in the past where adding "--"
doesn't quite work, because we are already inside a "--" (and IIRC the
behavior is not always completely predictable). But I double-checked
these cases, and we are not already in a "--". So we should be good
here.

-Peff
