Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CEC1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbdBMVDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:03:15 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37319 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdBMVDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:03:14 -0500
Received: by mail-it0-f49.google.com with SMTP id x75so3398324itb.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 13:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OXxVJC4luLXq/LjBgMrpkAoczuVDiCPqba34G51OceM=;
        b=F/OtlwfMAPjje/mpm50QcyVgrLHUBICvAtZXoz0KDDWv6MlVbgzUqajFxQf7bUJS+n
         PAfCzPgQqERcEmoJPHlWju1t6mpdzsXFZIhViq77foExVG39voXXub36OxELho1gtdKI
         ENZ/1xuk3oWfzSsaXQ8fM/2Nj37QtxQ+L90WlLNVDPCDJ4rqT80Wqie/bw8WY4g/qRvb
         7hvnYzKsb2+oYDSyPJPmnV9GVTpIQwkaS/uxUi0/NKnx6vw9Bvs4UFOp2CslGel6Mq6t
         +Z57l7K4nJEGCvtkYnxYOSB0iAsgFfa8BduwS7IKFulNoVahrdoGcaG3Ux6VYq6yeJYw
         ADYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OXxVJC4luLXq/LjBgMrpkAoczuVDiCPqba34G51OceM=;
        b=INhQSilRSu1fn2YbZvrmRsDQqFyK1j/A++g/Bqbi54QmQgLIEUYzXPN5nyxFdASIfY
         l+AClGdKU+Wb6AvP2UuoZATBsZ7w7uz/5lTZr7oYGRegiYkhoJwQ9hoCVYaRqJUwbT7J
         9V2HKaZoPyEDknQe3+CiLP7PDpg45VrOcEojptbxVaTA/nJMV05T4TqIX8RocwDbKz5j
         /60yn1GGaSM2dVDJJXbhNIybOakp1mCI90FscIxQXxsRi3iTG5XTHUhi2YrjiG4Hw/c5
         dOquZfSb3o7Y2yq3HoYnb9kPJmQJPdTu/0LHXPH1bx2qbH2m+pxjLmJPR2QThXzSq+aw
         L8mA==
X-Gm-Message-State: AMke39n/Mq7fhLLUYeLlQv1OMx42aa18bbD+rUynPwQPgy0x8gq46/igiT4VgjYtk69yVcLSnQci6nYCbmJDkiwb
X-Received: by 10.36.65.4 with SMTP id x4mr308209ita.69.1487019793429; Mon, 13
 Feb 2017 13:03:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Mon, 13 Feb 2017 13:03:12 -0800 (PST)
In-Reply-To: <f2549b5b-b3c8-3935-cdb9-9908914195b6@web.de>
References: <f2549b5b-b3c8-3935-cdb9-9908914195b6@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Feb 2017 13:03:12 -0800
Message-ID: <CAGZ79kapfeEpX5Y5Y5ebBMjePvrXhOM80KQWU4DuLs9=ApRHTw@mail.gmail.com>
Subject: Re: [PATCH] rm: reuse strbuf for all remove_dir_recursively() calls, again
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 11, 2017 at 11:51 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Don't throw the memory allocated for remove_dir_recursively() away after
> a single call, use it for the other entries as well instead.
>
> This change was done before in deb8e15a (rm: reuse strbuf for all
> remove_dir_recursively() calls), but was reverted as a side-effect of
> 55856a35 (rm: absorb a submodules git dir before deletion). Reinstate
> the optimization.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Was deb8e15a a rebase victim?

(I do not recall it off the top of my head)

That commit was merged at 03f25e85,
Merge branch 'rs/rm-strbuf-optim', but it looks
like it was reverted as part of 55856a35b2
(rm: absorb a submodules git dir before deletion)

Looking through the discussion at
https://public-inbox.org/git/xmqqmvfich2e.fsf@gitster.mtv.corp.google.com/
there was no apparent signs of confusion, but a reroll was promised, that
I cannot find on the list.

Anyway, the patch below looks good to me.

Thanks,
Stefan

>
>  builtin/rm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 452170a3ab..fb79dcab18 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -360,15 +360,14 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
>          */
>         if (!index_only) {
>                 int removed =3D 0, gitmodules_modified =3D 0;
> +               struct strbuf buf =3D STRBUF_INIT;
>                 for (i =3D 0; i < list.nr; i++) {
>                         const char *path =3D list.entry[i].name;
>                         if (list.entry[i].is_submodule) {
> -                               struct strbuf buf =3D STRBUF_INIT;
> -
> +                               strbuf_reset(&buf);
>                                 strbuf_addstr(&buf, path);
>                                 if (remove_dir_recursively(&buf, 0))
>                                         die(_("could not remove '%s'"), p=
ath);
> -                               strbuf_release(&buf);
>
>                                 removed =3D 1;
>                                 if (!remove_path_from_gitmodules(path))
> @@ -382,6 +381,7 @@ int cmd_rm(int argc, const char **argv, const char *p=
refix)
>                         if (!removed)
>                                 die_errno("git rm: '%s'", path);
>                 }
> +               strbuf_release(&buf);
>                 if (gitmodules_modified)
>                         stage_updated_gitmodules();
>         }
> --
> 2.11.1
>
