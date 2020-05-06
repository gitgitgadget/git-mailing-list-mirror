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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC346C47258
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13FB206D5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTL2a2rU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgEFIAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728290AbgEFIAx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 04:00:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB852C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 01:00:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so743976pgb.7
        for <git@vger.kernel.org>; Wed, 06 May 2020 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kK7hH57bq6vkJJU9F+fuRltSazWPLKfEajOtDR7f9D4=;
        b=LTL2a2rUZ0SXlKV8TQMVKovDx9AujAbNWe/a/LHEgW5ZfQHihS4ICr/4EUx6JM7E+f
         ar9lhwSN8dudv7b92r75HLnCgYJu3rqZ6wdHMYpaG8M4L0RQJ8N4KFL5JvvOWWE5Sk+i
         gp6tcvcgkDmRvpo07VSewmasonO74ETF81ofeePjpCdawPexudmwXV2QEAmTByq4EQx4
         WyWNsYtBFiolGZaa1CrbVrYViGUKqnc2R54qmI/7oiWEaORnIJtqapaMXO3ublsHOzlr
         VknDnF/gXHX8nmC4L7qm3UkUsY7jehhmWVdvvhpxZBJwwQOHLJDGrnX60Jk62Cm+lef+
         40/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kK7hH57bq6vkJJU9F+fuRltSazWPLKfEajOtDR7f9D4=;
        b=ldGBk7br5VqdJirLXoHxX4/57HM+YxLtlJCb4lmU7I3Rp2bgfUCoBHEj8t7JnAvOEx
         hjciIkszTTMmeO8R1QozKAFtLoh3KLT6J31Z0D2qG7BrOiFPNwI5LFZ5kJM0hvesiHVr
         MAo1F/hMhYjjuN7xQsiofuWKRqhzp2ZIImXql0jxuMdCY5f+IH3Oemx2GJ5JZ62AcW80
         Ocbeb9XrHXQJM1GNGuDDz8Rkmq94jG+3Ou922r22RU2V+aa5mX4omzPNQcDEYd/eDBOA
         OyWAP5X6yjlKW1sxcENh8nVSZQehStgaMp+WKadK/KJH0jqJf9uNYKMvy0GkLNWKJAdC
         F6xg==
X-Gm-Message-State: AGi0Puavm/8kYGo/MfsJNVoAyAtObjwPtHmelO+Na4BLvGwYoYQLFfEd
        5qeQFzxctjBO8zp6XCgOlcrBO8EU3SHFAw==
X-Google-Smtp-Source: APiQypKglBDZyPuqZs49cgPFDindApDAZ4hxxDf3aKFvBYDktvFEVh21QEPKzXC0ZL78OJJUXXRFoA==
X-Received: by 2002:a62:8707:: with SMTP id i7mr7241149pfe.133.1588752051779;
        Wed, 06 May 2020 01:00:51 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id s44sm4312629pjc.28.2020.05.06.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:00:51 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v6 4/4] gitfaq: fetching and pulling a repository
Date:   Wed,  6 May 2020 13:30:23 +0530
Message-Id: <20200506080023.12521-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
References: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an issue in 'Common Issues' section which addresses the confusion
between performing a 'fetch' and a 'pull'.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 5dfbb32089..53e3844374 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -255,6 +255,14 @@ way of cloning it in lesser space?::
 	presumes that the user has an always-on network connection to the
 	original repository).  See linkgit:partial-clone[1].
 
+[[fetching-and-pulling]]
+How do I know if I want to do a fetch or a pull?::
+	A fetch stores a copy of the latest changes from the remote
+	repository, without modifying the working tree or current branch.
+	You can then at your leisure inspect, merge, rebase on top of, or
+	ignore the upstream changes.  A pull consists of a fetch followed
+	immediately	by either a merge or rebase.  See linkgit:git-pull[1].
+
 Hooks
 -----
 
-- 
2.26.2

