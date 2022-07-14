Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE4C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiGNSUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiGNSUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:20:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1225B799
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:20:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i15-20020a17090a2a0f00b001ef826b921dso1781563pjd.5
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=x6ca5j6W0xuEMQ24Frev7xrT+gU9T6lrILmd7+Q7iLE=;
        b=I/XM8ZtmGNYo/+5pYhWp0SO0L1m5xDjTpY8cluz+QEV8rWgBZ25LSQSMF52IDw/D7H
         VBGKgBo930WE6g+RtFsyq4WgU5vpjt3po64TNBC2LSwBdhkBoaTSn+2nCo/YKqQagEOj
         9ym3XVpg2etrK5VY+nPborLtGkeD9ysoVHAGf29auyC2qlXZboGX5sO3dqZ0rl3J/3xW
         E4RrrMshJyHYOWdKyDxFm8PKB/g4xIa6km1Pkzg7XxRsnySjSV/6ePpqibT8NP7CWno7
         Q3QTGPXC/kSeDIcpw6O/6PaAVvJqgtsx1Q/Mwp2BbPF3cA7PRALoOC88z9YnE7P2ennP
         /+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=x6ca5j6W0xuEMQ24Frev7xrT+gU9T6lrILmd7+Q7iLE=;
        b=a9gn0GnuQO2l4EvUQpmQbhpNBS0vM9ahndUeXalGIJmmyEI2sS6DuGgoEdZcKkMTav
         vtjDa4325t/qIbJCjrDRHpofM4mcPl2s9ItKq+IQymSJVR7d6yJMUHdqpR8fuxilB0Bn
         i+FWClJdkK5FxsPsCr8bJchAf+D+G/CQiA1cwut4Z6c8PG+mabCcIcI66c2z91CXZ/iy
         Yi6xFGTRgPSQ0uRz+V5g/5nhV80LlKoyc48tr2yowte2xqClZkmoEqwqG3/ZTKinD6fr
         X2yo1dz+/MsJDMLJZgNAQ3BIxptUcNYPHBEZoGIBid2gcab9Wg+dWsZOnjvbmwQzon0W
         QUJg==
X-Gm-Message-State: AJIora8NnLIPOfPvskDj4wK/kUERsdC01jkJpfjZqVSWlZ6ZKUcHSEwU
        OYY7Alsu+f97s7KOk+TmudFlP/II318Wqw==
X-Google-Smtp-Source: AGRyM1uJc/iTMIsTkf+RExUi60T+twdQjkgazarqoKKLKW0LBkfTVFZSFukzBaZ0l8H1omtRJuHmr3F+EzodDA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:38cc:b0:1f0:afd4:cb82 with SMTP
 id nn12-20020a17090b38cc00b001f0afd4cb82mr6917363pjb.83.1657822807835; Thu,
 14 Jul 2022 11:20:07 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:20:06 -0700
