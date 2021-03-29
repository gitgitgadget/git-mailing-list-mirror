Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CDEC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A776191B
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhC2NeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhC2NeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:34:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A7AC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:34:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dm8so14260579edb.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NYODdjiduAjf7cVHXTVZaKbTUE2pwWxk8enoiWG81RU=;
        b=C/ksJbmq1fK+Jwk4pZQkxlfLjVB4XbqAikAIhBtAmviER3cgMPuwnYVGEWke19/J29
         56E7kW+Wi5iSlvAZ9zv+Nh/wSf1Yd2RcdTaXX/3AdS2gzj3m+RZ/pbZs5GzjNYwsvfW9
         dBPEos9RkMMKaaPhPIIFJF4D9Feb60Ir2EFsEpEJb3uYfW80X60LjXhsCCAUk9SILJiU
         nDArvUi0x+gfZt7O+UT33hxOKKM0R0V92unDrrUATmzHqf4xYtJa24LnjdqgHUIXwCLO
         6FBXdXTYxp2xjoTnGff+Cydl1ZL0S3AHr0EpTSlL9dWu8ubqcFeG5jJNGYnMrNh/Ut0m
         Gzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NYODdjiduAjf7cVHXTVZaKbTUE2pwWxk8enoiWG81RU=;
        b=Z+zMNNdv3fVcPasShWzzO/CEk3CLMGnzglG+cDs/qJ6HBtBejNIgZdFRR7e86LAgDC
         cplCN9NVSPBukeY5GqGmpXLppI5Ny9KRRY6m0saO3GCKqfkbR9yWMNDlGAdElSWQRm4P
         G1kZZMLusSG39yYnnDK0eMyD6cRByuRqud+a7LkNH32781Ozzn1ftN/ejVVpH8Xs8fGg
         N9kvkWDfm15xyEnFJET3rlGArdHQiPheOdHhb6KKD3wFVCDYBT3Bm5qwx9xCsJXIJrIY
         e5776xpw/nuaKSyRfUy/07OS7hIeLmOiCI/VOm+Yih005Sknb+qG/S4nngvy7+LRqVmn
         y0eQ==
X-Gm-Message-State: AOAM5323kx2o/aB/MxBZd/o7rIIiwhsLUHOGjTHShl+ClSrBbFGUXpBi
        c93L640USyNsg68UBI63oa7wPFjIO5E=
X-Google-Smtp-Source: ABdhPJznvxVmN2oPGmcO+Vd1edMcHgZBO7D9qRtopIcOKC7pp5c1BG3CiYe3pMhEuoNw8yRTbOyWgw==
X-Received: by 2002:aa7:ca04:: with SMTP id y4mr28416079eds.339.1617024844972;
        Mon, 29 Mar 2021 06:34:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cw14sm9201393edb.8.2021.03.29.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:34:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] improve reporting of unexpected objects
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <YGBL88lYheyFmwCg@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YGBL88lYheyFmwCg@coredump.intra.peff.net>
Date:   Mon, 29 Mar 2021 15:34:03 +0200
Message-ID: <87r1jym6d0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 28 2021, Jeff King wrote:

> On Sun, Mar 28, 2021 at 04:13:30AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (10):
>>   object.c: stop supporting len =3D=3D -1 in type_from_string_gently()
>>   object.c: refactor type_from_string_gently()
>>   object.c: make type_from_string() return "enum object_type"
>>   object-file.c: make oid_object_info() return "enum object_type"
>>   object-name.c: make dependency on object_type order more obvious
>>   tree.c: fix misindentation in parse_tree_gently()
>>   object.c: add a utility function for "expected type X, got Y"
>>   object.c: add and use oid_is_type_or_die_msg() function
>>   object tests: add test for unexpected objects in tags
>>   tag: don't misreport type of tagged objects in errors
>
> I'm somewhat skeptical of the final patch, given my comments (just now)
> in:
>
>   https://lore.kernel.org/git/YGBHH7sAVsPpVKWd@coredump.intra.peff.net/
>
> I'll quote them here:

Picking up where we left off in
http://lore.kernel.org/git/8735wfnv7i.fsf@evledraar.gmail.com ...

>> Because when we call, say, lookup_blob() and find that the object is
>> already in memory as a non-blob, we don't know who the culprit is.
>> Perhaps an earlier part of the code called parse_object(), found that it
>> really is a blob on disk, and used that type. But it may equally have
>> been the case that we saw a reference to the object as a commit, called
>> lookup_commit() on it, and now our lookup_blob() call is unhappy,
>> thinking it is really a commit. In that case, one of those references is
>> wrong, but we don't know which.
>>
>> I think a robust solution would be one of:
>>
>>   - make the message more precise: "saw object X as a commit, but
>>     previously it was referred to as a blob". Or vice versa.
>>
>>   - when we see such a mismatch, go to the object database to say "aha,
>>     on disk it is really a blob". That's expensive, but this is an error
>>     case, so we can afford to be slow. But it does produce unsatisfying
>>     results when it was the earlier lookup_commit() call that was wrong.
>>     Because we have to say "object X is really a blob, but some object
>>     earlier referred to it as a commit. No idea who did that, though!".
>
> Looking at the final patch, I think you side-step the issue to some
> degree because it is only touching the parse_object() code paths, where
> we really have looked at the bytes in the object database. So it
> basically is doing the second thing above (which is "free" because we
> were accessing the odb anyway).
>
> But I think it still has the "oops, somebody made a wrong reference much
> earlier" problem. The actual bug is in some other object entirely, whose
> identity is long forgotten. I think we would be much better off to say
> something like "somebody expected X to be a commit, but now somebody
> else expects it to be a blob", which is all that we can reliably say.
> And the next step really ought to be running "git fsck" to figure out
> what is going on (and we should perhaps even say so via advise()).

Yes I'm totally side-stepping the issue, but I don't see a way around
that that doesn't make the whole object lookup code either much slower,
or more complex.

I.e. the whole thing is an emergent effect of us seeing a tag object,
and noting in-memory that we saw a given OID of type X, but we don't
even know if we can look it up at that point, or that it's not type Y.

I don't think it's guaranteed that we're neatly in one single object
traversal at that point (e.g. if we're looking at N tags, and only later
dereferencing their "object" pointers). So passing a "object A which I
have now says B is a X, assert!" wouldn't work.

We could eagerly get the object from disk when parsing tags (slow?), or
have a void* in the object struct or whatever to say "this is the OID
that claimed you were XYZ" (ew!).

Or, which I think makes sense here, just don't worry about it and error
with the limited info we have at hand. Yes we can't report who the
ultimate culprit is without an fsck, but that's not different than a lot
of other error() and die() messages in the object code now.

So if we're going to emit an advise() that seems generally useful for
many of those error()/die() messages, and not something we should tack
onto this incremental improvement to one error.
