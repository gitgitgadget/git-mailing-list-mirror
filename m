Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4EC001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 09:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGXJCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGXJCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 05:02:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1214E41
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 02:02:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so5973250e87.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189353; x=1690794153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWdHgVZCgbdOo4MxLRrXAgXaIYsT6TBn253f3bFUBD0=;
        b=pwPS6HYg2ID80IHSEiwefbMqpUvbHhYlpp2fF9/Dzto5eK959YxAbLCZ7PZyqeWYqV
         n3nGU01142hxo4wYjb6V81FkNYVb2EW27GldbmmtcpLKL3NASA8WlvxHAB+Y5oUVNeIJ
         lSyFoQZD21SRLdstdGp8XNOIkPGTZD5vlV+S19+wfmUGIeC0m/gqQXsDZQS6s9dRshR8
         F7PwOkhDRS+OmKMfFKmQJHTLHk1EHAdtRlbwdvgE9lkUu7ikBNfXJ812IHqSlqUrZbfi
         MgeFbXSLmFPxW45j0gGEhTHq0BaNoq5YwbdVmbFIhB1kVUMhs3ZezN2THaOrub4yIkmK
         NgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189353; x=1690794153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWdHgVZCgbdOo4MxLRrXAgXaIYsT6TBn253f3bFUBD0=;
        b=Y6vWbKjMubz+WQmBja/bSzkIOZaksNJ9QiCpcFuR/pn9hoAqryo0Xbv3R/bWYlAVhu
         gXE3Lp1tEXx6KMAW2NtFdDEZjAeMBBPFkSh/k6fZI0ht1lsSXnAPHjnSj8Rrc+y4JJD+
         tQO84EkTxBYgXNMm6Tv+IxM37e3mMAeoKarYB6Kknx3DmbvhJVBcjpcguXNq6TwhJ5iY
         z6YtWfFn5KJuVPn5YWPSvlsi29UNPJ1JrgJ3r3eMmzH9ZvJiCltT6dx28HUV2tEVzw5x
         XJwq+rM6PMZM8/jLn5s4dWPb4X5RwAlkyoH0Wk5Rln9+eenAzAS2VbiOvNXBEU8GNmtS
         Slzw==
X-Gm-Message-State: ABy/qLbUpIHaRg+9Vjo6diR9C399TfLMfGPDU7ee11bdtSaXCxFg3FTM
        Jh9Vogv32D6GsRAgHlpSXqZWdoI9AVBfYHqB68E=
X-Google-Smtp-Source: APBJJlEy+PXF2Zu8D5DF24cbE3gIv6cmZeCWYkS8bFyjSCrC4gFIQwhPnQzt7BImsYNmyd4CjMIwmT31ND8L0cFKx/s=
X-Received: by 2002:a05:6512:2038:b0:4f8:72fd:ed95 with SMTP id
 s24-20020a056512203800b004f872fded95mr3956843lfs.22.1690189352856; Mon, 24
 Jul 2023 02:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com> <20230705060812.2865188-6-christian.couder@gmail.com>
 <xmqqcz161b3s.fsf@gitster.g>
In-Reply-To: <xmqqcz161b3s.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 Jul 2023 11:02:21 +0200
Message-ID: <CAP8UFD2TvKYsAsJJ-L=5Mc6k1QnzL9D1qL=-Wy9ByTMupdzoZA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 5, 2023 at 8:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +--filter=3D<filter-spec>::
> > +     Remove objects matching the filter specification from the
> > +     resulting packfile and put them into a separate packfile. Note
> > +     that objects used in the working directory are not filtered
> > +     out. So for the split to fully work, it's best to perform it
> > +     in a bare repo and to use the `-a` and `-d` options along with
> > +     this option.  See linkgit:git-rev-list[1] for valid
> > +     `<filter-spec>` forms.
>
> After running the command with this option once, we will have two
> packfiles, one with objects that match and the other with objects
> that do not match the filter spec.  Then what is the next step for
> the user of this feature?  Moving the former to a slower storage
> was cited as a motivation for the feature, but can the user tell
> which one of these two packfiles is the one that consists of the
> filtered out objects?  If there is no mechansim to do so, shouldn't
> we have one to make this feature more usable?
>
> At the level of "pack-objects" command, we report the new packfiles
> so that the user does not have to take "ls .git/objects/pack" before
> and after the operation to compare and learn which ones are new.
> I do not think "repack" that is a Porcelain should do such a
> reporting on its standard output, but that means either the feature
> should probably be done at the plumbing level (i.e. "pack-objects"),
> or the marking of the new packfiles needs to be done in a way that
> tools can later find them out, e.g. on the filesystem, similar to
> the way ".keep" marker tells which ones are not to be repacked, etc.

I think commands like `git verify-pack -v ...` can already tell a bit
about the content of a packfile.

Also this patch series adds `test-tool find-pack` which can help too.
It could maybe be converted into a new `git verify-pack --find-pack`
option if users want it.

Then, as you later found out, there is the --filter-to=3D<dir> option
added later by this series.

To clarify this, I have added the following to the commit message in
the version 3 I just sent:

"
   It's possible to find which new packfile contains the filtered out
   objects using one of the following:

     - `git verify-pack -v ...`,
     - `test-tool find-pack ...`, which a previous commit added,
     - `--filter-to=3D<dir>`, which a following commit will add to specify
       where the pack containing the filtered out objects will be.
"
