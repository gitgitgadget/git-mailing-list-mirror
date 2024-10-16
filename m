Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAA18800D
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106082; cv=none; b=uCDvRH/Ly9lIoq2sf7Nxz1LGokzOJVvh3Il+6Hdc7uY4AB66q21TK/V9cPfEpP7gFIWDDqHmjgWBkEGxe5TIezYzJQ19Ol6RckkVXHwhKHyC7rrejnl3o5kQaYpZSC4lwerFhe/iZho2/maHaS/223WHFZq26Z+sQxJz6XLIhAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106082; c=relaxed/simple;
	bh=ZnqNvqimtyJr0Pv29z4zRSYOZqm7VlbXDUX5iCqWAoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EISNOYuzuySJPpBWjt42PFe/y//0H5UyTTIq9+FuoLLFxogwxDrrsWvYb249eSqIifLcVsVxMcTRcWf/rwy7TP449/QV3lNPIZl7YZmgdvefK2XTfWp5TUnP/0fSmQ3+BNQiAhZ8MwFjTyQpvfb3GlJ+tKXfWEWu3u8LmrUzaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=TMNpWHqo; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="TMNpWHqo"
Date: Wed, 16 Oct 2024 21:14:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729106079;
	bh=ZnqNvqimtyJr0Pv29z4zRSYOZqm7VlbXDUX5iCqWAoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=TMNpWHqodQ6WVroBWmO7Nw/7W05cHP7fQ9cXbEQOETFo3IqWGQJmiSmtC7l/UBn4Y
	 SCUvj1R5FZFn5Zk9TO24BA1cdcm4OuIbVYRxmghYQzmuolNi8eY2Ko/EhglUXzLMMt
	 bYXxcRu4hCZ2tX0FuUW/ypQmGjZDWHbULy8TRmPH6kALI/crGRx3mvFeidFwgFfULd
	 rMu1rXJDCQJkPHIfUaGh0zFqjH1cLZinJ8el88rQHvtM77Ail9nNl1GjAEUWindiVN
	 DOLKHE/rtu1mNsZrAKx7Is7IAhZXO4UnH/GtpwdKQfPh/igKVoO2bKjCPuc0pItjyQ
	 Hrk5cviBqs+qQ==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <4dnthnr3ksoirvltn4smfyasyl5g4edzznheuo7hji4zy7h7gn@uomlcpchbvar>
Mail-Followup-To: Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
 <Zw9_46fbvbGhjmYw@pks.im>
 <w6vzuumbd5vrdluvnheescdgw36teuj6k5anlyiphvpr6slcgc@2gkwe2ye26a6>
 <ZxANnCw/yVzLl0yn@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxANnCw/yVzLl0yn@nand.local>

On 2024-10-16 15:01, Taylor Blau wrote:
> So that means that '%H', '%h', '%T', and '%t' are off the table. '%an'
> and '%ae' seem reasonable to implement, but '%aN' and '%aE' less so,
> because we don't have a .mailmap file to read. The same goes for the
> committer variants of all of those.

An interesting tidbit here is that git-shortlog(1) actually does read a
.mailmap file when processing stdin, but it takes it from the current
directory instead. Having read the full manual today, it's one of the
only times it mentions a difference in behaviour regarding standard
input.

-- 
Wolf
