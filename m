Received: from 16.mo550.mail-out.ovh.net (16.mo550.mail-out.ovh.net [178.33.104.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4C944D
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.104.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102103; cv=none; b=WKHGI117d9eC25Y3m3VBUMEtEoMnhAGZ7rOr/DKQya3MwAEXhXTTXY78oYVdbOMyrL3owKlYDumnwgzEFC3cs+lsRGpFDqUHfWuotYaV8BrOeNKY2bROiTjROeAeIkEgRYQrafp8QBTcHdDm5w3r+jjUF6EZOx4ra1B77Rs+4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102103; c=relaxed/simple;
	bh=83vIO1Wb+8MGaibKgYlG3TDN8aJsN2MjtPNYa5yJqlA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Xj7kfe7LJskjmei8XKlYT9EaPjEE+xqFz/J/Eoz30IxelQ3stcAe8UP8WDonyejQEDyM/nMG1NeSOQoDhI1Jn0baRJ+T1XqNilK1HKb3nUt3tSyinaDjv/KNlcQ2JiOsmN5NsxQMGuZ/3hWiLF31cRIZiLsHrAZbq3ik4y+hBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org; spf=pass smtp.mailfrom=devyard.org; arc=none smtp.client-ip=178.33.104.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devyard.org
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.9.150])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id BEB8127DD2
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 03:01:29 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-gtnk7 (unknown [10.110.96.65])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2FF311FD7A;
	Mon,  5 Feb 2024 03:01:29 +0000 (UTC)
Received: from devyard.org ([37.59.142.95])
	by ghost-submission-6684bf9d7b-gtnk7 with ESMTPSA
	id rjT7CIlPwGUC2xsAJXMUHQ
	(envelope-from <ypsah@devyard.org>); Mon, 05 Feb 2024 03:01:29 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G0016868a606-0212-4c1c-9335-25cfd87689c7,
                    2E889AE26219FFD1BF1F9309EC37D53C5121073E) smtp.auth=ashpy@devyard.org
X-OVh-ClientIp:213.10.167.74
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 04:01:17 +0100
Message-Id: <CYWT6JWQCTFG.106OCJTV3NQDU@devyard.org>
From: "Quentin Bouget" <ypsah@devyard.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] http: prevent redirect from dropping credentials
 during reauth
X-Mailer: aerc 0.15.2
References: <20240204185427.39664-1-ypsah@devyard.org>
 <20240204185427.39664-3-ypsah@devyard.org>
 <ZcARb4YNCD4NLJku@tapette.crustytoothpaste.net>
In-Reply-To: <ZcARb4YNCD4NLJku@tapette.crustytoothpaste.net>
X-Ovh-Tracer-Id: 5731112004510594555
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpegggfgtfffkhffvvefuofhfjgesthhqredtredtjeenucfhrhhomhepfdfsuhgvnhhtihhnuceuohhughgvthdfuceohihpshgrhhesuggvvhihrghrugdrohhrgheqnecuggftrfgrthhtvghrnhepkeefvdevvdfhhfdtleehgfekgeekfeejfeelheduueeftdevtdduvdektefgvefhnecuffhomhgrihhnpegtuhhrlhdrshgvpdhgihhtlhgrsgdrtghomhenucfkphepuddvjedrtddrtddruddpvddufedruddtrdduieejrdejgedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeohihpshgrhhesuggvvhihrghrugdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht

On Sun Feb 4, 2024 at 11:36 PM CET, brian m. carlson wrote:
> On 2024-02-04 at 18:54:27, Quentin Bouget wrote:
> > During a re-authentication (second attempt at authenticating with a
> > remote, e.g. after a failed GSSAPI attempt), git allows the remote to
> > provide credential overrides in the redirect URL and unconditionnaly
> > drops the current HTTP credentials in favors of those, even when there
> > aren't any.
> >=20
> > This commit makes it so HTTP credentials are only overridden when the
> > redirect URL actually contains credentials itself.
>
> I don't think your proposed change is safe.  Credentials are supposed to
> be tied to a certain site and may even be tied to a specific repository,
> and if there's a redirect, then we need to re-fetch credentials or we
> could leak credentials to the wrong site by reusing them.  Your change
> would therefore introduce a security vulnerability.

Good point, I had not considered the security implications.

I can see libcurl only reuses credentials after a redirect if the
hostname has not changed: [1]

	By default, libcurl only sends credentials and Authentication
	headers to the initial hostname as given in the original URL, to
	avoid leaking username + password to other sites.=20

Does it sound OK if I use the credentials provided by the redirect when
there are any (out of consistency with the current implementation), and
only allow reusing the current credentials when the redirect and the
original URLs share the same hostname?

If so, is there a helper to extract the hostname out of a URL in git?
I can see credential.c does this itself, otherwise, libcurl provides its
own helpers for this (curl_url(), curl_url_set(), curl_url_get()). [2]

> I should also point out that in general we are trying to make it less
> easy and less convenient for people to use credentials in the URL
> because that always necessitates insecure storage.  There have in fact
> been proposals to remove that functionality entirely.

Apologies, I feel like I may have given the impression I wanted to
configure credentials in git's configuration files, which is not the
case.

My use case is to `git push` a tag from a CI/CD pipeline to trigger a
release, similar to how I do it here. [3]

Or is this the kind of use case you are trying to discourage?

[1] https://curl.se/libcurl/c/CURLOPT_UNRESTRICTED_AUTH.html
[2] https://curl.se/libcurl/c/curl_url_get.html
[3] https://gitlab.com/ypsah/simple-git-versioning/-/blob/main/.gitlab-ci.y=
ml?ref_type=3Dheads#L110
