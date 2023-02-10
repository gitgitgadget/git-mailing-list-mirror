Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7AC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 11:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjBJLHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjBJLHH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 06:07:07 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9649036
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:07:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so14779327ejc.12
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7SKt6+xiGRdsfWQjEbVs4AM5e1HKuuyUOLMsKWcNHQ=;
        b=iqBtHz4yzJK7a0qKUY9HID+EAGrQxdZFKRXxwBz3dHWPnOPVJhfu9YzCFSthAwknuX
         owFRJu1doKkVZJ13jOeGJkh8JJ/C64qhXylrrGLqx8zpCF/I/Yl6p660kL4ptEWOt7nO
         TlVwrfoLdXNVAMstLUMD1lilwhNl/KIFDOxhEjLQxuffkpZvs6BV4m+1l3aBhGsDVMsn
         K5+XTFfLAg9pyptX48tuH4D3c/lZA+C8apk//UlLKHvt1mYwdRx3j/l4R0nS5VcPb3BQ
         R6TLEPT8oDqmr5sCfN1Nt1HxQ5OQbjlijDkQKGFBZd/NAPYWl9CiqNGOEHCIoVw70S0j
         gCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7SKt6+xiGRdsfWQjEbVs4AM5e1HKuuyUOLMsKWcNHQ=;
        b=IPLGvfTDsXsNM+xVFON7oH1Wa0EfBl/k9bU5Wcg93jfAjScxIceoBiaDCVtNLE7HUi
         qxxNa0S2EZXsxOttWHkf8jzw0ZPcjVkyy0wToq69CTyeIXfT5xb0WLiD7IuDkyE7jC5A
         tHKx2F+8XZ6SAjKnIWj9+A1aoQ9h2pW6troO6uBRDiq+bCpf/Chefx9eTTqwpFxvFWux
         MDOvrtTWUQn1n3CvK/daLOyRQ46+CSoPv1RYGdduUpQeDN40NCXjn6RhZhvY9E6OiPBX
         ksdTvlCLnB4yTsiC3DX4FEnYp0e6VX6KgWWop1sQ6fvvMUv2fCetdk6p/imIgyJrTZWA
         fQGw==
X-Gm-Message-State: AO0yUKWspGasEW5zgGakHsMdPMKMYyd8NNbLfRXTz9piByGP92dIVgj5
        Fj88sAiYwaMZ7m/i9yge2nVGhlVCgwfG8WTm
X-Google-Smtp-Source: AK7set9CujNxsrA5GiaPo/8F0k/Qq+AGQYB3px2LfsNw/IDi+Rlh/rN2aaXY7mIUXsZEuvXnWL7GNQ==
X-Received: by 2002:a17:906:5a5e:b0:8ae:11ca:81de with SMTP id my30-20020a1709065a5e00b008ae11ca81demr8746473ejc.34.1676027220881;
        Fri, 10 Feb 2023 03:07:00 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id gl11-20020a170906e0cb00b0084d381d0528sm2199451ejb.180.2023.02.10.03.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:07:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQRF5-001rvY-2e;
        Fri, 10 Feb 2023 12:06:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] signature-format.txt: note SSH and X.509 signature
 delimiters
Date:   Fri, 10 Feb 2023 11:52:42 +0100
References: <20220120053223.221667-1-gwymor@tilde.club>
 <20230210061611.124932-1-gwymor@tilde.club>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230210061611.124932-1-gwymor@tilde.club>
Message-ID: <230210.86ilg9wzho.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 10 2023, Gwyneth Morgan wrote:

> This document only explained PGP signatures, but Git now supports X.509
> and SSH signatures.

To elaborate a bit, in 1e7adb97566 (gpg-interface: introduce new
signature format "x509" using gpgsm, 2018-07-17) we added X.509, and in
29b315778e9 (ssh signing: add ssh key format and signing code,
2021-09-10) we added "ssh", but our docs were never updated.

Your commit message says as much in briefer terms, but maybe if you
re-roll having those references would help put this change in context.>

> Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
> ---
>  Documentation/gitformat-signature.txt | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/gitformat-signature.txt b/Documentation/gitformat-signature.txt
> index d8e3eb1bac..5f0c9202e3 100644
> --- a/Documentation/gitformat-signature.txt
> +++ b/Documentation/gitformat-signature.txt
> @@ -17,12 +17,26 @@ DESCRIPTION
>  Git uses cryptographic signatures in various places, currently objects (tags,
>  commits, mergetags) and transactions (pushes). In every case, the command which
>  is about to create an object or transaction determines a payload from that,
> -calls gpg to obtain a detached signature for the payload (`gpg -bsa`) and
> -embeds the signature into the object or transaction.
> -
> -Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
> -and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
> -produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
> +calls an external program to obtain a detached signature for the payload
> +(`gpg -bsa` in the case of PGP signatures), and embeds the signature into the
> +object or transaction.
> +
> +Signatures begin with an ASCII Armor header line and end with a tail line,
> +which differ depending on signature type.

Does the "ASCII Armor header" really add something here, or just confuse
the user with a reference that's not followed-up or explained here?
Maybe we should point out OpenPGP's '--armor' option in passing, to note
to the reader that this isn't some git-specific concept.

> +PGP::
> +	Signatures begin with `-----BEGIN PGP SIGNATURE-----` and end
> +	with `-----END PGP SIGNATURE-----`, unless gpg is told to
> +	produce RFC1991 signatures which use `MESSAGE` instead of
> +	`SIGNATURE`.
> +
> +SSH::
> +	Signatures begin with `-----BEGIN SSH SIGNATURE-----` and end
> +	with `-----END SSH SIGNATURE-----`.
> +
> +X.509::
> +	Signatures begin with `-----BEGIN SIGNED MESSAGE-----` and end
> +	with `-----END SIGNED MESSAGE-----`.

I wonder if structuring it like this wouldn't help make this easier to
read, and reduce the repetition, as well as making the circular
references between this & 'gpg.format' more obvious:

	The signature start and end marker comes on its own line, and
	differs based on the signature type (as selected by
	'gpg.format', see linkgit:git-config[1]).

        Those are, for values of 'gpg.format':

        gpg: `-----BEGIN PGP SIGNATURE-----` and `-----END PGP
             SIGNATURE-----`. Or, if GPG has been asked to produce
             RFC1991 signatures: `-----BEGIN PGP MESSAGE-----` and
             `-----END PGP MESSAGE-----`

        x509: `-----BEGIN SIGNED MESSAGE-----` `-----END SIGNED MESSAGE-----`
	ssh:`-----BEGIN SSH SIGNATURE-----` and `-----END SSH SIGNATURE-----`

Then for gpg.format in Documentation/config/gpg.txt we could add e.g.:

	See linkgit:gitformat-signature[5] for the signature format,
	which differs based on the selected 'gpg.format'.
