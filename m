Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFFBC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 03:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E31820678
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 03:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMVSAMu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHaDkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgHaDkM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 23:40:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62568C061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 20:40:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so3613089wrn.6
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 20:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=UvxiOarWfccWS3yzESDJOyKsQqiRPCi7ShioC7HKipU=;
        b=cMVSAMu+1z8RjJpVTtknVfpDAgW83la3IJUYLXUCdoQ+DsL+8XMFdu5jT1y7jH9d5U
         JQqto8FE8Tc8c62My3yIVGRgQEzT6zHccfvImAvkW58O+pYOWQMjjcw593yF/+GNrKXo
         bP4vSx8DKf003tLFD1LV0EvIYLxr+x0bsdZ1QqcKy7OCqRaLqn5UKz5jzMuQW9dzkxFn
         uRS7WatCJTq080THquDE5RI56tX7arEcZzyb3KgXpXGY63J8yEOyc7dQnURxPO4OQ8dy
         lA8IF+PZWt/Y2djFpjZZJjXca3aMf6wPH3+KpvfbQ/QNKgphu1opyGM8qBdI1pD7tOm4
         dM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UvxiOarWfccWS3yzESDJOyKsQqiRPCi7ShioC7HKipU=;
        b=VvrUtnD5JZ5wLmKmwqQjziSJK2AUyz+5jN+TVk216LF4qoDxYUoDj5o9r1gQzAwC7D
         Mu0j0MaIsSEwXRYZuYpCUM7TzUqRhmPv0B5aDa75WX+3VslSGyQPSU3VR1xnsT4Z7YqS
         DghZWm7kBjBj3y0tf20y+UrcxbG6dJJlPNV+mx0UjmjWtZgMDnmsj6fxJChLz4W+ANyB
         fstK2nOf+EpqyOVaGMWtLr9tY++EP7gOddw91Zkj/42ogUjNmnnWp32P6WgaxsFR3rRQ
         5RNVpmSmxvFeZKf6xwF2AcEhBwkSoF1UpJEZLiVIyt67e8uQ8srG0oKn21kLa5N3Mo19
         hNJg==
X-Gm-Message-State: AOAM531IAzelNTcsVOub/g3hYqsBRbP+EPdvz8XW79DNqvFCymHvJG/G
        wBvdcBFavUofa3MDlFps29wOTloXHlI=
X-Google-Smtp-Source: ABdhPJzNosoe0l15kCsK4ruylhhJM6MSn4c9AIQBWYXqHPgfMDUXbnPsFtK+FOUn5bmH+4TiBDYn2w==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr9259072wrp.298.1598845210546;
        Sun, 30 Aug 2020 20:40:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b204sm10123830wmd.34.2020.08.30.20.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 20:40:09 -0700 (PDT)
Message-Id: <pull.716.git.1598845209155.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Aug 2020 03:40:08 +0000
Subject: [PATCH] doc: mention GIT_SEQUENCE_EDITOR and 'sequence.editor' more
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Peter Oberndorfer <kumbayo84@arcor.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The environment variable `GIT_SEQUENCE_EDITOR`, and the configuration
variable 'sequence.editor', which were added in 821881d88d ("rebase -i":
support special-purpose editor to edit insn sheet, 2011-10-17), are
mentioned in the `git config` man page but not anywhere else.

Include `config/sequencer.txt` in `git-rebase.txt`, so that both the
environment variable and the configuration setting are mentioned there.

Also, add `GIT_SEQUENCE_EDITOR` to the list of environment variables
in `git(1)`.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    doc: mention GIT_SEQUENCE_EDITOR and 'sequence.editor' more

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-716%2Fphil-blain%2Fdoc-mention-sequence-editor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-716/phil-blain/doc-mention-sequence-editor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/716

 Documentation/git-rebase.txt | 1 +
 Documentation/git.txt        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 374d2486f7..9e2f9576c3 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -204,6 +204,7 @@ CONFIGURATION
 -------------
 
 include::config/rebase.txt[]
+include::config/sequencer.txt[]
 
 OPTIONS
 -------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2fc92586b5..0bb1cfb239 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -605,6 +605,12 @@ other
 	an editor is to be launched. See also linkgit:git-var[1]
 	and the `core.editor` option in linkgit:git-config[1].
 
+`GIT_SEQUENCE_EDITOR`::
+	This environment variable overrides the configured Git editor
+	when editing the todo list of an interactive rebase. See also
+	linkit::git-rebase[1] and the `sequence.editor` option in
+	linkit::git-config[1].
+
 `GIT_SSH`::
 `GIT_SSH_COMMAND`::
 	If either of these environment variables is set then 'git fetch'

base-commit: d9cd4331470f4d9d78677f12dc79063dab832f53
-- 
gitgitgadget
