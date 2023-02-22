Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58795C636D7
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 01:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBVBlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVBlo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 20:41:44 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787BE3252D
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:41:43 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id be35so6287560oib.4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q+AIB9lNcrbN3acXXCRRKs5BBZG0dZZ0HQ89qZXmgEg=;
        b=G42i1v9AaNl5Dm5lYvfoTDuLo27/C1ILjtM1WIJHoEAoy7UiIOQAhTjkTC/RPUenCg
         e2aSVf5aVsKHeajlum495qXVBMkKGpA8bla92FJDfP2NWiTMl+lkinC2lOHuYmfWfSpf
         EtZYaQeBbf4U30de/B2LAm9OHkWnAYxhCJtEL0IZTe2PR+1du2lVZ/jPWrPsUb5gWZU7
         OCenUg/SUMUBS7ZsbdVBf8UqtAr4Kq895mVsbLWMjXWk/IIQXdK2RTWFRmwVRK64LzJe
         iKM/t3GTylaNKLSL0iMrsOWmIrFFVawekffGluFRf5Q8H5KMR8D5crmCJIAdZ9NembfT
         Vp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+AIB9lNcrbN3acXXCRRKs5BBZG0dZZ0HQ89qZXmgEg=;
        b=Xj+o06liWpDZnoVMzgFiWY+/mSAyAx00HjIfGvaD/DvWCk62WETCCtV7uizfwf82YR
         MydN1UEMIO9lH2KYixpAEwfnkgGG6JrSslVWvQBW9hoCxpHmVPCps30Xbv9hHZfsS+yo
         MxhPGVrrPz1ljiLhpEIlIji9LEQqAdq7908NyTpEkcz5tLtYR3Chc795g77mRydcvE8p
         61CTrQkXumA2YC0sZwrA0vRwELthdgGvdx7DDeQE5N2S9p2dRvwkjel2fYUmFghbTY6v
         JOCuKGq5qwZEGgctLgDxsFJASGwg06VEPxSJ/fUi4lY4UhRWjTUYepZHDTvvT4tGAd+t
         jD5w==
X-Gm-Message-State: AO0yUKU9o4si+Evco+OmQ+3zOC/uAC/aCWtBUMxaA65xtPFiGmBXsLuO
        SJ3BMNHY6D/KtZeTKcToUfPCTuBp1o909bS5sos=
X-Google-Smtp-Source: AK7set/gZEyHHZEWpaYfXEaKvlUTPX/dUdIYvZraeN8nVuf5pcX/xbdBVW0Biw0lcssDy+Kt1Msw1y8gtng3v5jM+6A=
X-Received: by 2002:a05:6808:1795:b0:37d:8c44:93bf with SMTP id
 bg21-20020a056808179500b0037d8c4493bfmr655354oib.141.1677030102801; Tue, 21
 Feb 2023 17:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-4-alexhenrie24@gmail.com> <d1f10c52-9cfb-8e6a-cbd6-cd81b778b8cc@dunelm.org.uk>
In-Reply-To: <d1f10c52-9cfb-8e6a-cbd6-cd81b778b8cc@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 21 Feb 2023 18:41:31 -0700
Message-ID: <CAMMLpeQpSMVm0ZNMNz20+9bKAGhn4pFwTX62nR+B-V-KzvqT+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rebase: add a config option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 3:46 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 21/02/2023 05:58, Alex Henrie wrote:
> > +rebase.merges::
> > +     Default value of `--rebase-merges` option.
>
> Below I see this takes a boolean in addition to [no-]rebase-cousins, it
> would be nice to document that, especially what "true" means.

Good point. I'll add another sentence explaining that "true" is
equivalent to --rebase-merges without arguments and "false" is
equivalent to --no-rebase-merges.

> > +     if (!strcmp(var, "rebase.merges")) {
> > +             const char *rebase_merges;
> > +             if (!git_config_string(&rebase_merges, var, value) &&
> > +                 rebase_merges && *rebase_merges) {
>
> rebase_merges is guaranteed to be non-NULL if git_config_string returns 0.
>
> > +                     opts->rebase_merges = git_parse_maybe_bool(rebase_merges);
> > +                     if (opts->rebase_merges < 0)
> > +                             parse_merges_value(opts, rebase_merges);
> > +             }
> > +             return 0;
> > +     }
>
> I think this leaks rebase_merges as git_config_string() returns a copy
> despite taking a "const char*".

Come to think of it, I don't think we need git_config_string at all
here. As far as I can tell, it should be fine to just check (value &&
*value) and not duplicate the string in memory.

> > +test_expect_success 'rebase.merges="" is equivalent to not passing --rebase-merges' '
> > +     git config rebase.merges "" &&
>
> test_config is generally preferred as it clears the value at the end of
> the test. Then you don't need the final hunk of this patch.

I've used test_config before but I forgot about it. Thanks for the reminder.

-Alex
