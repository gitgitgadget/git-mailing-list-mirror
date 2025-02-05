Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16423CE
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790131; cv=none; b=SEzHtMclY1DnqwECUrw2rQe0G7AztstpRMtZbr0favJvcBvNsv80o0v4R0Vqd01x5rZ/bFLMzE0arHYffj11ZoMDWjmYj/29j02uE+nYDi7MGxO5I61OwTSwuc6q6WY/sm3lYrSBcrstx8vBX6ack8GcHtjAaUf9Cnmtg1wacis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790131; c=relaxed/simple;
	bh=53UkEph8ZitWD5XcDlk59tGUGnKahUfD1KUlJWve+nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V46ep6E7BZW9b4M6A9v0jO1nRLGmxrthNygDsbTloVuFDB+YH77QpSJGDAbYRuaRDqnt5ItcX7m4e24JQDaOtpzsSpgR20i09KpCzwmW8D35ynANOxG0tb/Ud8bAO5yt8w9FzLvYm5a4bnTRdS+XQWSuKZhVWu97IOvEtLyhuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HX0wn1nv; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HX0wn1nv"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id A959413F8A7;
	Wed,  5 Feb 2025 22:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1738790121;
	bh=53UkEph8ZitWD5XcDlk59tGUGnKahUfD1KUlJWve+nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX0wn1nviJUBUcHeTI2NxA1UutUFYFVj6cB5cOe7uthXROCYmQusQoVOX5boUuvAw
	 q3J1IKyMV/ROxi45OT3RsO1QCz/o5TcJwF9uN5vmyxu9J2NDk403TADtOe6rZIetih
	 PpUnUVbbEapCavTCiMVpSmZ56BXYfQM2FzCPGgmCmJ9e8t34G65bT/JRimyPsthAB0
	 7wUIHSyLkJVc/8yI23MOeJiFmb8T6DQ04KEGOWMrKs3ldw0SJRwYO1mTIiuqhEkGIR
	 IaqEf49JfTejBN5RoY905jAZArbFkLZt9KPY1Y8g5SdRHauzWJ2OXUDckHMkwho39N
	 l3xNXl3ENMqfw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/7] clone: make it possible to specify --tags
Date: Wed, 05 Feb 2025 22:15:14 +0100
Message-ID: <2212047.irdbgypaU6@cayenne>
In-Reply-To: <Z6MbSXQ3O476bpfZ@pks.im>
References:
 <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
 <20250204-toon-clone-refs-v5-2-37e34af283c8@iotcl.com>
 <Z6MbSXQ3O476bpfZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 5 February 2025 09:03:21 UTC+1 Patrick Steinhardt wrote:
> On Tue, Feb 04, 2025 at 10:34:01PM +0100, Toon Claes wrote:
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> > index
> > de8d8f58930ecff305f79480b13ddce10cd96c60..e89ae2e8c664f4d4e15e5f05264c8df98
> > 8295e3d 100644 --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -273,12 +273,13 @@ corresponding `--mirror` and `--no-tags` options
> > instead.> 
> >  	branch when `--single-branch` clone was made, no remote-tracking
> >  	branch is created.
> > 
> > -`--no-tags`::
> > -	Don't clone any tags, and set
> > +`--[no-]tags`::
> > +	With `--no-tags`, no tags are cloned, and set
> > 
> >  	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
> 
> This reads a bit awkward now. How about:
> 
>     Control whether or not tags will be cloned. When `--no-tags` is
The future form is useless, as it applies to the current command run.

>     given, the option will be become permanent by setting the

"will be become permanent": I do not understand this part. If I parse it 
correctly, this a passive future perfect form, but it does not relate to the 
current state.

>     `remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
>     future `git pull` and `git fetch` won't follow any tags. Subsequent
>     explicit tag fetches will still work (see linkgit:git-fetch[1]).
> 
>     By default, tags are cloned and passing `--tags` is thus typically a
>     no-op, unless it cancels out a previous `--no-tags`.
> 

If you let an empty new line followed by an indented paragraph, this creates a 
citation paragraph. What you want is to attach it, like so:

	(...)
	explicit tag fetches will still work (see linkgit:git-fetch[1]).
+
By default, tags are cloned and passing `--tags` is thus typically a
no-op, unless it cancels out a previous `--no-tags`.


JN



