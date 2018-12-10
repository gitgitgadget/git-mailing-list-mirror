Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15A720A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 22:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeLJWc4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 17:32:56 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41321 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJWc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 17:32:56 -0500
Received: by mail-ot1-f45.google.com with SMTP id u16so12076222otk.8
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 14:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RtR7LaghMoiTphXb8/MBqbGR72aZls3ngGfSSkhWcD8=;
        b=ieEtXTeZzJXvF7bzPn5KhZe7uk5bQ7IoQzBEDLyLFeB7BEY8veU4tCwMRLnlMReq/P
         ec2FhzYKUA/a0zA4tRMhfDL5lj8mTFiofvivSm9prvH0jn7z8H+N4Uchj51/phRrz785
         I8mxPhxgcopMj2rH+2lnt/xySamqdSshe6NcHejyCkKsJZypRRfHAheP/9/9E6ExGYTl
         hob2RAAk1jEnDQPm3dM6RcxXKd4dCb67bwqWMgo2aoSjuK1PX3oW0vnzc/rOu1PAMiEs
         I+daT05ZaizOZa0K0pLBqxl2xBn5ymJ/levxMAwrugADfpyU5W2YZSZLEEa35OYcfHmR
         xjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RtR7LaghMoiTphXb8/MBqbGR72aZls3ngGfSSkhWcD8=;
        b=m0rC5qqDAbWwH0dUbQIXSXsX3qf38NKRnejG7rWme1JJYM+g6v69rxJt+y9kz9A0AA
         WFAtGh01mgijliXSk94hnVCgZ+485HgWyPoc8BTXUSTZPzxqXxJ30/Luw3k+o7uJbrRB
         Lub9QzJQKYu/B6e+QnLaJRnvqzkQQnrGUBsy2BeDtngHKgjV1WcxT9V1oHZqoB9PvjNW
         mm9xdjKs/5qqxCJ8JHHIx3GGWjOmSmV+yqRPuE8ZnHVDOoNjc/sYa8LgAGkrWvdHDd9n
         s97/bc1dszCk3F1NL9P3KeD7Hc7QPYQNSz368MgRqwgbweO1rCcznD67YhZ7It7svTSP
         Ddjw==
X-Gm-Message-State: AA+aEWZblhwUlhqscu/Ys1pEW5qkeH199QFbMwXvie71x/+KvXZsX0oD
        nETBYjufJYiHlVbs/1Uc9lJEJsJ/7GhrQ+QeqqFjDA==
X-Google-Smtp-Source: AFSGD/UcA60P41WiGZIEAqcMCXwgnN+uN4C3uhO6P7LHw7DV9jWZ3SH4iZq/gDZqTkminXEfJolDuSM+uVIKDvdyytY=
X-Received: by 2002:a9d:2ae2:: with SMTP id e89mr10302991otb.290.1544481175194;
 Mon, 10 Dec 2018 14:32:55 -0800 (PST)
MIME-Version: 1.0
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Mon, 10 Dec 2018 17:32:18 -0500
Message-ID: <CAJdN7Kj5RaAsTstx_G14a_bR5Y92M3rtWAiMNPnQWgmz4JgEOg@mail.gmail.com>
Subject: silent_exec_failure when calling gpg
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've noticed that in v2.19.1, when using git to pretty print
information about the signature, if git cannot find gpg (e.g. "git
config gpg.program nogpg"), it prints an error to stderr:

$ git show -s --pretty=%G?
fatal: cannot run nogpg: No such file or directory
N

When I build from master, that no longer happens:

$ ../git/git show -s --pretty=%G?
N

Is this intentional behavior, i.e. something I can count on being the
case in future releases? Or should I treat this as a bug report? (I
have no opinion on whether this should be a feature or a bug, but I'm
working on a patch whose implementation may look very different based
on the answer to this question.)

I've dug around the code and come up with the notion that setting
child_process.silent_exec_failure = 1 is the usual way of suppressing
this message. But "git log -S silent_exec_failure v2.19.1..master"
shows no changes that could have caused this, nor can I find any
mention of it in release notes. It occurs for just about any
interaction with GPG that I can find, whether signing tags or commits,
or verifying signatures through pretty-print or git verify-commit or
git merge --log or git merge --verify-signatures. In all these cases,
v2.19.1 issues "fatal: cannot run nogpg: No such file or directory" to
stderr, while a binary built from master behaves the same in all
respects (including other errors when trying to sign) except that it's
missing the "fatal:" message.

This behavior makes sense in a lot of ways. If you're interested in
verifying commit signatures, it's hard to imagine needing a reminder
to install the program it depends on (though the error might help you
identify bad configuration for "gpg.program"). Conversely, if you're
not familiar with crypto software and try git log --format=%G? or git
verify-commit for fun, "Fatal: cannot run gpg" may look like a bug. So
I can definitely imagine justifications for this. Nonetheless, the
fact that I can't find documentation for the change smells funny.

I'd be very grateful if somebody on this list could tell me whether I
can count on this behavior in the future, or whether my code should
account for a possibility that this behavior could change in the future.
I'd also be very very interested to see in what commit(s) this change
occurred.

Thanks in advance!

John Passaro
(917) 678-8293
