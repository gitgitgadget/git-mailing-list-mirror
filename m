Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A622EED
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829900; cv=none; b=iteqfS6RqsRJodwslmfABS8bAenXTcNVWsLkU38wioTrzLnwq/iukWVX0Y7ZsAoJ9Ipbuu/gPKj9plnbXkpq5g5weYct8jW56sD6tdjE7Vi3VnFsVCMjV2EeQ9id0vWav5ykwU+lv9JiIJ/Oi8xESwVTCmXIm/IPPVuYE9xypss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829900; c=relaxed/simple;
	bh=zlLQ785IB3xtBNPLDXrbxaJ8YJH9Uzr1GBW5qMNGcYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tveb0Qmf3SYyx+UVFeXFIwKSGrWnWhcyCmRceHzKJJhMRS07uFE7a+NYbaP3KUIHOjngpuHHhXG3AUlM3bWSlpGYHALwKvFPbhiYQVaXPklm7qYCxGfCrC10LuMxa7r5MySNNgx72773KjIEr8PCdGK4/9TOzbzuh4umeh59IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11260 invoked by uid 109); 19 Jun 2024 20:44:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 20:44:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25072 invoked by uid 111); 19 Jun 2024 20:44:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 16:44:50 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 16:44:50 -0400
From: Jeff King <peff@peff.net>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org
Subject: Re: Ownership handling of the "remote name" buffer given to
 `remote_get` is inconsistent
Message-ID: <20240619204450.GA1527089@coredump.intra.peff.net>
References: <20240619195311.yhmbv5ruixa433rn@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619195311.yhmbv5ruixa433rn@glandium.org>

On Thu, Jun 20, 2024 at 04:53:11AM +0900, Mike Hommey wrote:

> When you call `remote_get(name)`, you may end up giving ownership of
> `name` to the remote, such that if you `free(name)`, using the remote
> after that may lead to use-after-free. Of course, this is a
> use-libgit-as-a-library situation; I don't think it happens in actual
> git code.

Try this recent series:

  https://lore.kernel.org/git/20240614102439.GA222287@coredump.intra.peff.net/

especially patches 2 and 3. Junio has it queued as jk/remote-wo-url.
Also, you might want to check the later patches to make sure the
cleanups don't cause any problems for your use case.

-Peff
