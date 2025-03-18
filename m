Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EE3FC3
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272049; cv=none; b=ttPpo3n5c1nw4EvNz+iVoaAtrVoE8hhqTfJzd82K1BDTf0HVk6We7qBojNL3MjGq0WFIpRX9BRMvOqnhjUgYVR69X0+iIt2uyzn1sU51ndoeTnqbRFw+RNPkQmhlh+RsskvGQ3LqCposIIuiWsBjYkXEXFr40Mx3Gi5QGS/KHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272049; c=relaxed/simple;
	bh=WQ3WWTktP5+Q1PTDcZDcMnjubcB5Fz9CCs5GV/RPC3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8XQeV7q9pQdZXgg6ENv/q0A3j64FLo32Qr18/2Kr4b1EmQ/7hTXkWgOy+w9Y+74+qGVj6XPEUZ/L4vG2M19Ja6KyPQNMdK3o+oSOh/wgprnweAdvirdyB86BxutSDl/Gzn1sMSxfCG5ZT/Cdknh1O1fTBZtVpC3RsGzaCdBGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=uZ3DaauI; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="uZ3DaauI"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 93A1C13F879;
	Tue, 18 Mar 2025 05:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1742272044;
	bh=WQ3WWTktP5+Q1PTDcZDcMnjubcB5Fz9CCs5GV/RPC3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZ3DaauI26KrzbMvZ8HAA+4FBxcm9WCV2tNzpV8z847JweEq5oiI/rcPN0P2xcRNO
	 MZpmkT62ODP4ibx0eA7D9SasYJLI+oJKf7DR0+tA7v2lEn7OIrJsOOeTLNEKS4daT5
	 QXHFgXGtldVzwNpzJ3+vsRIofaEqXpRZ6EF6TA7yJHfiEXhm5+ls+vzR6hT9MMaUIZ
	 ftevpeSqhpjWEA/lTv+H3tb35NDJBV6qUjtiBs7hbarPH1C+muAQmmfH36W2URBfeR
	 ZFBbCLxss6trRw33cyDpEIXLpmsfLreLfxaW/mt/3jZ8XBG8TDBT/qVbAxwXqz6QKG
	 i1ogR0z+BDq2A==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Subject:
 Re: [PATCH 1/2] completion: take into account the formatting backticks for
 options
Date: Tue, 18 Mar 2025 05:27:22 +0100
Message-ID: <2361196.ElGaqSPkdT@cayenne>
In-Reply-To: <xmqq1puv55y7.fsf@gitster.g>
References:
 <pull.1880.git.1742056310.gitgitgadget@gmail.com>
 <2773494.mvXUDI8C0e@cayenne> <xmqq1puv55y7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 18 March 2025 05:16:32 CET Junio C Hamano wrote:
> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
> > For the GNUism, the tests on MacOS and Windows by gitgitgadget passed. =
But=20
I
> > get your point and will reroll.
>=20
> Is there a good test in our test suite that validates the output of
> this script?  I had an impression that even if the regexp match by
> this grep were a bit off, the only end-user visible effect of such a
> breakage is that some entries from config_name_list[] may be missing
> when "git help --config-for-completion" is called, but I do not
> think of any sensible way to notice that some entries are missing or
> extra entries exist in the output.  So unless the regexp is broken
> so badly that makes the resulting config-list.h syntactically
> incorrect, it is unlikely that our test suite would catch anything,
> I suspect.
>=20
> If I deliberately break the regexp (this is before your patch), it
> does not seem to break t0012 (which uses --config-for-completion).
>=20

I noticed the bug when working with git-branch's doc, because it broke t990=
2=20
which specifically tests completion for 'git config get br' and could no lo=
nger=20
find the 'branch.'  So the tests have eventually found the regression when =
the=20
formatting went a little more widespread.

As for a way to validate the content of the script, I can only think of=20
committing the config-list.h and checking when the contents diverge.

=20


