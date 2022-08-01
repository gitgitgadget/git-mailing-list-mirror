Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9695AC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 11:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiHALc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 07:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHALc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 07:32:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1830F4B
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 04:32:57 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so8098374fac.7
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuB03W7/XMMrIuHzgAses3dy5/U3HRxziInw2txyhd8=;
        b=Ip9acQCrgFtNFworxS7cNvWvV0yJrF2aiUQsCVUe48w/iQkxC5/eQlS3yGU1DhXR3f
         rWcRAbhXXNWmjGPYdF5ysmBzSzElqPPzw8UPUjOy0WRfWJgkq858oaRlme21l1oI/MwX
         W+G2ff4p45Y3ca2BhR7jsQa5Mx4AQIx72QR8Sj3B4MsCftsOT1bQs86wf9aPuHcVVm5g
         LpVVkmICYqPtFdVghOcUuQGO5ovben5tONulCOKXNy8g66b4Va2/EW+FX1TTO0dCjzRf
         0wL88nqspam9MvKJ9cTrwIgwB1ECdoD/rbmlJMpMVR2r32RzSW+c2dz5pnzeVWEtRWtH
         F4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuB03W7/XMMrIuHzgAses3dy5/U3HRxziInw2txyhd8=;
        b=t/wlsWG/3ewx+sVcl0owsNrUu/HJQZ0w/queIHld8icL1fGzxz0mfk6yjSdfuHT5+g
         UuF8DTs4C8g1mfLSqiqmrJt8QDgiUChHmmgKWELpQye0nmeCdhhAY6hBtE+Oix9+wVg4
         ukXOPweHi0+xLGfMP6X+E9237MyAnYPLSObMYGibKqfwwIFRILQwp7D+UvwHTM57SIax
         GbB+Nu5bxGA8vC/3BjbYLNKi62AnEV7V2J0zIZ2jm6P5oTK5B8gKVq+NKOaHe50i151A
         +yvwYAEkmuzDVOfI8/8/ShXvaF2mdaLG23KC+tE4NhNYO9FraaMxYXpsuQOPBwcR0hHG
         UsEg==
X-Gm-Message-State: AJIora+DEuH7JyK0xZdlSFOX9ceui+9qdgHl63wOTiwwDBsZ2Tp0NB1/
        tve+oLaCyjF/8AnN5f5khhexhSwYM2h1wvl/qEg=
X-Google-Smtp-Source: AGRyM1tukTyKEMS/4nzqAGWy1F5r7HwZtosCYM+khPlfodtrRYd+6qNKayerd63bA5Wlq5xYxcPmGNnjVnUaAjUsppc=
X-Received: by 2002:a05:6870:738d:b0:10d:9757:ff2 with SMTP id
 z13-20020a056870738d00b0010d97570ff2mr7384898oam.251.1659353575822; Mon, 01
 Aug 2022 04:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220729101245.6469-1-worldhello.net@gmail.com> <20220729101245.6469-7-worldhello.net@gmail.com>
In-Reply-To: <20220729101245.6469-7-worldhello.net@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 1 Aug 2022 19:32:44 +0800
Message-ID: <CANYiYbG28jAZ8Kk17h0gkmmU300b1n917oPtBM_WeFX3QN=VXQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] refs: add reflog_info to hold more fields for reflog entry
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 6:12 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> The parameter "msg" of the functions "ref_transaction_add_update()" and
> "refs_update_ref()" is used as a comment for creating a new reflog
> entry. For some cases, like copying or renaming a branch, we may need
> more custom fields for the new reflog entry, such as old-oid which is
> different from the oid we get from the lock file. Therefore, we create
> a new structure "reflog_info" to hold more custom fields for the new
> reflog entry, and add two additional extended version functions.
>
> We will use this extension in a later commit to reimplement
> "files_copy_or_rename_ref()" using "refs_update_ref_extended()" to
> create new reference in a transaction and add proper reflog entry.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  refs.c               | 54 +++++++++++++++++++++++++++++++++++++++-----
>  refs.h               | 20 ++++++++++++++++
>  refs/debug.c         |  2 +-
>  refs/files-backend.c | 14 ++++++++----
>  refs/refs-internal.h | 17 ++++++++++++--
>  5 files changed, 94 insertions(+), 13 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 48b69460e2..e53f011e6b 100644
> --- a/refs.c
> +++ b/refs.c

> @@ -1074,7 +1078,12 @@ struct ref_update *ref_transaction_add_update(
>                 oidcpy(&update->new_oid, new_oid);
>         if (flags & REF_HAVE_OLD)
>                 oidcpy(&update->old_oid, old_oid);
> -       update->msg = normalize_reflog_message(msg);
> +       if (reflog_info) {
> +               update->reflog_info = xmalloc(sizeof(*reflog_info));

Should be:
        update->reflog_info = xcalloc(1, sizeof(*reflog_info));

Will fix in v2.

> +               update->reflog_info->msg = normalize_reflog_message(reflog_info->msg);
> +               if (reflog_info->old_oid)
> +                       update->reflog_info->old_oid = oiddup(reflog_info->old_oid);
> +       }
>         return update;
>  }
