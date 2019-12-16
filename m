Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F949C2D0BF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1263620684
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UByxvXU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfLPOCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:02:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfLPOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 09:02:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so7376810wrt.6
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YmwJ1AiAhROBSVvbSzClqv1iDdOg1HA0hifERAW9N5c=;
        b=UByxvXU/wT5JUhD6Pq9n/RbbhaIul5eWjvFCIP3Z81LnxC2Otd77Wu59iSQJF0bju+
         9HA0uk+9bVU8Zj/2mv8r4+8CDmT/0GiN+I09Pd91eaLTu9F9TB5C/fdENcmY9kkf1wzf
         pkD9XIHrcoeE/m20M1MQKFN2VdSyfSR/p7tnMu/EQhMYh/VwUfZsltN6jV1t7Ykt7MbN
         ffFiIuueTTUv1HHXkBirkpnUVyG/FdOYJtZybXfxqX34nY8P3wGzuSuFoz+jjnE0ZeCL
         jkgqmqtpEexamcF689US5KtsYH5wzNa9O2l7zrgKDJu6hkgpy/emfE4HMfZNsenRWXUv
         sNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YmwJ1AiAhROBSVvbSzClqv1iDdOg1HA0hifERAW9N5c=;
        b=WOLH6LSEgrnfqqqRUXDRhZ8AuO867X+OAXWR5s5YlT2WUDtVHQKU86WoMlA1I58+tK
         kog+sawd84jxP9iOQwqXU/GbwyL+nF28VQzUPGl/1qYorQnxRNa9YZPXaesn+uaGi6xQ
         xk21t2KG7n22Xw2IKdFRfXQlR+akfYJHc6KpUfwGSablwHU57kccSvFiCKYCelUEqTL2
         vBguevD1MA2kEiCdDTnuav9K16V9PotvhU5Bl5S3uc0l4KnAWfxJ8+C4z6b3P7YtulQ4
         m8Cp4qhm1FMdNLG56nt33cJRwWMYurxFxOWvy2ESGvNwyNYuKoG7VP2vpBFS+NKct42y
         shSw==
X-Gm-Message-State: APjAAAX6ADVMdKyAZbokSDAT92Bm3xtL8UfIvAGgnehkXhqSJfxWxIye
        aFFYRnW1pMlBhW4eCX6vyas+hOr6
X-Google-Smtp-Source: APXvYqwJPHtzMOzH+DtrwUhHHmE57NKYgkaZDJN6fxE4nx+NP+hlPLFkbX3A9OX4p4WWKwNg+M1esw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr30268835wrp.1.1576504946831;
        Mon, 16 Dec 2019 06:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a20sm21914645wmd.19.2019.12.16.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:02:26 -0800 (PST)
Message-Id: <4c4b783fd52252200a607c83517e126988e67f19.1576504942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
        <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 14:02:22 +0000
Subject: [PATCH v5 4/4] git-p4: failure because of RCS keywords should show
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
index 03969052c8..690e5088cc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1962,6 +1962,14 @@ def applyCommit(self, id):
                         for f in editedFiles:
                             p4_revert(f)
                         raise
+            else:
+                # They do not have attemptRCSCleanup set, this might be the fail point
+                # Check to see if the file has RCS keywords and suggest setting the property.
+                for file in editedFiles | filesToDelete:
+                    if p4_keywords_regexp_for_file(file) is not None:
+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
+                        break
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-- 
gitgitgadget
