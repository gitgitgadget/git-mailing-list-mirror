Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F5139E
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707442527; cv=none; b=YmpjC+C/J+g6h21w8LCtTKqnBFtvjucPnEFoCAUhVsM32iYtoCAqtHQn7twnKZqq9ZYQZjODfhtYNzBJ0MhHqfH5TodXSCenQO85WZhwFsEsjeuKYMZL6rs6jVb17aOTNe2QX4bMefI+g/maPFllj5eMF4YUXR/kVLY4hGHtFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707442527; c=relaxed/simple;
	bh=IUidngAXyxejLoarBHXZHqE3t+dn4j4weyl9n3XKnqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9uw3pOy9fz+aJwtR11rc/CuEsdiF7Vb2K2nZ7OgwI3WaqbMTgfx2ZIkveZrUnDW9iBjJrJMXiPonmHaMzxbjSMIIufAaPG372G30QUvfEjt0rQDOfoE2Enu3ycY+fVHlT56a9CUJlefewEJxyJU2yR6kVKQW7FzSitg0i9nSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=11yIT5Cm; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="11yIT5Cm"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D951F405;
	Fri,  9 Feb 2024 01:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1707442180;
	bh=IUidngAXyxejLoarBHXZHqE3t+dn4j4weyl9n3XKnqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=11yIT5CmWFaf14+dc1dUNR+AQIIKW5OOsXKgKD0U6KEsGoiiKb64sFwI0/KRt9BP4
	 UqlXXAcCZZ55XmpoaOT7AKMff0RfkHXU9gxmHlCgC1BRUkOxjLyVUaFTHkv3xln2Nv
	 uWjadxalR36RwLEm5XXped/4xb/OpMh/oKZHuC5s=
Date: Fri, 9 Feb 2024 01:29:40 +0000
From: Eric Wong <e@80x24.org>
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: cloning the linxu kernel repo at a VPS with small RAM
Message-ID: <20240209012940.M610977@dcvr>
References: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>

Toralf Förster <toralf.foerster@gmx.de> wrote:
> I do wonder if Git could automatically try to deal with only 1.5 GiB
> available RAM?

I have to use pack.threads=1 myself on SMP machines, too.

_SC_AVPHYS_PAGES should probably be accounted for in addition
to _SC_NPROCESSORS_CONF when calculating the default pack.threads value.
Calculating good defaults is hard, though...

I've also been meaning to try the newer tombstone-free khashl
to replace khash in our tree for memory savings:

https://attractivechaos.wordpress.com/2019/12/28/deletion-from-hash-tables-without-tombstones/

Perhaps you (or someone else) can take the lead, there.
