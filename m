Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04028C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 20:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhLMUKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbhLMUKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 15:10:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1EC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 12:10:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r25so55464493edq.7
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFzenTYuTY7dNwmvsKZCmXSDLsyzGgmgiuRRD3WIaLg=;
        b=SF0MU+ofQXg9jCcuRzELD2MbVjXD5fmXcnLqImDfFUw3T16GTJw6bLl/cU6rYDGoes
         EXPH+tEqgMw05RV4+K5pyVvk+pLV3BhsC+3IiCLLN7vjzyJbbdrf448JmQfkcnghVJTw
         L+aQozAb+w1/VEtwa3zaHEXFKfFjYayKuucy77TUXUHXTnKC3gQGOPBT0aPLGbaycW2j
         rnSvLrIpM8nJo51ezrWHYZbXZv3gJWQjc5Rc5CsMyZ7GWzyDWvGDunTQxk+KnDsjBCPF
         ZI93xJIESVfl4zmfdfF2JAyB1SxoQThlyCzpegySMhxjP+xWkOZ0NY9xAPAcALO4A5vK
         u7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFzenTYuTY7dNwmvsKZCmXSDLsyzGgmgiuRRD3WIaLg=;
        b=3OWzzmr22SNzcn1JQs0IG54TL8ryKMLG35pRhzwZBQiiSroQJyBGfZ7vaCMvlgf3xG
         im/7+CrRkq+/68tCOiMj6D76tcRHn1LE597rKuM/+Y4HvuHnVv18EUpbNywEWzEYPYia
         4PD5ZFE/igMll51nc2MSpa8bxV17rOW39+hPRySRgKluy8ZIRMZyjRj4Yntfmex2EdOB
         BEhK+HlYKCo0UdpwEHDNytZLNKQMRo9hLRPz4ff1XSz4mbA8olvqe7dBhl2zwAwEbdT/
         yxIK6y5xXzSms1fZtJMOo3/hv3WWSEZl6IJ/uYWu5cfymET64Ab9wIo4p4I3rArR7KiG
         XMow==
X-Gm-Message-State: AOAM533ckmoz3tP22SOc9FrsWnw4NWhpD+yMZOK7PCBk9pCk5A5LxR+a
        hQwCEPl0TN+LML/bFLOJKn8D0ghwVAPkSiSUtCbHO0n44aI=
X-Google-Smtp-Source: ABdhPJw6l0ecqwanMMmxMNh05rvkLQatTRlVpdVkIRZh/zBwxlvHqsiHnGZI5L3ajDYvQ3QLx2tVl+VmkZAKvhpf5+4=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr1338017edu.186.1639426242629;
 Mon, 13 Dec 2021 12:10:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <2501a0c552ad5147f61a96b9ebe45c5199e1dbfd.1632760428.git.gitgitgadget@gmail.com>
 <CA+6di1m91q70PfaFq0DKMsmd_Tb6XBB7H9AYPhwawX12cZgtGQ@mail.gmail.com>
In-Reply-To: <CA+6di1m91q70PfaFq0DKMsmd_Tb6XBB7H9AYPhwawX12cZgtGQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Dec 2021 12:10:31 -0800
Message-ID: <CABPp-BEZj4opBu+wo2whOCHrck1qMjZXfDY9tAE5FbB=Wr9F_w@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] read-tree, merge-recursive: overwrite ignored
 files by default
To:     "Jack O'Connor" <oconnor663@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 9:12 AM Jack O'Connor <oconnor663@gmail.com> wrote:
>
> > read-tree, merge-recursive: overwrite ignored files by default
>
> When this patch shipped in v1.34, a test broke in a project of mine
> (https://github.com/buildinspace/peru/blob/e9ba6e0024ea08105a8d027f958899cca39aeb9a/tests/test_cache.py#L111-L117)
> that was relying on git read-tree *not* to respect .gitignore files.
> (Obligatory https://xkcd.com/1172.) That peru tool is using git
> plumbing commands to manage trees of files, but it tries to keep this
> implementation detail internal, and behaving differently in the
> presence of a .gitignore file belonging to the user would leak this
> internal implementation detail. I've been trying to figure out a way
> to reproduce the Git 1.33 behavior in Git 1.34, but so far I haven't
> found any flags or configs to do that. (For example, putting !* in
> .git/info/exclude doesn't seem to help, I think because a .gitignore
> file in the working tree takes precedence.) Can anyone suggest another
> workaround?
>
> This is my first mail to this list, so please let me know if I mess up
> the etiquette.

Your email is fine.  :-)  Interesting usage case; thanks for sending it along.

Digging a bit into your repository, it appears this all started
because you noticed that checkout would overwrite ignored files, and
so you switched to reset --keep (in your 637d5c042262 (make cache
export refuse to pave .gitgnored files, 2014-07-22)) and then to
read-tree (in your 057d1af600f9 (Rewrite `export_tree` to allow
deleted files., 2014-08-05)) to avoid having ignored files be
overwritten. You could have stuck with `git checkout` all along, and
just passed it the --no-overwrite-ignore flag.  You probably just
missed the existence of that flag, because Duy forgot to document it
for 8 years (see git.git's commit 9d223d43e5 ("doc: document
--overwrite-ignore", 2019-03-29))  Going back to checkout might
provide you a workaround.  (Also, another random thing I noticed while
looking at your repo: `--diff-filter=d` is a much better way of
checking for not-deleted-changes than using `--diff-filter=ACMRTUXB`.
Note the lowercase 'd' rather than uppercase.)

Your report suggests more places should accept the
--no-overwrite-ignore flag, which I alluded to as a possibility in the
sixth patch in the series ("Remove ignored files by default when they
are in the way"[1]) and the comments in the cover letter about
precious ignored files (under "SIDENOTE about treating ignored files
as precious"[2]).  And perhaps we could have a core.overwriteIgnore
config option for setting a different global default (also as alluded
to in my cover letter).  Doing things would provide additional
workarounds, and finally provide the "precious ignored" concept that
has been discussed occasionally.  I think it's not too hard to do that
on top of my previous patch series.  I'll try to take a look after
some other in-flight series finally land.


[1] https://lore.kernel.org/git/b7fe354effff8da3de53bd9cc40a03b5fd455f67.1632760428.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
