Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67251B6D0E
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660895; cv=none; b=sf9528EGY96XheqmQDsF1f84/o8Lds3mjTLt5TTe/qpl193BAuaULWyhs0anXQ/bnCLcces1L/Jk2MVFaDyjBjYBr3ukQKv3HmXO2Izj65Vk6/1t86On20ZNdECtMpjzxaFuMj9eSJfLplLe2zjazefOT0AtvWeub+5eaHJf6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660895; c=relaxed/simple;
	bh=jR9ilHWq5BRKeJMcNPJVuzSOMl+Ui+C72o2cNtEx7DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9ySpreqSZIpT92lIV3vPEHNOD8raaN7pJnawPP7X9mAa1eS+jWd+prXExHCJ42eZN+SciOPluarptuX/Zz6nk2AuMRDDOyBXGTlSVCQ0Kf3zSOkPb3s+AwQrmCEHWZHvkLI6WCyaNcjCAWXTI3tnFSMs0IfNmyvTZHYcjTaus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KxRXAOjZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KxRXAOjZ"
Received: (qmail 28203 invoked by uid 109); 26 Nov 2024 22:41:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jR9ilHWq5BRKeJMcNPJVuzSOMl+Ui+C72o2cNtEx7DA=; b=KxRXAOjZr/YtLH8usX+LIKtCO0RsHerOuauHI3ASeC2m3UrFzRTJ+hXzT3uB7kDwFTWB7id6C5zcxdsoobyGzlT5XoyM5BRl/BNKVKIeAwT0XaNbtrlp+nenyjPLXMSicwyse6d77IqaSZL+jsa8ulLGErq2KulpVlV3XvZhkLaeLZVrDE/oIg8fU23Rgmvi3KpZXa3gxnEN/scJq1FbydsP/xYReQS+vixNUc5XnSX5VCTkIHJHtRxMpI6dsFCUsP1NTDIMfgJ/l4TnwNfkjvrZr0T9XCV/TmZZ8hoGIbqhauR6HL8Dh531liLaHjdJUHGg2wy6deG58W3ucuohEw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Nov 2024 22:41:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26573 invoked by uid 111); 26 Nov 2024 22:41:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Nov 2024 17:41:24 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 26 Nov 2024 17:41:24 -0500
From: Jeff King <peff@peff.net>
To: "Peter B." <pb@das-werkstatt.com>
Cc: git@vger.kernel.org
Subject: Re: git support for "xattrs" (extended filesystem attributes)?
Message-ID: <20241126224124.GB77402@coredump.intra.peff.net>
References: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>

On Tue, Nov 26, 2024 at 08:40:32PM +0100, Peter B. wrote:

> I'm evaluating and testing extended attributes (xattrs) for professional
> archival collection use.
> I couldn't find any proper documentation/information on how (well) git
> supports including xattrs in version control.

As Junio noted, Git does not store most metadata at all (and most other
version control systems are the same).

There are some third party tools to save the information in a separate
file within the history and restore it on checkout. I haven't used them
myself and some of them are quite old, so YMMV:

  - https://etckeeper.branchable.com/

  - https://github.com/przemoc/metastore

-Peff
