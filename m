Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29FC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBFV4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBFV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:56:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E42D142
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:56:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so12184879pjp.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eOtBFFf2gIQLGWJ6O3LF4rVr3v7aw2Qvt055eTeKuk=;
        b=LtsIJEYYlN08IyLd0M4v90ogW5XKxRRrnTEwwp+CIIRhjr/gxQ9N+ja5ayNi/SkzHh
         UQrLz1xargKVQHIf44d1i2SMrdasn8wpD23kH8RwSCd59DJbR9LLj86Jp8o11U2Dtpjo
         NkvI8SK4VU2iCqEAWW4486XwFeSdHJcBRd1xB8U9JFcpkk89HSpiUejvNYOwY3Tds5yX
         BGZYCIWm7n7B4+OF+S9SLeXjITY7gefIIXjndVZQC+fy9jxqGA1Aw1IbDRqCEqScjyLQ
         /B4Vkrt0L7ycqP/zAgr4mOgBIbHqGgTIDInrvRyYZ6+Td4pN4cMddG9+xb7WFHuaxS4z
         xnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1eOtBFFf2gIQLGWJ6O3LF4rVr3v7aw2Qvt055eTeKuk=;
        b=n+7NDru0eGtyykV7QGWafshuLz+ADIdrG+fsaydze4YXRj1K2Qu8EGGNCvHQ6LyZZp
         +N9ixU809NWPUN1ZQupnTKrBx+AgIaR18X90eZsdBu42UfEjcMt77fTkaY2t1e1e04Rg
         kaTrC18FtBJZFp13Lo+/yeHjY6QMYJSk3AxmfxiwEiEEw65dB2h/AUjZHS4i0jWK6iQg
         gDmQU3lbQOZzqaSWbPIltNBnZpz54jTKOWmbQ4Te7VZtWC2JBfdJolK+8n5EjOLfRv1N
         jXMGXZadq3ogcJA1e/hhjTOaBo0tcOE32dx9PURDECq3LL98nYsNZu7bK5ZvFyEhHr6d
         syJA==
X-Gm-Message-State: AO0yUKXU+KY3ZiKQprPS4dkGn5lKpQ9rLhE6MJZ5dZHwHao5yCWX6m7r
        2HUiBopcZ06Oc+amBKVFrSY=
X-Google-Smtp-Source: AK7set86Y8ZFR9fNJ2xmPOGznTYmZFMXgFviPlKR1rSAFBguVZtQ7pzNhWlVHL5YLqGxtHwEByiLpQ==
X-Received: by 2002:a17:90b:3849:b0:22c:198:6d73 with SMTP id nl9-20020a17090b384900b0022c01986d73mr1377446pjb.8.1675720608113;
        Mon, 06 Feb 2023 13:56:48 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id n16-20020a17090a091000b0022bb87344a8sm2625881pjn.55.2023.02.06.13.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:56:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] .gitattributes: include `text` attribute for eol
 attributes
References: <20220216115239.uo2ie3flaqo3nf2d@tb-raspi4>
        <20230203125920.751-1-philipoakley@iee.email>
Date:   Mon, 06 Feb 2023 13:56:47 -0800
In-Reply-To: <20230203125920.751-1-philipoakley@iee.email> (Philip Oakley's
        message of "Fri, 3 Feb 2023 12:59:20 +0000")
Message-ID: <xmqqwn4u4fvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> The standard advice for text file eol endings in the .gitattributes file
> was updated in e28eae3184 (gitattributes: Document the unified "auto"
> handling, 2016-08-26) with a recent clarification in 8c591dbfce (docs:
> correct documentation about eol attribute, 2022-01-11), with a follow
> up comment by the original author in [1] confirming the use of the eol
> attribute in conjunction with the text attribute.
>
> Update Git's .gitattributes file to reflect our own advice.
>
> [1] https://lore.kernel.org/git/?q=%3C20220216115239.uo2ie3flaqo3nf2d%40tb-raspi4%3E.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>
> I was catching up on last year's back emails, and had saved those on
> eol and text conversion, and was prompted by Torsten's [1] to check
> my .gitattribute files, only to discover, we aren't providing a good
> example to others. Let's fix that. 

Thanks.  Let's keep this single step as a pure "no, eol=lf alone is
not how we recommend you to mark a text file, and here is the fix"
change.

There may be other things people might want to do on top of
this change, but they can be done on top.

Will queue.  Thanks.


>
>
>  .gitattributes | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/.gitattributes b/.gitattributes
> index b0044cf272..158c3d45c4 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,17 +1,17 @@
>  * whitespace=!indent,trail,space
>  *.[ch] whitespace=indent,trail,space diff=cpp
> -*.sh whitespace=indent,trail,space eol=lf
> -*.perl eol=lf diff=perl
> -*.pl eof=lf diff=perl
> -*.pm eol=lf diff=perl
> -*.py eol=lf diff=python
> -*.bat eol=crlf
> +*.sh whitespace=indent,trail,space text eol=lf
> +*.perl text eol=lf diff=perl
> +*.pl text eof=lf diff=perl
> +*.pm text eol=lf diff=perl
> +*.py text eol=lf diff=python
> +*.bat text eol=crlf
>  CODE_OF_CONDUCT.md -whitespace
> -/Documentation/**/*.txt eol=lf
> -/command-list.txt eol=lf
> -/GIT-VERSION-GEN eol=lf
> -/mergetools/* eol=lf
> -/t/oid-info/* eol=lf
> +/Documentation/**/*.txt text eol=lf
> +/command-list.txt text eol=lf
> +/GIT-VERSION-GEN text eol=lf
> +/mergetools/* text eol=lf
> +/t/oid-info/* text eol=lf
>  /Documentation/git-merge.txt conflict-marker-size=32
>  /Documentation/gitk.txt conflict-marker-size=32
>  /Documentation/user-manual.txt conflict-marker-size=32
