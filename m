Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C246C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 23:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbiEMXHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiEMXHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 19:07:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D63291CC2
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:06:44 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b10-20020a170902bd4a00b0015e7ee90842so5007064plx.8
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=p2YC8QQAZiHdqe/8x5/Yma1wXtgHLUYa6fGT1xSurn4=;
        b=FfiEUV+IsxF3wP1TGqbLImE6FwNCiRSdqrTIjGWOBm24ucVOLyx6a6SzllTa4mR3mv
         gev9uBd99J8agoY9F3INAfRDVWlgfUp+whSFfTw9wINJp8KATVYrVZiF/Pnc9VVnFK/7
         CMNhzEiVfCp0CjILmhmjM4cVtjDZ00b9kyEH+bcIQrDpRSS/haKICEKWGPh0y+X5drCU
         SCyUmoUFendj0YdUN38lR1qmq79P3QgmEPGWMlvA/821zl+iyHPsFI5P8P0DMkXt49/r
         UP+cpLZ2o9zSrAD2ffBpZi/fR/6UreJO9rs9Mji/pZ/e2JmKjkE93Qe1+dgQn5u4xHQa
         J0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=p2YC8QQAZiHdqe/8x5/Yma1wXtgHLUYa6fGT1xSurn4=;
        b=6BnkOL7mHTZa33fDOUyfQh/gJ3VH2hCKlVVMqhwhxiNbRcF/zeYLwd1pwcUaetxmCC
         +8jtV3OLhC55Ku6wNnlfQO3ioxLycbe++Q3ib1WP6JHlv1GuRNYlsTL5IcA8A7S7MWpl
         ys9GEJgyA7G2wTc6MOqMMFnLVwDO10bdmZfAYta0TQ5MLnOYo0Y1W4y/BhCYt52cCoOZ
         2CzSmcgLWuxaDZ2szMIV2PG3/iXz++J9HoJa5t195Ws1yyAIAPNCzpCvnShUYwL28Bo+
         DXX2jKMLEYrouqrydfeKnzP77I/KgDQwzpbw6pJb78ZojGAA5Q8o/bDu1F+zWd8sVJhw
         82lg==
X-Gm-Message-State: AOAM530fu0b9Vm9lZm3WUUdKTr0Ttif+dnUYxhphQwXpk5et69dUqTD3
        sByoEY5rLmYfSKMYFapwS+lUCcpbzeJl5D5CVNoD
X-Google-Smtp-Source: ABdhPJwZe/wdYxy1tGVfw3hiqsLPERhmbQInJuGhjCt2wTPnsVxKZ7AvX/Z3rnwGFgOKa/Xygq7jnbAzEihILKSLuaey
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:eb4d:b0:15e:d25c:4e0a with
 SMTP id i13-20020a170902eb4d00b0015ed25c4e0amr6763328pli.8.1652483203601;
 Fri, 13 May 2022 16:06:43 -0700 (PDT)
Date:   Fri, 13 May 2022 16:06:39 -0700
In-Reply-To: <bcc48004450769410d7e6d8a6e56f08bfa9a02a3.1652458395.git.me@ttaylorr.com>
Message-Id: <20220513230639.1099955-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: Re: [PATCH 2/2] builtin/pack-objects.c: ensure pack validity from
 MIDX bitmap objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        vdye@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> An alternative approach to closing this race would have been to call
> `is_pack_valid()` on _all_ packs in a multi-pack bitmap on load. This
> has a couple of problems:
> 
>   - it is unnecessarily expensive in the cases where we don't actually
>     need to open any packs (e.g., in `git rev-list --use-bitmap-index
>     --count`)
> 
>   - more importantly, it means any time we would have hit this race,
>     we'll avoid using bitmaps altogether, leading to significant
>     slowdowns by forcing a full object traversal

This answers a question I had about why we're only opening the preferred
pack instead of all packs. (You mention in [1] that it's also answered
in that patch message, but I didn't see it.) In any case, it might be
clearer to move this part to the 1st commit.

[1] https://lore.kernel.org/git/Yn63nDhSBIEa3%2F+%2F@nand.local/

> Work around this by calling `is_pack_valid()` from within
> `want_found_object()`, matching the behavior in
> `want_object_in_pack_one()` (which has an analogous call). Most calls to
> `is_pack_valid()` should be basically no-ops, since only the first call
> requires us to open a file (subsequent calls realize the file is already
> open, and return immediately).
> 
> This does require us to make a small change in
> `want_object_in_pack_one()`, since `want_found_object()` may return `-1`
> (indicating "keep searching for other packs containing this object")
> when `*found_pack` is non-NULL. Force `want_object_in_pack_one()` to
> call `is_pack_valid()` when `p != *found_pack`, not just when
> `*found_pack` is non-NULL.

It took me a while to realize that the relevant want_found_object()
invocation that may return -1 is not the one in
want_object_in_pack_one(), but in the latter's caller
want_object_in_pack(). But even in this case, couldn't
want_found_object() return -1 (see the very end of the function) even
before this patch?

> @@ -1424,14 +1427,15 @@ static int want_object_in_pack_one(struct packed_git *p,
>  				   off_t *found_offset)
>  {
>  	off_t offset;
> +	int use_found = p == *found_pack;
>  
> -	if (p == *found_pack)
> +	if (use_found)
>  		offset = *found_offset;
>  	else
>  		offset = find_pack_entry_one(oid->hash, p);
>  
>  	if (offset) {
> -		if (!*found_pack) {
> +		if (!use_found) {
>  			if (!is_pack_valid(p))
>  				return -1;
>  			*found_offset = offset;

My understanding of the purpose of this code change is that if we reach
here with a non-NULL *found_pack, it is likely that *found_pack contains
an invalid pack, and this part overwrites *found_pack (and
*found_offset) if it finds a valid pack. This seems like a good change,
but I don't see how this is a result of something that "does require
us" (as far as I can tell, *found_pack could have already been invalid
before this patch, so the downstream code should already be able to
handle it). Maybe it's just that we couldn't tell if the pack is invalid
previously, but now we can; but if so, it would be better to say "use
this added information to overwrite *found_pack when it makes sense" or
something like that.

(An alternative to the change in this patch may be to reset *found_pack
to NULL when it is found that the pack is invalid, but I haven't
investigated all the callers to see if they can tolerate *found_pack
moving changing non-NULL to NULL, so the change in this patch is
probably more practical.)

Other than that (and the "close(fd)" thing in patch 1 that Junio
mentioned [2]), this series looks good to me. Thanks for noticing and
fixing the bug.

[2] https://lore.kernel.org/git/xmqqpmkh9tye.fsf@gitster.g/
