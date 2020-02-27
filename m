Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1428C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE7F246A0
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ed/AwWn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgB0QEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:04:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38990 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgB0QEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 11:04:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so4045335wrn.6
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nC9DO1Lsbgkzsh4FyIexP8Vd/bPGm7XK/8dVjERbltE=;
        b=ed/AwWn/lmQoVIk7BliYc7t8+n9U7SxttnFI9/nC6WZ66AOb1udQls1SDIZOqTKWFQ
         1jWCpbmKWK1jQRksVj+WA7wZM9F1oAQYEKStPXl+GzSE0n8KV3AsIC9h3YBr25eKcxUf
         5yqQgfLYnL2k2X9bmmWN4L9Xm1stDSAGZ43bVJwqmP5nEF8ygAEMJ1DmjlBA6rEmWtzN
         eFYOpjCINm08o1fYxRcfuSw7L18kIhA12bzc6c9y22XwK94gDVFXuKQa17l9+0txB00H
         0v2n2hxt2EdFIMJehafeaVD8/2szU53vasvJqXM3PqqkrTjqVLirB4Q/aG3mW/HXhZN6
         0nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nC9DO1Lsbgkzsh4FyIexP8Vd/bPGm7XK/8dVjERbltE=;
        b=LQWb0WIbhgUHSrTD0Ss6GdbLgQN8Jl7OCcE1WyE88NKElenUS2uDyvMXWyqUhKFpSN
         j4dPUbUPk5dl/NG6zP65Xq1UxccwMpdZpTTwFzEzUir5336ifGLc9tMVkXvI4Ie+/JwV
         D6eviT+NFua7+lzxJ8+rHnCICnaiVyqwiHO6NaZ7f9s9pPYPxuImIdOTy6zN4ykJsQYK
         3JxggETQpxNDiOjX8eWDYm4yD9+br4MCOjvScL008oY0KZw2Wb9MwrQrwC+C0/ngBT7n
         mgj3FIoZapkvRRXUR8fVL5O9a6oYRnKWhEoWUCi/dPNdcuw66lBZxcfMJSq/BmVfpG7x
         g3dQ==
X-Gm-Message-State: APjAAAWeF0gNseZAkn36/1sPWqnaNxcMhBQfdGI/S1WpbfNlJD6CX63f
        IhBAJEFIt7cEc2htvfZDnIcRtAA3U1rMvo8stfAhvw==
X-Google-Smtp-Source: APXvYqyUL1jCvDwXnOlWSGZRoXUhkwpUaGr7VXlF0u+SzCwzyBsUJoL307UjhIBc5wxihUju35uqNXrmClwc+sn/dVo=
X-Received: by 2002:adf:de85:: with SMTP id w5mr5211454wrl.323.1582819443328;
 Thu, 27 Feb 2020 08:04:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <pull.539.v7.git.1582706986.gitgitgadget@gmail.com> <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
 <xmqq8skpjjyz.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PikWsjFizg8=e9+YunkiaciD64BDks8=J55185NC5oQg@mail.gmail.com>
 <xmqqv9nti0gl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9nti0gl.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 27 Feb 2020 17:03:51 +0100
Message-ID: <CAFQ2z_PGgQ19uyjaEaJ4XMuvbkzW5fvJng3r2vYHDz4Z6pT3Aw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 8:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Without --show-head, HEAD should not appear in "git show-ref"
> >> output, but the expected output has HEAD, which is puzzling.
> >
> > The HEAD symref is stored in reftable too, and to the reftable code
> > it's just another ref. How should we refactor this? Shouldn't the
> > files ref backend produce "HEAD" and then it's up to the show-ref
> > builtin to filter it out?
>
> After looking at show-ref.c, the answer is obvious, I would think.
> for_each_ref() MUST NOT include HEAD in its enumeration, and that is
> why the caller of for_each_ref() makes a separate call to head_ref()
> when it wants to talk about HEAD.  As a backend-agnostic abstraction
> layer, behaviour of functions like for_each_ref() should not change
> depending on what ref backend is in use.

So, the ref backend should manage the HEAD ref, but iteration should
not produce the HEAD ref.

Are there other refs that behave like this, or is this the only special cas=
e?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
