Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799E24E4C3
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011802; cv=none; b=sZLN6tQXxceMKEfX/BbxV2ETXumfhcIgxDKpT/uSBOBkshvTHcXtj9Ewv2qgyaegARrap+ZtxU9ROq9Gtz5FOrM5ex5z2EA3PyUqZgKqEfJ3Dz2lpWlEcjc10xIb7xBWIxy0hGoVXSR8hA8xgWTlrOC+qGVT++Jk0LEaWZwWvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011802; c=relaxed/simple;
	bh=xNq4lH5uSDNfAvEStXX6CjYSJLhXvL1YR+4F3CcNlnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwGZIugqugEVB59H8v1V3KvqBLslG5JD4k1WAgcHMU6Vosd4crYEG0YHz2Opay5AOQP2/5ipNdb7H+4WzAcB4pEyhKPlBPawqNc/4t6JB8YifKy4T159VbQKxok0duvqABjDsujwL8aD+8CmENKxonq37BeGfBxOvf5RkpsBqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: floppym)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7E233341E90
	for <git@vger.kernel.org>; Thu, 02 Jul 2026 17:03:20 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c128cc012b4so124182166b.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 10:03:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rql5Ejb4/8LphwzG0NtsL4X8d0K9RAoWzIa2j9DfBjwOX5piDBJ6tVDymvmGu0Ji3pGCGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXDVB1H4cvbGtT+at63Q4/bZSS6E0b7VAFBGs5nanLEFT1wDx
	e0KF/ytmLJa9MvU5bJ/FU34IcWvaHv0IIMXgljA5KdWs1nagVMNWupWDOKAkZBxxPBoqcfviNni
	0ZjG2CD/O0RKqVi4mhAPeoOkhipFa3es=
X-Received: by 2002:a17:907:86a6:b0:bd2:15b5:bf60 with SMTP id
 a640c23a62f3a-c12c9de19b8mr36899166b.3.1783011797701; Thu, 02 Jul 2026
 10:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701193928.358825-1-floppym@gentoo.org> <akZGJP1kVtjBFN_e@pks.im>
In-Reply-To: <akZGJP1kVtjBFN_e@pks.im>
From: Mike Gilbert <floppym@gentoo.org>
Date: Thu, 2 Jul 2026 13:03:05 -0400
X-Gmail-Original-Message-ID: <CAJ0EP43gyQf_XhCLCNEzCq9wMYXZBQX=PWjR-wYqoESSvByJiA@mail.gmail.com>
X-Gm-Features: AVVi8Cfh6xMGc27l6MTnrLrZCpkGOhULq8wLNY-9516Zif-gAXBAdp-5OH_1tVM
Message-ID: <CAJ0EP43gyQf_XhCLCNEzCq9wMYXZBQX=PWjR-wYqoESSvByJiA@mail.gmail.com>
Subject: Re: [PATCH] meson: restore hook-list.h to builtin_sources
To: Patrick Steinhardt <ps@pks.im>
Cc: Mike Gilbert <floppym@gentoo.org>, git@vger.kernel.org, adrian.ratiu@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 7:06=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Jul 01, 2026 at 03:39:28PM -0400, Mike Gilbert wrote:
> > This fixes a racy build failure.
> >
> > ```
> > builtin/bugreport.c:12:10: fatal error: hook-list.h: No such file or di=
rectory
> >    12 | #include "hook-list.h"
> >       |          ^~~~~~~~~~~~~
> >
> > ```
> >
> > hook-list.h must be generated before builtin/bugreport.c is compiled.
>
> "hook-list.h" is required by both "hook.c" and by "builtin/bugreport.c".
> So you would expect that we indeed need the header generated for both of
> these, but right now we only explicitly list the dependency for our
> libgit sources, not to our builtin sources. And consequently the header
> may not be generated:
>
>     $ meson setup build
>     ...
>     $ ninja -C build git.p/builtin_bugreport.c.o
>     ...
>     ../builtin/bugreport.c:12:10: fatal error: 'hook-list.h' file not fou=
nd
>    12 | #include "hook-list.h"
>       |          ^~~~~~~~~~~~~
>    1 error generated.
>
> The fix is of course to explicitly list the header for both targets.
> And...
>
> > diff --git a/meson.build b/meson.build
> > index 3247697f74aa..bdc83843e8e0 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -278,7 +278,20 @@ compat_sources =3D [
> >    'compat/terminal.c',
> >  ]
> >
> > +hook_list =3D custom_target(
> > +  input: 'Documentation/githooks.adoc',
> > +  output: 'hook-list.h',
> > +  command: [
> > +    shell,
> > +    meson.current_source_dir() + '/tools/generate-hooklist.sh',
> > +    meson.current_source_dir(),
> > +    '@OUTPUT@',
> > +  ],
> > +  env: script_environment,
> > +)
> > +
> >  libgit_sources =3D [
> > +  hook_list,
> >    'abspath.c',
> >    'add-interactive.c',
> >    'add-patch.c',
> > @@ -566,19 +579,8 @@ libgit_sources +=3D custom_target(
> >    env: script_environment,
> >  )
> >
> > -libgit_sources +=3D custom_target(
> > -  input: 'Documentation/githooks.adoc',
> > -  output: 'hook-list.h',
> > -  command: [
> > -    shell,
> > -    meson.current_source_dir() + '/tools/generate-hooklist.sh',
> > -    meson.current_source_dir(),
> > -    '@OUTPUT@',
> > -  ],
> > -  env: script_environment,
> > -)
> > -
> >  builtin_sources =3D [
> > +  hook_list,
> >    'builtin/add.c',
> >    'builtin/am.c',
> >    'builtin/annotate.c',
>
> ... that's exactly what you do. So this fix looks good to me, thanks!

Thank you for the review. This is my first contribution to the Git
project and I'm trying to follow the lengthy SubmittingPatches guide.

I believe we have "reached a consensus" and my next steps are as follows:

- Add Reviewed-by (or Acked-by?) for Patrick and Adrian.
- Send the patch to Junio with the list CCed.

Do I have that right?
