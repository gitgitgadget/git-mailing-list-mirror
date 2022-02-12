Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B2AC433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiBLOb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:31:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBLObz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:31:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED864B0B
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:31:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s7so20557071edd.3
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=929BqBwUrZMPif7XXFfAOhZxW+vUbgD7g1yyaWGqhJY=;
        b=XmVD82j3hoHet9kpxoq9kUo+VGFvXPWrZNy3mvbOral4c5bcu1BkyrMpKqq0qFk7ui
         Du1HPmKoWvCxFqpFe2imuppEZb7MS5uKodLouz0wPsoOQJ3WqsM/kyqzJhyM5p6LwyM3
         KVlQwY+SGqYPcBa1d/C8aZY0WYHNLn5tEyQscV+ug5OLhZI56J+3qenZaiXS2UMMCwcK
         E5zl9A2HSOuVcokZtiUUnYS+0VSr/DFQ5VsoJiR2oW3Oa7FxXFmbuseh7Fio32IIdSg+
         AhW9tP+0AGds2iop2OgLyb52A0n3gLh5A92yJdgMFOOjnRfHnVsQPA/FsRApjvdXGhSH
         pEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=929BqBwUrZMPif7XXFfAOhZxW+vUbgD7g1yyaWGqhJY=;
        b=wwgJcCcZDlEj8Xzb6K57Ke4kY7rKNu89Neu83ZEW710FHtbEl7BGLzC2Mc3kqU8lYj
         3JbHxVcNVLGmOjQqH6vK5hsApA+HbLdCX6UPoe20OkCjsm6CiciLweSWKdTx5cFXWtta
         d2E28k+f9su3bnv3gJ3VYxvesVhQNyhnAeNJiZUuo9cODWisLEEHBQRBfvS0EPFah7yS
         aio1bgNGnFvRTk/5nc1sSmFADMxxllPkxgh13dt0TZfqmzrVmOHvWXp2swtU9TD8B4cg
         vlQDJjGnWmE6J0Q64nR1LCoqfO4/E6/6AqaKpFxTrbsC9fHZMV/RKIeiXoXmId+MqOAk
         9OpQ==
X-Gm-Message-State: AOAM531BwBne+ipdSVsZzdIweUY+k8YjQenZBvwIuzYgpqP/i4+CwrUC
        iS2G+V8DGhCQMZg/xj9AvcOfaE4yqUWaDw==
X-Google-Smtp-Source: ABdhPJxIgq0YyUiuzrtAQ38CjHsWk3VHBzenRWwcr5XDSfokwOFhIhekw3Hvj4dbnSx6jNv7CtWamA==
X-Received: by 2002:aa7:c3da:: with SMTP id l26mr3743256edr.294.1644676308128;
        Sat, 12 Feb 2022 06:31:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g2sm12426135edt.44.2022.02.12.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:31:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItRC-000RRw-Qz;
        Sat, 12 Feb 2022 15:31:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 03/20] submodule--helper: allow setting superprefix
 for init_submodule()
Date:   Sat, 12 Feb 2022 15:30:51 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-4-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-4-chooglen@google.com>
Message-ID: <220212.8635koyx4d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> From: Atharva Raykar <raykar.ath@gmail.com>
>
> We allow callers of the `init_submodule()` function to optionally
> override the superprefix from the environment.
>
> We need to enable this option because in our conversion of the update
> command that will follow, the '--init' option will be handled through
> this API. We will need to change the superprefix at that time to ensure
> the display paths show correctly in the output messages.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/submodule--helper.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5efceb9d46..09cda67c1e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -606,18 +606,22 @@ static int module_foreach(int argc, const char **ar=
gv, const char *prefix)
>=20=20
>  struct init_cb {
>  	const char *prefix;
> +	const char *superprefix;
>  	unsigned int flags;
>  };
>  #define INIT_CB_INIT { 0 }
>=20=20
>  static void init_submodule(const char *path, const char *prefix,
> -			   unsigned int flags)
> +			   const char *superprefix, unsigned int flags)
>  {
>  	const struct submodule *sub;
>  	struct strbuf sb =3D STRBUF_INIT;
>  	char *upd =3D NULL, *url =3D NULL, *displaypath;
>=20=20
> -	displaypath =3D get_submodule_displaypath(path, prefix);
> +	/* try superprefix from the environment, if it is not passed explicitly=
 */
> +	if (!superprefix)
> +		superprefix =3D get_super_prefix();
> +	displaypath =3D do_get_submodule_displaypath(path, prefix, superprefix);
>=20=20
>  	sub =3D submodule_from_path(the_repository, null_oid(), path);
>=20=20
> @@ -691,7 +695,7 @@ static void init_submodule(const char *path, const ch=
ar *prefix,
>  static void init_submodule_cb(const struct cache_entry *list_item, void =
*cb_data)
>  {
>  	struct init_cb *info =3D cb_data;
> -	init_submodule(list_item->name, info->prefix, info->flags);
> +	init_submodule(list_item->name, info->prefix, info->superprefix, info->=
flags);
>  }
>=20=20
>  static int module_init(int argc, const char **argv, const char *prefix)

Note/nit on existing (pre this series) code, I wonder why we ended up
with this init_submodule() v.s. init_submodule_cb() indirection,
v.s. just doing:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 09cda67c1ea..aa82abeb37a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -611,9 +611,14 @@ struct init_cb {
 };
 #define INIT_CB_INIT { 0 }
=20
-static void init_submodule(const char *path, const char *prefix,
-			   const char *superprefix, unsigned int flags)
+static void init_submodule_cb(const struct cache_entry *list_item, void *c=
b_data)
 {
+	const char *path =3D list_item->name;
+	struct init_cb *info =3D cb_data;
+	const char *prefix =3D info->prefix;
+	const char *superprefix =3D info->superprefix ? info->superprefix :
+		get_super_prefix();
+	unsigned int flags =3D info->flags;
 	const struct submodule *sub;
 	struct strbuf sb =3D STRBUF_INIT;
 	char *upd =3D NULL, *url =3D NULL, *displaypath;
@@ -692,12 +697,6 @@ static void init_submodule(const char *path, const cha=
r *prefix,
 	free(upd);
 }
=20
-static void init_submodule_cb(const struct cache_entry *list_item, void *c=
b_data)
-{
-	struct init_cb *info =3D cb_data;
-	init_submodule(list_item->name, info->prefix, info->superprefix, info->fl=
ags);
-}
-
 static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct init_cb info =3D INIT_CB_INIT;

Maybe it's worth it to declare the variables in the argument list
v.s. the function.
