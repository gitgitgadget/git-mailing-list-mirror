Received: from mailproxy01.manitu.net (mailproxy01.manitu.net [217.11.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767A1F30BE
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999617; cv=none; b=V4GbXG9/1UqC/UIZfaUBGJIMWU/cn0htx+17NBPFVv1pQVJg0egSW21eDJ+R7t1Pa3vbSHJkNX4hMwtBrv1yAaC3vP8AhRlJT6thpWV/2ezFoL0WSFVnU7Coey3v8ecnn49c07sN+Am42F6ALUeyQmki1x5VyjaMhMb5WzrbEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999617; c=relaxed/simple;
	bh=UdNUxpYSQ+ZJNxxLfiZni9QIaCJC5y4p6T4VtNwSNK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGf8LAdB+hRR7ZuMdt49KtSCx1b4nmMqFK3Qa4iImrBMcqmTQuvOAzEpc79GhgDAQ4IK5HejE0vWF38dxQWjZ0FkC03iP/d7ygSoer8+4ajTCbnmvDe/9wV12iNWwwuCmRPI7BewjjBiyOKBHQzsSIDaNGP7NzxCxYSgqhfBq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; arc=none smtp.client-ip=217.11.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
X-Forwarded-Encrypted: i=1; AJvYcCVy8HoXaWRakn/HQcehodqTm3mGRDYW8yp8dXzVzTvD/gSpqKpU7IT9hR2n1VmVNOWmbK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDmOPQfyM8tkWj4CKgYoANSzspEJCUu22OR0bdQ3epcXR8mQ1
	6ONZwcLXqcsW9oPk8o37Qx0nHl8W0YfhbzylNMocz/4dPDpDagrS59ogX4KCnnreNMK+rcq2eN+
	0pOy1qXq/Xdi4cQVOOTKA4uWzlE8=
X-Google-Smtp-Source: AGHT+IG+LtgMzLjGJy0G5xhnh01fSsxeUZazHeHxeDjR5po/u0GxYbUv4Mmxhj5rmFn496gP8yPfR6M1EH0sGUg34aQ=
X-Received: by 2002:a17:906:6a02:b0:abf:7a26:c45f with SMTP id
 a640c23a62f3a-abf7a26c695mr327195666b.47.1740999008529; Mon, 03 Mar 2025
 02:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
 <Z8GVAjwZWOM7c2fR@pks.im> <xmqqseny40kx.fsf@gitster.g> <Z8WFcaEtMCD5C0EN@pks.im>
In-Reply-To: <Z8WFcaEtMCD5C0EN@pks.im>
From: Michael J Gruber <git@grubix.eu>
Date: Mon, 3 Mar 2025 11:49:57 +0100
X-Gmail-Original-Message-ID: <CAA19uiTBzjHCn598t7DA7aF2X52WCuuVo0n1tgG5f2GFSLJiBg@mail.gmail.com>
X-Gm-Features: AQ5f1JpQk5KblFrFOCNdNRCnq0nKY9tEMeGVcw5UNNb4woBWX5TL2bJmgHYdd4U
Message-ID: <CAA19uiTBzjHCn598t7DA7aF2X52WCuuVo0n1tgG5f2GFSLJiBg@mail.gmail.com>
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mo., 3. M=C3=A4rz 2025 um 11:33 Uhr schrieb Patrick Steinhardt <ps@pks.i=
m>:
>
> On Fri, Feb 28, 2025 at 06:15:42AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > I suspect that most environment variables shouldn't matter (for now),=
 so
> > > overall the duplication may be acceptable:
> > >
> > >   - We need to unset a couple of variables, but we can probably reuse
> > >     logic `git rev-parse --local-env-vars`.
> > >
> > >   - We need to ask Git to not read the configuration, which we can do=
 by
> > >     setting a couple of envvars. This should be manageable.
> >
> > "Provide a controlled environment where Git pretends this is the
> > $HOME and that is the $AUTHOR_NAME and so on" is much more
> > preferrable than "Tell it not to read", no?
>
> Maybe. I guess for unit tests it's a lot less clear cut as most of the
> tests won't depend on such a controlled environment. So sanitizing the
> environment would be a good enough first step for me, and if we see
> demand for making specific information available to lots of tests we
> could still start to expose those at a later point.

Since I haven't been following the list I don't know what the plan is
regarding the different test sets/framework. But, unless they are
meant to be completely separate or rewritten right away, I would say
that both shell tests and C tests (whatever framework) should run in
the same environment, and this should be a controlled environment in
terms of git and other config files (which means set up a separate
HOME) and the most relevant env vars (test-lib.sh tries to do that,
too).

> Of course, if the author already wants to do both steps right now I
> won't complain :)

Nah, I had a hard time just reading the failing unit-test and figuring
out how to deal with it - GIT_TEST_OPTIONS=3D`-i -v` does nothing for
unit-tests, and I yet have to find documentation on them. I do
understand why you want a solution in C, not a shell wrapper. (Though
you have one right now ...)

I'd rather leave this to those "in the know", or "in the want" ;-)

Michael
