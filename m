Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2498C63697
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB7D22256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 16:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iip/qq+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgKSQJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgKSQJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 11:09:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3EFC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 08:09:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m6so6990505wrg.7
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 08:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=09YB0Nj91zcYk+AWqqy16fxDsdv1TTEU4umW9MMvr3o=;
        b=iip/qq+eViGqtlzQPdjaMuzT1oSQ0pHnCjC6i4LXc32bpyrv4Luuvz79EJYB610Cmi
         rwDEWXeK3z8ZnvfWC5CNOpNLhWlzxBCyjaAjyAZAn3uFtyVadxYlSrqbNN5RrJQ74yc4
         4H3O/6hc7MMFi4wMoozn3ZJ5ur3DcghLksg4t5deTS96oWwfMg7KoYZX2mPOHzS6h4JN
         bhoOMr9PXA52R7BhHKDOsmA+f35aA4CGNzgvMU/XvbuOfwqPpIrCrckN+eM+ro3DgbDT
         mCdb/y5FPh8UvOTh63NpMtWKCeZtK/VKe7dlWSwB/bUsg5/VS2/zTe0NzZgYSrz4wr47
         Afrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=09YB0Nj91zcYk+AWqqy16fxDsdv1TTEU4umW9MMvr3o=;
        b=fhIQ7lmwdXcjGGHWF3Gm7Atl0s98288OvQcwmqW7kX7uLJhd6eO6N2A+UbyOPUPn54
         Ag7+xL+/saNSJZuwDU2uvYQoDquCr+pkkVwxjR20MMX+tHYLfUDfh9ioF5l4vbt1NJj8
         Yyer6X14Kgp5Vi7vFrUi4IrWTVhBOKp58v6qI/o/k6gZk/L/vGB1Pjk60/rvpwUNK6Xj
         P9/DdXT3O7wwJHBdsGOWAaBAM8DVIJOXi05wtT/2+vaGM8qLA1jcpGbv2y7GEKZ91OnC
         O7Fn+G5tixnS/cmu7wF4QY6MhKS7G0DrdeadSP6fOo86AnfDsOzR+w3yRVJV+DFyjkpo
         wucw==
X-Gm-Message-State: AOAM533t8wT3titAQSwNWedS/yJ/jn8KuNYDSsoblcxk0k6gkDoYaQyk
        Ys5ma1heU7hNmxKZT4f1nvM+SD/R9L6HZfWEL2J0s0G6ej4epA==
X-Google-Smtp-Source: ABdhPJzcCSkjuvfLsLuZaxUcHlDypWxMT+K82OeFMlYpPkEtS3BEd/1lQcxwkMWToSYkP00EvJL70rfSrndf1Zh+hUo=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr10867597wrr.319.1605802177448;
 Thu, 19 Nov 2020 08:09:37 -0800 (PST)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 19 Nov 2020 10:09:26 -0600
Message-ID: <CAMP44s1uMwRb=0rmU48R7F5GsDkHz5M0WubmnfaMgAtJRYzC0A@mail.gmail.com>
Subject: git-completion 1.2 released
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git-completion is a friendly fork of the official Git completion and
prompt scripts for Zsh and Bash.

The main goal is to provide a more up-to-date completion for Zsh (I'm
the developer), which is basically just a wrapper around the Bash
completion.

Compared to Git upstream, you get many benefits for Zsh, for example:
no extra unnecessary spaces, correct auto suffix removal, colors
without PROMPT_COMMAND, custom aliases, fixed --no-options, and many
more.

There's also benefits for Bash users too, mainly plenty of bug fixes.

If you use the official Zsh completion the main benefit is that it's
blazingly fast. Simply doing "git log <tab>" on the Linux kernel (with
3k+ refs) takes several seconds on the official Zsh completion (about
3 seconds on my machine), with git-complete it's *instantaneous*.

There's other benefits too. Since the Bash completion is actively
maintained by Git developers, everything works as they intend too.

For example "git send-email <tab>" correctly completes branches, as
opposed to files in the Zsh official completion. Also, complex aliases
such as '!f () { }; f' are correctly identified and completed
out-of-the-box.

It's a sister project of the Oh My Zsh gitfast plugin [2], which I maintain too.

Since the last version a testing framework was added, and now all the
completion tests of the Git project pass with the Zsh wrapper too [3].

For installation instructions, and more information, check the wiki
[1], but basically.

 * make install
 * fpath=(~/.local/share/git-completion/zsh $fpath)

Enjoy. Cheers.

[1] https://github.com/felipec/git-completion/wiki/Zsh
[2] https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitfast
[3] https://travis-ci.org/github/felipec/git-completion

-- 
Felipe Contreras
