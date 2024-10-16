Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB42144AE
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107351; cv=none; b=jR06j5KSg3qSQ4MCrzlAc/LhYkqHNjSUKwnXOcuZoi0pwSQhpD9J3VdJ6zr5gy/JwVRHBuz+42BRfaZWXERnIShv1n+Vdj9y9iOLaNPfq8Xv+kHWBUKJguzg6yUYN4f/rhzcpS2Kc83X9ciS9PUxe8WTYtgrAY5zaBSkcM/mopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107351; c=relaxed/simple;
	bh=66CbuKn7zLYFbCxNpmqhVB/BqJvpU3DS90OqQcX0TVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlaJi0D3dVhx/YxK6UeixoHqIr0gHU87b2dtRYmy1W3C5vMbZXY+ZDSemB2xmmVm5ZBmDA3/UuO7wFx56vttm5Rn0G2FXQSGlM0gsHG/nEWIJ32ePEukrdkSifsyiq8JajMXLCP0KsD+bd7k42sBB2twcBtArmCcLhIPrDIrd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=wpQGPeI6; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="wpQGPeI6"
Date: Wed, 16 Oct 2024 21:35:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729107347;
	bh=66CbuKn7zLYFbCxNpmqhVB/BqJvpU3DS90OqQcX0TVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=wpQGPeI6XGitumwo92vLV5+vi/Vnzh5nCu7uL7Huw89ier+Kqu6VGTBrwxal/MCc7
	 mZ28ezq2ShA0tmD6EwRjjzWYQFRknPkw8yfbTKAwpWznZcnZsJgiW6aFNA99gaKyWH
	 6IZf0SUYjrg4T34VN+dxaa4Z+c7Ir3CgfwrHQIsOmVYoRqnweh4hH0dvFfLBxJ8l6w
	 4rl+ds3YKq1GBIwzlVJ/Ske0oZlDw85A8Ood+ez0sGXRzDUbaV6QIerMLkJOtZa+O8
	 bPSUqANTcHlDB4vJjpbf495jnbHk2QHABxSi4HE6fZV+A4dWXR67jVNH30Z41PBlzo
	 8KjIvIuWWNoIA==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] shortlog: Test reading a log from a SHA256 repo
 in a non-git directory
Message-ID: <jpbyxh7o3kip6mef7ie545futmfer2o4qjryvq7yta7qvsqj6f@4zsqyn7t7hnf>
Mail-Followup-To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-3-wolf@oriole.systems>
 <ZxATKIRGv4QCM9Td@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxATKIRGv4QCM9Td@nand.local>

On 2024-10-16 15:25, Taylor Blau wrote:
> Same note here about ordering Signed-off-by: and Thanks-to: lines as in
> the previous patch.

Shall keep in mind, thanks!

> > @@ -147,6 +147,14 @@ fuzz()
> >  	echo | nongit git shortlog --author=author
> >  '
> >
> > +test_expect_success 'shortlog from non-git directory reads log from SHA256 repository' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init --object-format=sha256 repo &&
> 
> I wondered why we needed a separate repo for this test, but I understand
> now that we need to have a SHA-256 repository to test this on.
> 
> I'm still dubious as to the value of this test overall, but I think it
> may be nice to s/repo/sha256-repo/ or something here to indicate its
> purpose more clearly in the test itself.
> 
> I don't feel strongly about it, though.

I personally lean towards skipping out on this test, but I can also see
value in it coming from a point of view of future changes to
git-shortlog(1) behaviour. Then again, perhaps it would be better then
to add a relevant test only if new behaviour is added. No strong
feelings here either, I'd defer to what regular maintainers and
developers here prefer :-)

-- 
Wolf
