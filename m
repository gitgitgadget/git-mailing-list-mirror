Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF6C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhKVQb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbhKVQb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:31:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED543C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:28:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so79908011edd.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=stq0YFzBrMeKkontKRAFTkfOXTKz4lEyn6ERutJdX7w=;
        b=GcBHQ2/X99CSsLVcsjymtikNH/bVhtpF/NaWLOA0htyE6F7kNQEfO2iF6pFjR+DKpG
         5l/TMR+aWoYZvgwBm3yYJxgjhqly6N8ibn/i1KW0brlJEJIQpK4P+4PUvdN5CsSLjAua
         mNHCjYt4CQfF/lR3dQBwPe3gQaeXrT6RmVeykzrWhKravrHwbWvVfo7B1lfbimx1Qmj+
         q/TqLgUeL876E0rHPVdTisv6khq0kGAXIPUYO6aBio1LrHVRyyUeD2mzH+l5VRWshY8d
         gYXjr8CJFglrNhqBfpCHXSSl/s0e2ksFy76nfMSWr6t9WFg845FwJhO1QwJBxv2SPk7h
         gc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=stq0YFzBrMeKkontKRAFTkfOXTKz4lEyn6ERutJdX7w=;
        b=CeJ4TgzhazCYru8x08/haB2cQ/8zS7lN+f/mT58TR6rv8rwtyQyTphRxCFXQRx9ZIX
         sw7W+koQ9PlOZroeW0bx/3tEhP40qMAL6CIKYPI2Z+aVUmawBd+/aFYD91XKf9RiKWQj
         hbG+NwOwTwaZx78rCcT//zH/ewm6/XTG5Uot1CAPRLHRIorpXBWz7XMm2xkryjWXZCZG
         7PLt2q6ceKtDiJZ5FOSUE5qME6PAGNTqVbpCdwaSiJy9+ggUwcVHRS/xHcBVGtDlxViL
         v0HUyVoB/jqqgvUhUFaVdkxHZelkiDI3LAmO4U8GTA55RNUQrE8NfpHU5Ldj77hwlsFA
         +c1A==
X-Gm-Message-State: AOAM53323VRSEJJmj2wCjEI0/u/wg5UQeya1nSoarvplmbXP6u0pD1zf
        qFtShO/LO8xmtr1nay9XmvQ=
X-Google-Smtp-Source: ABdhPJz6ayAn/g0Mx9gT21oJ0M4JTyBILwZ1S4+gqFdYSg63jiidlXqef0s+idgBi/57W9pdGyywNw==
X-Received: by 2002:a17:906:a215:: with SMTP id r21mr26288202ejy.21.1637598529489;
        Mon, 22 Nov 2021 08:28:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ar4sm3895221ejc.52.2021.11.22.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:28:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpCBU-0016tN-3p;
        Mon, 22 Nov 2021 17:28:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Date:   Mon, 22 Nov 2021 17:22:34 +0100
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net> <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
Message-ID: <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Enzo Matsumiya wrote:

> On 11/21, Junio C Hamano wrote:
>>It is rather common for us to reuse "struct child_process" in a code
>>path, e.g. builtin/worktree.c::add_worktree() prepares a single
>>instance of such a struct, sets cp.git_cmd to true, and runs either
>>"update-ref" or "symbolic-ref" to update "HEAD".  After successful
>>invocation of such a git subcommand, it then runs "git reset --hard",
>>with this piece of code:
>
> Do you agree that at least NULLing .argv and .env could be part of
> child_process_clear()?
>
> diff --git a/run-command.c b/run-command.c
> index a7bf81025afb..3839a26eff11 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -18,8 +18,9 @@ void child_process_init(struct child_process *child)
>  void child_process_clear(struct child_process *child)
>  {
>         strvec_clear(&child->args);
> +       child->argv = NULL;
>         strvec_clear(&child->env_array);
> +       child->env = NULL;
>  }
>
> With this change on main, all tests are successful.

That's what your patch that calls child_process_init() is trying to do,
but it fails tests on "master". The "child" pointer here is valid, so
what's going on with the memcpy() not working, but these two assignments
doing the job?

I haven't looked into why, but I'd think whatever the difference is
should be moved into making child_process_init() handle that, and
continuing to call that in child_process_clear(), if we go for the
approach in your patch.

I think an alternate direction of simply getting rid of "argv" is better
in this case, and I've just submitted a topic to do that:
https://lore.kernel.org/git/cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com/

It includes the test you noted to make the pager crash.

It still leave us with this oddity:

    $ ~/g/git/git -c pager.show=INVALID_PAGER show  HEAD 
    error: cannot run INVALID_PAGER: No such file or directory
    error: cannot run INVALID_PAGER: No such file or directory

But that was the case before that topic (if we hadn't
crashed/segfaulted), and with your proposed change here.
