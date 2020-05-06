Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E4C47261
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCAD20661
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIp5MLvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEFIAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728290AbgEFIAo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 04:00:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0298EC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 01:00:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x77so614162pfc.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOUXWnKVVNY07x46K9+05zWijgWjrRUXm0vAdRPb8HA=;
        b=fIp5MLvRJc1Cn6m9FMEyWoGyLlV5oMqrtYRq+00vW9FdjCLx5OAGkTFSX44v5PfTN5
         BJxdAihNppkmz6KFpKwsnn/fWHrwsw65OJRrqdc8Rormq3rXjmennpnAT40ukTrIBI18
         6n3frSlZKkgcfssWUu32cGXLH4AQj55Tuo8MIQ7dH0NU9cRXjJqm2oeogg8RU6AWSi05
         p2ARY3yCtJw5VjC5na/u5FvZr9lS/Sqw9xoiar4vpe0ai8S0fUhTrBZzVrXnssGOJfT/
         H3EfQu3kRnzlv9whlffZCR8jZyfxMjLpEjlrrUzg46tMI6MjMRvrF6yvO/30gII1ADuy
         w1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOUXWnKVVNY07x46K9+05zWijgWjrRUXm0vAdRPb8HA=;
        b=pvO4dLTFHh8dmXNLI3FVb9n3wvaoIIqYhT0JcWysjLce2jA7AWneTU1ojSDngCYSxp
         Nxh3v+ScaJV0jxHEv3NTi3q2rsNh0UTvkMHZz55Gvz63knRbGok0X7SUxDExLYbfFGrw
         9N3VG/Yn3fHhFn/v0RPHfkK+hHvbEfoTMJoWa/8zGngoYY3Z3SBuCBmbdGEicmlFV9md
         aZu5GsaQfqPhW5xlYZNhaXr9hH5kyKLPyRvdn0NtcNrquk0gsPUXbJbd/TV3u/e8jo+4
         Tm21vecl3v3r8RYUpefLkoAbNejxJiyDDcEjCc3DIaUUVeSXVOGCavmuHD4wl+WXqMpX
         xMMA==
X-Gm-Message-State: AGi0PuaYlrt8fXbiBzKT/ZcwmkuBkOmeYmJ7AZC7Q1Pb0Z6sVBw2GS5j
        uNvoP8q72IN0WtB98uVU2KPgu0SpRr3L+Q==
X-Google-Smtp-Source: APiQypLm4BTEU3dZK949a0vtm2AW12LoYVJaFZgopIdboa0tb7L9SPjg9x+JkY5PcUyerBj4ZwyYqA==
X-Received: by 2002:a05:6a00:a:: with SMTP id h10mr6932817pfk.160.1588752042809;
        Wed, 06 May 2020 01:00:42 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id s44sm4312629pjc.28.2020.05.06.01.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:00:41 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v6 1/4] gitfaq: files in .gitignore are tracked
Date:   Wed,  6 May 2020 13:30:20 +0530
Message-Id: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
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

