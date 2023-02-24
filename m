Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544BAC6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBXRtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXRte (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:49:34 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70A10FC
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:49:33 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-172a623ad9aso260918fac.13
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/6CNSHEayuzkLN2NLMamaaC7iewrhkzcGQ5Bv9E8pQ=;
        b=e+7beRWd9A+sgAew7/ACuI/NjjWyKTArscmvSi+JkNDawYB/fdVKTEGWUnjVxJlQS8
         yKpBhmnE8miBTY8VI8EdHQWdD1vbuG3PPPeEP3IaUQq072C//ON56R7MUhHERk9QKERz
         SajwEkJ1UtHEo5h3pM1JBh5wofDpOH0q/REIhjMVbd1zWGAYko6VhxQyt8UskGsB7kS9
         rxx3zJA+vHLdk11U+QtFKaXLoi2P4cHuusmgvwXmTcobs7YaO4bbWlqdlct2mVe0Pnt0
         lvv1Sw3I8aDO8LPElcsk6lbfBH7Sxpt/gnbOkanuAgXbpL7kX9XM65ff/6V6LrbufDaQ
         JCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/6CNSHEayuzkLN2NLMamaaC7iewrhkzcGQ5Bv9E8pQ=;
        b=QgYQf53kQlLvzOlApaxHEviMDAk7JP0jWalwBHJTWf7o1jf8YyE9/eymtLiOOlywrC
         OqIpUj3txjP7fJ4444jYFneGhZVAzYtPvFKPWrXgWRgCs52f9SICfoo920EW+o+FzdZY
         rid+Rgk7g5TCo5ILSedPR4Vd+k1r4GTQthHdFGnMUbnZznAPgZjpZ83VORXZAhj2WjST
         DspSg3fz2APHS1BwBskVVKyzvN3G0mkXGf4Tojx+g1NOpTqX/4o1UkuZEEBSiE9qNyWt
         QRnZA3ysllWDH+jGVM1xQVAu1rC4xuRgkXpucRmPBZrfYKQB1xnxm/VTNLNw+aqP9JR3
         /RdA==
X-Gm-Message-State: AO0yUKVVJVsvCqYxiSF4Uyiv8fXqnB8FzE/ww+pbCHmm64eVl8A3RiQZ
        Y5v2PFEJ7W4T+N98SBHksu30BzQ3cijYhHhjHIo=
X-Google-Smtp-Source: AK7set/JbuPg7pQRJwP9m5SUcfPGFO4dfv2NEFMsj/KWu62eDCOwFiAP4YjpNak2kDu2xbOJS5lyOhpc2CuvfEBu86s=
X-Received: by 2002:a05:6870:5b0f:b0:16e:94ae:e83d with SMTP id
 ds15-20020a0568705b0f00b0016e94aee83dmr1063580oab.5.1677260972510; Fri, 24
 Feb 2023 09:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-3-alexhenrie24@gmail.com> <c918797c-75cc-80d4-c978-360388877d63@gmx.de>
In-Reply-To: <c918797c-75cc-80d4-c978-360388877d63@gmx.de>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Feb 2023 10:49:21 -0700
Message-ID: <CAMMLpeRoPnj2-YXo3tOcqU2oqx1RokocZSvU-4hXV7rdMEBDXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rebase: add a config option for --rebase-merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 6:53 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> in config value parsing, a "maybe-bool" with a
> NULL value is considered to be equivalent to `true`! (See
> `git_parse_maybe_bool_text()` or
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-true for
> details.).

> On Wed, 22 Feb 2023, Alex Henrie wrote:
>
> > +     if (!strcmp(var, "rebase.merges") && value && *value) {
>
> Why do we require a non-empty `value` here?
>
>         [rebase]
>                 merges
>
> should be equivalent to `true`,
>
>         [rebase]
>                 merges =
>
> should probably be equivalent to `false`, and both are handled correctly
> by `git_parse_maybe_bool()`.

I didn't know that there was already an established convention for
what NULL and "" mean for boolean config values. I should have looked
at the source code of git_parse_maybe_bool more carefully. That does
change things because we're going to want to follow the established
convention here.

-Alex
