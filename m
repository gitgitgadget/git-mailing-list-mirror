Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD182C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 22:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiANWPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiANWPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 17:15:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F507C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 14:15:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 15so5736036edx.9
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNWlbd4bcoPOV/Vvo3MiM30A419fc6nG8OcqBrOl5/c=;
        b=eqrhSA2+fr1OI8ENbCfxZqTdxHZ0P5ZZJvePqdnidMYQgh/NVOFy0JU9jWVljdkS3Z
         L+vyukxAXuT4OlwJ6PgCmNrKlu1vRa0A7sLcc9gqmxcf8g/Qpjgc9T0tWGs5HIkobTf/
         ZjFaNPDGMdyInTo6eLqHij3KW3A/AAFpV4Oan5/6ZP1n2YDyQq3Z/4bSqM1Wz8hAdnQL
         /y64lUj6X59d3U981lOCaHPFzhIM4fYAZmteM/xnMUZ/8CY6aOxr3RPToQx5eM1Gtlmg
         fMfoKOj5KtpwagWX7mswWoWt4wQHEwdqTveEjvVpz8vncWX+lr8/3BKr0+lPU+N8QQW9
         QmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNWlbd4bcoPOV/Vvo3MiM30A419fc6nG8OcqBrOl5/c=;
        b=4ibjGdox49DTGT9QQclnyoIJ5zP7WnWsGgo67MGIdzOqRuR58hRaNStEKuthFd1AOw
         HzNMp5FQRIP5xkR5j4xNz9K3zk/YU6leWlfNmyJeSOJxesJkjQHah4Z7BVDuQ8OxdJAM
         QriV1MieNOktHzaAxBtiHT6uFzodaWDFgCCKjzYDrOOZ00dqqUsc/ol3RH3i3n792pp/
         j1t4RK8FZhxyuO1iK+B2rtfWBq+Q0/4MAbOgFZZ6S8pSC+I/SX/oK7h/Q9oipCKlyBre
         Nt1ODMbqXZgrHJxPaoRhi3dqhTeVrdxaRpDXhzGsnNckpRpw3yQ8iGOK4kCejcbGeRyp
         JrAQ==
X-Gm-Message-State: AOAM533/t1vKUCCgkQ02vofULOK2xMQXaxWklIcwAHpdNNCmtXZX2+yh
        +4iXjMFv1UE7YcwZu6KS+bBVnVLPD/ljwu4qAVUjIzOYGCDOEA==
X-Google-Smtp-Source: ABdhPJx445B/pF6z7h/yjJWdD712TFbn/lUCkmmESY8/qqZChxMzjWym9cCPFzOYYYVsSjb7yyxGTXS46YNm/zpQtJk=
X-Received: by 2002:a17:907:9712:: with SMTP id jg18mr9258449ejc.328.1642198543178;
 Fri, 14 Jan 2022 14:15:43 -0800 (PST)
MIME-Version: 1.0
References: <YeHTIfEutLYM4TIU@nand.local>
In-Reply-To: <YeHTIfEutLYM4TIU@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Jan 2022 14:15:31 -0800
Message-ID: <CABPp-BFM+fU+jVJwrU4ooPGvHbw859M+RNb+MvJe12MPV_=q7g@mail.gmail.com>
Subject: Re: merge-ort assertion failure
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 11:46 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Elijah,
>
> A colleague reported that they were able to hit an assertion failure in
> merge-ort when rebasing a topic of their back onto upstream.
>
> The scenario (which I have been able to reproduce on a private
> repository, but haven't had time to reduce further) is:
>
>     $ git --version
>     git version 2.34.1
>
>     $ git rebase origin/master
>     warning: skipped previously applied commit 9cda243afc2a
>     warning: skipped previously applied commit 882bb87a3a7c
>     hint: use --reapply-cherry-picks to include skipped commits
>     hint: Disable this message with "git config advice.skippedCherryPicks false"
>     [some "Auto-merging" messages ...]
>     CONFLICT (content): Merge conflict in
>     [some file]
>     warning: exhaustive rename detection was skipped due to too many files.
>     warning: you may want to set your merge.renamelimit variable to at least 165 and retry the command.
>     Assertion failed: (renames->cached_pairs_valid_side == 0), function
>     clear_or_reinit_internal_opts, file merge-ort.c, line 546.
>     Abort trap: 6
>
> Their merge.renameLimit is set pretty low at just "1", and this
> assertion goes away so long as `merge.renameLimit` is set sufficiently
> high.
>
> I haven't had a chance to look into it very deeply yet. Elijah: I figure
> that this is the sort of thing that may be totally obvious to you, so
> I'm sharing it here in case it is.

I don't have a testcase (though I think there is probably enough
information here for me to create one), but I think I know the
problem.  Does this fix it for you? :
https://github.com/git/git/pull/1193
