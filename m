Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB325771
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538277; cv=none; b=ImiVE3Pr9708EfMc6cwOTfKmEcK+O85mfq9dyVvfHTk7DZUqR6BYSnPp2bKiZ7T/mQOl7/DY1sleQovBYjBtKeMNN/0xtgcw+rRFQ80Zf3kpxDphgrM8myDFktGq76i8d0iZJAVRV7TjhGneuavGwZPiEZH5Jy9V6PtfNlRXsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538277; c=relaxed/simple;
	bh=o9zvFLs9F+gWj3fmzrxMqIVYVWeagui/akcYkd2Yofk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDucBvrk7dq8VwKVb7pEaqSVnt2/B6fqlrYb9pPhEjSBgVa7CUeKtThBVWnezQqRs2GebP1EiN69z5W+w9tdSOAeVlJag34/W6b88neb/JsGSmpgr2alrtSGlQSr+zfPRhTkkdMm85+ZPvy9RwZLNWQiWf1GK5iLz4k7+98XA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=XmDB/5P2; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="XmDB/5P2"
Date: Sat, 18 Apr 2026 20:51:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776538273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwBmvkoYA7e3rgGLofupaR/MFUTLGoC7oddUzAc8bn0=;
	b=XmDB/5P2Nv0fx8c/VzBEUbid1i7tzt8keXPAcOl1+9nwmoY7j5753tAOVu8LvKFruzvDMN
	KZ32EH8Abgc1XhfihKjxkTJKinXREmIOJ3MY5io+GciHcLR6Oe/WlbMJ0mYLKVSRcYqYly
	Zfe1GPAXR0i3JNus8wgxuoDs+wV9ByrBcJoVq9teironMr8NTlpgkoj/CsOhLR98sOy+qj
	sXBLXFgJ6x1UnKi1+bv0qboikv/6Oxh5RXBAjVcFKwxzIHIt78sEweP9jH9F9Ou7ZOVH4o
	hAL4zJHT8YCjf3X2XuYM11E4K5pqIjcqEvOhBCzuXan7wVKWvlBUynrec4RE7A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aePSGXu5l9x-NKVG@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=mroik@delayed.space;
 h=from:subject:message-id; bh=o9zvFLs9F+gWj3fmzrxMqIVYVWeagui/akcYkd2Yofk=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp49KTd8j8eJpXtPuxBjhjqR42a268h64Ke2OWI
 rHSh6LxJ7WJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaePSkwAKCRBIeX6hnBm+
 0XwCEACoonAYAkbCmt2toYK1I5/Xra+yMzRrQ1aqH2/+4FXHBCEHgKuYOlS73dUYN87/HrSmzWb
 bkXwSxTelszAGtD4tkrGXB8FawMKtwitr/zL0dcQj/gxzbhbwt4rJM4cyLuGSHzUk1g/JLf0F41
 1dR6DYLNFwveF7Ax7+zPAkLeuDaOsB15Z9jNeWqZtNaAVansYqfDKbqEMEamOML9nI+OM/7UajF
 bQ/XdVGVUkoQvWx8/GdXwf9UsA8X6IrXYECch7Bl8JId6/GShTPDgLzTjotUBdDjV8t1HQLgUOm
 rxp+SmyI6FrCdP2FG8OTMG0xHv8UKvPCJDWGW77n8swbF3SQb/ZFDf3kzYt9abJG6xTModkPmCc
 4Hey41J3SV9Em9F8Yx97LnKizFTO/BnDu+gsCBSMpmFPMt9TgaRXOyqxOmhaYjuWKXh3zGTfAbo
 a2gYFfR0zCtJMUkesjokEb15YUtDzbaCXsIAH73dp8JEYgi+jIizDETomwOo6Cw0/1djui/wgv7
 nVqdHRHbLzj6+ulnPFHF4wh863xBUunWpFeUwmXwXa9zeCva36E8xYCwz4SoLZeCWPGnVmiTLzu
 DZ20iLTGX+HrfxTpKOoUXdfhKUYPoIA5vEeslYVWBYKS70q28BwjkRwRVsr+9CdVd7iZCxNX4gi
 Ft0XE/wu9i4DNHw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260418164736.2367523-2-mroik@delayed.space>
 <fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev>
 <aePNILp-yB_8gfiY@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aePNILp-yB_8gfiY@exploit>
X-Spamd-Bar: /

On Sat, Apr 18, 2026 at 08:42:15PM +0200, Mirko Faina wrote:
> > I think the space complexity here could be reduced a little. After all,
> > since we’re only retrieving a few commits, there’s no need to load the
> > entire reversed commit history into memory.
> > 
> > Perhaps we could maintain a window (or perhaps max heap) of finite length?
> 
> Unfortunately since the underlying data structure is a linked list we
> have to traverse the whole tree to get the first one from the tail. The
> way get_revision() loads the next commit is through process_parents().
> Even if we were able to start from the tail we wouldn't have any
> reference to the children.
> 
> I suspect reducing space complexity would require to change a lot of
> inner workings of git to make the history traversable both ways.

Oh, I missunderstood what you meant, sorry. Yes, a window should allow
us to reduce the amount of the memory used. Will do in v2.
