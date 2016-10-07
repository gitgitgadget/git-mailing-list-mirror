Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80B220987
	for <e@80x24.org>; Fri,  7 Oct 2016 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbcJGSao (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:30:44 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36077 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754771AbcJGSan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:30:43 -0400
Received: by mail-qk0-f171.google.com with SMTP id o68so50374867qkf.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ghW/k5YLobkNB3VWrlQoUv/d2Tqbm3KhxMy6Bl8AQpc=;
        b=oHgqlR3wLOn9+xFQYPWL0ldxEduw3MoaIIMbj+sKkqSWnFUvdfFt1EKv/DELxgCxhK
         gztdCAhtxT5zw/QcxLM4wywFrcS24oEjN9newlcBeFDMksDyhVTeKNxN57MoivuoBuxo
         4dXmfTB2fhY1FMGxQvXbNA2xOk22cfklHGY+sPabE2G9DIU4RyKLkX1EUe83g/aZfADV
         VFm/rwnC4/O6xkZK44ASLvPKJlvjcrwbDeH7eqYHd1PuKQdKw6n6wU2l124I1+2K9hsd
         v2beLm39F6K/EQIZOUPe7JzCcxrRpETefla+jnfYHg3ZDXv3rHwCWAkMLwrHe5XLNbmJ
         3LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ghW/k5YLobkNB3VWrlQoUv/d2Tqbm3KhxMy6Bl8AQpc=;
        b=cdRQ0A37by1AhLWab6idZh6SQz6ks7O1Slir4AUMNp9yI4yXJdgjWDLFSEg1b+Z7dD
         L6RDr/th+TZeoMQ/szUeP9+rHikAH/Miv9GP1qxc5SHZfm0gXlNVhBMim9Gr/6ZlUY27
         lW4evHo8sIslub4mSCoGOBla4Ok0P5rZ55q5UGVZFO37J+m/czm9iytDNXD3p2PeYjOX
         lKfxplIB1h8DPZmo1w6Laba7WX+zAjaCap/2iItw5ZYIPElxfNMzoE3VqMCypcE/MBv4
         zLF5Urnq1u+wa2dm5HB4B6VOf98p9IojYnvJsXISRxJMvp11JP5SlRiFqB5a+nncujDC
         c9Vg==
X-Gm-Message-State: AA6/9RnOkyetuiotEJooEbNn5cMZaxKSmyaJvtwYZiNxAqVDuEH8qwVAwsZjFKViC5iCwMsBF3TI4IeauNRsd3me
X-Received: by 10.55.82.195 with SMTP id g186mr20009722qkb.220.1475865042183;
 Fri, 07 Oct 2016 11:30:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 7 Oct 2016 11:30:41 -0700 (PDT)
In-Reply-To: <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net> <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Oct 2016 11:30:41 -0700
Message-ID: <CAGZ79kYZbkXFLABdiQwTLLJ42CnV5OPWA5ESe0VfZLvrkQRWfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] batch check whether submodule needs pushing into
 one call
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 8:06 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> We run a command for each sha1 change in a submodule. This is
> unnecessary since we can simply batch all sha1's we want to check into
> one command. Lets do it so we can speedup the check when many submodule
> changes are in need of checking.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  submodule.c | 63 +++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 34 insertions(+), 29 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 5044afc2f8..a05c2a34b1 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -529,27 +529,49 @@ static int append_hash_to_argv(const unsigned char sha1[20], void *data)
>         return 0;
>  }
>
> -static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
> +static int check_has_hash(const unsigned char sha1[20], void *data)
>  {
> -       if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> +       int *has_hash = (int *) data;
> +
> +       if (!lookup_commit_reference(sha1))
> +               *has_hash = 0;
> +
> +       return 0;
> +}
> +
> +static int submodule_has_hashes(const char *path, struct sha1_array *hashes)
> +{
> +       int has_hash = 1;
> +
> +       if (add_submodule_odb(path))
> +               return 0;
> +
> +       sha1_array_for_each_unique(hashes, check_has_hash, &has_hash);
> +       return has_hash;
> +}
> +
> +static int submodule_needs_pushing(const char *path, struct sha1_array *hashes)
> +{
> +       if (!submodule_has_hashes(path, hashes))

So the above is an implicit lookup already, but we did that before,
too, so it's fine.

> @@ -658,13 +665,11 @@ int find_unpushed_submodules(struct sha1_array *hashes,
>         argv_array_clear(&argv);
>
>         for (i = 0; i < submodules.nr; i++) {
> -               struct string_list_item *item = &submodules.items[i];
> -               struct collect_submodule_from_sha1s_data data;
> -               data.submodule_path = item->string;
> -               data.needs_pushing = needs_pushing;
> -               sha1_array_for_each_unique((struct sha1_array *) item->util,
> -                               collect_submodules_from_sha1s,
> -                               &data);
> +               struct string_list_item *submodule = &submodules.items[i];
> +               struct sha1_array *hashes = (struct sha1_array *) submodule->util;
> +
> +               if (submodule_needs_pushing(submodule->string, hashes))
> +                       string_list_insert(needs_pushing, submodule->string);

That makes sense.

Thanks!
Stefan
