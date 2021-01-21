Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE4C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D9B23A40
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbhAUSeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 13:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbhAUSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 13:33:25 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34571C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 10:32:45 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w139so1756135pfc.18
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 10:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=1+a7dXBHOWAAz4t0qsDL9hzNGpS6a7kb4eKNtv+FDoY=;
        b=pnuIDS19qOWwaJQoVNHkSbA2iawqyBEuGt1FRSa+OkbAp9mhKwDRFpN1lM8ym8zM3T
         egZQ4j06AtW3gk2+I6Iucy0kMhvneOSfZa90PZcqTHMr2wK/JiPAD5njEcq2ouaQVf/A
         R1a66j08bndTozEjOLaHkkpgVSnpw84NGSG9iEILcF/UkxK17At2Rj06zyne1WyG2dWQ
         YGxyXRhc2x6vhLi9I4pGMd0LuHoHqgiklYgfQ3eZI6aiVJU8WDwmgqCZ+nbJD6eZAniG
         Fcaij+JucNHELjyZEyBbiG3tkz5PtELARBzltRRdGTQk7ePyGjQHThkocyhoh90w8lrU
         Ezjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1+a7dXBHOWAAz4t0qsDL9hzNGpS6a7kb4eKNtv+FDoY=;
        b=Fk3oNYVB1Bk1Z0EUT5JYf4NOjKILzEWTXxhFe3Rb4yfh/BaFOokzILNG7IrE2rM5Qg
         syttEFtvJrfhnzK3oIB8pNmgAk/jlcpiAb8kdZ4e/VjMOIRWxl8+TMA/QK4B/Iljc/lZ
         PJMQgK0xPiZcfhFQCTNCbP+U3dZpIRwaTqTGcOm/5M1UFkX/Q/jNglT9oSJYTpbs12QE
         HxNgEqwOReiq5uYVWyI0yoVapjX362z9cB2L1U34z06bD4PgIfo3DC7ydzu6bdfUbsua
         wF20Kdor5syn3XKuKaPD+MhuXssSd+yIMrLMzG0XuqlPHyPWoKKj43wb/HcQFrLGKKnY
         DwRg==
X-Gm-Message-State: AOAM5330OxKosTQ1OvclJCAhjym09I+JjMXGmoWoG88GfhXxBJlPwRfI
        zvcf2jlpql6Xez+DEakjFC4WgUSYjhmGTUfAdJfA
X-Google-Smtp-Source: ABdhPJyvPnlhO5XwewkeOkXEzLKescmLULF8ld5foCqWH3SQf/9TCzn8aCWaFZH+7Pr4IirGeXB4egqzBtSXipl2kUrq
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:7d08:: with SMTP id
 g8mr790619pjl.180.1611253964553; Thu, 21 Jan 2021 10:32:44 -0800 (PST)
Date:   Thu, 21 Jan 2021 10:32:38 -0800
In-Reply-To: <xmqq1refdm58.fsf@gitster.c.googlers.com>
Message-Id: <20210121183238.1780849-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq1refdm58.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: Re: RFC on packfile URIs and .gitmodules check
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, avarab@gmail.com, git@vger.kernel.org,
        peff@peff.net, stolee@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> > We wouldn't be OK, actually. Suppose we have a separate packfile
> > containing only the ".gitmodules" blob - when we call fsck_finish(), we
> > would not have downloaded the other packfile yet. Git processes the
> > entire fetch response by piping the inline packfile (after demux) into
> > index-pack (which is the one that calls fsck_finish()) before it
> > downloads any of the other packfile(s).
>=20
> Is that order documented as a requirement for implementation?
>=20
> Na=C3=AFvely, I would expect that a CDN offload would be to relieve
> servers from the burden of having to repack ancient part of the
> history all the time for any new "clone" clients and that is what
> the "here is a URI, go fetch it because I won't give you objects
> that already appear there" feature is about.  Because we expect that
> the offloaded contents would not be up-to-date, the traditional
> packfile transfer would then is used to complete the history with
> objects necessary for the parts of the history newer than the
> offloaded contents.
>=20
> And from that viewpoint, it sounds totally backwards to start
> processing the up-to-the-minute fresh packfile that came via the
> traditional packfile transfer before the CDN offloaded contents are
> fetched and stored safely in our repository.
>=20
> We probably want to finish interaction with the live server as
> quickly as possible---it would go counter to that wish if we force
> the live part of the history hang in flight, unprocessed, while the
> client downloads offloaded bulk from CDN and processes it, making
> the server side stuck waiting for some write(2) to go through.
>=20
> But I still wonder if it is an option to locally delay the
> processing of the up-to-the-minute-fresh part.
>=20
> Instead of feeding what comes from them directly to "index-pack
> --fsck-objects", would it make sense to spool it to a temporary, so
> that we can release the server early, but then make sure to fetch
> and process packfile URI material before coming back to process the
> spooled packdata.  That would allow the newer part of the history to
> have newer trees that still reference the same old .gitmodules that
> is found in the frozen packfile that comes from CDN, no?
>=20
> Or can there be a situation where some objects in CDN pack are
> referred to by objects in the up-to-the-minute-fresh pack (e.g. a
> ".gitmodules" blob in CDN pack is still unchanged and used in an
> updated tree in the latest revision) and some other objects in CDN
> pack refer to an object in the live part of the history?  If there
> is such a cyclic dependency, "index-pack --fsck" one pack at a time
> would not work, but I doubt such a cycle can arise.

My intention is that the order of the packfiles (and cyclic
dependencies) would not matter, so we wouldn't need to delay any
processing of the up-to-the-minute-fresh part. I'm currently working on
getting index-pack to output a list of the dangling .gitmodules files,
so that fetch-pack (its consumer) can do one final fsck on those files.

Another way, as you said, is to say that the order of the packfiles
matters (which potentially allows some simplification on the client
side) but I don't think that we need to lose this flexibility.
