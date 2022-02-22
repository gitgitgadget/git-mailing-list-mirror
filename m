Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D95FC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 02:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBVC3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:29:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiBVC3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 21:29:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1725C5C
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:28:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so38111987eje.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nr8uQm2Kv9XMbX5qaWayQzDj/NCsMVD2hYuL9E1ufdk=;
        b=X4BlQJJtXHU+SOhQliMc1mLmnnVRn7U2STNOpjt90BiSNC0wsCxNSEs6oOdrfWxROY
         t7mwIuDnKw/nD0ThIIVW6zSSTDzKN3eYcGSwFdjx8ZuZ/0B3VTuBuGUA2hGUjvq838Nf
         tdzk+/xf3tYrIW+LEC71M+B6BBQ7AX+Lan10fYCxBgQoAq0wi7RxgaYT2Kqem7vHnAWq
         ND8klWD5dJ3KcNiqRT3v3zHtqxeMvwlKn9H16wz1EMj4H42XbM3Ej3uX9Jf7c585N8Nc
         ttE9LjtMywoNYm3jYPS3OfQ5E0E3Q/qu6gxm/7v+ju/pd86GV+GFxz8Y7d0imQ8ZgmYm
         k60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nr8uQm2Kv9XMbX5qaWayQzDj/NCsMVD2hYuL9E1ufdk=;
        b=yIMJfcECGC+q5QBsDqtM3ah2EsoAaxTTw6OT+jwhCeKBemqnHEUWh8erJ/K6NPyFvP
         qWnFFnhLnAZ3lUs82J5x1FgPq4nRIFOG9R8HtMe8E2nsAKzPrrR0e0AsD0gJWn9cUXYy
         Lxaot8OR35SQuylXmtXBQVB9xulvirbkAk9ngFijnUT/ofkHyrfT1FbAY4KxO0WMTQgR
         +oO+quNZX6aQCZDuz+t7DpcDOic4Tf9tLrZDkYDh/XQJmDazyWNKXJGTQdokSQSywjwn
         m8p0K8083kyPujkSJG+yjWLWpYCEAPEvnXlP57svpWMLbr5m4J7tRca4HVa+g9FiCcqi
         GkvQ==
X-Gm-Message-State: AOAM533WusMfztyCl9neHByraO9Z5lIb1pegx0Y9OIXf1Rn3VW4DOniK
        ANyWzKSKsfnEgFLBrrlaJZihbrh85iEmo9m5fSc=
X-Google-Smtp-Source: ABdhPJxSWqlXr4h53NpJMCjoQqHkwmmjzbPC+f04CifLAyodtwS9VnXb/xVjXPxnCDGDJM1GhL1W+0KbojqmrDKYoO4=
X-Received: by 2002:a17:906:a855:b0:6cd:ba20:39c5 with SMTP id
 dx21-20020a170906a85500b006cdba2039c5mr17306921ejb.100.1645496919098; Mon, 21
 Feb 2022 18:28:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
 <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com> <7994775a9341b256d1ea7dfc417bb577d9a3195f.1645340082.git.gitgitgadget@gmail.com>
 <9b65e743-729f-6449-b7ef-c8c9fb130221@web.de>
In-Reply-To: <9b65e743-729f-6449-b7ef-c8c9fb130221@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 18:28:27 -0800
Message-ID: <CABPp-BESAh6wLComJoYsf7Q7NF2EMPptKRhfAoy=1-ZRZovnaQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] merge-tree: implement real merges
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 1:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 20.02.22 um 07:54 schrieb Elijah Newren via GitGitGadget:
[...]
> > +     /*
> > +      * Get the merge bases, in reverse order; see comment above
> > +      * merge_incore_recursive in merge-ort.h
> > +      */
> > +     common =3D get_merge_bases(parent1, parent2);
> > +     if (!common)
> > +             die(_("refusing to merge unrelated histories"));
> > +     for (j =3D common; j; j =3D j->next)
> > +             commit_list_insert(j->item, &merge_bases);
>
> This loop creates a reversed copy of "common".  You could use
> reverse_commit_list() instead to do it in-place and avoid the
> allocations.  Only the copy, "merge_bases", is used below.

Oh, good catch.  I probably should have been aware of this since
someone requested I move the reverse_commit_list() function from
merge-recursive.c to commit.c as part of my merge-ort work, but looks
like I forgot about it and copied this command snippet from
builtin/merge.c instead.  I have no excuse.

However, I wonder if that means we could also apply this
simplification to the code snippets in builtin/merge.c and sequencer.c
that you can find with
    git grep commit_list_insert.*reversed
?  Maybe #leftoverbits for that part?
