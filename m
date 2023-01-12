Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFC5C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbjALQA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjALQAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C70654D83
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:52:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9so20626189pll.9
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xP1K2suY5txmBYBeYC2FmAhUKhJJxgSgSoKG44lagbU=;
        b=Z86IzDGvKTj/cb7NfNkKxozvNDBe60nsB5G8uqy+PZI2loeT7UNsZccHvXfct1LF0M
         11fuJaWrTECicvbLSOvdvpuUTw/dbqUt3mn/VHYN5Ska6TAR0RCE3lIy2BA/3yowFxrE
         74wGTzU+bqlF21In+Yk705xkQ7uBms2eVQ0iZgyXqxuiSvfI7EbfTUN9jexx7iusUUv/
         E2aPPrWJUT3D7adI1vwGNbbi4ik4W08ZdcJFfAaTS4zreR9CIaGIZGoBSz0BsymBwQwY
         4xMUm2hIzW4+tTyrOpWyAyNZtxAezj+J8BK5DEEVDQfN4IbwwEsSl3Nwl/YVFvkDmTiW
         pxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xP1K2suY5txmBYBeYC2FmAhUKhJJxgSgSoKG44lagbU=;
        b=JIKAcLems59UmO2brF59NjisE+OF2mC6/FCdgWOE9TxzYFyoL+kG0pv86WcN1AmROL
         oe3z2QRWnYYi+m+zQgptM1hlULxFTegKu1BoiAMgbkW14W4GSOs4W6g87wqBYoOPSR7g
         7IeclDoiNv4VX6uaM7caxvp4XDo6c6UgY0g8GJctRRQFQl+j/A3CAYYFcb/2dZJ8S7Th
         4Mv/BeZISjyxKiqPHk77vxdgDRQGOrhI0AKt0fNq74BJHIE49IFsGYlbMLzC0atgk5b1
         Lo08MjbWJERl2Z4142W4JC/0TsD796Q5UQ4GQAqpZb9cB4iq/SnzYion2CfJ474SdF0Y
         4OtA==
X-Gm-Message-State: AFqh2kpBwYHOWr4Gq122vsgpA8Ibxg7cRa//DG0K3TeWQAGVFj+4kngF
        pJMCPgcF9DihM+sLUBHbdyTE9N9228k=
X-Google-Smtp-Source: AMrXdXvhsKv36g2Jik5OwEqab0VIrUEfBXxGP42z42r/QaGFxkVumhb5urZ5EA/lkmS2ftIP/AKz6A==
X-Received: by 2002:a05:6a20:94c4:b0:aa:806:7b91 with SMTP id ht4-20020a056a2094c400b000aa08067b91mr95644419pzb.39.1673538761498;
        Thu, 12 Jan 2023 07:52:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b00188ea79fae0sm12452391plx.48.2023.01.12.07.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:52:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 00:52:40 +0900
In-Reply-To: <pull.1460.git.1673519809510.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Thu, 12 Jan 2023 10:36:49 +0000")
Message-ID: <xmqq358fu4vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When adding a "break" command to a rebase todo list it can be helpful to
> add a comment as a reminder as to what the user was planning to do when
> the rebase stopped. Anything following the command is interpreted as an
> argument to the command and results in an error. Change this so that a
> "break command may be followed by "# <comment>" in the same way as
> a "merge" command. Requiring the comment to begin with "# " allows the
> break command to start taking an argument in the future if that turns
> out to be useful.

Why do we special case "break" and not give the same "comment is
emitted when the control reaches the insn in the todo list" for
others like "exec" or even "pick"?

Another comment with devil's advocate hat on is if we are better off
not adding "# this comment is emitted" at all, and instead do

    pick ...
    pick ...
    exec echo this comment is emitted
    break
    pick ...



