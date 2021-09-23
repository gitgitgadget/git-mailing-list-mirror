Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D28EC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFD660F48
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbhIWBIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhIWBIA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 21:08:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3635C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:06:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c21so16818971edj.0
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XGg9xW+TxD/I3Kt9O18TXNMwlUPkchnVdOmtyvqff1g=;
        b=hcIuL4S3wyiFLZMLiFven4u4o2wFs9PahJ+36pO+j2XisHhKyIQGygWpatnUzUb6EQ
         1kIU2d6+9AD3KTPNS3WT7teckHJW8PJhdWFqKLrtSy4a2J1Nf9+z56rlWLEknRksU687
         kYA5kzfwWo1TAGe27qKHM4+iu4VUtq4bkjwHlPTCYhkpXb0sEXg+D0ImDSmqPSYEQqsV
         p7NtE2lLw0f1/4DAkh1MgBIZnxGYZiT7xNLR2m/RTSA1452fNDv0L/Ks+4XNG2Wqiisv
         8I8KgVmS+cZFC9k+p91tR2NK++lLYSLetE4uYH/g1I/P13yhpSLG6L1ad1lSQ9qmztV8
         YxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XGg9xW+TxD/I3Kt9O18TXNMwlUPkchnVdOmtyvqff1g=;
        b=ji6H701Kl+hR3qV8/W7ZvwC+DQv4YCGwgt9xrx/jNZeWiC6oRBQesbEQUQZo+hGhGV
         FV7WIfNkvVV/jCtrvs9eGQ/YONoa+Hm2m4rvzWEe96P5LXjJ/PQWqt3a3s4iRDPQBfFN
         U/FwA/9MitTL4hOQXLg7+0zE4fzic6IgHltcCmCdlKlDB3hKO6FD8Ij+M2DgoX4gSifb
         SmL487NL+HsrVO/vUseyx5k0GTwQuW6TQRXGgOCB79hRckzVpsuHPyGLxnxyAjB4alCM
         eDGAaIyPtG8yodCEEhwYQUzCbwtgPgbf99b+uy1QBnPUSgNYvQvySv5udMlQCbqcEC5d
         kzmg==
X-Gm-Message-State: AOAM530mhpQyo/F3ketw7RB20hUnUHsG5Kx09cIzqh98VF9MKTfdmhp3
        RqYHnrt0rIje9le2U3zIurOLinMkrl9+vg==
X-Google-Smtp-Source: ABdhPJzTHoRWzZPLaoyoVUP53BpbYWGNnRwaMOZIblLin6Wt/OuKW516kjnOcc59APY8XDWl9cxDDw==
X-Received: by 2002:a17:907:1de0:: with SMTP id og32mr2297340ejc.348.1632359188128;
        Wed, 22 Sep 2021 18:06:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w11sm2258385edl.12.2021.09.22.18.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:06:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com
Subject: Re: [PATCH] Makefile: avoid breaking compilation database
 generation with DEPELOPER
Date:   Thu, 23 Sep 2021 02:55:36 +0200
References: <20210922183311.3766-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210922183311.3766-1-carenas@gmail.com>
Message-ID: <87tuic5cdo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 3821c38068 (Makefile: add support for generating JSON compilation
> database, 2020-09-03), adds a feature to be used with clang to generate
> a compilation database by copying most of what was done before with the
> header dependency, but by doing so includes on its availability check
> the CFLAGS which became specially problematic once DEVELOPER=3D1 implied
> -pedantic as pointed out by =C3=86var[1].
>
> Remove the unnecessary flags in the availability test, so it will work
> regardless of which other warnings are enabled or if the compilers has
> been told to error on them.
>
> [1] https://lore.kernel.org/git/patch-1.1-6b2e9af5e67-20210922T103749Z-av=
arab@gmail.com/
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9df565f27b..d5c6d0ea3b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1302,7 +1302,7 @@ GENERATE_COMPILATION_DATABASE =3D no
>  endif
>=20=20
>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> -compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
> +compdb_check =3D $(shell $(CC) \
>  	-c -MJ /dev/null \
>  	-x c /dev/null -o /dev/null 2>&1; \
>  	echo $$?)

Sorry about the overlap in
https://lore.kernel.org/git/patch-v2-2.2-6b18bd08894-20210922T220532Z-avara=
b@gmail.com/;
I didn't see this thread before sending my version.

I think your patch here is better than mine. FWIW I also had this on top
of mine, i.e. emitting output to stderr unconditionally:
https://github.com/avar/git/commit/d4bcc0e617e52df803870df29df82aa3b2205d84

But thinking about it again I think with the rationale in that
not-on-list commit of mine the below is better than either of our
versions v1.

I.e. for COMPUTE_HEADER_DEPENDENCIES the point of the test is that we
turn it on automatically, so it needs to not suck by default. The reason
we're doing this is, per the comment in 3821c38068:

    If this variable is set, check that $(CC) indeed supports the `-MJ`
    flag, following what is done for automatic dependencies.

Anyone using GENERATE_COMPILATION_DATABASE is turning it on explicitly,
and I daresay if they're using it at all they're either not using
anything but clang, or is keenly aware of the difference.

So do we really need to carry those 17 lines of the Makefile logic
simply to avoid showing this error on say "CC=3Dgcc
GENERATE_COMPILATION_DATABASE=3Dyes":

    gcc: error: unrecognized command-line option =E2=80=98-MJ=E2=80=99; did=
 you mean =E2=80=98-J=E2=80=99?

It doesn't seem worth it to me, especially as we document that we'll use
the "-MJ" flag in the Makefile comment that the person turning on
GENERATE_COMPILATION_DATABASE=3Dyes must have read.

Anyway, I'll leave you to do what you think is best here, and I'm also
fine with just going for the v1 you've got here, it just seems to me
like we're both fixing logic that's been copy/pasted from
COMPUTE_HEADER_DEPENDENCIES, and the reasons we need it for that
facility don't apply at all to GENERATE_COMPILATION_DATABASE.

-- >8 --
diff --git a/Makefile b/Makefile
index 9df565f27bb..32538f9e858 100644
--- a/Makefile
+++ b/Makefile
@@ -1301,23 +1301,6 @@ ifndef GENERATE_COMPILATION_DATABASE
 GENERATE_COMPILATION_DATABASE =3D no
 endif
=20
-ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
-compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
-	-c -MJ /dev/null \
-	-x c /dev/null -o /dev/null 2>&1; \
-	echo $$?)
-ifneq ($(compdb_check),0)
-override GENERATE_COMPILATION_DATABASE =3D no
-$(warning GENERATE_COMPILATION_DATABASE is set to "yes", but your compiler=
 does not \
-support generating compilation database entries)
-endif
-else
-ifneq ($(GENERATE_COMPILATION_DATABASE),no)
-$(error please set GENERATE_COMPILATION_DATABASE to "yes" or "no" \
-(not "$(GENERATE_COMPILATION_DATABASE)"))
-endif
-endif
-
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ =3D $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX =3D 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SA=
NE_TOOL_PATH_SQ)"|'


