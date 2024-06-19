Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C878C76
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832300; cv=none; b=MEoJy1gw1frx1e6X2K2BmO1yfTiU0VcsEbGuSJU9KFFm9ESBsmolTMOHum28i2e4bFF2E1mqEJSeo2Zx4BjM9v78M1uMExwpKMixTFOEUpl5WFslHnZQwO/YZmmrfE0KQl73SWzx1u0tUiooFCBXmhJHcVcGRRMi0oJxCiDLcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832300; c=relaxed/simple;
	bh=7oy6E1dc6FWJ6BAoQjTM6++W837w1/mTaKtrc6k0kKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByAphVGpTwRsjwx5ijqu3804sWEPHyOqPTAClg1g942VCawdNnI6gUOa9XwaZf+SpF+kdAZ0NYZnv8y0b0xns8sq58NPR9irWF2uvUKc3TPvPyux3yaZu9yXmjxsG7Q5q3RcLliFm7VnYVmNMLKBUYp8DPVknyoPKzpJSLsJAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sK2nV-00CZ0N-2R;
	Wed, 19 Jun 2024 21:24:54 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sK2nQ-004Gwg-28;
	Thu, 20 Jun 2024 06:24:48 +0900
Date: Thu, 20 Jun 2024 06:24:48 +0900
From: Mike Hommey <mh@glandium.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Ownership handling of the "remote name" buffer given to
 `remote_get` is inconsistent
Message-ID: <20240619212448.c66nvf6ca745yvux@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20240619195311.yhmbv5ruixa433rn@glandium.org>
 <20240619204450.GA1527089@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619204450.GA1527089@coredump.intra.peff.net>

On Wed, Jun 19, 2024 at 04:44:50PM -0400, Jeff King wrote:
> On Thu, Jun 20, 2024 at 04:53:11AM +0900, Mike Hommey wrote:
> 
> > When you call `remote_get(name)`, you may end up giving ownership of
> > `name` to the remote, such that if you `free(name)`, using the remote
> > after that may lead to use-after-free. Of course, this is a
> > use-libgit-as-a-library situation; I don't think it happens in actual
> > git code.
> 
> Try this recent series:
> 
>   https://lore.kernel.org/git/20240614102439.GA222287@coredump.intra.peff.net/
> 
> especially patches 2 and 3. Junio has it queued as jk/remote-wo-url.
> Also, you might want to check the later patches to make sure the
> cleanups don't cause any problems for your use case.

What timing! It looks like both these two patches address my issue
without breaking anything for me.

Thanks

Mike
