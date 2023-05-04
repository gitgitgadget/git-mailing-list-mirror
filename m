Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286EC77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 18:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjEDSHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDSHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 14:07:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983D422C
        for <git@vger.kernel.org>; Thu,  4 May 2023 11:07:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab0c697c84so5881245ad.3
        for <git@vger.kernel.org>; Thu, 04 May 2023 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683223673; x=1685815673;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=098Rzn3q/DCN+LNLbJn7oy/vsfvp5l8wFaElPJCalPc=;
        b=ObuDTeIV+fEr1+bcHVr1s5YWE4FCKAl/KCXV4FbTRjLOllEuWKS9X7vqRdF/c0Heas
         b7BP7yBj9ZG0l+qExwPO5iJma43dNs0LFwE5hmnts1xpRwCJE/kF4cbm4rSPiCz1yqtH
         nEUxGmhx2W8PCbY+JqV5XCJNWsvoAe6WWVpiHbKzgZc6v5N2EXFUu5hVowrMZOOJR8Ak
         RzZl2ErVNEFNxOI0x/b6OhUE6KU+oWXHuQXC7tUzq0n4RZatH3Vi7l254tLYV+gBoB56
         mAXnUAW2aj3bonY2wDalRmxB7rtylwkjPVrLPB6o4Et0674O2SDZyPfm23AgDFQQLzUq
         0GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683223673; x=1685815673;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=098Rzn3q/DCN+LNLbJn7oy/vsfvp5l8wFaElPJCalPc=;
        b=elAYyaaODm1D1xbqZ+LqiARSqcIi4vC95ZElKgKdB62qWqk42vHSQw+oCFkEDI0K8Q
         WhOuJknfZJiaoxr5/DDOQY0mvg/dX4RekloUM+WS/FLgBN8iBagpPMwfGyHfIqf77NWq
         XG4IteLNUlCse2f8keMxV684zKah/qSQpv56cYtPunJmJZ29p17L/ia+Xp3A/LGxDSm+
         ozY0UDnS2glNyWspZpozX4mE77Qmw3ov5ianKoJK6cUFwm1x7zlxrUXIS9lA6X4WcX5n
         3jxmeOpaxwqtvsnuEvXGPDaPbZGp3MwN/lbJsEVDtmZ+yyxB0RuNYtD3l1Jh3J6h/Wab
         Pymg==
X-Gm-Message-State: AC+VfDzGCNg4qN/0mgU1byIs4AZI2HW3qI8gYVerIZN8XPsdGzDV43y0
        CszBOYOcilXDymC4Tyr5Ph1HrFp8oLk=
X-Google-Smtp-Source: ACHHUZ5OkCx9pgRZw9YY8niqp+6vt9CX+YGUAtbcsiR+WEW2s8p3JPkviM589J6ohY8t0gqKhpeySg==
X-Received: by 2002:a17:903:2289:b0:1a6:6d9f:2fc9 with SMTP id b9-20020a170903228900b001a66d9f2fc9mr6154020plh.30.1683223672736;
        Thu, 04 May 2023 11:07:52 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902778400b001a2135e7eabsm23723296pll.16.2023.05.04.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:07:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g>
Date:   Thu, 04 May 2023 11:07:51 -0700
In-Reply-To: <xmqqsfcdtkt0.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 May 2023 09:57:15 -0700")
Message-ID: <xmqq1qjwj7go.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> --patch followed by --no-patch is to be a no-op according to the "git
>> log" manual page.
>
> I briefly wondered if it is a bug in the documentation.
> ... when "git log -p --raw" shows both patch and raw, I do not
> think of a reason why "git log -p --raw --no-patch" should not
> behave similarly.

So, to tie the loose ends, "log -p --raw --no-patch" and "log -p
--stat --no-patch" do behave similarly.  Where my reaction was
mistaken was that I did not read the manual page myself that clearly
said it is the same as "-s" that suppresses diff output (where "diff
output" is not limited to "patch"---diffstat is also output of "diff"),
and incorrectly thought that "--no-patch" would countermand only
"--patch" and nothing else.

In Documentation/diff-options.txt we have this snippet:

    -s::
    --no-patch::
            Suppress diff output. Useful for commands like `git show` that
            show the patch by default, or to cancel the effect of `--patch`.

I imagine that argument could be made that the last half-sentence
can be read to say that the option is usable ONLY to cancel the
effect of `--patch` without cancelling the effect of anything else.

But that smells like a bit of stretch, as "like" in "commands like"
is a sign, at least to me, that it gives a few examples without
attempting to be exhaustive (meaning that it is too much to read
"ONLY" that is not written in "or to cancel the effect of")..

Here is my attempt to make it tighter to avoid getting mis-read:

    Suppress all output from the diff machinery.  Useful for
    commands like `git show` that show the patch by default to
    squelch their output, or to cancel the effect of options like
    `--patch`, `--stat` earlier on the command line in an alias.

