Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EACC4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 01:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLRBzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 20:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLRBzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 20:55:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E08D2D1
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 17:54:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so9720959pje.5
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D33RWCdKj+IzEn48K7iY19WAGeRjJXeyHaKjSBAKZjc=;
        b=eF6C+cu4pLgew9zVW5h9FSP5MKFf1E72bDPlFVRpxj88J74dV72JuAwV38VLw6mT8J
         1ua6TI9OAXVkns1oNz5d1CRxtg+yNdolpgRkax6QT5QYV6bbnEOdaSnw0xqH98kV4beL
         yw85ZCogL9F2nkkHqES7PIihBYynWf9lrdHGAmkx6vGfpvVzHYeBoTTzLc7E0UVge5Vb
         dOsGkL03bxw6oSotuhLPxXhOhPK/RdrwhOIoFcFfJI8g44y7KIUcQkceyCtOxGuuwWrL
         8QoZvKBz2uh/MIamLtj2qZliEk0fAwUukOcGAu9O01yArx/dF1Wee9EjkyYHhfwttgB0
         yDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D33RWCdKj+IzEn48K7iY19WAGeRjJXeyHaKjSBAKZjc=;
        b=5NeCjwC+okFntsw4hDoDGAt6ye43Uk7Ybzzzqek9SdnSaFX0LXUk+HxYFWjD7JMHDh
         UQVUE6jw5djybAksvZFLIT/3fw2VXI5Zvxpuu5EMxHibhmscCFBh33mttCtg3a1/OF+x
         TRpcrNodIvlMxg92ogVRLAbh78/xk1p0qcE3RmG07g1gyUUiQ/WlY7p9UW470GjAMKFl
         4TlgrSCXHed9in89z13yraJDIS4MKi6vsj0pKhT9vf8N4KPW5D7bPBiFby1uFCNS8mVh
         k7iVy/OoScn+bCDxDC/6vLbTtC58Z6gC8/ofK461yrosqKBshTK+KAHphHS7p3UXHpIS
         clgQ==
X-Gm-Message-State: AFqh2kouZVMaTsWfY+Wa172zbdG5CbNjPiC8lLmNgmNRnMigKIYxMav3
        UU9boUY0wLUHlEBTRvxcIpkmgExM7UbEfA==
X-Google-Smtp-Source: AMrXdXv8cFNfo9d+Dlk8ZAm6rcuwHfIyvodq9iXS8wmh8oDDmMOo0CGac4BtdLohmdzAMf/R1IjIdQ==
X-Received: by 2002:a17:90a:6b06:b0:219:f15d:fe58 with SMTP id v6-20020a17090a6b0600b00219f15dfe58mr3931226pjj.13.1671328498759;
        Sat, 17 Dec 2022 17:54:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090ad80200b00218cd71781csm3435361pjv.51.2022.12.17.17.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 17:54:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>
Subject: Re: [PATCH 1/2] mingw: remove duplicate `USE_NED_ALLOCATOR` directive
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <bc79dfcc4d44e0f006dc64d75a2c7f8a11834229.1670274213.git.gitgitgadget@gmail.com>
Date:   Sun, 18 Dec 2022 10:54:57 +0900
In-Reply-To: <bc79dfcc4d44e0f006dc64d75a2c7f8a11834229.1670274213.git.gitgitgadget@gmail.com>
        (Harshil-Jani via GitGitGadget's message of "Mon, 05 Dec 2022 21:03:32
        +0000")
Message-ID: <xmqq1qoxzdam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harshil-Jani <harshiljani2002@gmail.com>
>
> nedalloc was added to fix the slowness of memory allocator. Here
> specifically for the MSys2 build there seems to be a duplication of
> USE_NED_ALLOCATOR directive.

Yes, if your platform's "uname -S" says "MINGW", your build is done
in a directory with ../THIS_IS_MSYSGIT marker file, and your "uname -R"
does not begin with "1.", then there are two USE_NED_ALLOCATOR=YesPlease
in effect.

> So this patch intends to remove the
> duplicate USE_NED_ALLOCATOR and keeping it only into the MSys2 config
> section so it still uses the nedalloc.

What about other folks whose "uname -S" says "MINGW"?

> Signed-off-by: Harshil-Jani <harshiljani2002@gmail.com>
> ---
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index d63629fe807..377667c4bbc 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -652,7 +652,6 @@ ifeq ($(uname_S),MINGW)
>  	USE_WIN32_IPC = YesPlease
>  	USE_WIN32_MMAP = YesPlease
>  	MMAP_PREVENTS_DELETE = UnfortunatelyYes
> -	USE_NED_ALLOCATOR = YesPlease
>  	UNRELIABLE_FSTAT = UnfortunatelyYes
>  	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
>  	NO_REGEX = YesPlease

The original in a wider context looks like this:

        ifeq ($(uname_S),MINGW)
                ...
                MMAP_PREVENTS_DELETE = UnfortunatelyYes
                USE_NED_ALLOCATOR = YesPlease
                UNRELIABLE_FSTAT = UnfortunatelyYes
                ...
                X = .exe
        ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
                htmldir = doc/git/html/
                ...
                COMPAT_CFLAGS += -D__USE_MINGW_ACCESS
        else
                ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
                        # MSys2
                        ...
                        USE_LIBPCRE = YesPlease
                        USE_NED_ALLOCATOR = YesPlease
                        ifeq (/mingw64,$(subst 32,64,$(prefix)))
                                # Move system config into top-level /etc/
                                ...
                        endif
                else
                        ...
                endif
        endif
        endif

With this patch, a build that has ../THIS_IS_MSYSGIT marker file, or
whose "uname -R" output begins with "1.", will no longer get
USE_NED_ALLOCATOR.  Intended?

Without knowing much about the Windows/MSYS/Git for Windows SDK
ecosystem, it is the inner one that looks duplicated, but the patch
is removing the outer one that helps every platform whose "uname -S"
identifies it as MINGW.

Perhaps that is what the patch meant to do, but then the proposed
log message explains it very differently.  It only talks about the
no-op case.  It does not explain why other folks whose "uname -S"
says MINGW (1) are not broken if this patch suddenly robs NED
allocator from them, and (2) are better off without using NED
allocator.