In-Reply-To: <patch-07.11-f8c20bbf266-20220713T131601Z-avarab@gmail.com>
Message-Id: <kl6lwncf4kvd.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <patch-07.11-f8c20bbf266-20220713T131601Z-avarab@gmail.com>
Subject: Re: [PATCH 07/11] submodule--helper: fix "errmsg_str" memory leak
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Fix a memory leak introduced in e83e3333b57 (submodule: port submodule
> subcommand 'summary' from shell to C, 2020-08-13), to do that stop
> juggling around the "errmsg" and "struct strbuf", let's instead move
> the "struct strbuf errmsg" to the top-level.
>
> Now we don't need to strbuf_detach() it anymore, but we do need to
> ensure that we pass NULL to print_submodule_summary() when we have no
> error message.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a964dbeec38..a05578a7382 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -932,7 +932,8 @@ static void generate_submodule_summary(struct summary=
_cb *info,
>  {
>  	char *displaypath, *src_abbrev =3D NULL, *dst_abbrev;
>  	int missing_src =3D 0, missing_dst =3D 0;
> -	char *errmsg =3D NULL;
> +	char *errmsg;
> +	struct strbuf errmsg_str =3D STRBUF_INIT;
>  	int total_commits =3D -1;
> =20
>  	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
> @@ -1032,7 +1033,6 @@ static void generate_submodule_summary(struct summa=
ry_cb *info,
>  		 * submodule, i.e., deleted or changed to blob
>  		 */
>  		if (S_ISGITLINK(p->mod_dst)) {
> -			struct strbuf errmsg_str =3D STRBUF_INIT;
>  			if (missing_src && missing_dst) {
>  				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and =
%s\n",
>  					    displaypath, oid_to_hex(&p->oid_src),
> @@ -1043,10 +1043,10 @@ static void generate_submodule_summary(struct sum=
mary_cb *info,
>  					    oid_to_hex(&p->oid_src) :
>  					    oid_to_hex(&p->oid_dst));
>  			}
> -			errmsg =3D strbuf_detach(&errmsg_str, NULL);
>  		}
>  	}
> =20
> +	errmsg =3D errmsg_str.len ? errmsg_str.buf : NULL;
>  	print_submodule_summary(info, errmsg, total_commits,
>  				displaypath, src_abbrev,
>  				dst_abbrev, p);
> @@ -1054,6 +1054,7 @@ static void generate_submodule_summary(struct summa=
ry_cb *info,
>  	free(displaypath);
>  	free(src_abbrev);
>  	free(dst_abbrev);
> +	strbuf_release(&errmsg_str);
>  }
> =20
>  static void prepare_submodule_summary(struct summary_cb *info,
> --=20
> 2.37.0.932.g7b7031e73bc

What do you think of getting rid of "char *errmsg" altogether? We can
replace it with errmsg_str.buf and do the length check in
print_submodule_summary():

  diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
  index a964dbeec3..f9f0de7e83 100644
  --- a/builtin/submodule--helper.c
  +++ b/builtin/submodule--helper.c
  @@ -896,7 +896,7 @@ static void print_submodule_summary(struct summary_cb=
 *info, char *errmsg,
    else
      printf(" (%d):\n", total_commits);

  -	if (errmsg) {
  +	if (errmsg && *errmsg) {
      printf(_("%s"), errmsg);
    } else if (total_commits > 0) {
      struct child_process cp_log =3D CHILD_PROCESS_INIT;
  @@ -932,7 +932,7 @@ static void generate_submodule_summary(struct summary=
_cb *info,
  {
    char *displaypath, *src_abbrev =3D NULL, *dst_abbrev;
    int missing_src =3D 0, missing_dst =3D 0;
  -	char *errmsg =3D NULL;
  +	struct strbuf errmsg_str =3D STRBUF_INIT;
    int total_commits =3D -1;

    if (!info->cached && oideq(&p->oid_dst, null_oid())) {
  @@ -1032,7 +1032,6 @@ static void generate_submodule_summary(struct summa=
ry_cb *info,
      * submodule, i.e., deleted or changed to blob
      */
      if (S_ISGITLINK(p->mod_dst)) {
  -			struct strbuf errmsg_str =3D STRBUF_INIT;
        if (missing_src && missing_dst) {
          strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s a=
nd %s\n",
                displaypath, oid_to_hex(&p->oid_src),
  @@ -1043,17 +1042,17 @@ static void generate_submodule_summary(struct sum=
mary_cb *info,
                oid_to_hex(&p->oid_src) :
                oid_to_hex(&p->oid_dst));
        }
  -			errmsg =3D strbuf_detach(&errmsg_str, NULL);
      }
    }

  -	print_submodule_summary(info, errmsg, total_commits,
  +	print_submodule_summary(info, errmsg_str.buf, total_commits,
          displaypath, src_abbrev,
          dst_abbrev, p);

    free(displaypath);
    free(src_abbrev);
    free(dst_abbrev);
  +	strbuf_release(&errmsg_str);
  }

  static void prepare_submodule_summary(struct summary_cb *info,

