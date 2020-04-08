Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D97C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D82C20769
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRwIqMt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgDHQeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:34:03 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34561 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgDHQeD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 12:34:03 -0400
Received: by mail-ot1-f50.google.com with SMTP id m2so7417266otr.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJmEOgXk6DV1x9HmS+P3bzpvE5N1NCEDu/qEqkGTfMI=;
        b=IRwIqMt5KFocK7NC5Y3llUzAgRCzHRrSSf5Pa1MackPszxN5zc+wpcnnZnZZRUa9l4
         wwqz86ow8Ljv+6Fnl/yyZN0nCh18XFszOKqGRQ+QJzqpNUq1XY3eESe1HQ5JHPtYuujB
         3VVTBRG81Kc+QCWoF7CqvHwyMByzZADS3p7mO1OablfUqz/H9/Xo4MGBD6i1Pw20ljNV
         3W6K4UWt4Ldar3cPk48SMD5YTUaHhJAaZjaUXqYdUc0pEl7b2mo/BHjXemZ62qEpmNqY
         +pzWeIY0CwRG9kv+GW5Q+92RC3KyltOeAvxSa/y8I03rYsKUUhSWvbowIncH6Az2ztHU
         PXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJmEOgXk6DV1x9HmS+P3bzpvE5N1NCEDu/qEqkGTfMI=;
        b=fRruAOOyBsLZD18rV6UKcyitdtRKhZYtnCqONEdNI3dU+H2iUomy4WPNpdt4jBc4ht
         PbGpgD3ii4nLLw5oPC3oBSe7iInnPREhA9VQlNWUboIsJIEWyPTZEYI8kp7Tt2xiH8Hr
         u+n4JrQLZhfFYImxNr4MP0GMrOYPUr0/277pq7CV833Ylr5RlpmraVd31c9U5WWr7NYV
         h5jGbd3VxvaT+FYEWswlpfDVAjsfYYabxcRwAecxkltAkm9/xFL7HBi1H9HKZhSHSPhN
         pv9Rcf+WOqgSVtC3k0UopuVgmvf0+ehLjhgqL/F5/XiWi3EQPoHkSkHbHyncxqkyr0CK
         le4Q==
X-Gm-Message-State: AGi0PuZPgj3HxhxoywSp6W1h/7zXoobsBuQGrDfKIxyS264t6YkIWMMi
        KYzCCxf0M1KWMIHUiRZXDB7YvvQwvFs4QvZ8rYJchKC3
X-Google-Smtp-Source: APiQypIHJwGS9Ma8MdGZAksc0PVY9ZQJaT7kGXEfiDGuoXPyx5F6bEtpp3YH6KWWESJaUscfsXM5ndG0jMittD8seUc=
X-Received: by 2002:a4a:9451:: with SMTP id j17mr6536514ooi.30.1586363642469;
 Wed, 08 Apr 2020 09:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <1540391834.807942587.1586332379241.JavaMail.root@zimbra39-e7> <907083995.810443848.1586362984955.JavaMail.root@zimbra39-e7>
In-Reply-To: <907083995.810443848.1586362984955.JavaMail.root@zimbra39-e7>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Apr 2020 09:33:50 -0700
Message-ID: <CABPp-BHtwTmTT0R7Mu3=YQ=sPDcuvkXqutBjTTBECW4MXQoYWg@mail.gmail.com>
Subject: Re: [BUG] submodule move badly handled by git-rebase
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 8, 2020 at 9:23 AM <ydirson@free.fr> wrote:
>
> This may be related to another funky behaviour I just noticed, linked
> to moving submodules around:
>
> - when initially created, the $TOP/orig-name submodule's git-dir gets created in
>   $TOP/.git/modules/orig-name, with $TOP/.git/modules/orig-name/config
>   containing a core.worktree value pointing to $TOP/orig-name
> - when moving the submodule, only the submodule worktree is moved, the git-dir
>   being the same $TOP/.git/modules/orig-name, where the core.worktree still
>   points to the old location
>
> Other unwanted behaviour include "git clean" reporting (and possibly cleaning)
> files from the wrong work tree - it took me head-scratching to understand why
> "git clean -fdx" was ignoring all the cruft I had in this worktree...
>
> Why is it that we need a core.worktree setting at all in there ?  Removing it
> allows "git clean" to do what's expected of it.  OTOH it does not make the
> original problem go away...

Not knowing much about submodules, I'm going to leave submodule issues
that don't touch on the merge-machinery or rebase code to someone else
to handle. (I'd probably do the same with the merge-machinery and
rebase side if I wasn't worried about 2.26.0 regressions in rebase and
if I hadn't find a clever way to re-use checkout code to avoid lots of
submodule issues while also deleting code in the "ort" merge
strategy).

Hopefully someone else on the list who knows more about submodules can
chime in on the worktree related bits.
