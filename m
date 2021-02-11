Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A36C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A7364E70
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBKHTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBKHTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:19:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CE2C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:19:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g17so2731406ybh.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OJ9DYOLCag/kXxXiQwdOa3pLbarXkqolexWQ3ZYDoGg=;
        b=sIWSaUu6HA2nVA3RevOH+ENqPUxPq7qKZy20S9QRo7E2Xmoqpq10VetUhnuys3dNrK
         KngFRczhVDOZ/FGgzy/u/jGeiPBlE0EkB+2AyhgHe0cDCwQX5FH7GGZGegkIq/TjbZLg
         V4sozSyMugKDcBS/6mFc3Ydb0VV8xdep6QTIg+Uo2WDU5Rb3gUFMnHEtQKlHDEHM3yWs
         GbXserjkRKyQNj0jVcBYl11eMmBDL+GAnQgv2ZKaeFUIdHrVgToQY9eZiUH/y2P5umfA
         yVZHKSvOzZ6lwshZvN/N9qNhV7wjdeGvH3V+kwtrWn2XVXRWw/N9XEWvFqu8WDf2UNoR
         3CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OJ9DYOLCag/kXxXiQwdOa3pLbarXkqolexWQ3ZYDoGg=;
        b=s8agKiRTAUzw3GYWmWx8IYzLaEcSEhfPYdB7SEcsfWIb4RYC7Y95/K++ux96RZN3JS
         2qXW8MxEQ8e3k2GYM2C5W9hhYJ7wOem08ZK+9etrPeT43RacizDeseb1+2yVdYzuAEMK
         m+aR6NjDAkAxFIHJW93REF6qjVkUfC9bE2NEBZI1+vegH8T4x8Nn0b03h+Fwx1d0BYVT
         GX47mHNvYfZ8/mTTJcCCB1cwOfFnv7YqxX09n51aP42BHh6Z+s2WxkGiIcdC/r5BO8iN
         2Zkj+8DQtvfOZkwzjVCii6E6ood7xV1y00ErKpQx++Jze6Q8vHqfqsdpRv0qManrA5sc
         vl+A==
X-Gm-Message-State: AOAM531YQBy3uBLrOt3i7Aovi4qSXXF1ARf/87e/n06HXh7OGQ6g/oZr
        CjpnX9OLnJ6zUvMr6f8nqxjf01ibq7Rv8cY6wI/YhWeCpK1rrfZwPpQcUYJeDHSJ244uQ5kjSAU
        yruDXoav+9GOCVuuZyuPX287SG9cvs1mGeZnBtUsGpYr+Ne1Qb+4g7MecWEZjKkO5BMNf
X-Google-Smtp-Source: ABdhPJyDVnLXsu7zZCZXp6pFYUA+ZTE/j4sUr2i1PE5xy0fLaKWJLCAEOlP0ZXCsylID+X48HqAZK+4VWDtcYkjV
Sender: "martinvonz via sendgmr" <martinvonz@vonz.svl.corp.google.com>
X-Received: from vonz.svl.corp.google.com ([2620:15c:2ce:0:547f:fd84:4085:9d09])
 (user=martinvonz job=sendgmr) by 2002:a25:57d6:: with SMTP id
 l205mr9289301ybb.363.1613027941742; Wed, 10 Feb 2021 23:19:01 -0800 (PST)
Date:   Wed, 10 Feb 2021 23:18:45 -0800
In-Reply-To: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
Message-Id: <0bdc333b25aca1de82fea3a1f290fe30ee3ebf51.1613027889.git.martinvonz@google.com>
Mime-Version: 1.0
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
X-Mailer: git-send-email 2.30.1.379.ge7fde23694
Subject: [PATCH v2] docs: clarify that refs/notes/ do not keep the attached
 objects alive
From:   Martin von Zweigbergk <martinvonz@google.com>
To:     git@vger.kernel.org
Cc:     Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git help gc` contains this snippet:

  "[...] it will keep [..] objects referenced by the index,
  remote-tracking branches, notes saved by git notes under refs/notes/"

I had interpreted that as saying that the objects that notes were
attached to are kept, but that is not the case. Let's clarify the
documentation by moving out the part about git notes to a separate
sentence.

Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
---
 Documentation/git-gc.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 0c114ad1ca..52824269a8 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -117,12 +117,14 @@ NOTES
 'git gc' tries very hard not to delete objects that are referenced
 anywhere in your repository. In particular, it will keep not only
 objects referenced by your current set of branches and tags, but also
-objects referenced by the index, remote-tracking branches, notes saved
-by 'git notes' under refs/notes/, reflogs (which may reference commits
-in branches that were later amended or rewound), and anything else in
-the refs/* namespace.  If you are expecting some objects to be deleted
-and they aren't, check all of those locations and decide whether it
-makes sense in your case to remove those references.
+objects referenced by the index, remote-tracking branches, reflogs
+(which may reference commits in branches that were later amended or
+rewound), and anything else in the refs/* namespace. Notes saved by
+'git notes' under refs/notes/ will be kept, but the objects (typically
+commits) they are attached to will not be. If you are expecting some
+objects to be deleted and they aren't, check all of those locations
+and decide whether it makes sense in your case to remove those
+references.
 
 On the other hand, when 'git gc' runs concurrently with another process,
 there is a risk of it deleting an object that the other process is using
-- 
2.30.1.379.ge7fde23694

