Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65A192B9D
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434557; cv=none; b=GrMlU9IW+hFcRBRt1efiVavxtvnRW4gmCW7ng5hNNVO9Cgib3oqJfLjEik4IX9zH3vGYS/egCOo5xhrwUxRQ88eAghzrp6HZzwk7oXwO3Cxfqfp5wb7hlk30XCYqsTl40SEt++Jh1ncNqZaytpX+Qtz5ubb+oreBcROG99FARk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434557; c=relaxed/simple;
	bh=6rvlzYjTM37h5EmlgFM4pDFbPDZQQdUsKSCKHWx5PKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSkDhOzSDP9mmpziGN06IT1gLjYLAXh5MV5L1PgU/1dSZnObxrubAwlLtgugarUDNqYW0cGdxerAp5SjJR6mCsDwpJW4qed09MjFtDJ7JrtXrtWRDbL9kp3v7n8/ZL+utxgr/WLHDDLOB0psXClWLuD5ZneoTgqVql1BL8nIqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25588 invoked by uid 109); 26 Jun 2024 20:42:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:42:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25078 invoked by uid 111); 26 Jun 2024 20:42:33 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:42:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:42:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
Message-ID: <20240626204232.GD441931@coredump.intra.peff.net>
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
 <20240621154552.62038-2-randall.becker@nexbridge.ca>
 <xmqqmsnekvir.fsf@gitster.g>
 <016501dac409$7dd5bc00$79813400$@nexbridge.com>
 <xmqqwmmijf6f.fsf@gitster.g>
 <xmqqplsaje6z.fsf@gitster.g>
 <xmqqtthlimtr.fsf@gitster.g>
 <03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com>
 <xmqqmsn87n9x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsn87n9x.fsf@gitster.g>

On Tue, Jun 25, 2024 at 01:58:18PM -0700, Junio C Hamano wrote:

> <rsbecker@nexbridge.com> writes:
> 
> > My take on the separate patches and discussion about reporting run-time
> > values of libcurl, zlib, and OpenSSL, is that these are being added to
> > --build-options not --runtime-options (does not exist yet). I think that
> > grabbing run-time values could be confusing to users who expect the
> > --build-options even if comparing the two values.
> 
> Yup.  I thought that the consensus was to leave all those extra
> complexities like runtime versions for a later and separate topic
> done after the dust from this change settles.

My only qualm is that reading curl.h at all in a program that is not
going to link it feels a bit funny (it is declaring symbols that will
not be available at link time). And we could fix that immediately by
having "remote-https --build-options".

Adding a curl_version() check on top of that could come later, but of
course it would be easy to do.

But that may just be me being overly conservative. If nobody looks at
those symbols, I'm not sure what harm would come.

-Peff
