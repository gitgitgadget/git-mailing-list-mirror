Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91311C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbiHSRyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351600AbiHSRxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 13:53:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EFC11C1D
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:31:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s23so2565378wmj.4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=uLsoPxtHkGAsJtZEs2up+e00PSrmdL+7swCZfsCb8TE=;
        b=JwEFJ8eKQq69PVURlnydqGsKO24+MMqe0KlBPpI5eMCX3+foKn7b6nJk7wHZKi4jqp
         MgT73Y+i804xvlmCSu5jep6A2KyyxvQk7njQYmXJbfD5W4lso2x8OdNZQomrzaV3pqW9
         sCOYFv50Ppu04IplL0JwJT2i//tHEzKPG7lZIR9J3jdPI4GjUaTyN3U1kN17/Mx3wYb9
         3M7NaqcEV7bD49i7mv0faS98uIX6HMEz1vRz/VdlMQ9GYpOpFmTOeRjpJKfdv9obrSgw
         8UTXwhgl5nzgsyNBx4hgmWpC0pAMpQwJnmER4L2aJWHF/HZPiCCdiPt89uCvMFoIH7qY
         UwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=uLsoPxtHkGAsJtZEs2up+e00PSrmdL+7swCZfsCb8TE=;
        b=bCjhAkL0bnPOehpCm/sEdXzP4CLHbguEfTmyBTVPO3RVifo8LH+VRpmy8SA8DZoSYQ
         sU9hnn+5xyEyat7J8+wNVvpL+ZPwszil+A9FV4JPpv5Mo2ypKkU6rckmjFRkCKggPRQK
         icyPJ9x/FIaAWKO+PE/QiXwKeVPx1OMNCbEliVCwYaLsMq2tiO9jNRZBFxGPuziqWziB
         u4XJB1F7og/cD+PXRUPvAOW7SwLlDa/kB3ua7YKQoIXyLVurW8fpxSnxaXo+HFkfSHwx
         45brQ/aBTcIieZTTaobO/mDINaKSH97LMEtVE1a2YXr71iNIc4450E1S8yWpWnvmt/Ab
         iKjg==
X-Gm-Message-State: ACgBeo2dllmj5LYkX5Mliras23AlpTJhYMvWWY6420VMsqMtv5oCH4DQ
        Uf1sh2pdHJ5yeSm7/0uCv1XJJOfWwy7FbQ==
X-Google-Smtp-Source: AA6agR71lPRw5rUx7ZeRWcJNMLhASF2eKrR6f4FxJcZbCNPt/va3yJQ8yatALgYDalEXB4RLHhqJcg==
X-Received: by 2002:a05:600c:3b06:b0:3a6:196a:6950 with SMTP id m6-20020a05600c3b0600b003a6196a6950mr7469533wms.69.1660930291847;
        Fri, 19 Aug 2022 10:31:31 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b00225232c03fdsm5161035wrr.27.2022.08.19.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:31:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP5qD-000p72-2b;
        Fri, 19 Aug 2022 19:31:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/20] parse-options: drop leading space from
 '--git-completion-helper' output
Date:   Fri, 19 Aug 2022 19:30:13 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-9-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-9-szeder.dev@gmail.com>
Message-ID: <220819.86fshs6sy6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> subcommands) a tad more complex, so I wanted to test the result.  The
> test would have to account for the presence of that leading space,
> which bugged my OCD, so let's get rid of it.

On the subject of OCD it...

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  parse-options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index a0a2cf98fa..8748f88e6f 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -620,7 +620,8 @@ static int show_gitcomp(const struct option *opts, in=
t show_all)
>  			suffix =3D "=3D";
>  		if (starts_with(opts->long_name, "no-"))
>  			nr_noopts++;
> -		printf(" --%s%s", opts->long_name, suffix);
> +		printf("%s--%s%s", opts =3D=3D original_opts ? "" : " ",
> +		       opts->long_name, suffix);
>  	}
>  	show_negated_gitcomp(original_opts, show_all, -1);
>  	show_negated_gitcomp(original_opts, show_all, nr_noopts);

...bugs me a bit that we have a "suffix" variable, but not a "prefix"
for this, maybe this? We could also make the prefix a "const char
*const" to indicate that we don't modify it in the "for" body:

diff --git a/parse-options.c b/parse-options.c
index edf55d3ef5d..3000121e5c0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -589,6 +589,7 @@ static int show_gitcomp(const struct option *opts, int =
show_all)
 	int nr_noopts =3D 0;
=20
 	for (; opts->type !=3D OPTION_END; opts++) {
+		const char *prefix =3D opts =3D=3D original_opts ? "" : " ";
 		const char *suffix =3D "";
=20
 		if (!opts->long_name)
@@ -620,7 +621,7 @@ static int show_gitcomp(const struct option *opts, int =
show_all)
 			suffix =3D "=3D";
 		if (starts_with(opts->long_name, "no-"))
 			nr_noopts++;
-		printf(" --%s%s", opts->long_name, suffix);
+		printf("%s--%s%s", opts->long_name, prefix, suffix);
 	}
 	show_negated_gitcomp(original_opts, show_all, -1);
 	show_negated_gitcomp(original_opts, show_all, nr_noopts);
