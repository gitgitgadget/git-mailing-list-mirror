Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050E3D16F0
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393273; cv=none; b=bWZjFIa8jzJ0HcL9mQ9XEi6djHWoR/jGf5StKXfBOfRPb0oQ/sK23mViWAz4YtCuy87RNpbXycoyv9GV3QBSSNBZJOaedYU1dqEJn7i8s9uueysM0sF6T3Pwp4SgdbCdhyTgLt5cxSjGNIgU6r0eYfSlyQkDGcbbwNwXMkoelnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393273; c=relaxed/simple;
	bh=YeOgkMEm69K7V5KIxPm2cUVbbooWkNWuXUV7v8ZodBk=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=dn6Ty0L/TPsOozRSVLuTUdRBCcIODHusgI0ti3+pon8LB2kPsFNsuhubk05Eud9+5NVy62dOgL7oKykG3kLBR6w/A7bGrZ2yxQ3XiGw6VyUC3E3v8mrjP+hPD501+3y7pSMUfPbVJgzM4McsiNsJC7dQ7zooViSdy7Ck4zN6V5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=dK0ZoZIM; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="dK0ZoZIM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=j.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=p8Jg4T+PoOrUpZ71N5Cs9+uJbsFKVO+MGBetFw7hZYw=; b=dK0ZoZIMqdJ7
	RTdFVz8JgGi1g0M4hM8s7kvwrLN8mDJs3Q6ENtYT8UYZ4zQU8bEe1BxNef9KIIZCOCfVHhq1GqypK
	nGVTFNTebeyg4lgMwjCtO9gQzQpOOScS6HQDNkHWWTesczdLoJo4fVzLL+S2fLrjoq1DOpOMsVv4V
	jdhzn+pHj9uNMhjignsK+mWqOd+cksfdgngS2PNcGfDk79PupmxRn3wCvIU8NX74z/6K5QtGSMNWh
	nMDyeOEcJMtL/XwERXMLnlV4E9esH/VJrOZS5wyM51n0CXcrjIPjbkHb/luB1fFVOsBUACduJJqR3
	3CVMfYgnghpAYvGLlBJT6w==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wUL4h-0005t7-3h; Tue, 02 Jun 2026 10:06:15 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27166.40199.68450.953526@chiark.greenend.org.uk>
Date: Tue, 2 Jun 2026 10:06:15 +0100
To: Junio C Hamano <gitster@pobox.com>
Cc: Colin Stagner <ask+git@howdoi.land>,
    git@vger.kernel.org,
    Christian Heusel <christian@heusel.eu>,
    george@mail.dietrich.pub,
    Christian Hesse <list@eworm.de>,
    Phillip Wood  <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <xmqqv7c13o5l.fsf@gitster.g>
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
	<a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
	<xmqqv7c13o5l.fsf@gitster.g>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/3a/3a90fe06810c445bcd1187f286aaae43.pem

Junio C Hamano writes ("Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split"):
> So after this message the thread went dark (except for a side
> discussion about rewriting subtree in Rust, which I do think it is a
> good direction to go in the longer term).

I'm indeed still working on this.  Given other things on my plate it
will be months rather than weeks before I have anything anyone one
might want to use.

> While I do agree that avoiding bash-isms in the main part of Git and
> sticking to vanilla POSIX has merit, this particular one seems more
> like an artificial limit imposed by dash than sticking to the POSIX
> as the common denoninator, at least to me.

I would be in favour of switching to bash, making bash a dependency
for this script.  We could use the env trick to support platforms that
don't have it in /bin.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
