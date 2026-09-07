Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5A3932D4
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762210; cv=none; b=aCl5eC+0bUikdj2PEu172TUlcBx4G9C9r9xxo3kjCj+eR0ZFHLDqx8+nEp26S2D9nV5TobcDxYgo7jB/odzkTumUMojCZiajymUCI6DXP84NOkzXbE6a3iQY/l1FbNpXQcVDQ8+Cc89Uruk/PEANEDkOon6SFXrYeslmowl+FH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762210; c=relaxed/simple;
	bh=c4l3q993fmXoOJh4SWI0gyYUjxXHmY0HCW4qNONdhew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzZyRqi4jQtIfKfR4EtGVetLtHb1Tu0RJNwogthi2WlzwZjNJwEEFBbcFDXxnmN29dRurYS/BB5OYVYYbd113OlZXQONh2qtBZVUYbEcY1BcZLn/FmgkynRDEUfucj3+scHq7xW9XAGkE6TIcGD+z9Mc+OaxVu4jssyqswcynQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=s5oKacW0; arc=none smtp.client-ip=95.215.58.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="s5oKacW0"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c4l3q993fmXoOJh4SWI0gyYUjxXHmY0HCW4qNONdhew=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788762202; v=1; x=1789367002;
 b=s5oKacW0VPwyXIQWXaFCOJjwIzjG95AczeTWOGaNuKjzh7HJBfsCSaTeWn0sFDSinZNeTjAy
 rXxmMuMr0m4UZrRCw1tUpWPr8yEo1Ez8rOfAQ+1n1Sj8/Smy42WsRWNsZV9/jG4pire3eOk2zqU
 aHgx+pnKF2nZj4BwfElj9uJM8i827dBeDXAzIYYK3wiNzkgL7pItlKr6F27ncZyli/xUiiV0z/+
 y+K1q+dbLiHiyJ5o0ZMtEupWSUyDZO5SeRGhWAxu+mcRkL9LceunZFAmlG/3kPFjnkFjPyezP63
 ufI6RgAkU/wHm2UbWr/qX70uN5vw3LwshuK1IM7XuGhrg==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7c889ca81aa96aaf;
	Mon, 07 Sep 2026 06:23:12 +0000
X-Mizu-Trace-ID: 7c889ca81aa96aaf
X-Migadu-Flow: FLOW_OUT
Date: Mon, 7 Sep 2026 14:23:08 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Aleksei Sviridkin <f@lex.la>, git@vger.kernel.org
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref
 has no reflog
Message-ID: <ap5YTGRduklkI1Li@wyuan.org>
References: <20260903010547.85469-1-f@lex.la>
 <xmqq5x0mfgyh.fsf@gitster.g>
 <20260903200015.36849-1-f@lex.la>
 <xmqqo6ee9jtx.fsf@gitster.g>
 <20260903214551.53918-1-f@lex.la>
 <xmqqpkyt3qul.fsf@gitster.g>
 <20260905171343.34722-1-f@lex.la>
 <fdf8fa9c-1e6a-4f7c-bbe3-a0b41cdaabd4@app.fastmail.com>
 <xmqq8q5e480p.fsf@gitster.g>
 <CAA0xjtou7HwaKS8arPsBavkOREBHJ5ARN52KWukDntTJG6DUyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA0xjtou7HwaKS8arPsBavkOREBHJ5ARN52KWukDntTJG6DUyw@mail.gmail.com>

On Mon, Sep 07, 2026 at 06:54:28AM +0200, Thomas Bachem wrote:
> On 06/09/2026 19:14, Junio C Hamano wrote:
> > "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> >
> >> By commit message volume, I would have expected the commit messages (if
> >> they are LLM-assisted) to read more like Jeff King log messages given
> >> the corpus training.
> >
> > ;-)
> I can ask for that from the next reroll on, if it helps ;-)

I've already had an LLM do this for a while in my toy projects,
feeding it a few representative patch series from Peff.

Thanks, Peff! ;-)
