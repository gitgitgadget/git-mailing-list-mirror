Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB9C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE22071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhzoopjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403961AbgAXUKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:10:23 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35446 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403928AbgAXUKX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:10:23 -0500
Received: by mail-pf1-f201.google.com with SMTP id q1so181441pfg.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=lZdWrxp/eA3TX52V1WoQHM3kBTkFABZ5HcvwM3rpIRI=;
        b=nhzoopjQB66xvysmxs9lzi4JkzrUNFoY1UhCI14gNGv49pG3evL4g4HYkZNImJI/ep
         DSj2NJxZkwc2d+IFQZ1bJGo827fsokaVSkpMfsyQ90YX1EmuY4eTHapMGCI64eq3ayTD
         Tejj2u2wh5MNEL1ALyveza47TfrFxdLMTYur339Jh3t6MvesnthKTjtDR+lc88fGscZH
         17XAjGUjCyjGt6ETFzk9ZPb8iE8jToHoeiUXI5CkQibsujraEvsNxpZhc5I+gwqKcQoT
         /xLd1x5ZtBr+pEyIUYNAPKJcLfEBXA/J0NN0a+dMMWolpx2zBNL0LmtBBtodeNq857B9
         L3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=lZdWrxp/eA3TX52V1WoQHM3kBTkFABZ5HcvwM3rpIRI=;
        b=A/qD+c87J+FgbwZ4Hja22/gnBD+zpOeqc/bBeA9bzr5d27WX6kUx0suBFPC2lKm2lb
         d8TqJNjuqu3TeAtan2hVn4IcA1FjhDL+Iai4NCSZSmOEy4RVMYaZukBwSmBlKrncHFva
         lfCh6hA7fmbcQs+6fti/eiFaC4u0tJBXIVRsuiWBPhcA/t7pYC8fEX6vjrq0rOMaoQQ+
         5HdYmpK1ajGf1NnsvdNtoJFjXPja0FoGn32hw5UlSo+Xvhtf0oeoVpmtrTfKEpDD+Hfp
         RwHDQa7CyY5qGSsEIJGsQyL1/36Z+bpdHUVHsIY4t5jaagD6XdJIKxc7q993WfNcUJy5
         oYdw==
X-Gm-Message-State: APjAAAVNAyR5r5oZGf3i27DN2y2476TvZcApJ/+OHqFjQtypbXW/t1Gk
        9HrZ2szo0WIl56h3nQlp7ykuQ/ze6OxPe/f8PztqRqv8x7gs/xpDIljrsI5hwjbUJlVK0TiSWRW
        As/FbcQVpNfaCOm91PEMmeoXlvOE/e9JKSyvEdWuuVdkqMi4+8EemRi7f4AhZSRJDJQARvfSifQ
        ==
X-Google-Smtp-Source: APXvYqxM7HE55CH7C0KxNtuSyExzqANTEadgy2xrPQw/RGf1I8vAD+qVUQ4QqnMtJ9pwwQnsAYBWbBGFXQ2vXEV5YwI=
X-Received: by 2002:a63:220b:: with SMTP id i11mr5834663pgi.50.1579896622755;
 Fri, 24 Jan 2020 12:10:22 -0800 (PST)
Date:   Fri, 24 Jan 2020 12:09:16 -0800
In-Reply-To: <20191213013128.6268-1-emilyshaffer@google.com>
Message-Id: <20200124200915.249473-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5] MyFirstContribution: add avenues for getting help
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Richard Kerry <richard.kerry@atos.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

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
On v3, Junio mentioned changing the justification for suggesting
#git-devel in the commit-message. Stolee mentioned a missed reference to
public-inbox.org which was fixed in v4, but I mangled the threading, so
I'll also move this one to reply to v3 instead of the
in-thread-with-Stolee v4.

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
2.25.0.341.g760bfbb309-goog

