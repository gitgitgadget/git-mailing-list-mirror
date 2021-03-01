Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F1C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E17D65024
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhCAQmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 11:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhCAQjh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 11:39:37 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3FC061788
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 08:38:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id c10so2874029ejx.9
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GUMmC0TIpS8Q9CdWm0bgP04j709MjLPYHhVhmMwbvWg=;
        b=kxQPyTTtoHf6hiz1EbTsmEKlO07pn7ThpkpKPZ9KmH2Qdfk3cJc0CrMqwZMirIEyj9
         qQcT071/yFr4MbViR+YsjHfAzO2LXumrI39oBbQ6yvrKg2X93vO6Zr4HTqgtemKGhAKX
         ewUOehV1vE9eBZo4F17JU4u2baBhK+6pq++rqNSBeihhxvBECmbP84euxHNzzJxtlQjG
         7zi/9hhVji1Mao4BNxsWfgjbu0OkxAnkkWQ52mUz23lHOBXbfG9xUi/MidRMhcbkHEPD
         2LedffJwKAgN4n6UO/7zZwcDxv8Z9QZhYNmJkPcqMsQqh+yEN+5OEOuUnpZ+1WlkzjeS
         FusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GUMmC0TIpS8Q9CdWm0bgP04j709MjLPYHhVhmMwbvWg=;
        b=nrs0+dFYgGxMLbURHKEa7nzHER1YnNbWklpjspRd0L0Bq1cgosYUeNnYR4kqQAxAxP
         qsRLdf5/gf+SDNvkaZkx6OFs+TGoukje0JPiYRQx464qZILDJ58CmAqMXrLgerCNAbre
         Q6ivNN/rUe1eBVyqs28vIFuoyYUZJh7zvwFxBdg9n0m7VsYKZmlxBSgvQEO7r3O0JOSi
         KfxR6CdgaoUhIDqO235Ot3CWOCyV9yaWk/JS+NltRight49ifQ+FLOIwlRZfgyTnQ7xb
         tjr1MKNU7XTQNXisTpoYaO8LS/X+mvFcEaw/Z+J79+HbYRj7mGaMs+crxaauNHavPqet
         qfyA==
X-Gm-Message-State: AOAM531QBrpRNeIl5szLlx0Ft0z+a8/lXmqLleX5lj1zJYAoIbAZyjKX
        hvUIeUIojQZmolVV0V79QWb101y5KZrGQw==
X-Google-Smtp-Source: ABdhPJyqjfBpeTbMuWT736L0jCEiCPRJ7NCEvwLgbOCBySSDVUB5UaixwU1+QhRJb1MksA0G48G+sg==
X-Received: by 2002:a17:906:d71:: with SMTP id s17mr17348851ejh.126.1614616724508;
        Mon, 01 Mar 2021 08:38:44 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bo12sm14503522ejb.93.2021.03.01.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 08:38:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sean Barag <sean@barag.org>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] git submodule update --remote assumes 'origin' remote
References: <2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com>
Date:   Mon, 01 Mar 2021 17:38:43 +0100
Message-ID: <87lfb6kewc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 01 2021, Sean Barag wrote:

> I think I've found a bit of an edge case in
> `git submodule update --remote` [1] that got easier to reproduce in
> 2.30+ under certain configurations.
> `git submodule--helper print-default-remote` defaults to 'origin' when
> run in a submodule in a detached HEAD state or on a branch with no
> remote tracking branch [1].  In git < 2.30, the only way for that
> default to be incorrect required a user to manually change remote names
> with something like `git -C ./some-sm remote rename origin foo`.
> `git rev-parse`ing that ref would naturally fail, but at least it's
> because the user took manual steps to break git's assumptions.
>
> Under git 2.30+ with clone.defaultRemoteName set however, submodules are
> created with that remote name instead of 'origin'.  The same behavior
> occurs, but this time without direct user action - only a simple
> `git submodule init && git submodule update --remote` is required.
>
> I'm terribly sorry about that regression - I've only just started
> working on a few projects that use submodules heavily and probably could
> have found this sooner.  I'm happy to fix it, but would *super*
> appreciate a little guidance.  It seems the intention is "use the remote
> that has the url found in the superproject's .submodules entry", that'd
> require `git submodule--helper print-default-remote` to be called from
> the superproject from what I can tell.  I've experimented with
> introducing fallbacks to `remote_for_branch` in `remote.c` [2] as an
> alternative:
>
> 1. use remote tracking branch; or
> 2. if there's only one remote, use that; or
> 3. if config.defaultRemoteName is set, use that; or
> 4. fall back to "origin"
>
> This seems to work (at the very least, no tests fail?), but leaves
> `cd ./some-sm; git remote add foo bar; git remote rename origin baz`
> open to the original behavior.
>
> Something tells me y'all will have a very simple solution that I'm
> missing :)
>
> Again, I'm so sorry for introducing a regression here!
> Sean Barag

Just a quick note, I gather you're talking about de9ed3ef37 (clone:
allow configurable default for `-o`/`--origin`, 2020-10-01) which was
first released in v2.30.0.

Just noting that in the context of this bug already being in a release,
since we're now in the 2.31.0-rc0 period. Meaning likely not a release
blocker in the next few weeks.
