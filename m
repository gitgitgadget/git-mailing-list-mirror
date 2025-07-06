Received: from 7.mo560.mail-out.ovh.net (7.mo560.mail-out.ovh.net [188.165.48.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1995192B96
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.48.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822688; cv=none; b=U09/JPfsIUjoz7ZOvxjcbNyVXxEb/AXh1Xz7e9dZIz5gSjPBMEKvCm7pj31biXwaP1CbAq0i46R1l/ghPUubqEuoUY+ePJkyoPjrv3/KI84tElMIzoMFKn6LNfW3/hnom8FD++/1y4jgh2YWX6jOVoOPOwobnqFfFLA56e8tHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822688; c=relaxed/simple;
	bh=tRsFuTFo4D3JqDm5nfzwyozS91hCSRRFgmObdeQ3m3c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F0sbr6RJBcRw08X0PTtBork41jKQbkILMAbggUJ09YCs0ftvWafC+4uWywMOuLcBSJS7MeCZ27uf0IIPp4qWx0s7T6N/BGNJ+Zl57IMMTloRe0xEdAaGbGjf9nmFT1TyW0qdOlpOW/docMcPnVamxfeUj2Km8Mcc4CTtvMrbJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=ujGyzWX+; arc=none smtp.client-ip=188.165.48.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="ujGyzWX+"
Received: from director3.ghost.mail-out.ovh.net (unknown [10.110.37.140])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4bZvB856xTzB671
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 17:14:40 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-j66bp (unknown [10.110.113.83])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 24EF4C04F6;
	Sun,  6 Jul 2025 17:14:40 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.99])
	by ghost-submission-5b5ff79f4f-j66bp with ESMTPSA
	id oaesAACvamhsZggAUTtfiA
	(envelope-from <redoste@redoste.xyz>); Sun, 06 Jul 2025 17:14:40 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-99G003d1d45c2a-aee4-40b7-963f-7febaef79f0f,
                    03B360DA9A158DBC4F736A687BEA6D6B8F7DE961) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Jul 2025 19:14:37 +0200
Message-Id: <DB553KB95680.28G0KIGGWCW9L@redoste.xyz>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>, "Junio C Hamano"
 <gitster@pobox.com>, "Fabian Stelzer" <fs@gigacodes.de>, "Elijah Newren"
 <newren@gmail.com>, "redoste" <redoste@redoste.xyz>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
From: "redoste" <redoste@redoste.xyz>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: aerc 0.20.1
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250705192113.GB2496172@coredump.intra.peff.net>
 <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
 <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
 <aGnDO3HIAQgsRbnJ@fruit.crustytoothpaste.net>
In-Reply-To: <aGnDO3HIAQgsRbnJ@fruit.crustytoothpaste.net>
X-Ovh-Tracer-Id: 12610078960284571029
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvleeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfrhgvughoshhtvgdfuceorhgvughoshhtvgesrhgvughoshhtvgdrgiihiieqnecuggftrfgrthhtvghrnhepjeeuteeiuefgleevvdffleeiieeghfdufffgieettdeuhefhgfettefhleeihfeknecukfhppeduvdejrddtrddtrddupdeivddrfeegrddvgeelrdefjedpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=tRsFuTFo4D3JqDm5nfzwyozS91hCSRRFgmObdeQ3m3c=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751822080; v=1;
 b=ujGyzWX+hz+CxLku1MTRFJqayiSmKqex9mWMHiRq4Ly1rBossDHuq4sWXFno6Y+oAv8AUNpk
 PybzPF6vfj6D53Z1Xqehg4olaZimI+WpMqQfVwS0uwLl+2P/RoYhDznRJ+omYddIP+q0njExKvB
 6tsYqfO/G+ZD8j4WI/v3o7HmwHUji6B4aoYwDKD7XTfiKV76u2aqwoOuXwzJQNcUou9yDD6Soit
 zyvRkt4TRLk5RMI1DTYN7uDx6qkgWiAeeZsLS42lUeodOJKnx259Pz/scvntSa3IbnDf0IDuLAE
 hHw3oMwt6QfTlM9eusD30Mvt0ay/anyUoysijwVzWuJbw==

On Sun Jul 6, 2025 at 02:28 CEST, brian m. carlson wrote:
> I think `find` is typically better in scripting and also in this case
> with a separate directory as the temporary directory we'll find any left
> over temporary files, not just the pattern we've fixed here.
Thanks for the feedback!

I used `ls` since it was the easiest way to have something that fails
quickly if a file doesn't exists (and `test -e` doesn't support having
multiple files), but I agree, using `find` this way is definitely
cleaner.

> I'll send a patch to fix the policy.
Thanks!

--=20
redoste
