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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73BEC433E9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7276964E3C
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBKHkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhBKHkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:40:00 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B6C061788
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:39:18 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id v128so3678380qkc.12
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0/4W6qCB9/htuHyi3DThLfp9ryc63hKnBiam8RpUedQ=;
        b=f3mT39Gl6skE49yyan9TN16RttVkpiCUGF0ojnDHcFnvyXu+Zr/l2ylMwDg/McoAFU
         3uY2dfMcu+H8C8bWOhrTwNETCwIyAabNjQ9qfWZogpefn1hx6M2s5ueiBx8lwldISqEj
         1yJiQCG8lEARlfdP6K4KratjIDlJXxog5p78RDuiSvCSwjoWLkUA9Xh/PHhxps3Axmg2
         hplvvsmmZ1BkcS/4VlzskizoMV0eNzvWF0FV8tf00bofiRdA5kAURBYk4pY1dXGoaClN
         U/VLO1Hu7Anf19DSwhtIFo36e4js9AguWWFs8N4Z8a2WNccwbUbaN6b7hSMLC4cuG0Fx
         sPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0/4W6qCB9/htuHyi3DThLfp9ryc63hKnBiam8RpUedQ=;
        b=NR/cT8St0zumREWYAo/cItjsOMiNWibZP+jcD/NPjO+8XBnJA6CiD/OQSyFcoXiEB0
         Fg+jpGTWzQgO2tVJngxUxBGLWUYJqzr7vAZ3UpboLahRgzGemsY1BGeQqOwyP+nRSr71
         Fa72JpopWRAa0uxDkgbOGH7iQZc50gArH/ROuWb86sXFN/T6d55ugCQH949W6wSYZ6db
         FJ2LdQdVBejPzMnStEzAA2ybHcje+4TnWRm88eOkDUY+KMPfoJSg692+IpQZgBvKYx+8
         flfcXWEvfe8/B1nZ2SfpDOyFup0KZiXanAzN0A2Ul1m6YzH/1nhDfPkbLhVolkDa9amy
         Jgug==
X-Gm-Message-State: AOAM533P11nKIW7lDkdxC0H9JKVhJt4bIWAEeW6ZZrd4Z5RqDQ70Shy/
        kfA2aXr0/CAvAl5JBYx0WxPv79KbSC405xtJlU+hwrAHqjQDgXsdRhRMp6DSHiiJFbYhsK256ie
        9ScjqZcqz9Ub7dEQotzshRQh8hnLcN6cZMblyfMsueTcSCMx9wb6fJKvlPgOQymgb2JQa
X-Google-Smtp-Source: ABdhPJxlLbWK3OVSop0VAqrDijDqUFwX2WqTeHvT02LZ+UZzVYWF7VgNbKwKUpIiBv0XY0JukwtBuLuzktBSMioz
Sender: "martinvonz via sendgmr" <martinvonz@vonz.svl.corp.google.com>
X-Received: from vonz.svl.corp.google.com ([2620:15c:2ce:0:547f:fd84:4085:9d09])
 (user=martinvonz job=sendgmr) by 2002:a0c:8c87:: with SMTP id
 p7mr6354806qvb.46.1613029157161; Wed, 10 Feb 2021 23:39:17 -0800 (PST)
Date:   Wed, 10 Feb 2021 23:39:14 -0800
In-Reply-To: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
Message-Id: <6cb0a3d0ab333984c35dd1026b80a2dc800d4520.1613029124.git.martinvonz@google.com>
Mime-Version: 1.0
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
X-Mailer: git-send-email 2.30.1.379.ge7fde23694
Subject: [PATCH v3] docs: clarify that refs/notes/ do not keep the attached
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
index 0c114ad1ca..853967dea0 100644
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
+rewound), and anything else in the refs/* namespace. Note that a note
+(of the kind created by 'git notes') attached to an object does not
+contribute in keeping the object alive. If you are expecting some
+objects to be deleted and they aren't, check all of those locations
+and decide whether it makes sense in your case to remove those
+references.
 
 On the other hand, when 'git gc' runs concurrently with another process,
 there is a risk of it deleting an object that the other process is using
-- 
2.30.1.379.ge7fde23694

