Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B24C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C072075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0746Xzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387393AbgAXVBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:01:52 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46839 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbgAXVBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:01:52 -0500
Received: by mail-pl1-f202.google.com with SMTP id t17so1716936plr.13
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=+sfC/ED+iQyvpHX8kugkmtkRXFr1mwSB0ULmna8LaEc=;
        b=s0746Xzr2nrMSjwLak1uwSSGld64u/irJJXseO017pqVAcq8md9QM2jI+6su3NnPQ6
         kAU3MX5FpfBEpxkM7mwXpCb1On7o3LwVytFccn4eK1i6f3mTXbSukX2kKcoaL0+q6rtn
         vz5ZTvznQjrTu5FbIwuWKbnhzTlN3K55sBqmgm0Wf2kWs31d8/R3ZRv7XV0cSgvNLEmf
         jJ6hk3gqngiWTcuPI08V4jZi5t0NjYnWLV3ECBZ8yD3mrsdItNizRwnbydcS9lQP5m0A
         TpWcvermGdM7Iw0xzyeMEtIvgD1fkrOViOSsaOvXQ25zke2Gl/Th6Dq9YicL+8OEGdpH
         juxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=+sfC/ED+iQyvpHX8kugkmtkRXFr1mwSB0ULmna8LaEc=;
        b=eZ6fU3GRIVddfZCOgqAF2B8ylSv30h/3L9Y5ma6vH2IO6cgnBP6AkOi4ci8x5RIKSh
         UttPnhmfuayWIxp9Janvz5kVXmuqTsmbiPnkTtQkysdByeonYzHBtynSOP5PPGsil4YY
         wC4dZb6cs78r6qHmZ1Zt4b+gBAcCZg7RiHY7rB7J5jkci18qh9UVgMshVpnYMjNg9G5q
         YJtkOV0g5DtELbvlaaKOX76gMzQujWkAhX+9fuGkesuMb/CAlJGwv+idmYEMnMdYTLtw
         7alo1xJ/P2xyK0Hzq0PWGD4hYdcNUa8bIfOPFeVM/lUy9fzCR+SQIcjIhCNZwyShgqlM
         gnSw==
X-Gm-Message-State: APjAAAUSrBzQCC285NeGk4+kt0USAADqfD+OatOjHXeVen/Y9lqEYnDY
        q3n5b9sj3L3pSGyQUDIZfvlh9mnaQ7q4dp/QD/VzA+qX97Slf5zKSXS0UxA9gXgBfkPeJ/bKiNV
        7N1da0NXTf7w91Zbkxfi+G02JuwD00AHZ/WUlcuJtJnLGD663Xu/C7GnrRdcpC2+h99ASaW3rQA
        ==
X-Google-Smtp-Source: APXvYqxcXE85JvV87PKkmqqJyelkRTz7jS7KaTrgzDDk5NZr2qlLZoh5M+SoYKEYoBKtXrGEm00wc5lUS2c9L4Kzh/k=
X-Received: by 2002:a63:7744:: with SMTP id s65mr6073601pgc.312.1579899711616;
 Fri, 24 Jan 2020 13:01:51 -0800 (PST)
Date:   Fri, 24 Jan 2020 13:01:48 -0800
In-Reply-To: <20200124200915.249473-1-emilyshaffer@google.com>
Message-Id: <20200124210148.220007-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6] MyFirstContribution: add avenues for getting help
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With https://lore.kernel.org/git/20191114194708.GD60198@google.com/ we
now have a mentoring mailing list, to which we should direct new
contributors who have questions.

Mention #git-devel, which is targeted for Git contributors; asking for
help with getting a first contribution together is on-topic for that
channel. Also mention some of the conventions in case folks are
unfamiliar with IRC.

Because the mentoring list and #git-devel are both a subset of Git
contributors, finally list the main Git list and mention some of the
posting conventions.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Since v5, let the mailing list reference resolve to a mailto instead and
added an explicit link to the (read-only) archives.

 - Emily

 Documentation/MyFirstContribution.txt | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 35b9130aa3..c361b5d4ce 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -23,6 +23,39 @@ useful additional context:
 - `Documentation/SubmittingPatches`
 - `Documentation/howto/new-command.txt`
 
+[[getting-help]]
+=== Getting Help
+
+If you get stuck, you can seek help in the following places.
+
+==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
+
+This mailing list is targeted to new contributors and is a great place to post
+questions and receive kind, detailed answers from volunteers on the Git
+project. You must join the group to view messages or post.
+
+==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
+
+This IRC channel is for conversations between Git contributors. If someone is
+currently online and knows the answer to your question, you can receive help
+in real time. Otherwise, you can read the
+https://colabti.org/irclogger/irclogger_logs/git-devel[scrollback] to see
+whether someone answered you. IRC does not allow offline private messaging, so
+if you try to private message someone and then log out of IRC, they cannot
+respond to you. It's better to ask your questions in the channel so that you
+can be answered if you disconnect and so that others can learn from the
+conversation.
+
+==== git@vger.kernel.org
+
+This is the main Git project mailing list where code reviews, version
+announcements, design discussions, and more take place. The Git list
+requires plain-text-only emails and prefers inline and bottom-posting when
+replying to mail; you will be CC'd in all replies to you. Optionally, you can
+subscribe to the list by sending an email to majordomo@vger.kernel.org with
+"subscribe git" in the body. You can also browse the
+https://lore.kernel.org/git[archives] in your browser.
+
 [[getting-started]]
 == Getting Started
 
-- 
2.25.0.341.g760bfbb309-goog

