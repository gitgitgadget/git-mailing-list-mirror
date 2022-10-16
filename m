Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21156C4332F
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 02:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJPCID (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 22:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJPCIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 22:08:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C293DF18
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 19:08:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a25so10259515ljk.0
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 19:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6KGhPnNRRC47YNb4qAFy4gEQujrZVP3wRWehblcnfM=;
        b=Io0a+ExakX5CjlaVBEvfJEcr4quA0A91BoBHq6qcKSEph8CkKCo6rsknxTfteOe6by
         Vmhb9vUVJi702Z6RMaR47PJ0pGqGyocqwnhds3EwufiuFO5jyQRulSRxKpOvD/sfha6d
         QawMYx+Wat/PUMeVOI0Nefgjb/Kq0PQ7ntYBnLbPiaeF14dpv3ASdfJp+btnPRdshYfh
         NlWqgKSUtJpWbp/B6TQuMTNF8mmWH2MgvxfRBAgiYo5ADweTKVT3TqPXzrHWxnw+H3jI
         zujkH9Lya99IIXyQbzyOG/41XmuTi37i7j0mFtKM4QAiWCKyWmMcJgZIdaQdZVTYSJSA
         v10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6KGhPnNRRC47YNb4qAFy4gEQujrZVP3wRWehblcnfM=;
        b=6RPRugoFtBMd1//JnmqMQHuMI2AbPsaak7p39RzNByAL22EihOiI3K+qrEnh6wcvFP
         nUbQ3tjhnrXwP3DqLFZbqx69LqR6cUhKE0kzWmYJtLDmyzQ9QxjeLqy2nzHYG5cYaQ6Z
         bHZfq7LqHEbM/aX7F1iaBJlgMr5K1gYZRdBBeGec2GhmY6KxLmjMcpvJ9eW65vFgwuyV
         Wmdy3+otohR3LEdA+SZvIWqzEYCrXOxfXQS7oHAQp6NJ3YnKtM70BkmwmvDWDOk4nYB0
         uqN/xMoycSaBl4RfQccKokjIQYyfN+Lb/+gMqiwoHkaJXFckUJPIhpxHLsmDt5QRJTQk
         dNIw==
X-Gm-Message-State: ACrzQf3/rLiJU0ITI8+Td3AKuC5yJ3E7cFMbi+m5nr/GiGga9Lsl5G3e
        Cj1X7wrc1TP/ZOs56U2cdGNiZco+E+JhXFx5sZnwka4r
X-Google-Smtp-Source: AMsMyM564SmjQlTFefkYiAYl6wTDvTM4iQH647iPyzv+T2COFsD70nGw1Aq8VPJO1hTVVOsc4aNQjsUZEOyLtSCM+40=
X-Received: by 2002:a2e:5d1:0:b0:26e:1d6:eb2f with SMTP id 200-20020a2e05d1000000b0026e01d6eb2fmr1862457ljf.194.1665886077738;
 Sat, 15 Oct 2022 19:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
 <xmqq7d11540b.fsf@gitster.g>
In-Reply-To: <xmqq7d11540b.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Oct 2022 19:07:45 -0700
Message-ID: <CABPp-BG=pm8gfRZNW8Rk1V77s40Do1FZy0mxH6epubHbzF8U5w@mail.gmail.com>
Subject: Re: [suggestion] Fail cherry-pick if it overwrites untracked files
 with the matching file names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rupinderjeet Singh <rupinderjeet47@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2022 at 12:23 PM Junio C Hamano <gitster@pobox.com> wrote:
[...]
> Files in a working tree controlled by git fall into one of three
> classes.  Tracked files are those that are known to the index and
> appear in "git ls-files" output.  Among the others, ignored files
> are those that .gitignore mechanism says are expendable.  The rest
> are "untracked", possibly containing valuable contents that should
> not be lost as the user may choose to 'git add' them later.
>
> Not just cherry-pick but any merge-related operations, including
> "checkout", follow this semantics.  Untracked files are kept, but
> ignored files are expendable and will be removed if they are in the
> way to complete the operation the user asks.
>
>     $ rm .gitignore
>     $ git checkout master
>     error: The following untracked working tree files would be overwritten by checkout:
>             file
>     Please move or remove them before you switch branches.
>     Aborting
>
>     $ echo file >.gitignore
>     $ git checkout master
>     ... this should succeed, removing "file" whose contents were
>     ... marked expendable.

There is a command line option meant to allow tweaking this behavior:
--[no-]overwrite-ignore.  The default, as Junio explains above, is
--overwrite-ignore.  The --no-overwrite-ignore option works for `git
checkout`.  It also can work for `git merge`, but *only* if the merge
results in a fast-forward.  Although there is code in unpack_trees()
to handle this alternate behavior by just setting a simple flag, we
don't bother setting that flag in most merge paths even when the user
specifies that option.  It was just never hooked up.  And several
other related commands (am, reset, stash, rebase) don't even accept
such a flag even though for consistency they probably should.

I've been meaning to get back to it and hook up this command line flag
for the occasional user that wants this alternative behavior.
However, it's not an issue for me or the direct users I support, and
complaints about this behavior from the community are quite rare too,
so I just haven't been too motivated to work on it.  If someone else
wants to take a stab, it should be pretty easy.  Just grep for
"preserve_ignored.*FIXME".  And maybe read up on these two commits for
context:
    04988c8d18 ("unpack-trees: introduce preserve_ignored to
unpack_trees_options", 2021-09-27)
    1b5f37334a ("Remove ignored files by default when they are in the
way", 2021-09-27)

Maybe I should just tag this as #leftoverbits to see if someone else
picks it up?
