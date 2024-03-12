Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E06997E
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231706; cv=none; b=grLLpBVo5vZCdDJ3aXKpha5P54ZF8zeOpvKayjoWJxr6AFq0aAvvRk4UTmId4jT/5pFcuvh4WTcaNXqjFEEts9vv5ced+DnQpUlJPNb+YIkVxNGL7RyptUoK2vFGCrPIMI4R9snRiuqzE3CRAihsS0PwI01GlPk5F7eSwIj9IHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231706; c=relaxed/simple;
	bh=x+lzIBKwNEzD+sg5eEZGaqULcmszhl4a6TXikq8x3Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4/FII2z9rJNz60c485qPbse9pO2kViGFGlM1vZyahrlq2IPQHK13INxvB2XCANoNTds3AjOBKXaiSKkvC4hzVe9FPCTwvB3YFDlknULgAJwyKxy3csUpcUCJL+2SDBU8Ef0as/5qW5NzmvVOsW/fPHrxt4Ud6cSuI5/0p3vZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16245 invoked by uid 109); 12 Mar 2024 08:21:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 08:21:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27621 invoked by uid 111); 12 Mar 2024 08:21:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 04:21:48 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 04:21:43 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 12/15] sequencer: handle multi-byte comment characters
 when writing todo list
Message-ID: <20240312082143.GD47852@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092747.GL2080210@coredump.intra.peff.net>
 <43b7b21f-8d11-4c67-96a6-ff2c8f037263@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43b7b21f-8d11-4c67-96a6-ff2c8f037263@gmail.com>

On Fri, Mar 08, 2024 at 10:20:45AM +0000, Phillip Wood wrote:

> Hi Peff
> 
> On 07/03/2024 09:27, Jeff King wrote:
> > We already match multi-byte comment characters in parse_insn_line(),
> > thanks to the previous commit, yielding a TODO_COMMENT entry. But in
> > todo_list_to_strbuf(), we may call command_to_char() to convert that
> > back into something we can output.
> > 
> > We can't just return comment_line_char anymore, since it may require
> > multiple bytes. Instead, we'll return "0" for this case, which is the
> > same thing we'd return for a command which does not have a single-letter
> > abbreviation (e.g., "revert" or "noop"). In that case the caller then
> > falls back to outputting the full name via command_to_string(). So we
> > can handle TODO_COMMENT there, returning the full string.
> 
> If you do re-roll it might be helpful to emphasize that there is only one
> caller.

Thanks, will do.

-Peff
