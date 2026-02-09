Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D1125A0
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645635; cv=none; b=tkL70Q6slu+cUACssy/woyuflPS1sczXjZoqIBSf8E56r5hcSQ4Y4p8xuM29P5sS/nSlFSbH2rKRsFs9cOWpH5GA41uaViBnIihy7YZhRnlzjBWAoNHdHgUgZdmq7qev4ta/C/LWk8ZIdNl4/C/VsP85n5sgga8w1JabxX6K9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645635; c=relaxed/simple;
	bh=fq0Dw/6c10eQuXpBOzUpKRcjS03hT6dd7lZWgCLnBOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnVidaPINiXDB/rH0cu0VkHFxlTozRN8BMXKgC7nNJ07bBqkr9ZoxN6swawqC3Jak56jssRKO3Vtt5K+Hz25jJbZVbd+4YjKlUDyiPNx3RtnJzDnul60Q632AKU/j2uaYpHe9Fu7C1+/elMXoLxF14Zgx9UaHCALW5MQLAoK1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ljWYO0wZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ljWYO0wZ"
Received: from macsyma.thunk.org (pool-173-48-115-57.bstnma.fios.verizon.net [173.48.115.57])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 619E0HAh031831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Feb 2026 09:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770645619; bh=XjZ4kJxwzaNkrzPgqAxeO3+gSh942XwTqI81TOjs4gA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ljWYO0wZPX+GT48Aiui5lNQHRLlQuxD2MmSV+BjhHS19lNLWZjogOvBfKIWf8a6lc
	 vMMKQ/+harZrMa9IU6mbOMRvNuy8IERv36Sz/KM4H8hTgvHp3A8zS/bzMKGUmI5fgi
	 GKCltwUOFj0seD4sxoe3uOVa/NRLLh/aJPTJkVQd10mjB+Au8HixzYOo/ndAcNptyt
	 ZQv2F8sVMABOsGgJt2p221KLOiZh6oVAYcqDCmxzrr4/ZJBZt363KRIX6Zp7fFkrau
	 GcObLA2wIcj2o9Gk2D7AAlSxE9VwhCoRmLo9OBAPr6zHPWs+865Qusj5CdwXnJxIDf
	 HGQaZ3lLTUTgw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 8FADD57CEAB3; Mon,  9 Feb 2026 08:59:17 -0500 (EST)
Date: Mon, 9 Feb 2026 08:59:17 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Jeff King <peff@peff.net>
Cc: Jonatan Holmgren <jonatan@jontes.page>, git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
Message-ID: <20260209135917.GD27241@macsyma.lan>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260209073602.GC585828@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209073602.GC585828@coredump.intra.peff.net>

I would just note that Unicode normalization can be *tricky*.  The
fact that ext4 case folding would do Unicode normaliation was
sufficient to trigger a CVE that resulted a security vulnerability in
git. Of course, who would be insane enough to use git on a case
folded file system (aside from someone running git instead Termux on
an Android device, that is....)?

So I'd suggest that git folks think very carefully before trying to
dive into the insanity which is Unicode.  It might be a very strong
nice-to-have for certain user communities, but it's also a mess.

	     	 	      		   - Ted
