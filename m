Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A8C47254
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1094420643
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxZWpjIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgEDFmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 01:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEDFmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 01:42:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501DFC061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 22:42:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so3296598pjb.3
        for <git@vger.kernel.org>; Sun, 03 May 2020 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLJr6sow8XRffqwXDnsy/n9IXJ73EI6kLpfmNNuAQ/0=;
        b=qxZWpjIPDG53TvC7Kr1QECp0AKa9Vx2Vm0JxjCmL0T7AnaVlkxzLKRFZEa5y+MCoHy
         otCxLiHIcMQe5Tp5kQd2zj6i7L65aCcAe5d2xOHX7HnN9Jj3JdBCiH8xgkve8SLaf6XO
         nXwHuei0/PEfSAZxniDiTjxYr2rkD91BmoNty901tx1xegTxyScRPP38uhK/pTK8qmz1
         +ASITq9uWi0Ey4tXKWRqsWDmIOPs1C6sI1jZfMoOiOgTdLDwd9tU+fzIUm9I1xehwPfP
         CQStHINj1N6BYIhrWAK9ReTWwh15ssDWbfj7QyOmiFohyAd1MQZ42/p8tMbEFz7pNx7T
         HHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLJr6sow8XRffqwXDnsy/n9IXJ73EI6kLpfmNNuAQ/0=;
        b=pw6mhFNtTCzfZdHZsAiJqnIoh+nbMPKuXusOH9kXlKNyztjSnd8kv4f/IwVLr18WVV
         6upsQeDPYsghMsbtTCG0uSt8S5YaFZAE8Ylx7KyFDEHj85Fs/IGUsL1yw8pVXcD55tGD
         3u5aRhQANY1zHXF3KGbXkmFnFzfHC4dk7vseFaYW4sdRMcOmTN7V/x3Vhc7/xmZRicrd
         3+gkgjz0Dq8wJYYBO3ibYMEOebQgBKI1hc+EhtBH4OXeiKQ23+yf1PNYMDncTNqQ1a7s
         CroZ5ZCGncroyaWe+hBYmhhuK4TlXErDD+/ADb0QRShDm3hf7dG9Q4eoZ5OUb+rki8dT
         xrEQ==
X-Gm-Message-State: AGi0PuZeUm83lFp920uvbk3EXSG5fGgswEihHnVA1PV71LMEyBGY0Ome
        Yvo8MooaBxJ7Dk0mYQgllCCE4TatG9c=
X-Google-Smtp-Source: APiQypIkZJq4OsLjkk5fc9YjD+m1eed/OMtAbaGyQVRmuZ1JfhO8ES7aU4ed3PMP9awOPqXObzuDYg==
X-Received: by 2002:a17:90a:a414:: with SMTP id y20mr15516673pjp.45.1588570952181;
        Sun, 03 May 2020 22:42:32 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id 189sm7850785pfd.55.2020.05.03.22.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 22:42:31 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, newren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v5 1/4] gitfaq: files in .gitignore are tracked
Date:   Mon,  4 May 2020 11:12:20 +0530
Message-Id: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
Git tracking files/paths mentioned in '.gitignore'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Thank you Junio and Elijah for the review! :)
I have tried to make the solutions to the issues as concise and crisp
as possible, linking the Documentation wherever necessary. Also, I have
converted 1SP -> 2 SP after full stops(.).

 Documentation/gitfaq.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 1cf83df118..11d9bac859 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,6 +223,16 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate.  This second, modified
 file is usually ignored to prevent accidentally committing it.
 
+[[files-in-.gitignore-are-tracked]]
+I asked Git to ignore various files, yet they are still tracked::
+	A `gitignore` file ensures that certain file(s) which are not
+	tracked by Git remain untracked.  However, sometimes particular
+	file(s) may have been tracked before adding them into the
+	`.gitignore`, hence they still remain tracked.  To untrack and
+	ignore files/patterns, use `git rm --cached <file/pattern>`
+	and add a pattern to `.gitignore` that matches the <file>.
+	See linkgit:gitignore[5] for details.
+
 Hooks
 -----
 
-- 
2.26.2

