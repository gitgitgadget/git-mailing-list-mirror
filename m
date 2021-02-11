Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BF4C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9E86023B
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhBKABQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbhBKABK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 19:01:10 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D34C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 16:00:30 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id q37so2716301qvf.14
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ikPWk563lT9DZHRdp/72gDq99c13wbGSadoft2K3fUo=;
        b=Ildav5cheR9JRHHrUUrRKQ2FaLE/FPNTbmBMn0UrTI9Gtt6pzKOzDfRSyiWaXj8naC
         2Z8j2GVDl8vCcPSHY4G9CbvHRKYYM7PKpc6jf7AuESrefTrJ6LM8Sg/oj9T+ixy/TXB3
         Ni+CA2irjHzbomObV+1JYsfVHxaBFnoRNWpnYZ7CQOkDAsS8/EsyVB6oZ9oYIHntyHSI
         KNmOZqOYSwYPdRXhOtDYdg5fOcTSrklmFbKJ424heJ59FwAAjWpJif87uWxNpG1bco/W
         rVofYl3zGrxLZqcENOJFi04nkcrrGl5FfNcJIU3HD0yY9FQWBoy2zfzOJqgPPpzrjrMy
         wH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ikPWk563lT9DZHRdp/72gDq99c13wbGSadoft2K3fUo=;
        b=TfdZvtXPXzx6aSYBjp5Iah+JRxzjMMLEC8wwOOz2YLzvu9G97VdGb0fuhBQ4WQC5Pl
         DATa+9kb51hEwvmTbm5f3dJmL7ZNpIVXqaT85Lj1wLt25tMv5w8H775t5NeDAZx+ZXfA
         2R4cRk1mJbqA/qUOA6cRZkMiCgmX9KwsLn13d/YhOMPZI/T/z8vXWSm/KuGSxlqIwo2N
         y5A66MinLKIKnGXrV9ankjR9rqP5sGlOO6jsGym5U2furhx1CTYccT3e2RxBVhAyxQdR
         tjD4bOIRw3nN6z1vD+fYhxQGJpk7dFO0R+34+GdqzwWqatfzlwtUwR3a5AlnTO2vbm98
         P6gQ==
X-Gm-Message-State: AOAM531UqNwyblVlNd7OdsiMaN9Up61yXQOvwVUEi4iy2gQ2XJ8MpAOS
        E4H7aLV87/dri9XgIVWSsMo57HWzSarQexMhj3q5dawzQ99twNC3vXO9jI//4wkkaBuYSVu0oPR
        wiPxA1FabAxdBhh/rn0cS8sdFYhuKXr3sl5bROJnKjjIWntm33EeBOFm9qxGs82SJtZhe
X-Google-Smtp-Source: ABdhPJwf4wSoAdRTAsV59grM2hn0pZzO5vqfnqtiZsKsTnsMWGDH8awtMpcu2eqGoXZ80uJJQMGWJegzhAS/tmR9
Sender: "martinvonz via sendgmr" <martinvonz@vonz.svl.corp.google.com>
X-Received: from vonz.svl.corp.google.com ([2620:15c:2ce:0:547f:fd84:4085:9d09])
 (user=martinvonz job=sendgmr) by 2002:a05:6214:324:: with SMTP id
 j4mr5137804qvu.53.1613001629117; Wed, 10 Feb 2021 16:00:29 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:00:21 -0800
Message-Id: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.379.ge7fde23694
Subject: [PATCH] docs: clarify that refs/notes/ do not keep the attached
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
2.30.0.478.g8a0d178c01-goog

