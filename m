Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E605C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiAXRx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiAXRx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:53:26 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519CC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:53:26 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z29-20020a62d11d000000b004c8f0d5dec9so1954593pfg.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yJSgJaFdbD5JH6R8sTHWwLPNLcOe3I00ve1DRa27cYA=;
        b=IUkCi6Mb67HYlLxMpCx0R9UtkmnBxgs15V2045ibKvqeIc02Q2JAwPChRaXbM4pEQM
         DBGJR7opRbE7l7fu2IpqoB07Oz3PtpIhdxwDa5eQqsHGPokKeAJeiPRUnB27HKH/JXUO
         IEJo/lz3voSFpfpswhodSonh03+bQmmWqKOa2HYBf9j5bnlFvGelE+tiqrPVtBDRIR4D
         td3c3VuoCjEufcD+/5L/AB6THXwduapMf32cmX3en+NeqxeSLL4UvSm5oE0gk1T3BNrS
         voAsZksNl3RB7Sh5OQDZzltcgHI6tfsD8IbkN9vU4z7FyWvWKe9VLQhrzDOs5w+SVcOb
         x0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yJSgJaFdbD5JH6R8sTHWwLPNLcOe3I00ve1DRa27cYA=;
        b=fu2MT2a9yzbKjA2cyansQlph8jG7HztbKG9qh3YDI45RAU68yIrqi4rQNYWy9GHtFy
         mXY0PXjmxiXrhvMPQvo/qxiOzUFzwKGDf1yOEASSyky0EUso04GGh7RXb/cFMD4zAp2m
         vz0m1mJy6JbYJEU7paZoEPrl5ROUgmm+fVM9tisaKcgcUCsFKnuzG9EXVmxhqcoIcnGM
         Q7Gk7+QZrRTvv/eA5TJQUsQTsh728114mWIR6Szb8lzow3ejO1lMifwgEhasxSX0Ea2T
         w2GTuKO0IgZdlEPnDMsD4tJNT6Pnv2njkTC056gtQgZoN4JfY8n3niA3jTI+zbQ7ogAq
         oNVA==
X-Gm-Message-State: AOAM530TU1ISDLsOxt8ZN2hrx9doU4eLPmPQLFUeFTvNMp+/ZL/In9/g
        BnXKvM/KlymXTVfs2WlPdCr8gmCZG8RJUsFpcdxj
X-Google-Smtp-Source: ABdhPJwa2HU+9fdzHR8TiZWyGQgV0Gp84TopZflronvAFgQA6WiCxsh4hcQHrcflH1131bOk8f88lOT6Nbt7QMsvl44a
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8d8d:b0:14a:dd79:17b2 with
 SMTP id v13-20020a1709028d8d00b0014add7917b2mr14915996plo.88.1643046805883;
 Mon, 24 Jan 2022 09:53:25 -0800 (PST)
Date:   Mon, 24 Jan 2022 09:53:22 -0800
In-Reply-To: <YenfyK8wE5VXuHoo@nand.local>
Message-Id: <20220124175322.2433200-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YenfyK8wE5VXuHoo@nand.local>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v3 3/9] pack-revindex.c: instrument loading on-disk
 reverse index
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, Jan 20, 2022 at 10:15:45AM -0800, Jonathan Tan wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> > > In a subsequent commit, we'll use the MIDX's new 'RIDX' chunk as a
> > > source for the reverse index's data. But it will be useful for tests to
> > > be able to determine whether the reverse index was loaded from the
> > > separate .rev file, or from a chunk within the MIDX.
> >
> > As for this patch and all subsequent patches, we (at $DAYJOB) discussed
> > during our Review Club the idea of not supporting .rev files altogether.
> > Firstly, because of this bug, we cannot fully trust .rev files anymore.
> > And even if we decided to trust it (or to trust it after some
> > verification step that I can't think of), that file would only be useful
> > for a short time until a regularly scheduled maintenance step
> > regenerates the bitmaps anyway.
> 
> I assume that you're talking about MIDX .rev files here, not the usual
> packfile ones which are only related in the sense that they follow the
> same file format, but are otherwise distinct.

Ah, yes - sorry for the lack of clarity.

> We could drop support for the MIDX .rev files, but I do not think it is
> a very good idea. There are tagged versions of Git which have .rev files
> out in the wild, so suddenly dropping support for them would mean that
> existing repositories would no longer be able to read their multi-pack
> bitmaps after upgrading to a version of Git which doesn't include
> support for separate .rev files.
> 
> So there are some backwards compatibility concerns there, and I think
> that that alone means we can't do it.
> 
> In order to maintain good test coverage of the soon-to-be deprecated
> external MIDX .rev files, this patch series adds some additional testing
> knobs to make sure that we're thoroughly exercising both cases.
> 
> It's somewhat unfortunate that we are stuck with on-disk .rev files for
> MIDXs, since it opened the door for this bug to manifest itself. But I
> am not comfortable getting rid of them at this point.

Thanks for this explanation of your viewpoint. I still think that it's
fine to drop support for reading something that a tagged and released
version of Git has created, since it is a potentially wrong cache (and
does not contain any new information), but what I can do is to review
the rest of this patch set assuming that we want to keep support for the
on-disk MIDX .rev files, so I'll do that. This way, if we decide to keep
support for these files, I would be happy to see this patch set merged.
