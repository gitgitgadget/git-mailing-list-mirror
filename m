Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C756C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 09:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbiAKJOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 04:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbiAKJOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 04:14:35 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B5C061759
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 01:14:35 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id bj47so4873874vkb.13
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 01:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xRJlyqEdLY9SXgS2gIOX2fn7pGbxpjuta/SnEioBl4=;
        b=GyTx1VfImYix63qwK7nDlyQ18sFRxNLKH9quO74VVXa/jnc7PCnFiuTlN4TTrbozCO
         seX4Eud0NCdriDckCVY2QYWKhOA6q0jnJPwZXQqaY/ASL8lsMqBEpR3T2wzSyaaZ+Xi+
         iZkRbffnIzt7L7gAagzoTKLK6Fyy/zdYNm4WKm4h2AsAu16+EzHT29DjJeegLWKp9E6W
         OD2b/gO78yR3rFZZkhLJwLjCBxCK/ec9ng/x8TV0VLzFa+x5N6AOSU9Gxa/NuLs4cVkt
         mciSOcNIaS7NLBtiXj0umdQoH589ZA41HPCa7tUh2CpvYrI/wO0Ud8lIuJ5WxqNMxGZM
         5gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xRJlyqEdLY9SXgS2gIOX2fn7pGbxpjuta/SnEioBl4=;
        b=oR7Z9FnZyjK8JobuFiRHuhC2Tc6Tr/f1t2UeZqMxgzkxe/0z8T+OtuCPpy0meF76Rq
         9bBz6s6niqxo6yOnmci+1UKkqL9MuPoKzHkzCFzhw/bcUYtSZ/nPIyFYxCNw86YygMxj
         M5gj0+3fA8Scq9ToUTaoqGIlWbo21xicP6Iun4CtVgXzb3KyEuJy+gq0fyWpFrF6Z3Zj
         8bXO/3/Dz8KsatkubCCuVhLSIkexhJe5kXO8XWrkKHJE5l+BY+0JRfz8OHu3gTAtWasX
         Y53vNMPTIfjGuC3gVF+TBjwopR3TMSbAK7n8/HjxRI3KjqOpf5fH27Y2gDMY24sBrGI4
         oy0w==
X-Gm-Message-State: AOAM531F2IXWWP8+nMBNZ4qoBGw6piK6ZzUjyc0EwC0h4VyiSauOT52J
        eXs9JYv6UlE79mZ4mjno5/FTavUfYyF3yQ0gBDs1GHHGZwpU402yggc=
X-Google-Smtp-Source: ABdhPJy2wM4J6vTHY+w1owFpf6QQ9Svy62SwAHnmzB1Kik1ASS3QY1GfgndUlla0e/wqWS0FTDS9JQ3B1CDKuLHkrGo=
X-Received: by 2002:a05:6122:889:: with SMTP id 9mr1581970vkf.21.1641892474221;
 Tue, 11 Jan 2022 01:14:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641440700.git.dyroneteng@gmail.com> <75503c41a7e2f3fdbb59ce3568853049b55a2d3b.1641440700.git.dyroneteng@gmail.com>
 <xmqq5yqwd266.fsf@gitster.g>
In-Reply-To: <xmqq5yqwd266.fsf@gitster.g>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Tue, 11 Jan 2022 17:14:23 +0800
Message-ID: <CADMgQSQpX2Dn2q9_y7=pat3s-xUtLaO0iVgrOus3-rvUXQReDg@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] ls-tree: optimize naming and handling of "return"
 in show_tree()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyronetengb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 4:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Teng Long <dyroneteng@gmail.com> writes:
>

> What this one is doing sounds more like setting the type variable
> based on the mode bits, and doing only half a job at it.  The name
> "init" does not sound like a good match to what it does.
>
> If we make it a separate function, we probably should add the "else"
> clause to set *type to OBJ_BLOB there, so that the caller does not
> say "we'd assume it is BLOB initially, but tweak it based on mode
> bits".
>
> I.e.
>
>         type = get_type(mode);
>
> where
>
>         static enum object_type get_type(unsigned int mode)
>         {
>                 return (S_ISGITLINK(mode)
>                         ? OBJ_COMMIT
>                         : S_ISDIR(mode)
>                         ? OBJ_TREE
>                         : OBJ_BLOB);
>         }

> or something like that, perhaps?  But I think open-coding the whole
> thing, after losing the "We assume BLOB" initialization, would be
> much easier to follow, i.e.
>
>         if (S_ISGITLINK(mode))
>                 type = OBJ_COMMIT;
>         else if (S_ISDIR(mode))
>                 type = OBJ_TREE;
>         else
>                 type = OBJ_BLOB;
>
> without adding init_type() helper function.
>
> > +     init_recursive(base, pathname, &recursive);
>
> This is even less readable.  In the original, it was clear that we
> only call show_recursive() on a path that is a true directory; we
> now seem to unconditionally make a call to it.  Is that intended?
>
>         Side note.  show_recursive() has a confusing name; it does
>         not show anything---it only decides if we want to go
>         recursive.
>
> At least, losing the "we assume recursive is 0" upfront in the
> variable declaration and writing
>
>         if (type == OBJ_TREE && show_recursive(...))
>                 recursive = READ_TREE_RECURSIVE;
>         else
>                 recursive = 0;
>
> here, without introducing init_recursive(), would make it easier to
> follow.  If we really want to add a new function, perhaps
>
>         recursive = get_recursive(type, base, pathname);
>
> where
>
>         static int get_recursive(enum object_type type,
>                                  struct strbuf *base, const char *pathname)
>         {
>                 if (type == OBJ_TREE && show_recursive(...))
>                         return READ_TREE_RECURSIVE;
>                 else
>                         return 0;
>         }
>
> but I fail to see the point of doing so; open-coded 4 lines here
> would make the flow of thought much better to me.
>
> In any case, I think your splitting the original into "this is about
> type" and "this is about the recursive bit" is a good idea to help
> making the resulting code easier to follow.
>
> > +     if (type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
> > +             return recursive;
>
> We are looking at an entry that is a directory.  We are running in
> recursive mode.  And we are not told to show the directory itself in
> the output.  We skip the rest of the function, which is about to
> show this single entry.  Makes sense.
>
>
> > +     if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
> > +             return !READ_TREE_RECURSIVE;
>
> Negation of a non-zero integer constant is 0, so it is the same as
> the original that returned 0, but I am not sure if it is enhancing
> or hurting readability of the code.  The user of the value, in
> tree.c::read_tree_at(), knows that the possible and valid values are
> 0 and READ_TREE_RECURSIVE, so returning 0 would probably be a better
> idea.  After all, the initializer in the original for the variable
> definition of "retval" used "0", not "!READ_TREE_RECURSIVE".
>
> The name "recursive" is much more specific than the overly generic
> "retval".  Its value is to be consumed by read_tree_at(), i.e. our
> caller, to decide if we want it to recurse into the contents of the
> directory.  I would have called it "recurse" (or even "to_recurse"),
> if I were doing this change, though.

Thanks, will apply in the next patch.
