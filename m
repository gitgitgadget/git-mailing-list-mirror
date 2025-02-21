Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1512FF69
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151073; cv=none; b=bZQziQXa2ECcB3xZdJwxc171sMOqdzZHJ/f8zUshJw+rASjRrZh54Guznr7oDUY6WJwhPzFZsOIm/Wb1yOm71A97ZUPzVCdfOypcB+c//Q+pZSMCaL6V4ue3TVhCOu641MKxWY1pioqEnc5X24Cei8ReF8LleKOdpo60ePt8IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151073; c=relaxed/simple;
	bh=Rq2bbo1jsXDEyabgvqj4xHK/IYV/goPu1DrsZl03y9E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNKvojdWhfTqvs9B9ZVaLL34PLc3Tp6AWKs+Tz4EYPBthgtOuyhWV/YdjsK4tsdhlnSbdmyPxJmrbD3nOSFLXbdwC/wvWeRFAHgemMuFF8oWJqhliFa3X4neL+xQ0t6feerKYbN8meMVbwnUxJmXInhh0/cyrSq3foqOiQH5Z98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0wEFa5D8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0wEFa5D8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07574C4CED6;
	Fri, 21 Feb 2025 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740151072;
	bh=Rq2bbo1jsXDEyabgvqj4xHK/IYV/goPu1DrsZl03y9E=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=0wEFa5D8Ter4eRVZstBtppOk1LrK4lEUuyjtRega650cJ92T+VnKPBvRiLRnKIr47
	 8Zz6IJtIyVXV5spXu4ubTuh92DtZs4YI7geGFuxr1xXaU5lFBzzuDTT+ZK/3O0yq80
	 LLrlaE7cmlIVGyMbsiMVdA1S9pTKtuVMMhzfJ+zs=
Date: Fri, 21 Feb 2025 10:17:49 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Jamenson Espindula <jafesp@gmail.com>, git@vger.kernel.org
Subject: Re: Deleting first commits; maintaining last commits
Message-ID: <20250221-intrepid-furry-wapiti-eebff0@lemur>
References: <CAOW_YOkX8K=7i7w9c5oH5Cfia0kCzwC3=ok5E=eUwYgpcOKTRQ@mail.gmail.com>
 <Z7fGQalzCg_Fx-ub@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7fGQalzCg_Fx-ub@tapette.crustytoothpaste.net>

On Fri, Feb 21, 2025 at 12:18:09AM +0000, brian m. carlson wrote:
> > My Git repository on GitHub <https://github.com/espindula/br-blfs> has
> > about 23,500 commits. However, there are several old (before Feb, 28
> > 2022) commits I would like to delete and maintain the newer ones
> > (after Feb, 28 2022). So, Is there any Git command (or combined
> > commands) I could use?
> 
> No, Git doesn't offer such a thing.  Due to the use of cryptographic
> hashes used, it would be impossible to verify the integrity of the
> repository if it could just be truncated like that.  In addition, the
> goal of Git as a version control system is to track history, not to
> destroy it.
> 
> However, if the concern is size and not something else (like removing
> personal information), then you could use a shallow clone to just
> download a certain number of revisions and work on that.  The full
> history would remain on the server, and you could still push newer
> changes, but the size on your local machine would be smaller.  If you
> need more history, you could use a partial clone instead if you're
> willing to be online to work.

Another approach is to create a new repository and use a graft/replacement
commit to indicate that history continues in a different repository, right? I
do sometimes wish this was a bit easier/more accessible to perform, because
that would allow creating "epochs" for very large repos. Unfortunately,
shallow clones tend to be very heavy on the server-side.

-K
