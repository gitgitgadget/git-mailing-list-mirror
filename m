Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA405732D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm9LC+8F"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbbe583e04so3584980b6e.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705004447; x=1705609247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzy7KuxLy8UoOHPCDkNtWHSqf8OWhwFH+XpdF7xesy4=;
        b=Cm9LC+8Fi4IytEj0U1mOyz5Im6YsF/BeIDB73T7KauJbOCGumXHQXU5OOEA32T6Qw4
         9ikdYGX0dSFt2ZMrBCgehmQy0VV/aGoHWeX954+dnZ5Oa3Dz3j247YPmWhRSn9/x2IOE
         BAZXmFK9gTyitPvVibJH3Xpn5r71qx62/ZiDyvQuYB//PIvxGdg/DUM6v6rq7FbX8pKV
         CdDPz/Ny+nBSoQomxETw0MIr/0pUKI6fjpgt5d+CwA4r0unGT8vJkQV5fdC6os8i2g8q
         Y8K5ANXzHWjN352EbXSxKH8xSbYiynZpkNYcYRtPltVv8mvxVKSm2xpKywqM587OU8Da
         Chdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004447; x=1705609247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzy7KuxLy8UoOHPCDkNtWHSqf8OWhwFH+XpdF7xesy4=;
        b=KZwaauXfnDVbcXbbc8hBcMlhtHCqsk6deiFuwdHxwVswuUJHIOPv3P25Q0lQz5hNPW
         lRcr5hLgTBbBpf0IbWJCG/nkV3dA0xGXnE28yL47S1ReA6xUv8+UNIg2U7MzyN9Jjv8A
         HosTcKAaCmZOJgaUjCM/VO/S5kkoqZKVsmO+B3vLFRb1AMB/JIY2YD0N46xDk3Q+Rian
         I4HXIGnb+hJ0ZVEPlCeMVxzkkLRAklLsftoCHzoXXYIF+S74rjJ+L3+AUpxB8WKqK0MR
         KCj+Ji7OamFWIZ78oSkYOBnoBbz7ch9IZRkmfnnbMWs/2FvSFmKsZz8FIGPu9KIgeQtl
         htIg==
X-Gm-Message-State: AOJu0Ywonu4pnw9pkljSs8H2gEqMdTvk+w3tM6UgqoMOVLsxD9vVlgVe
	C/r8tI18dhQrPEh8Y7ffV1nifGOfG4xqqIWDmLo=
X-Google-Smtp-Source: AGHT+IEFyz6gzQgMfTk4K2T6xJx1O2HrfIStGyUO37FepSXGJuZF9JA2MTvXGWbLvKzFw4wFXsLJITSW/VLFnbpSefI=
X-Received: by 2002:a05:6808:138f:b0:3bc:29af:e847 with SMTP id
 c15-20020a056808138f00b003bc29afe847mr278430oiw.50.1705004446695; Thu, 11 Jan
 2024 12:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com> <xmqqv8807ll1.fsf@gitster.g>
In-Reply-To: <xmqqv8807ll1.fsf@gitster.g>
From: Justin Tobler <jltobler@gmail.com>
Date: Thu, 11 Jan 2024 14:20:14 -0600
Message-ID: <CAGAWz+5d+r97Nq_CB5BFnujo_K9bhCArPuLT2o8XNXvsJyETPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Generalize reference locking in tests
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> The use of two fifos and avoiding deadlocking parent and child is
> tricky enough that it does feel that it warrants a helper function
> to do the common part of what these two patches add.

To avoid the trickiness that comes with introducing fifos to these
tests, in the next patch version I've followed the suggestion of Peff to
instead create d/f conflicts to create an error condition. It appears
that these tests are not particular to the exact error condition being
triggered and therefore d/f conflicts are much simpler to produce.

Thanks,
Justin

On Wed, Jan 10, 2024 at 6:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This approach is more verbose and may warrant consideration of implemen=
ting
> > an abstraction to further simplify this operation. There appears to be =
one
> > other existing test in t1400 that also follows this pattern. Being that
> > there is only a handful of affected tests the implemented approach may =
be
> > sufficient as is.
>
> The use of two fifos and avoiding deadlocking parent and child is
> tricky enough that it does feel that it warrants a helper function
> to do the common part of what these two patches add.
>
> I think I read t1401 patch carefully enough to understand what is
> going on, but I cannot yet claim the same for the other one.
>
> Thanks.
>
> > Justin Tobler (2):
> >   t1401: generalize reference locking
> >   t5541: generalize reference locking
> >
> >  t/t1401-symbolic-ref.sh    | 28 ++++++++++++++++++++++++----
> >  t/t5541-http-push-smart.sh | 25 +++++++++++++++++++++++--
> >  2 files changed, 47 insertions(+), 6 deletions(-)
> >
> >
> > base-commit: 624eb90fa8f65a79396615f3c2842ac5a3743350
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1634%=
2Fjltobler%2Fjt%2Fbackend-generic-ref-lock-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1634/jlt=
obler/jt/backend-generic-ref-lock-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1634
