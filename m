Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF75C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF96C2072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgNLB8rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKKRCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKRCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:02:39 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99639C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:02:39 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id r11so594880oos.12
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vO5UyiGzbygUsWJ0qsYYFrLrqcJyftGzWiD5cZGjwB4=;
        b=QgNLB8rFHRNYTLx44HG1KrGYgEzieDC4qjKy4TmAGWIbKQ3q4c3th6ib/znnpqlCp5
         YyOleFG2lHnh1ulFWdyQ0eOkP0FB0KpLQOL6s8vUCJkLQjMHaz9iDhSIKfQeW+EiweCf
         jiRWeN531K8DSKBuQX2Cmu5pc3pi5V5ne1N66o8EruxkC9i7Kb5/2MRD1fguE4ht92m7
         stqQqckMwTWq7An/gWV3agEnq2f0QRU9vUxV8hH7YX1IJotxwjZdb2vXFfUVQChzFjuq
         rVhHS5Qofw9YrrZ13q10gwv5CE/hAx7cmsizhcLR/9m1dLOo8pOjeMUjQLhSJlaX7Q2a
         bXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vO5UyiGzbygUsWJ0qsYYFrLrqcJyftGzWiD5cZGjwB4=;
        b=k2qDFtQeBzZRAkbOvIXNELZiGbeQfqs+JvgzC+YC2XXOyrHdZzSByf3gNaNclQo/wO
         9KNKFNMP70iRiECmqra7nM8vDKySu4Iu13MeOwDeeE5uLXNrB1xc9nvqyniJCq5cU9NN
         gTZpCKb7gGfUXoueu9tikm2xsUSIZ1O5jDAQb4DE98WtohMPcdrDzpnj+zlI06T8kQca
         LglrWAxwmOFReGELRDgYJkv5W34L2jpLyPjsD+VXZERwx++kQwe6OcSVMQUdMHWbVgq/
         efMAFAdyn0y4+Jvqq+J6VZaj/a6b24bkoHOZVODowp8o2ASGieh0zMMT+wPNQ2xody/q
         eEpA==
X-Gm-Message-State: AOAM531x/aPgPCK3KewiHcwzJ9I4bt4MWRVC/IdAELEs0Py+QXAW/URf
        lrjW6tLRTLeB2o1aZ/3B7T3HHFP9GQdb1IQJ6H37QK3mlu4GuQ==
X-Google-Smtp-Source: ABdhPJxg+i39dTYySFUeBrhuRnjk42h/rHAE/46t/yrQ+dU7qgX9fSHt1WoPICbFw55etu/zGaROJK9deB+/vemnrAU=
X-Received: by 2002:a4a:9806:: with SMTP id y6mr17948211ooi.45.1605114158757;
 Wed, 11 Nov 2020 09:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-7-newren@gmail.com>
 <42037753-c8c1-629c-3d99-d54842686b2e@gmail.com>
In-Reply-To: <42037753-c8c1-629c-3d99-d54842686b2e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 09:02:27 -0800
Message-ID: <CABPp-BFGs-uMNT3Ge6ZttMTxNEu-S3cdwU74XjNYYent3PQi6g@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] merge-ort: implement a very basic collect_merge_info()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 6:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> > +     /* +1 in both of the following lines to include the NUL byte */
> > +     fullpath = xmalloc(len+1);
> > +     make_traverse_path(fullpath, len+1, info, p->path, p->pathlen);
>
> nit: s/len+1/len + 1/g
>
> > +             void *buf[3] = {NULL,};
>
> This "{NULL,}" seems odd to me. I suppose there is a reason why it
> isn't "{ NULL, NULL, NULL }"?

Probably because I was copying from unpack-trees.c, which deals with a
variable number of trees instead of always exactly 3.  But yeah, it'd
probably be more straightforward as { NULL, NULL, NULL }.

> > +             const char *original_dir_name;
> > +             int i, ret;
> > +
> > +             ci->match_mask &= filemask;
> > +             newinfo = *info;
> > +             newinfo.prev = info;
> > +             newinfo.name = p->path;
> > +             newinfo.namelen = p->pathlen;
> > +             newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
> > +
> > +             for (i = 0; i < 3; i++, dirmask >>= 1) {
>
> This multi-action iterator borders on "too clever". It seems like
> placing "dirmask >>= 1;" or "dirmask = dirmask >> 1;" at the end
> of the block would be equivalent and less jarring to a reader.
>
> I was thinking it doesn't really matter, except that dirmask is not
> in the initializer or sentinel of the for(), so having it here does
> not immediately make sense.
>
> (This has been too much writing for such an inconsequential line
> of code. Sorry.)

Yeah, copied from unpack-trees.c:traverse_trees_recursive().  The
newinfo variable name and a bunch of the surrounding lines were copied
from there too.  I can switch it, though, if it makes it easier.

> > +                     const struct object_id *oid = NULL;
> > +                     if (dirmask & 1)
> > +                             oid = &names[i].oid;
> > +                     buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
> > +             }
>
>
> >  static int collect_merge_info(struct merge_options *opt,
> >                             struct tree *merge_base,
> >                             struct tree *side1,
> >                             struct tree *side2)
> >  {
> > -     /* TODO: Implement this using traverse_trees() */
> > -     die("Not yet implemented.");
> > +     int ret;
> > +     struct tree_desc t[3];
> > +     struct traverse_info info;
> > +     char *toplevel_dir_placeholder = "";
>
> It seems like this should be "const char *"
>
> > +     init_tree_desc(t+0, merge_base->buffer, merge_base->size);
> > +     init_tree_desc(t+1, side1->buffer, side1->size);
> > +     init_tree_desc(t+2, side2->buffer, side2->size);
>
> More space issues: s/t+/t + /g

In my defense:

$ git grep init_tree_desc.*t.*\+ | grep -v merge-ort
builtin/merge.c: init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
builtin/read-tree.c: init_tree_desc(t+i, tree->buffer, tree->size);
merge-recursive.c: init_tree_desc_from_tree(t+0, common);
merge-recursive.c: init_tree_desc_from_tree(t+1, head);
merge-recursive.c: init_tree_desc_from_tree(t+2, merge);
merge.c: init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);

None of which blames to me.  :-)

I can fix it up, though...at least the merge-ort one.  Someone else
can go through existing code if they so desire.

> I'm only really able to engage in this at a surface level, it
> seems, but maybe I'll have more to say as the implementation
> grows.

It _might_ be helpful to compare to unpack-trees.c's unpack_callback()
and traverse_trees_recursive(), but there's so much unrelated stuff
there that it's possible that just gets in the way more than it helps.
Regardless, thanks for taking a look and spotting little fixes; every
bit helps.
