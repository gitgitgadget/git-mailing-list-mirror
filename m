Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F034AC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbiF1K2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbiF1K2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:28:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B8BE0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:28:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u15so24768702ejc.10
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=a/YMDr0+0IdNBu83de//EST38m73ajszSSoZ7XME5xk=;
        b=cs2Z/hK/3tAYKeBvG6o3DoDeRai43jlc2kt9sLChT+RevXY2n9vMbp50KJmIPlJXPv
         v42c/4Dx7EnRkOuVb2posqLetdUB0kskKa6fvhXancfV5jarfV3S/YP1fIOn8/3lE1A4
         1qesVdd7qY6+E1AIBvbnsgdAfAB8+9K73ou+d3SDn7Km/Xx8/5bHlpys8s+SKb6ZkqI/
         9NDWqUsWLSIXQyUgxYodNCAB7ky9pVYr3ED+M4an62cVABn2kZICNwvkqkzuRdyw7jkB
         9qS5Pv/UkHRc4QqsnrcpXJ+7WOJ05PQXq5QOeIEXZB+vKcHnZBG6LS7fDbmPFlHOysJS
         ipdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=a/YMDr0+0IdNBu83de//EST38m73ajszSSoZ7XME5xk=;
        b=hsJ5UslBwTDIeClwQVitSYrsUx9Hzp5YjaaIDNHIwPm64hC2FuhRfkyEbX13sBZ78P
         +gDCxQvnj/glxzBVjL2bP/4PveKg0+jR5tycKKF+/a6Z12iV7/kD6CJMuTa8d9NDmagf
         twCJKzOrklJbIj5sZRNwP246GcHDn55KuZaUeqDMTHD6KztKda5+z7P6fBZ2vfr7SuNT
         uYfB+ND7bKsWUDZaGtv65yCQm21TPh/X+FwTS39bgIF84P34ZCPETO/d6mQqN+kfJpqk
         PzeJ7OpNLK+3MFsKHBegwK3UBvsMoHHcQ/BduzBeA4OL26NICZx8tkSs0uw+U5XaKKsY
         Gyzw==
X-Gm-Message-State: AJIora+i3dfwn+zBFrHYUatkv8yoqObnGrnLNOR7PtIIlK5XdEp7Nzjb
        Je5n4xiiR93xZRKXrAth9qg=
X-Google-Smtp-Source: AGRyM1txzGISn+EQCVWn5rdYtUvZ2W7bxGe3KSIAh5kGnPagFgJV9H8ujGPGUazhsCWgLZY16bwA9Q==
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id i4-20020a1709064fc400b006dab4c6fadbmr17479670ejw.282.1656412084914;
        Tue, 28 Jun 2022 03:28:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bo5-20020a170906d04500b006ff0fe78cb7sm6221003ejb.133.2022.06.28.03.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:28:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o68Rt-001p1u-NR;
        Tue, 28 Jun 2022 12:28:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] git-rebase.txt: use back-ticks consistently
Date:   Tue, 28 Jun 2022 12:22:18 +0200
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
Message-ID: <220628.86k091f5fy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

This looks 99% good, but...

> While inspecting the 'git rebase' documentation, I noticed that it is
> inconsistent with how it uses back-ticks (or other punctuation) for
> identifying Git commands, command-line arguments, or values for those
> arguments.
>
> Sometimes, an argument (like '--interactive') would appear without any
> punctuation, causing the argument to not have any special formatting.
> Other times, arguments or 'git rebase' itself would have single-quotes
> giving a bold look (in the HTML documentation at least).
>
> By consistently using back-ticks, these types of strings appear in a
> monospace font with special highlighting to appear more clearly as text
> that exists in a command-line invocation of a Git command.
>
> This rather-large diff is the result of scanning git-rebase.txt and
> adding back-ticks as appropriate. Some are adding back-ticks where there
> was no punctuation. Others are replacing single quotes.
>
> There are also a few minor cleanups in the process, such as one place
> that did not use tabs for the first paragraph in a bulletted list.
> Another case still referred to the dashed form, but it was the only use
> in the file except for the heading and NAME section.

I think the commit message should speak more matter-of-factly & briefly,
i.e. just "change so and so...".


>     While I noticed this inconsistency when looking at git rebase as part of
>     the git rebase --update-refs work, I didn't know the best way to update
>     the document from start to finish.
>     
>     This giant update is probably not the best way to present the change.
>     
>     I can see splitting it up in a few ways, but I wanted to check to first
>     see if that was necessary. If it is, then here are the strategies I
>     considered:
>     
>      1. Focus on type of update. This would mean a change for adding
>         back-ticks on all --<option> text, adding back-ticks on all "git
>         rebase" instances, adding back-ticks on things like <upstream>, and
>         doing other types of changes like whitespace updates or "git-rebase"
>         to "git rebase".
>     
>      2. Focus on the section of the document. This would limit the diff by
>         the section size, such as OPTIONS or the discussion on the backends.
>     
>      3. Focus on the edits that most-recently edited these lines. Doing some
>         scripting, I was able to construct this date-sorted list of previous
>         edits (by diffing the git blame output before and after this
>         change). The most-recent changes before this are:

I think this is fine, but I want to recommend doc-diff in your toolkit,
e.g.:
	
	$ Documentation/doc-diff HEAD~ HEAD -- -U0|cat
	diff --git a/e4a4b31577c7419497ac30cebe30d755b97752c5/home/avar/share/man/man1/git-rebase.1 b/e37244faa0a730bb930dac4e10d8eed4af682a5d/home/avar/share/man/man1/git-rebase.1
	index 91ccda823b2..41dfbee38a4 100644
	--- a/e4a4b31577c7419497ac30cebe30d755b97752c5/home/avar/share/man/man1/git-rebase.1
	+++ b/e37244faa0a730bb930dac4e10d8eed4af682a5d/home/avar/share/man/man1/git-rebase.1
	@@ -489,2 +489,2 @@ OPTIONS
	-           Append "exec <cmd>" after each line creating a commit in the final
	-           history. <cmd> will be interpreted as one or more shell commands.
	+           Append exec <cmd> after each line creating a commit in the final
	+           history.  <cmd> will be interpreted as one or more shell commands.
	@@ -502 +502 @@ OPTIONS
	-           If --autosquash is used, "exec" lines will not be appended for the
	+           If --autosquash is used, exec lines will not be appended for the
	@@ -880 +880 @@ NOTES
	-       When the git-rebase command is run, it will first execute a
	+       When the git rebase command is run, it will first execute a

I see Phillip spotted some of this already, but the "exec" change here
looks unwanted, i.e. let's use double quotes there.

For the last hunk I'd think just:

    When rebase is run, it will...

Would be briefer & better in that case.

I also see that we have other spots in our wider docs where we use the
dashed form, I'm fine with converting this case, but maybe better to
leave it aside to make this only a ``-quotation change, or to split up
this & the whitespace & other things you mentioned into another commit.

Any way you're OK with is fine with me, thanks for fixing these.
