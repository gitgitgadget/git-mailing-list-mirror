Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825ABC133
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728699045; cv=none; b=IISA6hyia6h/Gwdc629t/V+ZgSe/vtKzVhKy1Aw+bAPAhb6uxKDTb5MuPzKHc6GLspk/BeDkpdZE+fWGri+3yfByuvjvWp4K5Jl4uLqOnnCjPli+0r1ESyozKOjJHxzMuClPuZyorYa1Wgn0qs6WbPRwJGQQnbPzIsQiswqkZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728699045; c=relaxed/simple;
	bh=J4Fvd+9s/b+XMF1o2DSCkgplfO7D3lww57BYb7kYv2Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nkU5pSnzLgWnXj7yfd6UrePBNlF2i5GleZukAnitWR5d2zSDXLZ3s4M/+W6qoZA+nMNRTstIq+tNrm/UUZ167b+DDzC4MkaTOPyIDwrFWjWFudNg57LxyZsJrNvDVt7Lt3Ftsif0FbUFhikGndQDhVQhvrzstTeQZU5lSfe8t8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso2321277276.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 19:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728699042; x=1729303842;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4Fvd+9s/b+XMF1o2DSCkgplfO7D3lww57BYb7kYv2Q=;
        b=GeuSM76vPr/rR3V6EcFQgryVMpYHN71ywUwW4Bb2WEu257stFIfrRrBjGkn+rx4hZG
         7ePzmFO+jKwvYS62h9nL94HqEqzEtI5frDGH3cGLNyLVnvs71vakeHyvw884M2MLpPAA
         68q7VtFEaNjX5nYmWkFvrf3RWU5obagBw4SzhrRGSWJV0G0sP1WOzEEh2B9+7RxUntg8
         sg0ZTnIvgFGPGFS85leSulYnA4CgGCKbHDMRQKAgFWhsMyy2xFC5yuLqyjQPE1GBiLGC
         vEOCSGT3U4ZeQZX8C6fHDDMMF0o4EQRjPxr+WY1jSrhzOh1tFT9/1xKKY9ZAxf0l3nnL
         o0Mg==
X-Gm-Message-State: AOJu0Yw7jWWftOfSRObg9vTMIYA1CcejQCeqlZcA7Dd8HI8B2PRwLENn
	/sFszc0pHoCSeixBXj0I9+dXtMq34N7xNuD+43qzaOG9wtjQv6GkDLz3vPqclZXGreqpza55Xzt
	naxGEjRaG1KdBd+0idEpXr/5oeYCFUw==
X-Google-Smtp-Source: AGHT+IHfQpkHCl7NtMmYYhJ3GqXz/YuH2n/AAWMZWrWhRl6SUd2AvW75+oBHeCcxIQXYUX/QCxPKaZ/9FGvlbltOaSw=
X-Received: by 2002:a5b:88c:0:b0:e29:1def:1032 with SMTP id
 3f1490d57ef6-e291def112bmr2795046276.41.1728699042029; Fri, 11 Oct 2024
 19:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Fri, 11 Oct 2024 22:10:26 -0400
Message-ID: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
Subject: git no longer builds on SunOS 5.10, a report
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've spent the entire day trying to fix the build for SunOS 5.10, as
I've done a few times over the years out of sheer stubbornness, but
this time I'm throwing in the towel. I figured I would at least relay
what I found though, in case anyone else came looking.

First, clar.suite was generated as broken because clar-decls.h was
generated as empty. Tweaking the sed one-liner in Makefile that is
used to generate clar-decls.h fixed that (move the end-of-line marker
outside of the capture group, `$$\)` -> `\)$$`), which I would submit
as a patch, but (a) that only fixed part of the problem and (b) I'm
not entirely sure why it helped. If someone else wants to apply this
change, which would align the end-of-line marker placement with the
start-of-line marker placement, have at it.

The next issue was that clar/sandbox.h uses mkdtemp, which I don't
have here. Git has solved this in compat/mkdtemp.c via
git-compat-util.h, but clar is not using it. Adding git-compat-util.h
to clar/sandbox.h feels weird, but does get us further along. That
change introduced banned.h into clar, which exposed the use of strncpy
and localtime, both otherwise banned in git.

Including git-compat-util.h in clar/sandbox.h (bringing in mkdtemp,
and replacing strncpy with strlcpy) and clar/summary.h (replacing
localtime with localtime_r) leads to our next issue: a redefinition of
_FILE_OFFSET_BITS, which is defined unconditionally in
git-compat-util.h, because clar.c imports system headers that define
it first. git-compat-util.h is meant to be included first, so, I added
git-compat-util.h to the top of clar.c. That caused system includes
via <wchar.h> to no longer compile due to syntax errors. This is where
I gave up.

I'm sad that I can no longer build git on this old version of SunOS,
and that it's the newly-imported unit-testing framework and not git
itself that is preventing me from building it. Given the talk of
adding rust to git, and of bumping the perl requirements to 5.26.0 (I
have a system 5.8.3, and a 5.10.1 for building openssl), this moment
was inevitable. On the plus side, this was the slowest platform I
built git on, so perhaps I should be happy about my new free time.

Please note that this should not be read as opposition to the new
unit-testing framework in any way. Building git (and curl, and gmake,
and zlib, and openssl, and perl, all for git) for SunOS was a hobby
for me, and not anything I personally need, and besides, it's not like
my previous builds have disappeared.

The last successful build for me was 2.45.2. I've built or tried to
build most versions since 1.6.6. Some of my build infrastructure was
unavailable since sometime after 2.45.2, so I have not tried 2.46.x,
but it lacks clar, so I expect it would build fine.

Cheers,
-Alejandro
