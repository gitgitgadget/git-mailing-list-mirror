Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0584FAC
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027196; cv=none; b=LRImFHx2268gY97QTTHtOcL7e05gCPzyn8WaIaEmzMCWgvyDSvrjvqjgyGpYnnqqmG6kwxCIXJWWd9WzrCpPHlCI6EkhroYjXzNAhqVWgyL1imJa4sJ+3vRPr+HsDDs/uI00M7nfdI5onIk75FGstd8/PloSQE4gZYqggi0H+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027196; c=relaxed/simple;
	bh=TPbWQZ+t5aZeAbahbbcIqgd4gubdguF866HqEEHrRlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpnJUfTWIIATwgxqPx4TEiAghILp2xIe6GW+TMp7+dnuohU7JEsjxCbbeBeTNYNTbyvatmOcrrx7Gns8iFbr75lr2lLtU0ShFQn6v3D8cSkI5mlFbSp6nme+cHLWploWRoP5iXhmhTREsSwYgi/i4Ft7MlyZ3wf1LaYPQsgrX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=rmnE9Oty; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="rmnE9Oty"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:a24:f690:de50:c41e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 9815D60338;
	Thu, 21 Mar 2024 14:19:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711027191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8hEHQLkUtWeDvZpNy4aNOL2CbpGIBSW+GQONVALAIY=;
	b=rmnE9OtyFBbrlgLjNJZNoh1gshV0CpKs5xFsqimiDAAHPdiFVxijA7vwyzeXOcmEh7PPzY
	LaG5pDWCpuomz8PipHqyYO3gHabMG5KXVQu0oIB+1cYArNrp2E1ae6MT6MYZsJqJCHyi8c
	dfKpd2KG9BaAysgTidWOxAyjF2cK69Af4LOqamVbz2/RFT6M8pCJAC6Z7jNLlPfP9Eir80
	SZIlQgbxVKh/++1hbtvpwbcjzTYVFCou48PMSgr5tZTawD7YZp+uOMKbKV8Ii9aV7YPRFf
	arVwgd3O/KSy+zfeergyg50uGDl98DPoXQNc5rHXYzB4Vt6J/v7T66MwFLb+AQ==
Date: Thu, 21 Mar 2024 14:19:51 +0100
From: Max Gautier <mg@max.gautier.name>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/5] maintenance: use packaged systemd units
Message-ID: <Zfwz9zs3odKcU9Dm@framework>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-4-mg@max.gautier.name>
 <ZfwqFU_b3MqLCZNR@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfwqFU_b3MqLCZNR@tanuki>

On Thu, Mar 21, 2024 at 01:37:41PM +0100, Patrick Steinhardt wrote:
> On Mon, Mar 18, 2024 at 04:31:17PM +0100, Max Gautier wrote:
> > - Remove the code writing the units
> > - Simplify calling systemctl
> >   - systemctl does not error out when disabling units which aren't
> >     enabled, nor when enabling already enabled units
> >   - call systemctl only once, with all the units.
> > - Add clean-up code for leftover units in $XDG_CONFIG_HOME created by
> >   previous versions of git, taking care of preserving actual user
> >   override (by checking the start of the file).
> 
> We very much try to avoid bulleted-list-style commit messages. Once you
> have a list of changes it very often indicates that there are multiple
> semi-related things going on in the same commit. At that point we prefer
> to split the commit up into multiple commits so that each of the bullet
> items can be explained separately.
> 
> Also, as mentioned before, commit messages should explain what the
> problem is and how that problem is solved. 
> 
> Patrick
> 

I need to think a bit about patch ordering here because changing from
the "random minute" implementation to the systemd
(RandomDelaySec/FixedRandomDelay) is required to the other changes of
putting the unit out of the code and in the package.

I think I have an idea how, I'll work on that, thanks.

-- 
Max Gautier
