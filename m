Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A981EEFC
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377619; cv=none; b=KewzIuxpU9iVJd6WHaVYULHhVnhw9Rtszbu9jA2zhE7A39arEbvQdAw9/kudKhpVLzlxYV4pYPAnSm3k+23xfCrv58v2S+eloVgBtCLlCrGjKYlZIDXcH9VwZn73Cooy+hmudfMgq2FA3JZZXRtbkekWOysxn4ClcRfpd61iF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377619; c=relaxed/simple;
	bh=2Kg+MvNeOHPRVdZa2DxEsJwsZD58D+giZQoETGB6BVs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cQak66ywpiOJt/VYdQuZOe6rM8VA22PSKLn/bO9gYj5L8lrHNbGbDCnqp8SiR94fcvTU3aQXh3mRVIMzWg6gpIdFJAQ6fZKWWBH0cabUqXdWlUg/R9bM9CFq7H/ffcrxJNybNnLiK7sHqrFu1rq2DW8MXr0taFWT+nmL7hv/E/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41JLJtEQ825854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 21:19:56 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Dominik von Haller'" <vonhaller@fastec.de>
Cc: <git@vger.kernel.org>
References: <FR2P281MB1686B7258CFB60A0F33FE108BA522@FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM> <ZdO1oL73SF5ZKOJT@tapette.crustytoothpaste.net>
In-Reply-To: <ZdO1oL73SF5ZKOJT@tapette.crustytoothpaste.net>
Subject: RE: Why does the includeif woks how it does?
Date: Mon, 19 Feb 2024 16:19:51 -0500
Organization: Nexbridge Inc.
Message-ID: <01d401da6379$635fdb30$2a1f9190$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQHfIIxpl5bCl8/iQtr5z/nA9ym1QwBqsLonsQVbvqA=

On Monday, February 19, 2024 3:10 PM, brian m. carlson wrote:
>On 2024-02-18 at 15:37:29, Dominik von Haller wrote:
>> I have been playing around with the includeif from the .gitconfig. It =
did not work
>for me at first, but after some help, I did get it to work.
>>
>> If you are curious. My Problem and what else was discussed here:
>> https://github.com/git-for-windows/git/issues/4823
>>
>> Anyway. So, I was trying to access the email property which was set =
through an
>includeif config. It did not work because I was in a non git directory. =
Yes, I do know
>that the property set in includeif is named gitdir, but it was not =
obvious to me that
>you need to be in a git tracked directory for it to work.
>>
>> I am trying to understand why it must be this way. Why does it not =
work in non git
>tracked directories?
>
>The main reason it works this way is because the goal is to adjust =
configuration
>based on the location of a repository.  Thus, if I have =
`~/checkouts/work/` with my
>work code and `~/checkouts/personal/` with my personal code, I can set =
options
>that are appropriate in each case (e.g., `user.email`, =
`user.signingkey`,
>`credential.helper`, etc.).
>
>Also, except for reading and writing with `git config`, the =
configuration is typically
>not used unless you're in a repository.
>There are only a handful of Git commands that don't use a repository at =
all, so
>usually setting configuration outside of a repository isn't very =
useful.
>
>Note that if it didn't require a repository, then it would have to work =
on the current
>working directory.  But, it should be noted, the gitdir option =
specifically does not
>operate on the current working directory.
>While it is customary to have one's working directory be inside the =
repository, you
>can be elsewhere and use `git -C` to change into the repository =
(internally, Git does
>indeed change the working directory, but that's an implementation =
detail).
>
>That's not to say a feature couldn't be added that operated based on =
the current
>working directory (or some related constraint) instead, but no such =
feature has
>been added.

I have considered contributing an "includewhere" option that would do =
that and differentiate from "includeif". I'm not sure it is required, =
and what would happen with symbolic links.

Just a thought.
--Randall

