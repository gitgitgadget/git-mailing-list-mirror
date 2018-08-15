Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A501F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbeHOTbW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:31:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37509 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbeHOTbW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:31:22 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so1482691ioh.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kq33cRjaDu6hQavdTe2YFeQLbX2CR+olUzUDYGQx3YU=;
        b=OP3lpSIaG3fP5OhCXJbFQ0plPoVllGwOPRoY5O5NYZfw6GgblBZ+DhwsvrUnOGwxpb
         MIPtxBOHVORpJJz+h+p6+fzruXCcuKjZtuZyXi//Zhs1d6rd+r/5qRjwZ//AGjG+qbk7
         fnTYg5U+6cLNNcuwTQMAu8D8B31fV28nA/WlINvOMIKZ/mojbkUvpVAQ+XxW/Jpe0IcU
         B7gBCxpSw1GKgRHpOPTaBF29mtfmCRX8lndFPalJ1bICLvPp6Gf29sqBtU20UunVKaVN
         vKkADYLa1d+pZX1ympo3L/Tsx1thnJ4wwtscm5EiORUEGS9Wed1wPZZTQO5ZnvD0gIFf
         +OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kq33cRjaDu6hQavdTe2YFeQLbX2CR+olUzUDYGQx3YU=;
        b=MyuDenvnw5FjYr6saKL8cJvnrADZzz7Ip98qYkga1rhahyYVT21xMnQ9frHvFNOmWZ
         9BlkUq/rHvLx5/VcIJNICqdNnkuuu78eDfyzzEq3oONIElr2536j+PcrbvFgYEVNNj0I
         0JyImdFeHOPg4v8HVrnqB6o4qQ5NYx3ZL3TXYDRhwGa0bswV+Eu3JgZ34cQ0B6jwRv3L
         GDIUnk/8flsVFZTXR2mqerZmxgfd4rJGghk25rs1QcrcEwLXntS1f3tD6bCvdLAjuJ6i
         VXylNmIRGLXlvuTcSlmTfnlAGTsAFK84k2SWFos4jvDYmUNqolN8oWi73nI9CLQGrxQ9
         U2Dw==
X-Gm-Message-State: AOUpUlGzPq9mhZ54irYm9K3y7u7xWBMGHTLQje3+HSKzO/TLtCx4kXkr
        q1JOq1AJ/e9FieLndhZf+P4md2UdrO4Fgc07CHY=
X-Google-Smtp-Source: AA+uWPyHl5NKkNX4C6hTJljXfKOT/+UOn/EoYBmYLkoRkwMBPfPUtXZ3CkurWjty5NQxmJTgNCnJLDxzEJymj9RlzcY=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr9122159iok.236.1534351109818;
 Wed, 15 Aug 2018 09:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-4-pclouds@gmail.com> <f3403347-607b-b67c-297c-eeb9190a7de7@gmail.com>
In-Reply-To: <f3403347-607b-b67c-297c-eeb9190a7de7@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 18:38:03 +0200
Message-ID: <CACsJy8BFKzQurH6v-geY_ZJjtwF+S2YnZQA=Q6FajLm=GvHjiw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] unpack-trees: optimize walking same trees with cache-tree
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 8:58 PM Ben Peart <peartben@gmail.com> wrote:
> > +      *
> > +      * D/F conflicts and higher stage entries are not a concern
> > +      * because cache-tree would be invalidated and we would never
> > +      * get here in the first place.
> > +      */
> > +     for (i = 0; i < nr_entries; i++) {
> > +             struct cache_entry *tree_ce;
> > +             int len, rc;
> > +
> > +             src[0] = o->src_index->cache[pos + i];
> > +
> > +             len = ce_namelen(src[0]);
> > +             tree_ce = xcalloc(1, cache_entry_size(len));
> > +
> > +             tree_ce->ce_mode = src[0]->ce_mode;
> > +             tree_ce->ce_flags = create_ce_flags(0);
> > +             tree_ce->ce_namelen = len;
> > +             oidcpy(&tree_ce->oid, &src[0]->oid);
> > +             memcpy(tree_ce->name, src[0]->name, len + 1);
> > +
> > +             for (d = 1; d <= nr_names; d++)
> > +                     src[d] = tree_ce;
> > +
> > +             rc = call_unpack_fn((const struct cache_entry * const *)src, o);
>
> I don't fully understand why this is still necessary since "we detect
> that all trees are the same as cache-tree at this path."  I do know
> (because I tried it :)) that if we don't actually call the unpack
> function the patch fails a bunch of tests so clearly something important
> is being missed.

Yeah because removing this line assumes n-way logic, which most likely
means "use the index version if all trees are the same as the index"
but it's not necessarily true. There could be flags that make n-way
behave differently. And even if we make that assumption, we need to
copy src[0] to o->result (heh I tried that "skip call_unpack_fn" thing
too when I thought this would be the same as the diff-index --cached
optimization path, and only realized copying to o->result was needed
afterwards).
-- 
Duy
