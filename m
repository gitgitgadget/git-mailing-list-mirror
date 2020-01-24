Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340EC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B360F2071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDwP/bSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgAXV0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:26:13 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:57186 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAXV0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:26:12 -0500
Received: by mail-pl1-f202.google.com with SMTP id 91so1748213plf.23
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=mOcbevCFLnqa0tGqlkFeeMom3QH1r8jqaXyVf0dU25E=;
        b=bDwP/bSBWDghE4SB/8+a7o+RuIkgsLNWWNzenRBY0coTt9K9LD5UM0xahig5S6XNu6
         HJpkTFWkj3VTJwlE5qReNveZHwQAldqouti3XwFflxwziDv55rsNqAOng5/f2bKBBhjJ
         uKABFb/4p+NEt9E0h9Fe1vEKANSCGbKR0XQK/m4rwovqh1E8BY2inD4hFJn2pEKEgtNe
         HTQ4Y0x+ZHTW52lZz9P+MUT8wv/UkaHbEeOkBmI4tzSJrk2Y1cPB1KF1jIPRlUZO1jWU
         mJJy7zPLv4SJztmOj8p+I9btGDPKLx/5f+Cc19E59ubqPaYPyzY+CgInOUmIf5+lz2w2
         u3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=mOcbevCFLnqa0tGqlkFeeMom3QH1r8jqaXyVf0dU25E=;
        b=d1fnXkZ7t2MZ1Bme+dbT6nH6Y5C8Arey1eUf7QXuZuGN66jpyB4do04e/l8l0fh7uD
         /pPV7mudEDoMbBHGQvO/GYt//KxQu/66Q99iod06lMm8qFOZcRUh8zCIX5TaJ/SVP47N
         jHOJ690QajDJOvREHXzmImiq2oKHBKOIwET2/cBw9fsKME9SccVXUH0ZuBPG1170WLiN
         SGM/MrWk2zQFEq44BxLnU7K8104r49TXwNc+ubpYMqe/Yi9/MUHQGjy0nQCnpcI7LnIA
         laB0KWPnN9k72enDth1MidDyOFiANfsAxm0MWmGauUF7jRBjPuKUQTIYKc0bABcPm1gN
         cWUQ==
X-Gm-Message-State: APjAAAXY6DV+CSfkMuJrSE/9lDsmGy7P3M8w0PcDiI3P+cPSplWFlGdh
        EjSrzdk96xfDbaEOZMJSY+aNI7l5VoISfb9ieukK9mpLfpctfUFdqVexCG05c85PdG5MjD8kwX9
        F2dylU3TQmnnZm/QFxxF1KDXZGn//PamcU1Qlh0kqJbxAw5VV5aDrzx/e6bFejvD2lxDB/WaR2A
        ==
X-Google-Smtp-Source: APXvYqzoBy+C+hirGOfFSkoGNtzvJuqsKJVMyFRLWuDPXKD5oOmJKEUviuZ/wyJaWi8dVdSjsAYNmwLNNXl2Mpi0HmE=
X-Received: by 2002:a63:e201:: with SMTP id q1mr6080271pgh.441.1579901171781;
 Fri, 24 Jan 2020 13:26:11 -0800 (PST)
Date:   Fri, 24 Jan 2020 13:26:02 -0800
In-Reply-To: <20200124210148.220007-1-emilyshaffer@google.com>
Message-Id: <20200124212602.74194-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7] MyFirstContribution: add avenues for getting help
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
Took a slightly modified version of Junio's suggestion for the archive
link so the final text reads "The archive of this mailing list is
available to view in a browser" instead of "The archive of this mailing
list is available at archive to view in a browser".

 - Emily

 Documentation/MyFirstContribution.txt | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 35b9130aa3..522c75099d 100644
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
+"subscribe git" in the body. The https://lore.kernel.org/git[archive] of this
+mailing list is available to view in a browser.
+
 [[getting-started]]
 == Getting Started
 
-- 
2.25.0.341.g760bfbb309-goog

