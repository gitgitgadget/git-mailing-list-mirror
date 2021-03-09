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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2EEC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EB065239
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCIQou (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCIQoS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:44:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBA8C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:44:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id l7so9852003pfd.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IZcSDR3YOtWDBltcCXwn1kxvI8Q6q/CvpHzd5h1Hdh0=;
        b=jJkMnbJYeTqT8wCLeCHNv2O/hjTr9Pr0xDp+CI8r9+xsZ54dQePUAlj611wDCa0djz
         hFUjL+0Ct5gPEWiCn0rcMQOEVHJfqgw7a+ONF+MtLE9UgsU04M0I9MZ+qRpg+YqPDxXe
         pAaqsNVIbr8uPNBHzZ1rjccZTi165FkMkryj9bGAcbBX0EzHvfl2yWc+SZt4QSniM6EM
         fboxyLzb23r0d4z7ybvljO2nRqBA9Yh14FoAa3MDMO2P3CApN1mHiIqtR8d5e0xD5rZ5
         X/REPjcKQdLtckosPlvgrFzkRsAEpJFHF6zBQdPLCfeX1ipvmrdP04qPgSyHKSxwZyk3
         DxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IZcSDR3YOtWDBltcCXwn1kxvI8Q6q/CvpHzd5h1Hdh0=;
        b=Bju3Izi/txHH4N3v3IvciQKIP8a6oZy9SWfK7beUKzzUIs01Fep3MuZ3wIwwI2uWbi
         VQyEU59/usbw0eAq5PIRQhqQ1cTObySUv6FLimGgOzeD8qiVPhCwOtfrf+DiUQN/WIWo
         /d08Xgl2F2NTXZe4E3ZboXRSwR/kZ4pNQk+p5TfVr+qAS2SOVTyZ7I3NsQhryFgzqD7K
         uFc8xkfwarTaEMvgSEbXQoSeB0+RwtuEmjt7b5kPKQxEXzGSW90XTCmQS5+RhfwOrTf4
         12b7MnE4oTNFq4BcZ3LdZtWzRNrlXYSMKKyg/tu0YsPv5EXMX+/4jukyid6F/4vLw/wo
         3+hw==
X-Gm-Message-State: AOAM531OkBbGm3tPAuPUfhWr2l+HsIr+++BwPLMJMuLa5LY1ujpFm0Lj
        GQKSHRXjyp6QsPN8e4Fq2Gq+u7fPMn2TDWb30Gw=
X-Google-Smtp-Source: ABdhPJx3haXo1vbZynbyn3fkP5nXYajcHzXG7ByDWwsPvVYOWwhatHABUKFJ/xQQ9BtXjlZYXXV4fE20BVRWCtMCpiU=
X-Received: by 2002:a63:1350:: with SMTP id 16mr25600281pgt.85.1615308257967;
 Tue, 09 Mar 2021 08:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-6-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-6-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 08:44:02 -0800
Message-ID: <CABPp-BG2Odp9J+nSRoKXQEaThjoyd62-PVPB4=OBikx0d3jueA@mail.gmail.com>
Subject: Re: [PATCH 05/30] tree-walk.c: migrate to using new "object_type"
 field when possible
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  tree-walk.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index b210967b73b..6e9161901d8 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -521,7 +521,7 @@ int traverse_trees(struct index_state *istate,
>                         if (!entry[i].path)
>                                 continue;
>                         mask |=3D 1ul << i;
> -                       if (S_ISDIR(entry[i].mode))
> +                       if (entry[i].object_type =3D=3D OBJ_TREE)
>                                 dirmask |=3D 1ul << i;
>                         e =3D &entry[i];
>                 }
> @@ -892,8 +892,8 @@ static int match_entry(const struct pathspec_item *it=
em,
>                  * nothing else (to handle 'submod/' and 'submod'
>                  * uniformly).
>                  */
> -               if (!S_ISDIR(entry->mode) &&
> -                   (!S_ISGITLINK(entry->mode) || matchlen > pathlen + 1)=
)
> +               if (entry->object_type !=3D OBJ_TREE &&
> +                   (entry->object_type !=3D OBJ_COMMIT || matchlen > pat=
hlen + 1))
>                         return 0;
>         }
>
> @@ -1038,7 +1038,7 @@ static enum interesting do_match(struct index_state=
 *istate,
>                     ps->max_depth =3D=3D -1)
>                         return all_entries_interesting;
>                 return within_depth(base->buf + base_offset, baselen,
> -                                   !!S_ISDIR(entry->mode),
> +                                   entry->object_type =3D=3D OBJ_TREE,
>                                     ps->max_depth) ?
>                         entry_interesting : entry_not_interesting;
>         }
> @@ -1071,7 +1071,7 @@ static enum interesting do_match(struct index_state=
 *istate,
>
>                         if (within_depth(base_str + matchlen + 1,
>                                          baselen - matchlen - 1,
> -                                        !!S_ISDIR(entry->mode),
> +                                        entry->object_type =3D=3D OBJ_TR=
EE,
>                                          ps->max_depth))
>                                 goto interesting;
>                         else
> @@ -1094,7 +1094,8 @@ static enum interesting do_match(struct index_state=
 *istate,
>                                  * Match all directories. We'll try to
>                                  * match files later on.
>                                  */
> -                               if (ps->recursive && S_ISDIR(entry->mode)=
)
> +                               if (ps->recursive &&
> +                                   entry->object_type =3D=3D OBJ_TREE)
>                                         return entry_interesting;
>
>                                 /*
> @@ -1105,7 +1106,7 @@ static enum interesting do_match(struct index_state=
 *istate,
>                                  * be performed in the submodule itself.
>                                  */
>                                 if (ps->recurse_submodules &&
> -                                   S_ISGITLINK(entry->mode) &&
> +                                   entry->object_type =3D=3D OBJ_COMMIT =
&&
>                                     !ps_strncmp(item, match + baselen,
>                                                 entry->path,
>                                                 item->nowildcard_len - ba=
selen))
> @@ -1154,7 +1155,8 @@ static enum interesting do_match(struct index_state=
 *istate,
>                  * character.  More accurate matching can then
>                  * be performed in the submodule itself.
>                  */
> -               if (ps->recurse_submodules && S_ISGITLINK(entry->mode) &&
> +               if (ps->recurse_submodules &&
> +                   entry->object_type =3D=3D OBJ_COMMIT &&
>                     !ps_strncmp(item, match, base->buf + base_offset,
>                                 item->nowildcard_len)) {
>                         strbuf_setlen(base, base_offset + baselen);
> @@ -1170,7 +1172,7 @@ static enum interesting do_match(struct index_state=
 *istate,
>                  * in future, see
>                  * https://lore.kernel.org/git/7vmxo5l2g4.fsf@alter.siame=
se.dyndns.org/
>                  */
> -               if (ps->recursive && S_ISDIR(entry->mode))
> +               if (ps->recursive && entry->object_type =3D=3D OBJ_TREE)
>                         return entry_interesting;
>                 continue;
>  interesting:
> @@ -1193,7 +1195,7 @@ static enum interesting do_match(struct index_state=
 *istate,
>                          * can probably return all_entries_interesting or
>                          * all_entries_not_interesting here if matched.
>                          */
> -                       if (S_ISDIR(entry->mode))
> +                       if (entry->object_type =3D=3D OBJ_TREE)
>                                 return entry_interesting;
>
>                         strbuf_add(base, entry->path, pathlen);
> @@ -1269,7 +1271,7 @@ enum interesting tree_entry_interesting(struct inde=
x_state *istate,
>                 return positive;
>
>         /* #15, #19 */
> -       if (S_ISDIR(entry->mode) &&
> +       if (entry->object_type =3D=3D OBJ_TREE &&
>             positive >=3D entry_interesting &&
>             negative =3D=3D entry_interesting)
>                 return entry_interesting;
> --
> 2.31.0.rc0.126.g04f22c5b82

To me, this commit shows the advantage of the new field; the new code
looks much more readable.
