Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA3C352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 02:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5108A20848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 02:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJtqRWPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgBNCEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:04:05 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:36667 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBNCEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 21:04:05 -0500
Received: by mail-pj1-f74.google.com with SMTP id m61so4773016pjb.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 18:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=4iebp/1F/zKsbpxPhtFy0ptHg36A87Oge3tRKzNGmXQ=;
        b=wJtqRWPCxALiD1Y59jJLfFgytnQ+FGHSQVzTfMyuYvJgRhrTcG1bQ41sv718KKBrmI
         U2QzE7IhS6iVxhJxNdxqWiWUUlhpvamSy7RY8ygD6n8qv01fTJKEm5Ao3H2cJMS1j0Wp
         Wsdoy2Z3nlWbTiBBa5fvN0L2IYXuoXXZ/RxY9pJ8fQqC23cLcvDWSTRYqm8n4o2LaDHu
         kArVV+eKpwi5eeEJYRAcNCf944+9WOGt0/hayTTV3ieb40LFUlX1o/54sUDsrVrlieNM
         UF/XCe/MLQYewRNy0b/ou7TZc4p6B1UnFhbW6VH+yErGvNZJeu9OOyC3prUeUfDS8m0q
         8/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=4iebp/1F/zKsbpxPhtFy0ptHg36A87Oge3tRKzNGmXQ=;
        b=VGvoqwa8+CzBeZVDyi8AR3BkQ1HzEFLQh6im0t3QaVYZxkb7N1rj6DPsHkJV2jKLaZ
         +vpkLzteqvTp4b6HWJDbH3oScifk08egwd3x+JBV1nsVb22nM/mG2SxBwTyZW8Kv46iu
         49/4NkxfK9lV7RNaNWmvBzO65mURiUsTknWlQrYi/eXRBbbHdEPupADDjyJGGMjNuQ2r
         7htKn3fMw52ae5jEQp8FXy5FWv/1XJ719H9vATQRoYp5n4OChV2XE0mnujdaiEAqpOAk
         bVaY0D9XN0ApKAhvkIZmyh3xilm1YyBERI5SFfBCkqJGrXOBfkZisYCZwIgUrqv18q8y
         iNQw==
X-Gm-Message-State: APjAAAWNI9gJKhFS2G0uNsq0q+E57aXawnfAYd5L3nanV9MyF/h90hfF
        susUq8zHcMuDIv0nJQCa2PBxK61i0UvK+zmgCWzx8NY3DBiUV/HgrIuzY2qZSmfapAN63StR+k1
        /R/Tt6XoWr9udAPBXdNb1ABSZj+ENiRhqF2PABvlW2Au80/r21v59rTbVvQAlOB337TJVn2dDvQ
        ==
X-Google-Smtp-Source: APXvYqzRWR+tmBDMSKMsKwEhXi14UVQE6iijQOeypAN7xkK0hdtcyqhxEIK+3AFDy8Yx+yR02piV1GWx442vIbduh1c=
X-Received: by 2002:a63:1e06:: with SMTP id e6mr978800pge.134.1581645842857;
 Thu, 13 Feb 2020 18:04:02 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:03:59 -0800
In-Reply-To: <xmqqh803fzf1.fsf@gitster-ct.c.googlers.com>
Message-Id: <20200214020359.17463-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] MyFirstContribution: rephrase contact info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make an effort not to discourage new users from mailing questions to
git@vger.kernel.org, and explain the purpose of the mentoring list in
contrast to the main list.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Since I didn't hear any complaint about
https://lore.kernel.org/git/20200206221305.GB190927@google.com, here it
is in a real live commit. There is no difference from the scissors patch
but the commit message.

 - Emily

 Documentation/MyFirstContribution.txt | 29 +++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 522c75099d..427274df4d 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -28,11 +28,24 @@ useful additional context:
 
 If you get stuck, you can seek help in the following places.
 
+==== git@vger.kernel.org
+
+This is the main Git project mailing list where code reviews, version
+announcements, design discussions, and more take place. Those interested in
+contributing are welcome to post questions here. The Git list requires
+plain-text-only emails and prefers inline and bottom-posting when replying to
+mail; you will be CC'd in all replies to you. Optionally, you can subscribe to
+the list by sending an email to majordomo@vger.kernel.org with "subscribe git"
+in the body. The https://lore.kernel.org/git[archive] of this mailing list is
+available to view in a browser.
+
 ==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
 
-This mailing list is targeted to new contributors and is a great place to post
-questions and receive kind, detailed answers from volunteers on the Git
-project. You must join the group to view messages or post.
+This mailing list is targeted to new contributors and was created as a place to
+post questions and receive answers outside of the public eye of the main list.
+Veteran contributors who are especially interested in helping mentor newcomers
+are present on the list. In order to avoid search indexers, group membership is
+required to view messages; anyone can join and no approval is required.
 
 ==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
 
@@ -46,16 +59,6 @@ respond to you. It's better to ask your questions in the channel so that you
 can be answered if you disconnect and so that others can learn from the
 conversation.
 
-==== git@vger.kernel.org
-
-This is the main Git project mailing list where code reviews, version
-announcements, design discussions, and more take place. The Git list
-requires plain-text-only emails and prefers inline and bottom-posting when
-replying to mail; you will be CC'd in all replies to you. Optionally, you can
-subscribe to the list by sending an email to majordomo@vger.kernel.org with
-"subscribe git" in the body. The https://lore.kernel.org/git[archive] of this
-mailing list is available to view in a browser.
-
 [[getting-started]]
 == Getting Started
 
-- 
2.25.0.265.gbab2e86ba0-goog

