Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2F2C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 13:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbiC3NUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345012AbiC3NUt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 09:20:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F33335D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 06:19:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id pv16so41520311ejb.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bSJ2J6EhK2WvD6B6UUFzO1MAGqWwMYBRYQwFYMcGCUI=;
        b=pb/lUYvhpGwsZXxeXf2lfMHhvhu6F9GEy96CNnPK4Pk1eYUCO9QzpU1bQ06CsXf1Wq
         UFKB6bOyoE/34Caras0RjeZNZgFAzGXJ/nXDaMNRATBSd0jujvN2KCItfgsPlS64xX97
         6ofQMAln0o65mWT7cfHzReYcm1sQnFGNlNYmeUW3mEyosZgL2rYX2peslkPkRd5T9oKL
         VkUv/GuZOFAm8hTrUTxkiAe/TaqemECDULIB7dJO3foKp+oD1YQwBVs3Kz7wZrUR0YJU
         EJKzTFBu+3wjBV0M2sSlAwVfUQ0yJbMJX+73bqA9qco23O7ooRkiufqlwcg22Wg3/KUk
         q1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bSJ2J6EhK2WvD6B6UUFzO1MAGqWwMYBRYQwFYMcGCUI=;
        b=EozEKYtwWEFjwHO8TLLok3RmSO+MY3ORBj6S5rApdKflvMbBPo1GXPrZCsNe/Uu+e4
         6as0gzNqi/O8uzW+hl87b+XzNUufIihb2gC3PENP/TIUtD7i+9cwKfKZ4xci5WKt609u
         k2XUwboF6i40phrwZl6z0xDAJD1NJVYFi265iephxIDmm3NS2IWkITrBGrClrZHN1E1V
         nk59NlA0hRYvI6xtLXS13Gt09bd7lKofX6VWx3ouf/zJyqLutT2Jby5dCALH9LCNF6BU
         UbKMIhKHGxd9g3AYgXfnf3UnpMWnyCuZIO8cXKeKM6mQ5XkNVjXj24/ERbNFDMLfCAFh
         1hPQ==
X-Gm-Message-State: AOAM531WlArybSVMJXPDlX6ZT33wiShc6nvSq9Q0efkz1YTrgu6T9TIC
        yoXhbxQ27XXWIFpmMt2F+Xe85UNyuehoxg==
X-Google-Smtp-Source: ABdhPJwv+MYnztAlymBQa3MEDmghyWMJDkH36G+n455C9D3Fixhfi1iuISf59sDxuj61hKXBpYg5Ug==
X-Received: by 2002:a17:906:6a1e:b0:6e0:5c27:a184 with SMTP id qw30-20020a1709066a1e00b006e05c27a184mr26325810ejc.355.1648646342681;
        Wed, 30 Mar 2022 06:19:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id eg6-20020a056402288600b0041919c78082sm9890191edb.87.2022.03.30.06.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:19:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZYE1-004H4Y-Ag;
        Wed, 30 Mar 2022 15:19:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     me@ttaylorr.com, derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: Teng Long
Date:   Wed, 30 Mar 2022 15:17:44 +0200
References: <YkPGq0mDL4NG6D1o@nand.local>
 <20220330073230.61358-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220330073230.61358-1-dyroneteng@gmail.com>
Message-ID: <220330.868rsrpohm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Teng Long wrote:

> On Tue, 29 Mar 2022 22:55:39 -0400, Taylor Blau wrote:
>
>> You're right; open_pack_bitmap_1() doesn't need to care about whether or
>> not bitmap_git->midx is or isn't non-NULL, since:
>> 
>>   - if we did open a MIDX bitmap (which we will always attempt first
>>     before trying to open single-pack bitmaps), then we won't even
>>     bother to call open_pack_bitmap() at all.
>> 
>>   - if we _do_ end up within open_pack_bitmap_1(), then we _know_ that
>>     no MIDX bitmap could be found/opened, so there is no need to check
>>     in that case, either.
>> 
>> So I think we realistically could do something like:
>> 
>> --- 8< ---
>> 
>> diff --git a/pack-bitmap.c b/pack-bitmap.c
>> index 97909d48da..6e7c89826d 100644
>> --- a/pack-bitmap.c
>> +++ b/pack-bitmap.c
>> @@ -387,3 +387,3 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>> 
>> -  if (bitmap_git->pack || bitmap_git->midx) {
>> +  if (bitmap_git->pack) {
>>       /* ignore extra bitmap file; we can only handle one */
>> 
>> --- >8 ---
>> ...but having the conditional there from the pre-image doesn't hurt,
>> either, and it makes the error clearer in case of an accidental
>> regression where we start looking for single-pack bitmaps after
>> successfully opening a multi-pack one.
>
> I agree with the "accidental regression", it's a protection without
> any disadvantages so far. So, if we don't remove the "bitmap_git->midx"
> condition for some robust reason, then I think maybe we can let the
> warning more detailed if the "accident" happens, like:
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 91a6be358d..e64a85bc59 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -333,7 +333,15 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>                 struct strbuf buf = STRBUF_INIT;
>                 get_midx_filename(&buf, midx->object_dir);
>                 /* ignore extra bitmap file; we can only handle one */
> -               warning("ignoring extra bitmap file: %s", buf.buf);
> +               warning("%signoring extra bitmap file: %s",
> +                       bitmap_git->pack ?
> +                               xstrfmt("A non-MIDX bitmap has been opened: %s, ",
> +                                       bitmap_git->pack->pack_name) :
> +                       bitmap_git->midx ?
> +                               xstrfmt("A MIDX bitmap has been opened : %s, ",
> +                                       midx_bitmap_filename(bitmap_git->midx)) :
> +                                     "",
> +                       buf.buf);
>                 close(fd);

Aside from any bitmap-specific issues, let's not compose messages like
that via concat, it makes them harder to translate.

In this case the original message doesn't have _(), but looking at the
context that seems to be a simple omission.

It's more verbose, but it's better to split this out into 3x warning()
calls.

It also has the advantage of not leaking memory from the xstrfmt().
