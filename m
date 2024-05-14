Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40ED180A6C
	for <git@vger.kernel.org>; Tue, 14 May 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717032; cv=none; b=TBnQsdD5LOEqtl5pGswpeHT3yDT21QTDKj14gkloWZEd1hch0B5e8lH26JdoSKyA1qIO+zQQLV4r4rbA6Ie9sojz+88udaHTtqTNotzE4r3Ra9bzU4ZQR1baMm1npVowluPet6g2gjDmzk2tcBP+vsPwHCeNa0T9AVlc+ios+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717032; c=relaxed/simple;
	bh=REOBF6coSaHywYdJEZNTPKWvGHYR4LzWoihXJP8gHjU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODbAwznUq3hxkFnwBYJomgMqhbmg1Aat0VX/yBwC5X0crTS1f5yJdBRDAnwuzRZxJhv6m2qWHs3BNfpzcoVNVZv/OK6okgI4Hba1lrxxeE+PiCYVdxD008sqbkSg7+uZkFN7WiIKv3la0SbQO2w5w8bWM0Kjbs/HqdtqdjgDn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDgVFk91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDgVFk91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419DAC2BD10;
	Tue, 14 May 2024 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715717031;
	bh=REOBF6coSaHywYdJEZNTPKWvGHYR4LzWoihXJP8gHjU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=vDgVFk91E+jhWuugzjHZEouoEkDDk45uI5eKlhNQPyElqUDtPONfUAur3lEmAtTgN
	 vsKH+MI/mdT1jezDc7lh7he8Oz1IfcYKBEFkR3XCUVsbnse6wYr844sWl2/YMy96mi
	 GBO69F5JkKwINyFjAlQhZP1dTOgKWeNWNZ7oH7A4=
Date: Tue, 14 May 2024 16:03:50 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Dimitri Sabadie <hadronized@strongly-typed-thoughts.net>, git@vger.kernel.org
Subject: Re: Author signature
Message-ID: <20240514-lively-potoo-of-sorcery-0028de@lemur>
References: <D19KZ1CBA7JF.27PYPL5X68543@strongly-typed-thoughts.net>
 <ZkPA2Pmz2EB6SOzL@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkPA2Pmz2EB6SOzL@tapette.crustytoothpaste.net>

On Tue, May 14, 2024 at 07:51:52PM GMT, brian m. carlson wrote:
> > So… I was wondering: since we can only sign commits, is there any
> > way / work in progress to attach the author signature to a commit? To
> > me, it would make sense to have something hierarchical: the comitter
> > simply signs above what the author signed, and the author doesn’t sign
> > the whole commit (I guess?), since we want to be able to change the
> > commit hash.
> 
> This is a great question.  I have seen previous requests for author and
> committer signatures, or in general, multiple signatures (such as with
> co-authors).  Git has only one signature field (well, two if you could
> the one for the SHA-1 encoding and the SHA-256 encoding), but OpenPGP
> does allow multiple signatures to be embedded in one ASCII-armored 
> blob.

It's worth noting the gittuf work that was recently profiled on LWN [1].  
It does already integrate the concept of multiple signatures via in-toto 
attestations [2].

I feel like it's a better approach than overloading the currently 
implemented signature support.

-K

[1]: https://lwn.net/Articles/973217/
[2]: https://github.com/gittuf/gittuf/blob/main/docs/design-document.md#attestations
