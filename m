Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B47C3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 20:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjAMURc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjAMURa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 15:17:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB5F5CF81
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:17:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso25473466pjo.3
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLfWFtDAWNANuAei9OkHFzBDsaq2w1bk+BmnorFpCjc=;
        b=Xg7jGZG/6Y5K2/ADpMa3d4iaIuA0Da3vJ0AdYNAsJ9jgsNbmPtq1TZU/Hjit3v2ndO
         AiXzzTngF/SOdryc4M1XTOM5ggIudNRTLr0OuyfRV+J4hylkB55Ed9pvx5sDHYs3F1uk
         rQEGuONj3BAFjtljY8BnhD2lo74G1sMJ++Rjc16ifXxv2Dp6sOn73wjvImGb+pgCefX8
         7kKwpWGamMUUN8Cpyf5PiSWQIwHM0igc9s8qcFfGpQ12cSXCzgzn3oOb+AmRcYYJc5AI
         Cxkc8303HflenqaBPE0VR1X8lTnooJa5s2eNswetb8u15OCdeA+vX5+e8PDpqJomwbIY
         1vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RLfWFtDAWNANuAei9OkHFzBDsaq2w1bk+BmnorFpCjc=;
        b=uNleFJj73pqhBThx88QPgoK6wgatPLRxUMMBMMp6V28d5QEBeLxL9Iu1VZywu/pBVz
         /uvKpr2LusiGKfiGWvShf32tTdAhmT+B0f10XfZG7kwWODsxFvGUDNGPOwbnWEOSfOUK
         wzIZ//Rqyx1UoYDfp7Eb7SI4Ddoc8vTKhWilQ6SAkV92qnBn/rUlYI0Cl/q7SaVmmuJc
         eWXgaVmUbdFdScvhjj0yTyt13wL+bHHqRXkC+VS8i3tmlRxgaMCkOG39G1k09XbA6Cnn
         sFPfO1ZQprf7aadPFsytd9BxDpwwIf6gWYvCYZm4CTtewhmB5aDMaSqX2QNKFwLOd1Xc
         AUSQ==
X-Gm-Message-State: AFqh2kq+B5yC1YN/az5bVzmBlGKW3YjcNIAFXjrsJLDqDb0qXTLiCC+n
        KK7Rcld+b4UGESyUZHRQIRw=
X-Google-Smtp-Source: AMrXdXsG/CnlzhBfFh5UqfjCLJd3I2FkIVwC5B6xae14MdZ9uVZ0vZ1N8gcTd3hGKcE07WrG+0OvEQ==
X-Received: by 2002:a17:902:8688:b0:189:e7ea:9ff9 with SMTP id g8-20020a170902868800b00189e7ea9ff9mr71974158plo.42.1673641048406;
        Fri, 13 Jan 2023 12:17:28 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g20-20020a170902e39400b001745662d568sm2754799ple.278.2023.01.13.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:17:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
        <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
        <CABPp-BFf4pbRAy+Oaghx5d8DZgBjY_OUM-rJZna+JyNwx9WB-Q@mail.gmail.com>
Date:   Fri, 13 Jan 2023 12:17:27 -0800
In-Reply-To: <CABPp-BFf4pbRAy+Oaghx5d8DZgBjY_OUM-rJZna+JyNwx9WB-Q@mail.gmail.com>
        (Elijah Newren's message of "Thu, 12 Jan 2023 09:14:26 -0800")
Message-ID: <xmqqwn5q1960.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Of course, the same applies to edit/squash/fixup/reword, though if I
> could go back in time...(warning, long tangent coming)...I would make
> it so those four directives did not accept any commit ID argument.
> Only "pick" and "reset" would accept a commit ID.  Instead, today's
> "edit X" would be two commands ("pick X" followed by either "break" or
> "edit"), "fixup X" would be "pick X" + "fixup", and "reword X" would
> be "pick X" + "reword".  That'd help users understand rebase state
> much better (it's so easy for users to get confused by whether they
> should be using `git commit --amend` vs. `git rebase --continue` and I
> think this is partially to blame, though there's other changes we
> could make to help with that dichotomy as well).  The separate
> directives would also make it much easier to figure out how to both
> fixup and edit a single commit in the same rebase (pick the commit,
> then add a fixup directive, then an edit directive).  

Intriguing, and I feel sad that it probably is too late for all of
the above X-<.

> In fact, "squash
> X" could just be discarded as superfluous, since it's just "pick X" +
> "fixup" + "reword" (or we could keep squash as an abbreviation for
> both "fixup" + "reword").

IIUC, your "fixup" is

	git reset --soft HEAD^
	git commit --amend --no-edit

i.e. discard the log message from "fixup" and use only its tree, and
your "reword" is

	git commit --amend --edit

so "pick X" + "fixup" + "reword" would not be quite usable as a
replacement of our "squash X" (or your "pick X" + "squash"), I am
afraid.  You'd want the log message from "X" as well as "X^" to
edit the replacement of X^.
