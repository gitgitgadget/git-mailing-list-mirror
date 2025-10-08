Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933274A06
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959315; cv=none; b=R8HuPs90Q1Xprf4f3+XHm1dVyNuXHD3w28dyB1ZleZ9diw98NpmuI+hS9/v7dkoOV1L5Exvm0naWrjIq04M+llUInN5rcHSp8JRQz+XVQ0gFZJ8OfbOwIb2DEY5ycyDBIgO9ZjmBJVaJfO/v0D+4dre9P7bROvD4gZSZdhtxqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959315; c=relaxed/simple;
	bh=M3kQmSL3qyci1xzvB4jZnCfjkgtVBZIiUm9jS17rixQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FdxWI6/I8wn0cvAN1f4Vs2fN8plnive8mt9oPcFt10ewpEjxJGoiuYWPP8kzJfgjfwkRsMNLlZnWQudNEfwfkzUB40FKw6e8KsNGUbSeMKuO6kNIAUiT7Gcyxl0n5STKIXGIRQkG9//bshRkLWeISk+JLvQ7EYbHRftlpQYkzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 598LZ2w51726205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 21:35:02 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>, "'Michael Lohmann'" <git@lohmann.sh>
Cc: <git@vger.kernel.org>
References: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh> <aObX4C7lMHRnjbYq@nand.local>
In-Reply-To: <aObX4C7lMHRnjbYq@nand.local>
Subject: RE: [RCF] Secure git against involuntary arb. code execution without feature loss
Date: Wed, 8 Oct 2025 17:34:56 -0400
Organization: Nexbridge Inc.
Message-ID: <020201dc389b$677305f0$365911d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIj34gKHE567upen6Y12BP4iUrWbwGN/9avtB0HG/A=
Content-Language: en-ca
X-Antivirus: Norton (VPS 251008-6, 10/8/2025), Outbound message
X-Antivirus-Status: Clean

On October 8, 2025 5:30 PM, Taylor Blau wrote:
>On Wed, Oct 08, 2025 at 11:02:03PM +0200, Michael Lohmann wrote:
>> * Proposed solution (keeping all existing features):
>> - On first use, git generates a secret "token" (e.g. a random string =
in
>>   ~/.gitsecret)
>> - On calling `git init` or `git clone`, the secret is copied into the
>>   new .git directory and serves as proof that this clone was created =
by
>>   this user
>
>Sure, but the problem is not with direct clones (at least, not using =
the --local
>optimization), but with clones that recursively clone other submodules.
>
>If I clone a repository with --recurse-submodules, I imagine that this =
proposal
>would *not* suggest copying this token into the recursively cloned =
submodules,
>right?
>proposal improves the experience
>
>> - Editors would no longer need to prompt the user for "Do you trust =
this
>>   repository?" in most cases, because git could prove the clone is =
user
>>   generated.
>
>If the above is true (that Git would not copy the token into =
recursively cloned
>submodules), then I admit to struggling a bit to see how this proposal =
would
>remove the need to consult the user in this case. Instead of the editor =
doing it, the
>user would need to do it themselves?

I am wondering why this approach cannot be made more general. If there =
is
a tokenization framework built into git that organizations can use for =
integration,
they should be able to plug-in their own approved tokenization =
solutions, which
have already been vetted by the security groups. I am concerned that we =
are
potentially opening up git to CVEs due to insufficiently secure tokens =
that are
outside our specific domain.

--Randall

