Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE1C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 18:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348856AbiFOSnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOSm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 14:42:58 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4AC13D27
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:42:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x19-20020aa78f13000000b0051bdda60a06so5535504pfr.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YS5Xq64Kff901kPC4gLP1a85UBlLaMt03o4bOTmPZDM=;
        b=PIpI9h+e602j/10xdNSLNbYVC9dcEpM4HuiQdfPt063NnsPShL28w3ABEjx/UEdVZi
         CLIZkJJDfRt7dJbtldeOAb1LUZ2iHglEy1RfYKEVLShD70G2CRaitjSOwRVV5OkffMob
         YrNrIMi0VhTiT2DS/i3F0mYo3+9VqXZNQGtiteXoZYCNbuWw1dtKG7nL4B4WvaV8FlR3
         JwpCkkIH4+UEimGtoZhMM5m5/iHJlu8mO5UWuVMumWT8KPSffD4Q8B7EWavx12ErOdXL
         nvG4Qjjq+PZnZgSe92fkYyr5SyP/P0zmCsjApyc/wx/c8AmbxJroUjVHJL5wcysW/X3J
         UPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YS5Xq64Kff901kPC4gLP1a85UBlLaMt03o4bOTmPZDM=;
        b=ONBcu+4W/KFDy+PM9iknE0zHsoaMAizqv+Wnp+luhkvqEAWQpRP0q+/fvWkX+dKSZS
         g7Sc/HIOniLU1VEOS3yIj00Wb8yj9OTKseFUDkFhbrtM1//lBc0NvEcOGpJp/8tg5RxR
         nfOqifMbrPbjH+oqKe+MA9xuk57Lc8cgCae/VnwHtf/JTpRAzd/EDhcQ/VneW5bRvfJn
         opy6DHoct8DzJc9gg0GGkLpCuJCIFVIpR11uR/rLbTNlDbD1++xHXEHRqXdusSDA5MBu
         ng2G6MgDZipFk0csWpg+fyfjsW2WzJsLz5SgTZ8nw7JfTsVKihK+pyF0Gmi9d9CQNZfa
         OFTw==
X-Gm-Message-State: AJIora8DOuGUIZYOiNU3dLYuMoxzUWx9imWC68Q5t/m8ChKth0HVIeDd
        hyzLnFF6XD0VXYzaIUebJQ7KGtU3mz92rg==
X-Google-Smtp-Source: AGRyM1t3iYZH553NKcKUyEE6Zun4h0zUXRwImVO8VI06V9EYK0Ymv7UG5diamctCkWKNjMwQl6eJ+cGgiIpXmg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:4844:0:b0:3fc:c299:a7a4 with SMTP id
 x4-20020a634844000000b003fcc299a7a4mr1011017pgk.510.1655318576859; Wed, 15
 Jun 2022 11:42:56 -0700 (PDT)
Date:   Wed, 15 Jun 2022 11:42:55 -0700
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6l35g56a4w.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 00/12] submodule: make "git submodule--helper" behave
 like "git submodule"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Super happy to see this moving forward, thanks!
I'll summarize the discussion to make it easier for others to follow.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This series:
>
>  * Removes dead code from git-submodule.sh, or dead code where it was
>    the last user.

This is 1-2/12. Not strictly 'necessary', but removing the dead code
makes it easier to tell what git-submodule.sh is doing and will make the
final review simpler.

These all look good to me.

>  * Simplifies CLI parsing in git-submodule.sh, where it was doing
>    something overly complex for no reason.
>
>  * Brings "git submodule--helper" in line with the CLI interface of
>    "git-submodule.sh", for a follow-up series to remove the latter, as
>    we'll be able to make a new "git submodule" in C dispatch directly
>    to our new "git submodule--helper" code.
>
>  * Removes the "-v" option to "git submodule", which has been
>    supported, but was a) never documented b) never did anything
>    anyway, except as a way to negate an earlier "--quiet" option, as
>    "verbose" was always the default.

3-10/12 is the real crux of this series, which removes all of the extra
parsing from "git submodule" by making "git submodule--helper" accept
the same args. This is great, because it means that "submodule--helper"
can just pretend to be "submodule".

One thing that this series _doesn't_ do (but the RFCs do) is to actually
take advantage of this fact and remove the options parsing from
git-submodule.sh, e.g.

     cmd_foo() {
        git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foo \
        	${GIT_QUIET:+--quiet} "$@"
     }

or in the case dispatch in [1]. Like we discussed earlier, I think this
is for the better - getting rid of the options parsing is (probably)
going to be most error-prone step, so it makes some sense to do that on
its own.

We agreed that 8/12 should be moved to that later series, but everything
else looks good.

>  * The last couple of patches are cleanup that isn't strictly
>    neccesary for the end-goal of "git submodule" in C, but cleans up
>    some more shellscript code.
>
>    The "say" function is removed from "git-sh-setup.sh", now that
>    "git-submodule.sh" doesn't use it anymore (which happened before
>    this series) we can replace the couple of remaining uses with
>    "echo", and by having "git-subtree.sh" own the code that used to
>    live in "git-sh-setup.sh".

This is 11-12/12, which removes "say" and related cruft.

The changes look ok. I'm not experienced with this area of the codebase,
but I've verified the findings in the commit messages.

[1] https://lore.kernel.org/git/RFC-patch-09.20-bd0e4a4f8b8-20220610T011725=
Z-avarab@gmail.com
