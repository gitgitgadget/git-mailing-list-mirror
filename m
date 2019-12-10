Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A9C00454
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC36220637
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBohWi7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfLJPXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:23:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfLJPXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 10:23:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so3673956wmj.4
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 07:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o+vj6uvVsChVb0svYX33+5HkrkO+BSUa9jCDybMu8Ss=;
        b=tBohWi7V+L/aT7gGnPMpOiTw+JZUkkrHCJMwnriz/kDgz4cYIFR7BgYDSy59264Byo
         njXY5oE5GV1LknO7n36IycXRAiMdnFxBtxz6woyxP+TL0YGcKRb0tU1upM+KCjxTW8lj
         ZWII23494/v3LFauxLuhaCTXpRQ4N+KV5y4chs2i3jvNChweoVZQUTUF1hQLuYNV/TnO
         gNSZad/+/Oeyo03saTF3xKmq5hxdkYh7XxdaSO86gRDVRbKJE7cgQ4Wp2JAGIDV8C2BG
         Tiv0shqP2fNFr4Fg2F6WRQeEt1AaTnGxHDDGxIgjtrRt9rezEFHezZ2krwl/4AELrK1A
         e8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o+vj6uvVsChVb0svYX33+5HkrkO+BSUa9jCDybMu8Ss=;
        b=kXYcbgQRM0k+7X/ymkzNRD6kwvZDKGt0/+Y2KC6ukdfcdGeOZzwYzD5Oxs0EM9WfJj
         C57zy1oIhqxBpZNHmdRrKuNKN+56niT1Rxk9JmV7T/pCByk/dtTVjyEzy3TC9p/USzf7
         gGuUKgycrSmUOz9K9Ezsc1Wf/9pa/A022MyrCAnx8s1dvWOtTFMhWBMxpGgtLjZdCOwl
         9Nh7nsQ3Ad149GqJhC3tmA+IYIqH2j0kiMuoCxa5S3ktr44GbNrAOjQ8Kj1fipHxv8fb
         eFVPcv2oQpDKVNgjJ//kyZeumyPrda4sEFCpKtrmHkvFsbd0QdXfk5/U+iKJPJNoh+KT
         0Fxw==
X-Gm-Message-State: APjAAAXYHOJwotBtDKQ8+1CWGcqiZdlXywdJAY8GCJeFjrFy220UFFKT
        jymHDjB8IT3CEc1h2f73x16FXZrq
X-Google-Smtp-Source: APXvYqxJaJ8N1i4VCMjukYI6aDO5NWUPm+V5l9RhjdwxBs2gNjbE7VK6bkwxYUYvZnJrNCsEZGTdCA==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr5690398wma.97.1575991379224;
        Tue, 10 Dec 2019 07:22:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm3365285wmf.21.2019.12.10.07.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:22:58 -0800 (PST)
Message-Id: <50e9a175c3323074ceec848c0d4054edd240e862.1575991375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
        <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 15:22:54 +0000
Subject: [PATCH v2 4/4] git-p4: failure because of RCS keywords should show
 help
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When applying a commit fails because of RCS keywords, Git
will fail the P4 submit. It would help the user if Git suggested that
the user set git-p4.attemptRCSCleanup to true.

Change the applyCommit() method that when applying a commit fails
becasue of the P4 RCS Keywords, the user should consider setting
git-p4.attemptRCSCleanup to true.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 174200bb6c..cb594baeef 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1959,6 +1959,14 @@ def applyCommit(self, id):
                         for f in editedFiles:
                             p4_revert(f)
                         raise
+            else:
+                # They do not have attemptRCSCleanup set, this might be the fail point
+                # Check to see if the file has RCS keywords and suggest setting the property.
+                for file in editedFiles | filesToDelete:
+                    if p4_keywords_regexp_for_file(file) != None:
+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
+                        break
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-- 
gitgitgadget
