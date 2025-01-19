Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390D1DED6B
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737309492; cv=none; b=VUG36JHtUZBJXZq27GUO3D4jsA0wmLnymk9lFJ1KSEZm1GFmHb+bX8XN72C0g5vDMq8OJW8Jvip58LQuYvZCaND7R99UskiU/718jdfLiT/5CVvXTc7jP0KYS23iXlGodQQdHb0ppL430cEBVcHn1CpdCWqe/1Y+xsU/dD7rTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737309492; c=relaxed/simple;
	bh=kCwYAyMX4voDvuqLHTAT+HN07a8dUf0d+1gmadYDn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k76No8JrRG8kmSM01+O3txNMhljjDWnrcmCpdTOhDBej1siYH839svVmVmu9eKY9w0P4sUQAxw0Kct5D9rWw4AtYcru1Qj4i5Nf0zB+yqOied/3PotD3kWMGPU8UDU4T+1h3Sn0IokdkWBgCd/YM4Yg79KbE1JyaSBIK7Cvulvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=cy/OJJSh; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="cy/OJJSh"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:ebc1:636e:a4c7:c1a2])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id DE6FC19F73C;
	Sun, 19 Jan 2025 18:57:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1737309481;
	bh=kCwYAyMX4voDvuqLHTAT+HN07a8dUf0d+1gmadYDn2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cy/OJJShKysPNMhUgFGEcM8PRg0zSk2BVdFKBe6c8ZO8h7i9W5kp8HM4qc50hIJke
	 QipEHj5XkPGyzXk4EBGnoJ0iW12M1IKpo9v7lstBzph5QAq3QFzw+BN9o5GvDGZ0UN
	 RPXpC8qvI7KekWoPxgS6BOo4lVuj3QXFKp9n5BEmsxG/VIs7c2uqpcmASPiv7mFMAa
	 6bQSiaMAdM+yOgO5+AqYCcgw2NFf6AvVOAGZkzIv/1QIShkMnm9pCDDsl6OfS0LbE0
	 SNE1WNcPiZs60xF6y6Qd6MTDYBqbGFFAQt09fIhCsgWKJM+aA1AVlMYLiPFx3EVX0y
	 Ck1nzc9UR3SVQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik.188@gmail.com,
 Derrick Stolee <stolee@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/5] backfill: add --batch-size=<n> option
Date: Sun, 19 Jan 2025 18:57:46 +0100
Message-ID: <2972493.e9J7NaK4W3@cayenne>
In-Reply-To:
 <3cfd23073a036ea426569769b3e31290076257a6.1733515638.git.gitgitgadget@gmail.com>
References:
 <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <3cfd23073a036ea426569769b3e31290076257a6.1733515638.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 6 December 2024 21:07:16 UTC+1 Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 

> @@ -38,6 +38,14 @@ delta compression in the packfile sent by the server.
>  By default, `git backfill` downloads all blobs reachable from the `HEAD`
>  commit. This set can be restricted or expanded using various options.
>  
> +OPTIONS
> +-------
> +
> +--batch-size=<n>::

Please format automatically using backticks:  `--batch-size=<n>`::

> +	Specify a minimum size for a batch of missing objects to request
> +	from the server. This size may be exceeded by the last set of
> +	blobs seen at a given path. Default batch size is 16,000.
> +
>  SEE ALSO
>  --------
>  linkgit:git-clone[1].




