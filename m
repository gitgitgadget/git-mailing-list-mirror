Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE7C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E99161351
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 22:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhFQWhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 18:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhFQWhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 18:37:14 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00108C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 15:35:04 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so7824554otl.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HPQaVuKwdlYZElrm6cAbzjOZIsNS+jrE1/JC1lvYJSU=;
        b=cp31pPGgH35Y86++FkHlPn6LvG3J0v0Ev9QQBlv3fUJDmWgE/FoX1Xz0fHUD2tNIiS
         1UIj350yzxRAE/8Ag9hBR4RZ27DFafAKQqYpdVrW6WFZkkQV1rVb4GwimMJwjC6Qt1Oa
         GyCAzWDsChVNlbDi48/wUZ1Sb8lu88xb91GuXbUakWOrbb0PObGJbzirDTybEg9H2NjL
         XmtPKq5mwmL28suxXTOcBfg4PCH1SS95nAZ0u2SJJTet1BIkbwlhPzTlPGa2/cMnhJj2
         tLZ+n5+XQ44/oXGqZfvbGNszTJpheSWU3lBFoUoYn0i+oi0pwLOdsX1Olu7mz4xldLRz
         P1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HPQaVuKwdlYZElrm6cAbzjOZIsNS+jrE1/JC1lvYJSU=;
        b=H6m6Uslu2922ewd2GyjANCnyt5QVGspwx2/nGc45VHRp/zDfbAaPt9k0Y6KEFnYCAg
         UEwEAjGzo2q0+0UNxYosqo7Uls/vXu091uyrgaxnVOgdyiGbJ/EZ0uKTu2jgfZvKLd/t
         XmXCIAQA2KyHl1UxflvLf7IEousQaDTKbHuWAL1Z8YEdaqHofNPXtCcoqDfODrBdYCCF
         PCjANax/JRYgEmp5qClgfjU1XP2QI2lmzZoMIe26eRLBsK8pa0ZV7Rt2wWl3JWM6p+Uq
         Utnahm4eWKLNGXjdIMB7nE510CbmTV5iYKmAeDSixm2qg2gO0HqBGAgtlSb9kupJLexF
         lNMw==
X-Gm-Message-State: AOAM532Jz9LRb4DzPBmSweHvLM+ZKYM7vnsISGzXfOMm761z20pY6bFw
        Um7jzWCfAlDDkSks/Rul1Cs=
X-Google-Smtp-Source: ABdhPJwVzfM3JfGdrw1sPxexL9gnUN7MX0SMWm8cinkKsPZ+TQvovJZnwh3hUtpoE0na2QWgWKt4qA==
X-Received: by 2002:a05:6830:2476:: with SMTP id x54mr2964262otr.312.1623969304355;
        Thu, 17 Jun 2021 15:35:04 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k7sm1427865otf.72.2021.06.17.15.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 15:35:03 -0700 (PDT)
Date:   Thu, 17 Jun 2021 17:35:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60cbce16708c1_37b9208b3@natae.notmuch>
In-Reply-To: <87sg1iyl92.fsf@evledraar.gmail.com>
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
 <20210613225836.1009569-2-felipe.contreras@gmail.com>
 <87sg1iyl92.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 1/4] merge: simplify initialization
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Sun, Jun 13 2021, Felipe Contreras wrote:
> =

> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/merge-file.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> > index 06a2f90c48..0186f4156a 100644
> > --- a/builtin/merge-file.c
> > +++ b/builtin/merge-file.c
> > @@ -28,7 +28,7 @@ int cmd_merge_file(int argc, const char **argv, con=
st char *prefix)
> >  	const char *names[3] =3D { NULL, NULL, NULL };
> >  	mmfile_t mmfs[3];
> >  	mmbuffer_t result =3D {NULL, 0};
> > -	xmparam_t xmp =3D {{0}};
> > +	xmparam_t xmp =3D { .level =3D XDL_MERGE_ZEALOUS_ALNUM };
> >  	int ret =3D 0, i =3D 0, to_stdout =3D 0;
> >  	int quiet =3D 0;
> >  	struct option options[] =3D {
> > @@ -48,10 +48,6 @@ int cmd_merge_file(int argc, const char **argv, co=
nst char *prefix)
> >  		OPT_END(),
> >  	};
> >  =

> > -	xmp.level =3D XDL_MERGE_ZEALOUS_ALNUM;
> > -	xmp.style =3D 0;
> > -	xmp.favor =3D 0;
> > -
> >  	if (startup_info->have_repository) {
> >  		/* Read the configuration file */
> >  		git_config(git_xmerge_config, NULL);
> =

> Looks good, maybe we can fix the similar code in ll_xdl_merge() while
> we're at it?

Yeah, but since code cleanups for the sake of cleaning up are frowned
upon [1] it's not clear how we would get these merged in, since Elijah
has gunned down the obvious fix in patch 4.

Now the cleanups are orphaned.

> Also, not a problem in your commit, but we check for that constant in
> only one place, as:
> =

>     XDL_MERGE_ZEALOUS < level

My mind can't process that, so...

  level > XDL_MERGE_ZEALOUS

> Urgh, do you know if there's some reason we're not doing level =3D=3D
> XDL_MERGE_ZEALOUS_ALNUM, or at least level >=3D XDL_MERGE_ZEALOUS_ALNUM=

> there?

Nope. To the best of my knowledge that's what the code actually meant.

In general the code in xdiff/* seems to be following a very different
style than the rest of git's core.

Cheers.

[1] https://lore.kernel.org/git/xmqqbl87zyra.fsf@gitster.g/

-- =

Felipe Contreras=
