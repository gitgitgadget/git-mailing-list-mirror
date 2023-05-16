Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241A5C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 03:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjEPDH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 23:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEPDHV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 23:07:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468461B6
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:06:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso15558047e87.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684206412; x=1686798412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68bSbryPID17/LNrgrwQdPGk/Pgyd3xlaq4my16FV9U=;
        b=bvuluAbNI8r6a2meSx/lAc6KQEm+2xM8s2vr8wCmZ0lKoD/+ewvMc4hAxhAe42dojx
         s5S4CWz6UYzLiujSVznID1J/QYgaMXi78cEolFl/q0U+MsC5KiRZVieseybQ4P0pOE5x
         RTnrskteem6U2VJ9KnuOX4nJTbK/3z6NDdn9YcAr7ecKaz7hqmcOuoUgfRvPy+CQLsKB
         DlCC3XWIEHUWlcYTCD5UrEmjwtvtJx293ixmGvGhcXDtVuaqlwbt3/ROShIFyej5N9EM
         +I85/2CjQ4zWtXUMul7UDKZBdrcWe/2cZjoFRFPNhEJKcmNEJBkBFY9XCA3jfpDyQ+qT
         HKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684206412; x=1686798412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68bSbryPID17/LNrgrwQdPGk/Pgyd3xlaq4my16FV9U=;
        b=Gw9ix2r6Qh34nsmBd8tyXb77i6onu057X+pjrG/Pwb3wvdpnU6ANNRVlLvC+yv7J5N
         c467vzfuKA+sKF/A7XGN021SXp3PM3mnHMDtt8Y+kpGz1cfTEg74rxWR4lcyYMAnthWg
         wO4O42pgsb9JLasTMpFhk1uv7luTzQTCLE4NxgCfbnDAtzHjFsR+PY1GuwDsEFAvTHv3
         qcJndjcoeYNh+nWaL+WMh/u3iIo8zxwDW0E3hH981hK7B3h2G5Xgei3btWrvXhoA4I+j
         8KwITZ5cPRHKNiML5V5BmhnqfAtzcdfxmaosORzrrnvSJqllmvl4TlNlYyeeEVUKbujF
         0S8Q==
X-Gm-Message-State: AC+VfDz6kIst80LETERMCVKVsVdsY6bVW+MKYCPH7OPFnq30GNuQNvn9
        ddrOQdFwr0bqDvkQ9HeRwbFu9rNGHmBqPa1uWeKbL12X3/U=
X-Google-Smtp-Source: ACHHUZ5DZbzuLWlU8psSkRhku8nbGklirGmIVfbbY1P06M+BZgI7LQbX+ioI/aRfKP7fqCY39umqxbfOrv6Nmy+68zo=
X-Received: by 2002:ac2:532a:0:b0:4f3:84dd:a4e with SMTP id
 f10-20020ac2532a000000b004f384dd0a4emr1058505lfh.37.1684206411806; Mon, 15
 May 2023 20:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <41d48379b3dc4b621b097e145fc3be6257466654.1683875072.git.gitgitgadget@gmail.com>
 <20230516001615.1460450-1-jonathantanmy@google.com>
In-Reply-To: <20230516001615.1460450-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 20:06:39 -0700
Message-ID: <CABPp-BELvMe-umfk7HXyvh6JziuHMbnLZq7TgNSidxN_ofixsQ@mail.gmail.com>
Subject: Re: [PATCH v2 26/27] hash-ll, hashmap: move oidhash() to hash-ll
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2023 at 5:16=E2=80=AFPM Jonathan Tan <jonathantanmy@google.=
com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Move this function to hash-ll, so that khash.h can stop depending upon
> > hashmap.h.
>
> [snip]
>
> > Diff best viewed with `--color-moved`.  Note that there's a small but
> > important change to khash.h in this patch as well to allow this move,
> > which is easy to overlook.
>
> [snip]
>
> > diff --git a/khash.h b/khash.h
> > index a0a08dad8b7..ff881631778 100644
> > --- a/khash.h
> > +++ b/khash.h
> > @@ -26,7 +26,6 @@
> >  #ifndef __AC_KHASH_H
> >  #define __AC_KHASH_H
> >
> > -#include "hashmap.h"
> >  #include "hash.h"
>
> Is this the small but important change to khash.h? I thought that this
> is the reason for the change, not what "allow[ed]" this move.

No, the small but important change to khash.h was only in v1, and was
split out into a separate patch based on feedback.  I just forgot to
update this commit's message when I did so.  Sorry about that; I'll
fix it up.

>
> > diff --git a/object-name.c b/object-name.c
> > index 45f4d51305b..7e96c97051e 100644
> > --- a/object-name.c
> > +++ b/object-name.c
>
> [snip]
>
> > +struct raw_object_store {
> > +     /*
> > +      * Set of all object directories; the main directory is first (an=
d
> > +      * cannot be NULL after initialization). Subsequent directories a=
re
> > +      * alternates.
> > +      */
> > +     struct object_directory *odb;
> > +     struct object_directory **odb_tail;
> > +     struct kh_odb_path_map *odb_by_path;
>
> This is not present as a minus line (that line uses kh_odb_path_map_t).
> I thought this was so that we could forward declare "struct
> kh_odb_path_map", but I don't see such a forward declaration. (Was it
> declared elsewhere?)

I think this hunk probably should have been part of the khash.h patch
that was separated out, to make it more clear.  I'll fix that up.

> Everything else looks good.

Thanks, but I realized some point on Saturday that this patch was an
accidental squash of two patches -- one splitting object-store-ll.h
out of object-store.h (the majority of the patch), and the other about
the hash-ll/hashmap/khash changes.  I'll split it back out in my
re-roll.  There won't be any code changes, just splitting the patch
into its individual parts.
