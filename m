Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461E165EE6
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105313; cv=none; b=jHzR6kaPV0T0R+t+6ZGUpGHqpVn4/wiQDRbQPYkHxyojhEH8R/c208QjWzJpLdqHmu1rSG5abUEEwM77LkUU57mVvsNIsZWIf5tt8PK3tX1qa1FlXiDY4C2ugkDt03KYdqCRY5qgCOKs8ImKi0Fo6W4h3cFHLT5Jz/SRr8NJMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105313; c=relaxed/simple;
	bh=AJuYpKYApiTBb8XzfZNxmNmLTzujt/yS+ks9B1MIBPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULB3B5Z3vFb1+1GdETvOQi09BW1s6KNEe6PdX/3DKyWzQ6EDwm8Ke0PtmFwAh86P8sLRsOPLFigdkL5bJd3seaXWrodIwBgNUNxJ3uGrja8vqlgUxznaBuxEdV0Q6zUs+YthwvILxKY9hJURDroQ9PBGxygJCcYfA2KGAx9y1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=u9QE42Sp; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="u9QE42Sp"
Date: Wed, 16 Oct 2024 21:01:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729105310;
	bh=AJuYpKYApiTBb8XzfZNxmNmLTzujt/yS+ks9B1MIBPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=u9QE42Sp/cre/abTMf5cekzNpIz//O5vLittd32mXEXVC913Zi8r6adL0GAzGCcky
	 nlqILGBpQBxn2sI4VFQYYzzexz6EID7GlzKAzNnyO85Eu11nfsrpbfEC7xYXJBCB5D
	 aWkjnJaVmFKf4cqJ5Z7ga/tcdkE/rKWDFtgY0m3fEnHBFFn1sEElo6To7TGdv+QOxp
	 2ijG9ztJQvbvfl+lKFFmD/8QODBVT/Px0+1aRwW+5PA5IPumMQ1J3bfdJUMZc5JAQA
	 U3DCWY+nIhfG/5aUCPAs+1lzKI5mCavrSMQMmHHEJ0yQn7EPVdkFiMYgyqNKYIKRIh
	 TB96dQRJGicAQ==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <wmx7z4qhvldtshatda73uzlcceyrmqjqnqmy5scivjfdzmfriq@x73trwmxjcdi>
Mail-Followup-To: Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
 <Zw9_46fbvbGhjmYw@pks.im>
 <yxfpbmwy5bhtjwmffzrfoagugs4rsxw7wn2cvve5ygzcnlolpu@lhjgpz4riogd>
 <ZxALiDHkkq4yIP8R@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxALiDHkkq4yIP8R@nand.local>

On 2024-10-16 14:52, Taylor Blau wrote:
> As a nice piece of #leftoverbits, it would be appreciated to have a
> patch that amends git-shortlog(1) to indicate that '--format' is
> ignored when reading input from stdin.

Think I shall give that a look in the coming days, then, this is
something I'd like to see fixed as well. Immediately what comes to my
mind is that not only --format is ignored (--author is too if I'm not
mistaken), so I'll see whether there's a nice way to indicate which
specific options are valid when git-shortlog(1) reads from stdin.

-- 
Wolf
