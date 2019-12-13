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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE2C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 01:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847D3206B7
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 01:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxH0Wgyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfLMBbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:31:35 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41315 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbfLMBbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 20:31:35 -0500
Received: by mail-pg1-f201.google.com with SMTP id r30so421530pgm.8
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 17:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=mxSB/lgD5rvV9KC70HVMsDN9ml5EBMT2pc23XbulqgM=;
        b=rxH0Wgyy9b7asJvvG90WJ3NBoZUcnyX5Tcg65Eff8WvebVupa9DKiv5hjXx/SNc62+
         Z2a6Hh+4jm3BG92DMRgotHteJhAZnP9P9TXg1m+jBRZMtqmkeaOAW47sJdAXLSRFDwDB
         lzbRN40MfoxPklqkVD4+Nwz5MN9KqVI8vp+//wjJRA8W6QgcJ59JPaLx2DMD2s7McuC2
         tpnpAa6fdp1qmWoGh7acyneRTF3wg6TymV5KNnwmXcqMPgaiWcjR8nAf1J9c4f8YzXIj
         StcrfNso4avQgCcds7u53y8CxGUPUYrSZ09/hSkS7RAfyoP5/HOTS3279kiWKRw5k5Mc
         JzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=mxSB/lgD5rvV9KC70HVMsDN9ml5EBMT2pc23XbulqgM=;
        b=X9zUzWTUvbqQ5p8tKiO9qum14EtIDfTTgrcTGh8P4cr9d5PJQACLONKNtMtpMg8F72
         0NJidcU7SB/eWxafhuLg9UJrZe/OTaAVf1B4A8UOgzhE2SUl62GjKALeLKx17R3JecYg
         g0hnJ1defAkiOJyclN3yocvmDVQcWUK8PX0w6/fVIW22HO98falA/PuU3K39JlNeBoIM
         cbUmzk0DR4YYNIWkrj5WzYtqqt3LlHFwlRuGNkw2ALgrxSujaTDN2lzuDbWUzBfgcUaP
         5luik2b48Tu8RqemlXTkN782ixVLs+l3aZycntdBfBWHsq2wY2rVk6fzDIiC15SrDVJv
         wLGg==
X-Gm-Message-State: APjAAAXpzsTB7MV2sJj2KUPbAgCLmSUr5dgZ+joXmjDet7xN4nLGVpS9
        YrLsweVVOwa6FC+Cy31IKLtYWQwpBYdPjOj1Kmgaz0VPAgsE/UNuXl6mlbsgj5j7NFHQi/sIxvx
        If1mdfDadd5F55e2oqTaPfm/OQFCjly1Cor4JewP1Y9zOxyGh7oeyrJtwNQJkoZSvCIK8h8VEUQ
        ==
X-Google-Smtp-Source: APXvYqz3ZtdTjdlaZkARCcwe+8QiF/p2/2AaDkjHzMbo27jr6zEsMyCjIFuk7XgX4oZzV8iayQ+vBtmzfKkQo+0qIT0=
X-Received: by 2002:a63:e90f:: with SMTP id i15mr14205463pgh.9.1576200693051;
 Thu, 12 Dec 2019 17:31:33 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:31:28 -0800
In-Reply-To: <20191115230637.76877-1-emilyshaffer@google.com>
Message-Id: <20191213013128.6268-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3] MyFirstContribution: add avenues for getting help
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

With https://public-inbox.org/git/20191114194708.GD60198@google.com/ we
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
Since v2:

- Removed a double slash in a URL
- public-inbox -> lore.kernel.org
- Removed indication that Git list should be a fallback; instead, treat
  it as equally useful for first attempt at Q&A.

As for the conversation which spun off regarding the access controls on
git-mentoring list, since the list still hasn't seen traffic, I'm going
to keep them as they are for a little longer.

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

