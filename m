Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65738C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKWBWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhKWBWg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 20:22:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D558C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:19:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so84989945edd.3
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UiqXPN7YvxB7B/wHyRtsw7lv+l5FkL+S96vkTKcsQ0=;
        b=GXvFjACVW16ZmnDUylunOnjHN1diPHJVbprCiqiioTXJmDcncumzCvUSm1jPhJTIF4
         0fAwzj85h5jECzD90sYUuGNkBQoMCk/iX+4Tbm78NdO8P9XyvRJE+hae0UY2AtqOKk3v
         bKNvR1MiNLKuOpt4GqiRlMhwYm+1nEgqUDV2vqsuHPx2sOORUjwqCIqU6psTtWQPTwnv
         c+GD0bPEAaQfBPfTFkE7xqgtKp3fmuglMiGTVMbvA4fSJLW0dYg41OXy7+/1LWrouxBW
         hYCa1J1U8HGtEBVp5raCiS3oCMFmvDxWAMtA+660yprU9B5waexNvJIXYDP8q0aaWEuz
         GNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UiqXPN7YvxB7B/wHyRtsw7lv+l5FkL+S96vkTKcsQ0=;
        b=BKB2/cFZBA2DCeVPKtMKE6KoEsPw+aGWgfgb+C4hPI5NYp1lZsAI6dMOVFT6+LFCp1
         Pz1WUkjFthX3U3cUX2DtNmfPstj0x4ByNrjzavTjdX6WSSO4PEO46MoW591i7sfhx9KM
         5zG+yHSEV3YMH1dYlpFJGp0h8ApDCjmkhWjypyBZD3EJcqRpRTK7dxAuonCiS4Iq/gn/
         go3wh6YioHISQNDFaFYk1puj7y0e5lyvwvLs23UVZa3O2L/hZ0boVAHlxmErNFRSKlej
         2q324ANq6llXSCg+mRXX6QPdNb+WIQ+FLZdwwkBbGNE00xYNWHrrqLUcd2l/AVcmEiyL
         Zaew==
X-Gm-Message-State: AOAM530jHz6EwIZNnDhHeWvCMScqCZzg9O6HYM4R9ix4VVPTSdzmBEQV
        jAA48AEfiOi7J8e7ymEf7Y6EG6NtlyE9pqW66DY=
X-Google-Smtp-Source: ABdhPJxL3PUnYsvfI88TsaLvoKKQOak+wp68LnElKAyE6Favo23jyuahdqOMvxFxlGA3GXuEhDbTMkmb2DU3iE47YiI=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr2397777eja.172.1637630366970;
 Mon, 22 Nov 2021 17:19:26 -0800 (PST)
MIME-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com>
In-Reply-To: <20211123003958.3978-1-chooglen@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 17:19:15 -0800
Message-ID: <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
To:     Glen Choo <chooglen@google.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 4:40 PM Glen Choo <chooglen@google.com> wrote:
>
> > @@ -3259,9 +3259,12 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
> >       closedir(dir);
> >
> >       strbuf_setlen(path, original_len);
> > -     if (!ret && !keep_toplevel && !kept_down)
> > -             ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
> > -     else if (kept_up)
> > +     if (!ret && !keep_toplevel && !kept_down) {
> > +             if (the_cwd && !strcmp(the_cwd, path->buf))
> > +                     ret = -1; /* Do not remove current working directory */
> > +             else
> > +                     ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
> > +     } else if (kept_up)
> >               /*
> >                * report the uplevel that it is not an error that we
> >                * did not rmdir() our directory.
> > @@ -3327,6 +3330,8 @@ int remove_path(const char *name)
> >               slash = dirs + (slash - name);
> >               do {
> >                       *slash = '\0';
> > +                     if (the_cwd && !strcmp(the_cwd, dirs))
> > +                             break;
> >               } while (rmdir(dirs) == 0 && (slash = strrchr(dirs, '/')));
> >               free(dirs);
> >       }
>
> I don't think it's appropriate to implement user-facing concern (don't remove
> cwd because this will confuse users) in library functions like remove_path().
> remove_path() has other callers e.g. midx.c, and possible future callers e.g.
> we're working on adding a command to delete corrupted commit-graphs and this
> library function would be extremely handy.

I think we'd want this code change for those cases too.  Said another
way, why wouldn't these callers want to avoid deleting the original
current working directory of the git process (which is likely still
the current working directory of the parent process)?  Deleting that
directory causes problems regardless of whether it's a user-facing
command (rm, merge, stash, etc.) or something more internal (midx or
commit-graphs stuff being called by gc) that is doing the deleting.

Putting it in this helper function means we protect all current and
future callers without developers having to remember which
"remove_path()" variant they need and why.

> It seems more appropriate to check the_cwd from builtin/add.c and builtin/rm.c
> instead.

Not sure how you determined that those two paths are affected or that
those are the only two.
