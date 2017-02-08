Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8CDB1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 06:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbdBHGWu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 01:22:50 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34226 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdBHGWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 01:22:49 -0500
Received: by mail-ot0-f196.google.com with SMTP id 73so16970941otj.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 22:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JSWWMaGC1BDytVlj6qOmpVqcsjM0JCFO+rZ9Tu2Z5Cw=;
        b=L2TUIRXciUDY1fJb3DFYkyPvZeDlmOEztAyaxoaIvQf6qWsisCpVBGC6R+yXnXKEgT
         2iHFtA3W+d/8qI7mqzc7hmEc3QKadKfVWXLdq81IGX7XI/hyW5fMIS3jbCcwpxCxXQSw
         aBtQcXsS7vLg0XGEH1MnSCrUK9xwuJij+bNRt4yfChkuupVOrg3vQ0rdDk5+5FDUNTwQ
         WUVAG9kyB9BHRxn+/fA1szD1sSVXfRmdppihcFCb39Z3JouEylPvIPzWI0dki+14kjcw
         YX3oZ8ISCUlm9ocCnHuHZ3l5hoO8/J4uHLuXh3NVDhmYIWsXWNuat4J65WssyslDkBYO
         zxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JSWWMaGC1BDytVlj6qOmpVqcsjM0JCFO+rZ9Tu2Z5Cw=;
        b=YxswUJrJ5H2PQ6gBOTAIrjV7ZMG+xqIZpjR/v38QXlgq40ZpnsEv4KlBqxM4uZ5EkT
         vieDxuCbNwl1WvlWGHk5/2cHeHO/rqhWbjyfw1cI92EiywoFh64saIHASzg3CO5rfgTK
         isHWRkn2mK0WEO2bua0+30zGNpHVGOaRU3ZeQydqY/6LG2YH1Gzw2H9AMirk4Pe5APv3
         VqpbNRFpEDcaKMFiGDflS77RyzL1uZaE2TCYsoMVl+6XODdIgwIG0HCixKhdSjo25cee
         8tLzwI/MjiNqkNx8hohF80okPn2BO4uWixwQCZdEpk7eEPIwRae3LdJb/315eBjSGvvB
         Sg1A==
X-Gm-Message-State: AMke39kBSQUYLkSEIgPA5z9XJiSyOkStyamse2rtiD+ZhWlMP4AIljLdYUNnhcesYosBPwul/e37icI/F/a1HQ==
X-Received: by 10.157.9.214 with SMTP id 22mr9822447otz.128.1486534954049;
 Tue, 07 Feb 2017 22:22:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 22:22:03 -0800 (PST)
In-Reply-To: <73ec9cc7-8a86-8ba9-90fd-a954fa031820@web.de>
References: <73ec9cc7-8a86-8ba9-90fd-a954fa031820@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Feb 2017 13:22:03 +0700
Message-ID: <CACsJy8CE-cyTZHZZhvhdsNau7iSqBci1BdUqDYvxoE5odV2SBA@mail.gmail.com>
Subject: Re: [PATCH] dir: avoid allocation in fill_directory()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 5:04 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Pass the match member of the first pathspec item directly to
> read_directory() instead of using common_prefix() to duplicate it first,
> thus avoiding memory duplication, strlen(3) and free(3).

How about killing common_prefix()? There are two other callers in
ls-files.c and commit.c and it looks safe to do (but I didn't look
very hard).

> diff --git a/dir.c b/dir.c
> index 65c3e681b8..4541f9e146 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -174,20 +174,19 @@ char *common_prefix(const struct pathspec *pathspec=
)
>
>  int fill_directory(struct dir_struct *dir, const struct pathspec *pathsp=
ec)
>  {
> -       char *prefix;
> +       const char *prefix;
>         size_t prefix_len;
>
>         /*
>          * Calculate common prefix for the pathspec, and
>          * use that to optimize the directory walk
>          */
> -       prefix =3D common_prefix(pathspec);
> -       prefix_len =3D prefix ? strlen(prefix) : 0;
> +       prefix_len =3D common_prefix_len(pathspec);
> +       prefix =3D prefix_len ? pathspec->items[0].match : "";

There's a subtle difference. Before the patch, prefix[prefix_len] is
NUL. After the patch, it's not always true. If some code (incorrectly)
depends on that, this patch exposes it. I had a look inside
read_directory() though and it looks like no such code exists. So, all
good.

>
>         /* Read the directory and prune it */
>         read_directory(dir, prefix, prefix_len, pathspec);
>
> -       free(prefix);
>         return prefix_len;
>  }
--=20
Duy
