Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BD2C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjATP1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjATP1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:27:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94AAD502
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:27:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b10so5953137pjo.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ii6oVlNW0p0OUXxy7JcC4R9HMKI65XtEOLdB93aUd2g=;
        b=Js+rMMlkXuugJNyFEIrUrzc1Aq3cz7hlUCtJ4n8X11iVXak5BAKN5d12cBWmZB6mW1
         H/cpJD9iqUY5C5YAw8x48dzkwThjKtBnCOaKMxIOZDB32fM4RrMDJTRQGYWAb1c5kxlX
         r2F90RVvWMGGF9HKRapIHLOiXWdgOwUSiOKbrkpP11QqaYX6EUgJVEc9Jn7AY9vC1Upm
         1VNEOszEXOHQH8eWxMCp7JgiFl8ucUJXp8wp5fWdUCdDy/DuxYOJfhLonbzqKv7pjLWA
         nKlDt/kGSpWh6w/LnmqEN1IFBLypupZ7+f3ZVLWnDhEcpOxR1gRaRnhkdAE2OeX13TAC
         /xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ii6oVlNW0p0OUXxy7JcC4R9HMKI65XtEOLdB93aUd2g=;
        b=oqqZEE9aEnflURETVR56pnD9HqM4c+H/m0ehkT0z4q7JzRePzI9IsAEvPH0DVIhZb3
         DURkhFjZVV/X0hqB3uT+IcTBZNJtYzV213mAjR6ErjNP0LuP06P7g6RbyGEq5mTJzfON
         BMmZqTn+HsUac9RPlIhzV3JCQRj/Rn8wPsPsAUJIGssJZgQcyXDiF30VwJyiD/Z7fbHF
         BmyywP883iZCJQN7+6YlQ0lbclYMK9wX5nTS+WK9dmvn6o0XtSJUyI6WQgdZbyllw/Sx
         E26RdXBnT+5WvY7QbOji7pkSE7vEh8r1PcIWS6okh4aqHLu3VQEYP0BUglCk+wQ6KPJH
         GhMQ==
X-Gm-Message-State: AFqh2ko6nPb34yMQ5wsxlVKw5bwXGxmHOCR9jnFj/V4jCF+W2wpIkK5H
        o/m+Gqj9u4d2dBWlaU/R8zU=
X-Google-Smtp-Source: AMrXdXslqlgjS6wQV4yIsTZMA1uUxbLYNx2pjP/JQIdjQwfvGBe/h2F+XN5Gsm1NhaMYS4zJkA03TQ==
X-Received: by 2002:a05:6a20:4386:b0:b9:3cb5:99c2 with SMTP id i6-20020a056a20438600b000b93cb599c2mr7044087pzl.17.1674228455178;
        Fri, 20 Jan 2023 07:27:35 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g38-20020a635666000000b004768b74f208sm22570844pgm.4.2023.01.20.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:27:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] rebase: mark --update-refs as requiring the merge backend
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
        <f480813c-7583-179f-0149-d970d3f2519f@github.com>
Date:   Fri, 20 Jan 2023 07:27:34 -0800
In-Reply-To: <f480813c-7583-179f-0149-d970d3f2519f@github.com> (Derrick
        Stolee's message of "Thu, 19 Jan 2023 16:47:53 -0500")
Message-ID: <xmqqr0vpxm3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> +	if (options.update_refs)
>> +		imply_merge(&options, "--update-refs");
>> +
>
> This solution is very elegant. The only downside is the lack of warning
> if --update-refs was implied by rebase.updateRefs=true, but I'm happy to
> delay implementing that warning in favor of your complete solution here.

If features A and B are incompatible and both can be specified from
both command line and configuration, ideally I would expect the
system to operate in one of two ways.  I haven't thought it through
to decide which one I prefer between the two.

 * Take "command line trumps configuration" one step further, so
   that A that is configured but not asked for from the command
   line is defeated by B that is asked for from the command line.

   This way, only when A and B are both requested via the
   configuration, of via the command line, we'd fail the operation
   by saying A and B are incompatible.  Otherwise, the one that is
   configured but overridden is turned off (either silently or with
   a warning).

 * Declare "command line trumps configuration" is only among the
   same feature.  Regardless of how features A and B that are
   incompatible are requested, the command will error out, citing
   incompatibility.  It would be very nice if the warning mentioned
   where the requests for features A and B came from (e.g. "You
   asked for -B from the command line, but you have A configured,
   and both cannot be active at the same time---disable A from the
   command line, or do not ask for B")

   When A is configured and B is requested from the command line,
   the command will error out, and the user must defeat A from the
   command line before the user can use B, e.g. "git cmd --no-A -B".

A knee-jerk reaction to the situation is that the latter feels
somewhat safer than the former, but when I imagine the actual end
user who saw the error message, especially the suggested solution
"disable A from the command line or do not ask for B from the
command line", may say "well, I asked for B for this invocation
explicitly with -B from the command line, and you(Git) should be
able to make it imply --no-A", which amounts to the same thing as
the former choice.

