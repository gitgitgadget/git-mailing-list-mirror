Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13427C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjBJTZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjBJTZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:25:33 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7247D899
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:25:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k13so7567536plg.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7S3RMKSX9WcJuoU8w50EWV3fmggYfPXmB3pOrtErh+4=;
        b=SbWviz53hYs7p45ygY5dreASADIxX5lT5y7nHantOB+zyyQ82czIPE0JRBHApdB8fR
         GghaW5BmVXTy3CF+9jgxfVR71fhZ3XeG5kdb/k87lBxOxBY5AKZK3C1/0yNkF/eCIRgc
         wYlqc0qzhyfTIA1oAfPf/+/5NQJA+e59GivIFo1ViVK2HNrStCabFKgVstC0bOFxNXBN
         yEt4p73IGMoNgBIy1ZE3SKmKpPzabTaTQ+cKO5SLyOPEIiWpSEc82Jc3I7xh5o7rOEqC
         FkaJwJJXjMhwmMY5BtgG+UjR66wmz5GzwhHjMWwj9yLoPHMVffTBAKJWJ+mmrOi8Bfyy
         4awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7S3RMKSX9WcJuoU8w50EWV3fmggYfPXmB3pOrtErh+4=;
        b=pXW1x1JXaiglPSqo6nj3UeMj/R8wwbxyTjNHcYUu0X7XGq1FBlyXBoThniKrmbdLdl
         Fzii+SQoxB+yPPLSlijkmrvyjmHAtt5Komwfk3uEQEe8JZJak71kLddjzLVH9YNfvy5U
         FQkYfeU1R4zqncS8gEZV8C8eiCkG8E1SkMaZKkMcrQNk4MOroWsbkh3OsXXNSfTBJyja
         yAdJYDrTh9gxyIoyLwejl5Y8P3MTRXwexh2do6jPabvtNWJfNq+JIrzPZspgVyvNNwXK
         ubVOwmptPqc+EFi3OQf7LrbYqmFv0FfX2FJ4lpeDChbDKpA3xOoJ/S5r51TrK78RVHe5
         Bqwg==
X-Gm-Message-State: AO0yUKWLhAfoKqFA4i8OoUYLSt1czBSw2LWjMEkMJo7jVz8IowtojC0j
        2MRS+dIYjdQSqGXm2L4B2qt2FIn98ro=
X-Google-Smtp-Source: AK7set/nIYyHRfOENK/3daRD6OAlvQiHqdY9xwADUwxwcXZIRORZvmsmY8FaImqd1IABYTWQbD7lBw==
X-Received: by 2002:a17:902:f0cb:b0:199:3f31:8611 with SMTP id v11-20020a170902f0cb00b001993f318611mr8727830pla.39.1676057132073;
        Fri, 10 Feb 2023 11:25:32 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ab8300b0019607aeda8bsm3723856plr.73.2023.02.10.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:25:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] signature-format.txt: note SSH and X.509 signature
 delimiters
References: <20220120053223.221667-1-gwymor@tilde.club>
        <20230210061611.124932-1-gwymor@tilde.club>
Date:   Fri, 10 Feb 2023 11:25:30 -0800
In-Reply-To: <20230210061611.124932-1-gwymor@tilde.club> (Gwyneth Morgan's
        message of "Fri, 10 Feb 2023 06:16:11 +0000")
Message-ID: <xmqqfsbdiaqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> This document only explained PGP signatures, but Git now supports X.509
> and SSH signatures.
>
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
> +calls an external program to obtain a detached signature for the payload
> +(`gpg -bsa` in the case of PGP signatures), and embeds the signature into the
> +object or transaction.
> +
> +Signatures begin with an ASCII Armor header line and end with a tail line,
> +which differ depending on signature type.

OK, we used to say "begin with <<something PGP>>" that was not
generic, so we borrow the "ascii armor header/tail line" term the
crypto folks use.  Then ...

> +PGP::
> +	Signatures begin with `-----BEGIN PGP SIGNATURE-----` and end
> +	with `-----END PGP SIGNATURE-----`, unless gpg is told to

... it may be easier to understand if the paragraph somehow made it
clear that "ascii armore header" is "-----BEGIN PGP SIGNATURE-----"
and "tail" is "---END PGP SIGNATURE-----" for the format being
described.

Alternatively, if we are going to repeat "... begin with X, and end
with Y" for each format, then we may not even need to have the
previous paragraph that says these formats follow the same pattern
(i.e. header then contents then tail, but header and tail are
different depending on the format).

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
