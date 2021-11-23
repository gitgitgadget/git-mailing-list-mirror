Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94FBC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 19:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbhKWUAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 15:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhKWUAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 15:00:15 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D8C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:57:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so96791571edd.13
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfe7QOF2qZWue53ulkFEZC7cFfVkf8LwbGM6NKLlJJs=;
        b=DgkA8cNS5beZmndTMD5ovqI0h0oAigwmzRsbxxduag5BBgvgTkczO61CvPiQKWAP6B
         EHzHbBT5/B1wanqrl9K1GTxuVBrFoIxqoQ8+2mAN1ZXcNHAS5rMVC3b8YTMJ8BZSBHsm
         GEREUVnKfuNkf6TiodQT/a3VZv0CFO5Z5gDvmyq9pxDGyF8DSVXyBQpWB2JeRFAA+gFe
         vwql6aDVLS3BYc+AvAstB2Xbta6RkiXbFGPvb6Xo7KSgAwZEtZMzg62JdARH+ibpweDW
         jW9TstU5WoMNPmKx4P/uJyQmevtyLBIbFE/yIIbPyMl4QhxKHh2lG7QFei38uUyWIQYB
         Npvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfe7QOF2qZWue53ulkFEZC7cFfVkf8LwbGM6NKLlJJs=;
        b=eF7wwp5AGRoh/EzzFxLyhP5nCFGM66H+lad/40FrRzT3yxhpdi/NYmuca1uiX2vJWR
         A98KKoufNZu6hCW51DaN/wTGEbEkjj8WXrkMFa6IOYSA0OzvzRkJy+2g3u8WpHSpl9f4
         kLm4ipv1yTqoqMMkBrl5wp4kw0T0cg3BNd9JNeqDUHibUBR6YvsdyX5n1AmeJmqJupDM
         CR3MNiCOqqMZVhanJw5nygKcP4mZvVXwdhRgPrYCFs9jiSZK46eVYguQ7Rt0mbVw2EEZ
         WoPgSvd0+j/q1ZPo6DWeYMv5An85gTL7O/GH8wypQAJ1R8t6q+yhjjsJwTujOfmPjcCV
         fU5Q==
X-Gm-Message-State: AOAM531DTtKumwTDaJ0ZZVAz02MAV4su7c7yNV+ho3VhMw8ITHB2EAus
        1HugSP0IsbQHvBOeZctiLbbx4QlGC3yxhasr+1E=
X-Google-Smtp-Source: ABdhPJzhiJwRDgnodYYtfeCxXjHPUH16q+GB+3JKjN3Tvt6zoGztqDzKD660V6ZvJfgOXbAu1JPL54ZDGMbr6m7ucl4=
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr13825750ede.0.1637697424817;
 Tue, 23 Nov 2021 11:57:04 -0800 (PST)
MIME-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 11:56:53 -0800
Message-ID: <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
To:     Glen Choo <chooglen@google.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 10:19 AM Glen Choo <chooglen@google.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> I don't think it's appropriate to implement user-facing concern (don't remove
> >> cwd because this will confuse users) in library functions like remove_path().
> >> remove_path() has other callers e.g. midx.c, and possible future callers e.g.
> >> we're working on adding a command to delete corrupted commit-graphs and this
> >> library function would be extremely handy.
> >
> > I think we'd want this code change for those cases too.  Said another
> > way, why wouldn't these callers want to avoid deleting the original
> > current working directory of the git process (which is likely still
> > the current working directory of the parent process)?  Deleting that
> > directory causes problems regardless of whether it's a user-facing
> > command (rm, merge, stash, etc.) or something more internal (midx or
> > commit-graphs stuff being called by gc) that is doing the deleting.
>
> I agree that most, possibly all, of our commands should prefer to die
> than to remove the cwd, but that doesn't justify adding
> application-level concerns to a general-purpose utility function. Even
> if it sounds overly defensive, having an obviously correct utility
> function makes it easier for future authors to know exactly what their
> code is doing and why. And surely if we're imaginative enough, we can
> definitely dream up some possible use cases for remove_path() that don't
> want this dying behavior e.g. other applications that link to our
> libraries, or some new merge strategy that may need to remove + restore
> the cwd.

Sounds like your objections here are based on a misunderstanding.  I
totally agree with you that adding dying behavior to these functions
would be wrong.

My patch doesn't do that.

> I'm not going to say that we'll *definitely* need remove_path()
> in its current form, but mixing concerns like this is an invitation to
> unexpected behavior. An (imperfect) example that demonstrates this
> principle is https://lore.kernel.org/git/24bffdab139435173712101aaf72f7277298c99d.1632497954.git.gitgitgadget@gmail.com/,
> where we made a change to a generic path matching function in order to
> speed up unpack_trees(), but accidentally ended up breaking gitignore.

There's no mixture of concerns; my patch is correcting this library
function to more fully match its documented intent; from dir.h:

    /* tries to remove the path with empty directories along it,
ignores ENOENT */
    int remove_path(const char *path);

Since the parent process's current working directory is still likely
parked in that directory, there is a good reason to treat it as
non-empty.  Thus the cwd should not be one of those directories
removed along with the specified path.  No need to die, just stop
removing the leading directories once it hits the cwd (much like it'd
stop once it hit a directory that had files left in it).
