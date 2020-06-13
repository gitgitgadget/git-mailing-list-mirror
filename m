Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D1EC433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602F420792
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 22:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i88r+Q2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFMWEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMWEH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 18:04:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78908C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 15:04:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so8873340eds.7
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 15:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=of1c6Ea3bd93wDpowyc6+356hzUXAn/atZ3a48KE85Y=;
        b=i88r+Q2RN8R3BwfZhV0z78Beh6jHUlNf3GVmEl7kWTP0TyYgkbI3s3bFhEphJALobk
         zpDkv75gy7VkvcTZmpMJ8fsGfZAHt73WInO1tGEVP+0JzRbO3E610eKWEcSdEa4nm4m7
         iZmfqJqLE41QJCqiWp3q7lLkHBm6kiDa6g7M8jiWtaVSrM/kJEAEWyxP4ZRHKXfayWQe
         w3dxRKvCGf+/rVcBA8E+DsXmvb7l3UQ1/OHMfNnUGWY9sADAYNL5KUyOgdHoPQQ74qKm
         +VvYmLJZDz3je+ARJhWnCrzIpsb3V/f2ApviZNxWwPdtHsisfBpKNb1uv+HvD5CiIWuh
         0T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=of1c6Ea3bd93wDpowyc6+356hzUXAn/atZ3a48KE85Y=;
        b=a0IznnZm30h63txfq4nLLIBR1zI8iq00j1KPIkh67eNFX+2Ui9ZUxZ6B99CKIYThfD
         Xg5lJeUJazm0YqNa7RuT/86yhcFQJbVr2ejVVEs262xu2aeiHcuoH7DJujNQyp/VKoZp
         owGbvO9z5FjChXaZBzU+mEGiR3kwbFaw/lnWrmoeLc05VaPMZ+b4BGVI7IyjDb8NccKr
         TKMGAAGwdin8NF+RSztFm+Jm/6DszoGqzkKr5fy/mx0UTqk0AvipqQ2CZzRTHKq4qKXJ
         S8BxwOL/Wh0YiZP4Y76QvsXPlaZeL17GXPnAAEukdVwRJWa2nb0SF3qkayY1f8IG6KaS
         c6Aw==
X-Gm-Message-State: AOAM532isd55pgfavCeVBtjgQsiBSbXi7b5/dSgI3+mOpalq/0FRgKk1
        R5iphChMvGykV5QhJtLbr6lz6Kf28MwXvpQdnT8=
X-Google-Smtp-Source: ABdhPJz2UctNzNdhiGgAVSKt4uWteOG5akbWAOC7hSgTSWZaKsfU2qrxZLGgns136L5OMST8Fq3fmb7g8CFGYW3LtD4=
X-Received: by 2002:aa7:c558:: with SMTP id s24mr16994432edr.237.1592085845697;
 Sat, 13 Jun 2020 15:04:05 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Sun, 14 Jun 2020 00:03:55 +0200
Message-ID: <CAL3xRKfuTbU2SeAUscDwZ2V1qyW4L_n9j7uxiDMat3zd5ZU3uA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/6] stash: mark `i_tree' in reset_tree() const
To:     alban.gruin@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

Thanks for working on this.

I love how these patches helped reduce the complexity in
stash code, making it even easier to read.

On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:

> As reset_tree() does not change the value pointed by `i_tree', and that
> it will be provided with `the_hash_algo->empty_tree' which is a
> constant, it is changed to be a pointer to a constant.

Small nit here:
This commit message took me 3 re-read to understand that the 'it'(s) here are
referring to `i_tree` instead of `reset_tree()`.

Perhaps it would be better to rephrase it a little:

  In reset_tree(), the value pointed by `i_tree' is not modified. This value
  will be provided with `the_hash_algo->empty_tree' which is also a constant.

  Changed 'i_tree' to be a pointer to a constant.

Just a suggestion :-/
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/stash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 0c52a3b849..9baa8b379e 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -228,7 +228,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
>  return do_clear_stash();
>  }
>
> -STATIC INT RESET_TREE(STRUCT OBJECT_ID *I_TREE, INT UPDATE, INT RESET)
> +STATIC INT RESET_TREE(CONST STRUCT OBJECT_ID *I_TREE, INT UPDATE, INT RESET)
>  {
>  INT NR_TREES = 1;
>  STRUCT UNPACK_TREES_OPTIONS OPTS;
> --
> 2.26.2
