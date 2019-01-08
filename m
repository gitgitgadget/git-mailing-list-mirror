Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A391F803
	for <e@80x24.org>; Tue,  8 Jan 2019 15:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAHPGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 10:06:18 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41866 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHPGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 10:06:18 -0500
Received: by mail-ot1-f54.google.com with SMTP id u16so3730411otk.8
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PDto4dbQ9d9HnewiFhxQBmFwqA6TXVl+0QLwtjDPv6k=;
        b=gtNScj0PsJrJhDK6rBzPw2rEqh4G0es3aujbAdAJ1rkZMwR+qtuMsz3LOP+o9nr1LN
         aCVR4W0CiureID7rIsrIzC9y/uHdr9tD/hK/duRPPFMJQyM0Sr1CTRudLQv89tH07U4+
         F5df3AcKZGZZbaZEHRtRwXgj0NjVdUAQUz1afIxZhakyfCLjPXxDaz2HA/fDv1qDTvHw
         iD7edH2kvDnBfEsW8pJcjnEQET8VI0geEN9exSqVgEew3hwIiMaYyH4OkkRwkt1+XNRl
         hSFglNN+FusWE7blbTDTbtrfTXKVi02nQMVgd/y28nK8UYI7RqbBSjSYCsuDIQUM6/1e
         i6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PDto4dbQ9d9HnewiFhxQBmFwqA6TXVl+0QLwtjDPv6k=;
        b=Biwi0DRRkTWgB4a8OWscBDofsepAHMYveI89cJu2RmCEqAJSxuonQaIqPEHWgiFeWo
         2Z+GW79uwCtapqlTeDOX79W0HBK49BUb1lOGMErkL8nB9cdMrypgbQLTHjSjnT7FiYw+
         xLuHuSxtrfD4W4m+8at7VO8A2F8l/P8rYGcvXZquzvZ2NAoqsdwvZi2FvpFzPGTMjBHR
         rcqv7nKnOTKXJVmUlxV0mhDgGIR5byWv4yx9GZzDThXFwXyq7HzY4T0lWIVhITDnVK1a
         j9765pBOZ0VxBjuY5ks/i0wdXmWpQhntOhlvXq2Cw8252iTjpjQFgHeYqvKJ64kVBld3
         O4qg==
X-Gm-Message-State: AJcUukd/doOkDeZsfsxDZyV8EfMqKckUYhOPol1IDC92ihbLKgFTfvt5
        YAWXHgjmvTQHZD+cQtgBzFNq9AZu1IjnG3LigOJ7ZmZO
X-Google-Smtp-Source: ALg8bN6pcyOhi7TZKRdy/2ayZaZc8OSAG/4AcVs1IBkAXSxn8CoBRBt9UviwhW3oZS7b0jIxHYJ4uWQBtyfhqGymiYc=
X-Received: by 2002:a9d:2aea:: with SMTP id e97mr1470340otb.206.1546959977636;
 Tue, 08 Jan 2019 07:06:17 -0800 (PST)
MIME-Version: 1.0
From:   Markus Wiederkehr <markus.wiederkehr@gmail.com>
Date:   Tue, 8 Jan 2019 16:06:06 +0100
Message-ID: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
Subject: git rebase: retain original head?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I frequently run an interactive rebase to change the order of recent
commits, apply fixups, etc. When merge conflicts occur I often want to
compare the result with the original head prior to starting the
rebase.

In the past I used "git diff ORIG_HEAD". This used to work as long as
I did not manually invoke "git reset" during the operation.

Since git version 2.20.1 (not sure, maybe 2.20.0?) this no longer
works because ORIG_HEAD seems to get modified by fixup commits during
rebase. Now I have to search through reflog to find the commit I want
to compare the current head to.

During the rebase operation the original head seems to get stored in
'rebase-merge/orig-head'. Unfortunately this references gets removed
after the rebase operation completes.

Would it be possible to retain this information? Could you set
ORIG_HEAD back to rebase-merge/orig-head after rebase completes?
Alternatively, could something like REBASE_HEAD be added for this
purpose?

Undoing a rebase would be related to this and is a very popular
question on SO [1]. Users recommend using "git reset --hard ORIG_HEAD"
which now no longer works.

Regards,
Markus

[1] https://stackoverflow.com/questions/134882
