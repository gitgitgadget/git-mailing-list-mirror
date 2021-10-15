Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF94C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741E26101E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbhJOMxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbhJOMxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:53:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B779C061766
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:51:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d9so37422519edh.5
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dNuv+oCbAV47Q283wolBl3SntvwAj5C5+6WvGLO96kY=;
        b=TR42sZJFNpDgSVUlrCwJHlHxZm5s/bhwvJ2qypeVZ8hZ2eknwjLRuA0hRN25V3U3kj
         g7V15j+SXh+R8XGDsZzhWefamS+34RSWAws8QPNuFdSRTc/MYeZ4TF5QmB5KKWpYQqSL
         FMfcsE8qsviuEonmXtHQpBpEMgdSKAeLdDy0Ukam9ToNJ+UycHhSwnexNUKCuWd1Fb5h
         mzzoxRvOjsYyZrHhubx+pQ9GxvD22/ogssHV1RYWMECHsaybDNZuYQS5Ic1exxdSDDfs
         YGkxkPVmUzE85fNNAzEC7VN/ew2HbqbxC2j5MMzm8nioLYh0a4gTYOw3uFML1mLyjDaj
         jVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dNuv+oCbAV47Q283wolBl3SntvwAj5C5+6WvGLO96kY=;
        b=tpjXjdsXMj8cc7VfI3mqFN+U12IHrRtb4TEDV23T2RNdBQeox/0fh8pdXBjeuSBOrX
         lBZ/pxFeFJb9/hAed7WHB/BHsUzuGoLyBoq0KDJzeZw5s/OaVPcI7erDgF43v3LUWPwp
         /YQZTehN/AcYY6GaZ7ObyWeA0JHmUbq2YQ9nGRTzamC9nlSGSmP2BtaZzKgI4rwNQcnO
         WyNaNDGxZvvB8j0wTufHsIayVVM9RjGkT3J5SjDLEJorQIKpf8Le7S1qKVbQ9rPldXTj
         Yu04ZpxKNE6xEkh3f7i0FmR86mPVOH4OFemE+XXsqplV+M+RtI0f4ojm8CZtS/rCbp37
         HV3Q==
X-Gm-Message-State: AOAM5307PYSiTLEik3VBjo5Pt83Z5WEenKh/sOSrfixh2QXlSmWHGyy3
        DoR1iCnNQnpcbTg0GkXlW/irFJxmx1Xf8g==
X-Google-Smtp-Source: ABdhPJwOmb0/HHQcQ21cqKGg5qTVuhdJK8jWxw+RLEclKUL76RPBQ/2FojJYfsj9bYQS/mQzpejDTw==
X-Received: by 2002:a50:d8c7:: with SMTP id y7mr17430622edj.133.1634302257949;
        Fri, 15 Oct 2021 05:50:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k3sm4233359ejk.7.2021.10.15.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:50:57 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbMfo-00036y-Uz;
        Fri, 15 Oct 2021 14:50:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        vagabon.xyz@gmail.com, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] archive: rewrite description for compression level
 option
Date:   Fri, 15 Oct 2021 14:46:29 +0200
References: <20211015121336.46981-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211015121336.46981-1-bagasdotme@gmail.com>
Message-ID: <87h7die9jj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 15 2021, Bagas Sanjaya wrote:

> Rewrite the description of `-#` option. Since the option is also
> supported on tar archive, move to OPTIONS section and remove EXTRA.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v1 [1]:
>      - Mention common levels (store-only, fastest time, and best
>        compression).
>      - Note that compression level option is supported by both zip and
>        tar format, so move the description to OPTIONS section.
>
>  [1]: https://lore.kernel.org/git/xmqqpms6akup.fsf@gitster.g/T/#t
>
>  Documentation/git-archive.txt | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index 9f8172828d..9aecc0936c 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -9,7 +9,7 @@ git-archive - Create an archive of files from a named tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
> +'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [-#]
>  	      [-o <file> | --output=<file>] [--worktree-attributes]
>  	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
>  	      [<path>...]
> @@ -65,10 +65,6 @@ OPTIONS
>  	Look for attributes in .gitattributes files in the working tree
>  	as well (see <<ATTRIBUTES>>).
>  
> -<extra>::
> -	This can be any options that the archiver backend understands.
> -	See next section.
> -
>  --remote=<repo>::
>  	Instead of making a tar archive from the local repository,
>  	retrieve a tar archive from a remote repository. Note that the
> @@ -88,17 +84,13 @@ OPTIONS
>  	of the current working directory are included in the archive.
>  	If one or more paths are specified, only these are included.
>  
> -BACKEND EXTRA OPTIONS
> ----------------------
> -
> -zip
> -~~~
> --0::
> -	Store the files instead of deflating them.
> --9::
> -	Highest and slowest compression level.  You can specify any
> -	number from 1 to 9 to adjust compression speed and ratio.
> -
> +-#::
> +	Select the compression level. The supported levels and default
> +	value (if none is selected) are depending on compression command
> +	backend configured for the selected format (either explicitly with
> +	`--format` or inferred from file name specified with `-o`). Common
> +	values are `-0` for only storing files (zip only), `-1` for fastest
> +	compression time, and `-9` for best compression ratio.


This is getting there, but I think we really should not have a -# in the
synopsis, since that's not how we refer to a digit-wildcard in any other
context. And users might assume that a literal -# is meant, some
commonly used tools even support that, e.g. try:

    curl -L -o /dev/null -# https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-11.1.0-amd64-DVD-1.iso

Let's just use "[-<0..9 digit>[", or "[-<digit>]" in the SYNOPSIS and
explain that it's 0..9 below in this section..
