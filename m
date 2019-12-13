Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADB9C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1482253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqjgLeDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfLMER3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 23:17:29 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:47466 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfLMER2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 23:17:28 -0500
Received: by mail-pj1-f73.google.com with SMTP id m14so686177pjr.14
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 20:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=vJyziR+CcV+Uct1GU1bjhgwDbYLe1tSzI+XfSCoQLlg=;
        b=NqjgLeDAdkGg7dt//P/KdgCs5vcb+HWziY+jrTqVl5xKi58iUG3MHAo7KesI37OyoR
         09pr0SsLBf9AyvmlbPbcYeuMVvKN8P8JtSUJlFUR8f3mpX4bSP0Rgo9IlkeY2qIfJV4l
         utZiOV5G96CLieiRcVU2FtX6lgU3uWZY6cBGjRKJcz9eM+l/jx6GCd/Ftv35x0VbrEjZ
         jZkK10ophQzBFAwfEBUoJP0CjqNh/Mw5GEWRJuVH9f/BeYTCkG3PrT3oIG/73/Jqf8oN
         H3mDR/ydp0IzGH6n2ubkANMavUqFfG9/Pvs0mF+DRxpW7fqYeOPIE0DVGZML/hhO04EN
         pnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=vJyziR+CcV+Uct1GU1bjhgwDbYLe1tSzI+XfSCoQLlg=;
        b=BimWtNIJa8BpT5BRuHy4bA8osJUBBkaK2E2X4MjOD2XT5eVUsvzw9uFTOp5LAXbU+s
         DOgpYDoOGO/UiflpnbO/0qfX58IQ03Qt03JZbBRYkufDnydkwW6V8hUJ8Q5XCRMDlgi1
         JFqG1asKFIN0agZSARMe/JbwvnN5X36+NcawHU2J093fTjt0dQM13T56qPCwM4Wj1fWG
         lttWErvpxTUwkM8mr9SQ6khsFGW1kQa7WvSc0O5zLwtGgFKgW986MmKhZ2L4qKLKS9bs
         UMPauNmskySXSq+A8tpTZmP8atpfUAEEB2oC8lRoW2QTh5LzPq9Hqm/xU9hH7/Fz6aHb
         QXKA==
X-Gm-Message-State: APjAAAWVSLCY+XmEQsHCjbvbAnKed4piiq2ANyAMb5viurOc3Daud+qP
        +t+pkZGUV0hBL6L46XM79PQYc7WfNpXyGokPXeN8AcEFae4DISbnfXtK+u3rfC5V+2/KyhcLjxP
        HBzTjjuAyxUte5/bYTRqQd7p9O9mbdNBQrNLWGgIvchX0kiYxodz5YRirKZmxA8uqyYIhe0gw1g
        ==
X-Google-Smtp-Source: APXvYqx0pEduoqiV7RQGamwOfBTvEOS5M7W3t56DSJ/Kjr9McQfKISyakw5S7Rz8AfFZrWYj2FM7sMzTZFp88YErD2M=
X-Received: by 2002:a63:2808:: with SMTP id o8mr14471130pgo.39.1576210648003;
 Thu, 12 Dec 2019 20:17:28 -0800 (PST)
Date:   Thu, 12 Dec 2019 20:16:56 -0800
In-Reply-To: <f3037862-b8f7-d674-4b1e-7b9df3fa49cd@gmail.com>
Message-Id: <20191213041656.24267-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4] MyFirstContribution: add avenues for getting help
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Kerry@google.com, Richard <richard.kerry@atos.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With https://lore.kernel.org/git/20191114194708.GD60198@google.com/ we
now have a mentoring mailing list, to which we should direct new
contributors who have questions.

Since #git-devel's traffic is fairly low, it should be OK to direct some
questions there too. Mention some of the conventions in case folks are
unfamiliar with IRC.

Because the mentoring list and #git-devel are both a subset of Git
contributors, finally list the main Git list and mention some of the
posting conventions.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Only difference from v3 is the public-inbox -> lore.kernel in the commit
message. Thanks, Stolee.

 - Emily

 Documentation/MyFirstContribution.txt | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 35b9130aa3..e7489d156a 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -23,6 +23,38 @@ useful additional context:
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
+==== https://lore.kernel.org/git[git@vger.kernel.org]
+
+This is the main Git project mailing list where code reviews, version
+announcements, design discussions, and more take place. The Git list
+requires plain-text-only emails and prefers inline and bottom-posting when
+replying to mail; you will be CC'd in all replies to you. Optionally, you can
+subscribe to the list by sending an email to majordomo@vger.kernel.org with
+"subscribe git" in the body.
+
 [[getting-started]]
 == Getting Started
 
-- 
2.24.1.735.g03f4e72817-goog

