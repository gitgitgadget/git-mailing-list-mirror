Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FADC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLQPYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 10:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLQPYA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 10:24:00 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C06BEE05
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 07:23:58 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id x38-20020a4a97e9000000b004a5d69cfc90so809221ooi.6
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8R6E/5QVpGgcoVxiEmho9IbWMCULh+lsa+EGf6Ej2og=;
        b=DuHVITsGIqDi0VjGAapSgQ1tEf1TRY62xQ+ST+tgVLD63eGTY46WzguWe5UCr0ZDpA
         03e8XDyzASu4NPQxq7aNjI0tDgZZtbMaQ6aMGxwS8mjV8hp/yDahbXjhwfuOq6/OSyCG
         +q8/1p31bbxjn9EXpZfBnYaA29M05ugf9DyywgjxgWdSMo8xbbyE86XdsXRFxR9B4KU2
         qvVWp1Xqi2GInI3ghZeGtRPZdvcElqjEIRXfM795zrUHTNdgzlxAbfGQYo0lqXSedkSa
         mhA9CDmF3M44BTQCM534jGExAYBm9C0btq915R0ak297EtjnnVaKWqjinCupzwtyDMvu
         kLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8R6E/5QVpGgcoVxiEmho9IbWMCULh+lsa+EGf6Ej2og=;
        b=zkTp2vPiXG8MXcbsZk2UlJmWLRk1roKj17ozhzPktdGZxIdg9+b0o7YZqhXZLrlL/M
         dXgj3MgnIXZhVq6hHVGd8lqau8IJP+O+u8yqI10+rBawBMzcFBPTUXaJ51z1ZFD1cmgP
         BTb+FVkpHQg/Pucr15YKAnLDDJ5TpeBBtxgWUInde0XXt8pgPcVTmosyqvFMH7fMQS5Z
         4km9QlbgTXLqCz34bL/sGnq5DXNiPDBVcZ57xY50hsZ8SLXHypwG6WyOgKAIynMmmQjj
         WPTTzpeOmxnzElXgnDm6qCzC40LlOuHOvEZtSNTw0OdpFgUgylYDCmhNmc41eh8q8kSP
         Le4w==
X-Gm-Message-State: ANoB5plAPmpZgL8puLXqxetG9m7MsQBpEQmuitOPdwMSAqdWlWSTV7Aj
        mxSOp46n1RKf/mkTeJALp7Ev/ItZJ4EZai2kNgnYPrehWYiLIw==
X-Google-Smtp-Source: AA0mqf5P9p2mQv+XZmtKMZzEPUP39Ep022AkCm+FL8qql6LEz54PCdHVM5wduPQ7AxnUiAscGvpTBdf5AbydnoZZNLc=
X-Received: by 2002:a05:6820:1b15:b0:4a0:91e7:8b51 with SMTP id
 bv21-20020a0568201b1500b004a091e78b51mr12275730oob.64.1671290637708; Sat, 17
 Dec 2022 07:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20221216093552.3171319-1-karthik.188@gmail.com>
 <20221216093552.3171319-3-karthik.188@gmail.com> <xmqqr0wykj59.fsf@gitster.g>
In-Reply-To: <xmqqr0wykj59.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 16:23:31 +0100
Message-ID: <CAOLa=ZSo7zMVB6c-9gjAS-1zKkdVbRmUV02q4hT_LbU8dAt0tw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2022 at 12:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > ... to optionally allow the users
> > to check attributes against paths from older commits.
>
> The above makes it sounds as if attributes are taken from places
> that are unrelated to the "older commits" and the point of the
> change allows "paths in an older commit" to be inspected.  I do not
> think that is what is going on, though.  Isn't the point of the patch
> to take attributes definitions from arbitrary tree-ish?
>
> Also, "older commits" is misleading.  You may be chasing a bug in
> older codebase and you have a checkout of an old commit, but you
> know you have corrected the attributes definition since that old
> version.  In such a case, you may want to take the attributes from
> the latest release and apply to the currently checked out working
> tree or commit that is older.  That is checking attributes taken
> from newer commit.
>
>         ... to check attributes taken from a commit other than HEAD
>         against paths.
>
> or something, perhaps?
>

I agree with your wording, it's much better. I'll stick to it.

> > Add a new flag `--revision`/`-r` which will allow users to check the
> > attributes against a tree-ish revision.
>
> "tree-ish revision" sounds a bit strange.  We used to use "revision"
> very loosely to mean an "object name", but we weaned ourselves off
> of such a loose terminology over time.  These days, the word
> "revision" only refers to a commit (or commit-ish).
>
> I would understand "... against a tree-ish."  If you feared that
> "tree-ish" is not widely understood (which is a valid concern), then
> "... against a commit (actually any tree-ish would do)" is probably
> what I would write.
>

Thanks for explaining, I somehow keep associating revision to be the universal
set, which consists of tree, commit. I'll use your wording though.

>
> > Since we use a tree-ish object, the user can pass "-r HEAD:subdirectory"
> > and all the attributes will be looked up as if subdirectory was the root
> > directory of the repository.
>
> Is this meant to explain a feature, or a misfeature?  In other
> words, when would this be useful?  I would omit this paragraph if I
> were writing it.

It's a misfeature to be honest, I think it was called out in the
previous version
of the series. I'm happy to drop it, because I initially didn't include it.

https://lore.kernel.org/git/674caf56-940b-8130-4a5e-ea8dc4783e81@dunelm.org.uk/

>
> > We cannot use the `<rev>:<path>` syntax like the one used in `git show`
> > because any non-flag parameter before `--` is treated as an attribute
> > and any parameter after `--` is treated as a pathname.
>
> I do not see what this one wants to say.  <rev>:<path> is an
> established way to name an object that is sitting at the <path> in
> the tree-ish whose name is <rev>.  The user can use "-r
> <rev>:<path>" and if the <path> in <rev> is a tree, then all the
> attributes will be looked up as if <path> were the root.  So the
> users can use the <rev>:<path> syntax, cannot they?
>

Yes ofcourse, this one merely is stating why we cannot use `<rev>:<path>`
directly (i.e. without the --revision flag).

I'll correct it to:

    We cannot simply use the `<rev>:<path>` syntax without the `--revision`
    flag, similar to how it is used in `git show` because any non-flag
    parameter before `--` is treated as an attribute and any parameter after
    `--` is treated as a pathname.

> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > Co-authored-by: toon@iotcl.com
>
> Co-authoring is fine, but as one of the copyright holder, the other
> author needs to sign it off, too.

Can I simply add this, or does Toon need to provide his approval on this list?

-- 
- Karthik
