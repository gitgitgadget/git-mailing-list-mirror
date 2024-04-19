Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53EA2AEF5
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563541; cv=none; b=RHSU7DSb8KjDMBt9zw0JiWwoGSFZQ5i2UVEN9ci2RwIaKtOMWCeFbTyihzhuJy13SvK5f6v9QEGBKSrOk8RX5Vek1zMECGDPk570lcxeZdf+DKe7ZcIHnSRXN7hEPhy2DfhJCzkKAI/Sows1WyipubiBWIl5mtOHT2phitTcj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563541; c=relaxed/simple;
	bh=Nj8qfAproCROeDwyxxAjMZRAXxz/YgxTP2lH6prm/cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7PQryCfw9caVLXJxGAwzca9RCHay/OJDFnECVIklJasWTocpNCgbcnr/R3WXXm5UaudipJqfyccCdEVVLyQYprpCUfZTbaFQu/3k0en1IfWH9nF/pngglExKOo1EYGfYqPYymz2gyDOU3zbYJbZkIzNMkGiB5TT1MN98h9LEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=sfYe4avb; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="sfYe4avb"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5544C1F44D;
	Fri, 19 Apr 2024 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1713563204;
	bh=Nj8qfAproCROeDwyxxAjMZRAXxz/YgxTP2lH6prm/cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfYe4avbe9MW60hgF+q7crGthwP9weWL8I3TQCH+/ZpoZ/EysUTw3a3GHDTeTbQjp
	 BkDJb3KzvLzvgfHlqjNZVAkTx+48fMZynibJR4KT9UyME7IWfQe/UeT3tu7zfYUtJF
	 cmmKqL1AvXtyINNH2i6wtLD7HxnEC68odE8WYxCg=
Date: Fri, 19 Apr 2024 21:46:44 +0000
From: Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] switch to tombstone-free khashl table
Message-ID: <20240419214644.M168521@dcvr>
References: <20240325230704.262272-1-e@80x24.org>
 <xmqqy1a4ao3t.fsf@gitster.g>
 <xmqqy19959b2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy19959b2.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Eric Wong <e@80x24.org> writes:
> >
> >> The memory improvement is minor, but any memory reduction at all
> >> is welcome at this point.  Fortunately, this set of changes is
> >> unintrusive.
> >>
> >> I have some other ideas that I'll hopefully get to implement before
> >> swapping kills all my SSDs (see bottom).
> >
> > Please describe what this topic aims at to sell the topic better.
> > Are we trying to reduce memory footprint?  In other words, if this
> > topic were to hit a released version of Git, what would the short
> > paragraph description for the topic in the release notes look like?
> > ...
> 
> So, did anything happened since this exchange?  I remember that we
> caught and fixed a few minor sparse errors, but other than that, I
> am not sure what to do with this topic.

Not really...  I've been thinking we can beat khashl for our
purposes usage by allowing explicit tombstones to be configured
and getting rid of the ->used bitmap entirely.

One goal is to eventually reuse the code with the open-coded
hash table in object.c   That said, I've been bogged down by
personal crap this year and don't know how/if I'll be able to
hack on it this year.

> Not that I want to merge loud tree-wide topics down during the
> prerelease period...

No worries, we can keep it out for now and work on it
incrementally or drop it entirely in favor of something else
down the line...


git's about to turn 20, and I really want to ensure it and the
tools around it continue to be usable on computers from 20-25
years ago.
