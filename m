Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD574C43457
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7228D2076C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpST/0wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409046AbgJPUwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408909AbgJPUwk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:52:40 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62465C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:52:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u4so2293084qvk.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=miOpoCaXWedJXhOx5DhSvSMgZ4oVjfDrs3UqJCIhyTg=;
        b=kpST/0wMAw0kPeiCZXfexLmaBa9hsyadLrb5ld2ShQJKVblXRrp3XSyttmABhIuaEC
         wOQZOkYWSd5kBZBUqA5lSgaVJibJh3g7oSOrixqAdHQ3w0FTwtQCz3d2xuJnhjCN5Ib3
         C36VoHPD+2/tRF+U/PqfQWsL72W7orTUsEDY2CQXh6ntDfXN+oatyL7T4b0h9N+smfyR
         Kjft+gXDFNIU38QpC+DRmo5aZ8WJVLkXysMeExlFq9yB+XoVk5mQnBjnEC7L8amqPyAI
         nqKMf9oabNNuVAVQrPqAi2/45wlGMysjRn4wu58XDDbX+2Y7aj7M8FlVeazZndz7occQ
         xZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=miOpoCaXWedJXhOx5DhSvSMgZ4oVjfDrs3UqJCIhyTg=;
        b=rSrWHhRfTvFfC1SzrMhvWQOUtaZ9fZqLOTU6OS7a8o6aeqxg+dphNo7sgo/AK7AGmw
         m6tYID+6rOOJHgr39wDl9ZvDmJyoQ0GrcIVZVUXeoogy28TeixJJZNQqFDMRWyg0UFI3
         nmeldh2sJvMAduNmPJ50fqpgvK4HqIHHb2YsuMsDd3AAEJsyMGO4L8i8hu1x5HZb91tc
         RsLFDZT/X3Bevg3Iw4+CxkyU0vXREwW8YS7UWBY2Mhg3zuPSI8vLSqfYaxsh4M/vp0I4
         WP0AcbjJC2/VfjTwD9CfmBSzT5n9NPLmOiaCmogEVfzmnscsP+92whJSaZr4wwHb/Ss5
         JWVg==
X-Gm-Message-State: AOAM532N8skj2QubGFOZ0Do+VbFgG3JhVp+Kacsxj1x8ZfZDKHgoqsnz
        wBJ6QOH2hsW5CBNqlJIDTGO3KadD7tEj3PHDUeOlVuvyJ3V2nhV9f5NhWNswx++Qqc57y5bOaN+
        mMDgtw1/XI7MLVmWMN5hqIcdTI3S2yboCeMWfwLDrW/BoAOUmijAL9xy+stIALi3sCIcXfzIHfg
        ==
X-Google-Smtp-Source: ABdhPJy1N3DRFUXVYVD5c1ooUvVYRIGDnFXyWeMpRy62KmzgYuqfvaFTayB+PsasfFIhnQLtgv70o9PU1ZpjFvHIYjk=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:44b3:: with SMTP id
 n19mr6070740qvt.39.1602881559416; Fri, 16 Oct 2020 13:52:39 -0700 (PDT)
Date:   Fri, 16 Oct 2020 13:52:31 -0700
In-Reply-To: <20201016205232.2546562-1-emilyshaffer@google.com>
Message-Id: <20201016205232.2546562-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201016205232.2546562-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 1/2] MyFirstContribution: clarify asciidoc dependency
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per IRC:

[19:52] <lkmandy> With respect to the MyFirstContribution tutorial, I
will like to suggest this - Under the section "Adding Documentation",
just before the "make all doc" command, it will be really helpful to
prompt a user to check if they have the asciidoc package installed, if
they don't, the command should be provided or they can just be pointed
to install it

So, let's move the note about the dependency to before the build command
blockquote.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/MyFirstContribution.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 4f85a089ef..7522387ae1 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -507,6 +507,9 @@ documentation is consistent with other Git and UNIX manpages; this makes life
 easier for your user, who can skip to the section they know contains the
 information they need.
 
+NOTE: Before trying to build the docs, make sure you have the package `asciidoc`
+installed.
+
 Now that you've written your manpage, you'll need to build it explicitly. We
 convert your AsciiDoc to troff which is man-readable like so:
 
@@ -522,8 +525,6 @@ $ make -C Documentation/ git-psuh.1
 $ man Documentation/git-psuh.1
 ----
 
-NOTE: You may need to install the package `asciidoc` to get this to work.
-
 While this isn't as satisfying as running through `git help`, you can at least
 check that your help page looks right.
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

