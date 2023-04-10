Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A8DC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDJXKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJXKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:10:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51C1BF6
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:10:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso113717pjc.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681168241; x=1683760241;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CW+MH7TXlyhkUll2F8LbdCAmaxn5So+LaeM/CufueUU=;
        b=pXyHdgXGvd3Hba3Bs2Hh+KpAJZkjQAHiYPcUsDvvwvUdDp6dunoEPKdvrkx7u4z9o6
         cbxCeT9A0k9PEAgJJkgFBAd4nLA3/YZiSPR3y2596N4fo76IoGa+SrozYN4G/oPTCtUf
         c5cBU7QFkjvHJUKSRQjaYiCiR1oBxiN7lAz8/2sGn139En1zBsJg7oQTORGcQw4RvMon
         fkzJ4e4aGun4tiIoj06BBbynS582nVldswXZQgqeSY5efyTkbHJGoLoQMziaZQVK2ZOP
         gyGLJmpW7Z+VbWmo+LIa7h9l84ruyVbkq/atUI/sRCRkQUQi8jC4Ja2+2vW5XlC/dcsg
         88fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681168241; x=1683760241;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CW+MH7TXlyhkUll2F8LbdCAmaxn5So+LaeM/CufueUU=;
        b=cOy/mbJ+EOgorJhlMlyuFmtOpyDusqaA3yLNsvDFTJeUMJjDXrQX++7uDkuzK7kEEC
         lzynh4xYJPYNh+lA9iFCRGh6wmCrkskopgNaa0fCD4d/7zJOqoZIP6bwjxHbcTcvEGPx
         yDtrn4CkrYVcRK7VLmKmn5fvnBcJMLHuwfevJJI8jAjQjVvUb5/1xw34Al6Z198qjQVn
         DufLWm8lKEIBGkjl42xsmNhCJJl2Xa9RcjJ3vC381ql4Cy4bROSwYj5jvX4Xu/zzVo8b
         mA0vpUyp3RoLxH096/EEeHUhVJEZt8R3QqLim7+ZIRYAp95g5GhFw0wVTKUaywZi1B7Z
         0DdA==
X-Gm-Message-State: AAQBX9dQMoF/b5eM0n9CIjP0xlwKFF3fUVT9x35BC/mRpIUogSJxIU8U
        Z+oKusuCHAfR34Rdyc30fN4mowx/xiM=
X-Google-Smtp-Source: AKy350Yk3VgHl6hYpsn0WjblBmxyNPalqlZPKp5iuUsDHnaBi6t38gsj5VGD3KzVOK2liPNhptcoRQ==
X-Received: by 2002:a17:90b:1d91:b0:23b:3f18:a8fe with SMTP id pf17-20020a17090b1d9100b0023b3f18a8femr12450844pjb.31.1681168240593;
        Mon, 10 Apr 2023 16:10:40 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902a60e00b0019f892dc696sm8304779plq.229.2023.04.10.16.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:10:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] usage: clarify --recurse-submodules as a boolean
References: <ZDSTFwMFO7vbj/du@google.com>
Date:   Mon, 10 Apr 2023 16:10:40 -0700
In-Reply-To: <ZDSTFwMFO7vbj/du@google.com> (Emily Shaffer's message of "Mon,
        10 Apr 2023 15:52:07 -0700")
Message-ID: <xmqqfs97cozz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> `git switch` `git checkout`, `git reset`, and `git read-tree` allow a

Missing comma?

> user to choose to recurse into submodules. All four of these commands'
> short usage seems to indicate that `--recurse-submodules` should take an
> argument. In practice, though, all four of these commands parse through
> the same callback path:
>
>   option_parse_recurse_submodules_worktree_updater(...) checks for
>   set/unset, or passes off to...
>   parse_update_recurse_submodules_arg(...), which is a straight handoff
>   to...
>   parse_update_recurse(...), which only accepts true or false.

"true or false" -> "various forms of 'true' (e.g. on/1/yes) or 'false'"

> So ultimately, it can only be true or false, unlike `git push

Likewise.  Here is a minimally touched up version I queued.

Thanks.

    usage: clarify --recurse-submodules as a boolean
    
    `git switch`, `git checkout`, `git reset`, and `git read-tree` allow a
    user to choose to recurse into submodules. All four of these commands'
    short usage seems to indicate that `--recurse-submodules` should take an
    argument. In practice, though, all four of these commands parse through
    the same callback path:
    
      option_parse_recurse_submodules_worktree_updater(...) checks for
      set/unset, or passes off to...
      parse_update_recurse_submodules_arg(...), which is a straight handoff
      to...
      parse_update_recurse(...), which only accepts various ways to
      spell a Boolean
    
    So ultimately, it can only be true or false (or yes/no/on/off/etc),
    unlike `git push --recurse-submodules=<enum>`. A user could provide
    `--recurse-submodules=true`, but we don't typically suggest that for
    boolean arguments.
    
    Documentation/git-(switch|checkout|reset|read-tree).txt suggests
    --[no-]recurse-submodules, too.
    
    In fact, these four commands are the only ones that use this codepath -
    so there's not any reason for it to be so meandering. However, because
    option_parse_recurse_submodules_worktree_updater() modifies static state
    in submodule.c, we still need to get a handle to that static state
    through a function call.
    
    To preserve the behavior of --recurse-submodules=true and clarify the
    usage string simultaneously, get rid of the OPT_CALLBACK_F in favor of a
    simple OPT_BOOL, and call a setter in submodule.c for the static state
    instead. Also, remove the now-unused
    option_parse_recurse_submodules_worktree_updater(),
    parse_update_recurse_submodules_arg(), and parse_update_recurse() calls.
    
    Signed-off-by: Emily Shaffer <nasamuffin@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
