Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF8C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiGURt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGURt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:49:58 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088DA33A26
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:49:57 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id t9-20020a05683022e900b0061c99c2e074so1084647otc.8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wpfeGkjTx3awVErzpJH5R3ZGlyRC8L63+BU9F6CMfuk=;
        b=crRljKhTkb7StMa09hHZropb8hBbPBa8ObYTBZ22usIINUN/eT1Cc0QbLb3P4tHu/p
         YOIVkGtSNBpWGkGY5CTq/byXqEM2QZevmWdEgcItk66dCsir8vzNxRWbCC76faz1a3IH
         yipC+c9+Aiog44kWID1qD3J6t1c5BAaWFy4X8woH6C+kqxT0xlAqXjPwlj7gUbX28k0w
         SUcRv6b69wWqki2rKBAl9SAgIRvvSvWULUSecXB/KjYzF5UmVxsQ5dM1UbnnvzS3hQeJ
         j4L1814KX3tEEhiPy3wIIQ55DtU1YY7HQN2jrxo9qGgWdRwHtBHALJm/C88fH9MARAtf
         WDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wpfeGkjTx3awVErzpJH5R3ZGlyRC8L63+BU9F6CMfuk=;
        b=aybeTw5B8qOXY6QTzbRHVWxVwAvyoztDkNPi1wChPYPd2dEbaicnF5Wqv3KUWLcNN4
         1iHXLhxwpU4KelzjyuoXTglNUM5urHLgjxchiVOLQ+x5/bBgINXcL/wfuoV5kJAIPWTA
         KnifsSC105BZI+xh1L0rEh4YNbBTh4MKVLaX8zbfrgxnCVbXDFqwayb9PjyvmYttkWUB
         vcYGvmz5E/C8hmg9wFJzHs5oXbEtbM08ExpQHdBBBc0KGljWMjcvrluSY9pXX3zoAFY1
         01UGALxPdf0AtBkwaH4pbUAGiwYz0pCRx8QN43GMlCv7g4bz25wLGTyOdCKI+VIylu24
         TWmA==
X-Gm-Message-State: AJIora+ysRL/0q2/NvQnPCquMj0qLQL3+SQEbggGwmAx4+6j81FsTMYZ
        84AfzS3aEWndmM9iBNggRMdqy88wyfNDSA==
X-Google-Smtp-Source: AGRyM1t2tt0abii9MTvIwUmgakCE3i7qrDEz14iHzkX0v4o16rw7wPN5VSB/OCONoVe7s+kfCjCp2XBAMl5AiA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6808:bd5:b0:337:e765:263c with SMTP
 id o21-20020a0568080bd500b00337e765263cmr5492838oik.102.1658425796441; Thu,
 21 Jul 2022 10:49:56 -0700 (PDT)
Date:   Thu, 21 Jul 2022 10:49:54 -0700
In-Reply-To: <patch-v2-04.24-9fb60485c3e-20220719T204458Z-avarab@gmail.com>
Message-Id: <kl6ledyetkxp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <patch-v2-04.24-9fb60485c3e-20220719T204458Z-avarab@gmail.com>
Subject: Re: [PATCH v2 04/24] submodule--helper: fix most "struct pathspec"
 memory leaks
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

> Call clear_pathspec() at the end of various functions that work with
> and allocate a "struct pathspec".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 115 +++++++++++++++++++++++++-----------
>  1 file changed, 81 insertions(+), 34 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b36919b66c5..28c5fdb8954 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1105,7 +1129,7 @@ static int compute_summary_module_list(struct objec=
t_id *head_oid,
>  	struct strvec diff_args =3D STRVEC_INIT;
>  	struct rev_info rev;
>  	struct module_cb_list list =3D MODULE_CB_LIST_INIT;
> -	int ret =3D 0;
> +	int ret;
> =20
>  	strvec_push(&diff_args, get_diff_cmd(diff_cmd));
>  	if (info->cached)
> @@ -1145,6 +1169,7 @@ static int compute_summary_module_list(struct objec=
t_id *head_oid,
>  	else
>  		run_diff_files(&rev, 0);
>  	prepare_submodule_summary(info, &list);
> +	ret =3D 0;
>  cleanup:
>  	strvec_clear(&diff_args);
>  	release_revisions(&rev);

This function doesn't use a pathspec at all. Was it changed for
consistency reasons or perhaps an accidental inclusion?

All the other hunks look correct.
