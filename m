Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0052C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4C761AA2
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbhKPSZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhKPSZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:25:16 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A8DC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:22:18 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n6so163062uak.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0XXlDl+R47m+kaqJ437308ZLAM37BETY3FBsDIQyjZY=;
        b=o4qjnzftwjMdA2lkiYbUPdp8IZr8wIur1mMezDiRD3OGjEd2QzOchKGtRS9VNiCupi
         75rGXgoW/1Ujr7sWERYRB3OqEwliOJPREtncVGumWFmhv6YqXlCy363b4Px/G7oTnmS+
         dUfRuNjnwkT6BFJ150QXGQ+nqUVbfeKAjJmmrb3OVpptDMC1v1LCxhzHHme7c97hup0u
         L8a4OVSBnGBKEYezlZbLtBDhP92vyHpvUE7356rmmZA9HnYgPth2m8fJ2d4JMxMSfiRE
         TFIPUih8AN8BieN6hkWJ3kqBsYy5XLHGMvoz8F7Jz1oduYHz1bAtrLyk26InbtTy9/9N
         PMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0XXlDl+R47m+kaqJ437308ZLAM37BETY3FBsDIQyjZY=;
        b=eSl97fDODRIbUIauSGDaVWEYVW6NCH/nZplO1j/atQ/6VvDZdP2yL+SPS5nYU7Q1aA
         ueq5Aw6vNm+orZ0PmtZuZXRJZJloUR2bCDQzv9Z7hMSI9FFwKTZPzrJpz6CwEGl2XJ+P
         ue42sPb0qMi4QMZpSrjANygxI9htRS6JP0xvfNLFhsicvPspFqeq7c8uLcoEzc6yIVHb
         1JjIBJqx7LijPffOz2k4pz7cjEEcphSUXF3hY9OurfRaujPrUIOp5b23J6iAx54fFXbo
         guhf52mLOPprwdwZ2mw38VKQc5E9nnadLY0E/1gDCsJPwyHGJ7gP625jtXM7XMmjc9bK
         ksvQ==
X-Gm-Message-State: AOAM532z0zg0TyUDfjRRZH1QrouOP/RunPbR5rLWPeabvdGVCjTfqBrD
        IYywJZuGjr+gvIoqdC9cUhZYQWjvpofMTMGXANE=
X-Google-Smtp-Source: ABdhPJxK7bObUsQibVci9zwelg5pKQzWsBBaPqQqCv9u9eQ47ztrYRItNGefEnvzWFWoK9LYoxJJEHOw1oc06LXcUuM=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr13868558uae.96.1637086938063;
 Tue, 16 Nov 2021 10:22:18 -0800 (PST)
MIME-Version: 1.0
References: <87bl2kv309.fsf@igel.home> <20211116110035.22140-1-carenas@gmail.com>
 <211116.86tugcp8mg.gmgdl@evledraar.gmail.com>
In-Reply-To: <211116.86tugcp8mg.gmgdl@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Nov 2021 10:22:06 -0800
Message-ID: <CAPUEspgUugXNqs8nWHTupsOhtD-g1ETY=VRyo0+9bVpCH1A_mw@mail.gmail.com>
Subject: Re: [PATCH] grep: avoid setting UTF mode when not needed
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, someguy@effective-light.com,
        gitster@pobox.com, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 4:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> First, if we've got a post-PCREv2 version whatever fix let's guard that
> with an ifdef, see thep GIT_PCRE2_VERSION_*_HIGHER at the top of grep.h.

The availability of PCRE2_MATCH_INVALID_UTF does that implicitly, but
adding one makes sense to make it explicit; specially if it leads to
better testing.

> In the context of this being a pretty urgent post-release fix (but I
> don't know if Junio would consider a point-release, so perhaphs it's
> not) I'd be OK with either of:
>
>  A. Let's back out this new log grep color thing entirely while we
>     reconsider this. The gitster/hm/paint-hits-in-log-grep topic
>     currently reverts cleanly.

Agree that reverting the whole feature makes more sense, but was
aiming to the minimum change required to allow for a "brown bag"
release with this.

The way the PCRE2 integration works, uses the fast path that presumes
valid UTF-8 and is documented[1] to have "Undefined Behaviour" when
the subject that is being searched on is not.

That has been shown before to lead to crashes or infinite loops

Carlo

[1] https://www.pcre.org/current/doc/html/pcre2jit.html#SEC4
