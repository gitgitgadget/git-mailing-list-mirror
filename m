Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DDFC7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 23:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEQX4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEQX4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 19:56:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AFC40E4
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso2808813276.2
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684367799; x=1686959799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WumVw8pfyzqyi4gRTvcKTYmddmYbNOaLTISxCz/HumE=;
        b=CnGw/+q3+geD7I+Zweu/MBfJUEHEI+pR8qpwWf+y1fVaRdqWnsCMwMzXcGsRSu1yEU
         ODmxoXswIPx5SWJdgfvFJesUaw+MMB4Gm39OtEpa+xv2EDbyzj+1lbbDiiWckwi161Nz
         H/SuFR+StAS+W85ptsF14cgObdhEfXOtoEjZhRjIP94r0stWXxW3AEw9q1jxRZgznzRr
         tpNewt784kt91xu4MuQk546Xji2eczAK/HmqQxlyTee2bl+a+9nGbZL9ZXTIOBqH0Cr5
         c6+wyBmORp0oqNer+IVS3fkj+7TbiOpftEHs0P8JNzrN8JPRL5RdbCwHaxeRN7fI5JQk
         3GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367799; x=1686959799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WumVw8pfyzqyi4gRTvcKTYmddmYbNOaLTISxCz/HumE=;
        b=TWbpVo+Ykjv/rf88++D6Y1CxA4bPDVgCVhFYB+t/0Ynhxazl4n2+VYUMOvltXoLxTy
         qn4opnD79ySfzt02wlYlNm1dzQoUsohY5AJoDC0tB+JoWxSFx/AW4vrjRL6bv43bQTpr
         Sa7UeSq6CJn5tfoK0qwPOFXiRJSCiMhbF2NuznQVvLQmWE4jSp6QgEa55XqzAWT0CPyz
         easgNjArwh5/nhxuymtzSmbvTCrQB3MMuqRxBC5cppFs9ET9cnbbqfae8Sqb5lLgp2zY
         OKUepiQavoRMfh6vF/qqLu6wWmG05/n/846xG2MKxwZKCU7zvXsjfctK1hXR2EeM3I8V
         KfCQ==
X-Gm-Message-State: AC+VfDzu0BjTiDLYXI3dhVfJKTjPm0k55dF57nsp6XujBSk3STPF0ztz
        vvmOCLyquw9nf3ZizynB8wtr/icghepz3XQW72Uc87kX63zBNPMyJXZ03tv3RSEkeAYohI5ntKy
        V+qOgY/uJ9hPzRYVk8O6DJNTV5rG9RiawJmXDB+AtCDmtbg/kaqvU42JTKH0typo=
X-Google-Smtp-Source: ACHHUZ65Wu6N23IoMb5LBN8RU6NgzQ0wn29Y8Xv8ljkaQH5Hi1mADzDzfLEm3I5yb7Y/7v+4fHYTADFWt6pjPA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:f597:a1b7:3c54:2bc8])
 (user=steadmon job=sendgmr) by 2002:a05:6902:2d1:b0:ba1:d0:7f7c with SMTP id
 w17-20020a05690202d100b00ba100d07f7cmr18783074ybh.2.1684367798779; Wed, 17
 May 2023 16:56:38 -0700 (PDT)
Date:   Wed, 17 May 2023 16:56:32 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
X-Mailer: b4 0.12.2
Message-ID: <20230517-unit-tests-v2-v2-2-21b5b60f4b32@google.com>
Subject: [PATCH RFC v2 2/4] unit tests: Add a project plan document
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, calvinwan@gmail.com,
        szeder.dev@gmail.com, phillip.wood123@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Describe what we hope to accomplish by implementing unit tests, and
explain some open questions and milestones.

Change-Id: I182cdc1c15bdd1cbef6ffcf3d216b386f951e9fc
---
 Documentation/Makefile                 |  1 +
 Documentation/technical/unit-tests.txt | 47 ++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b629176d7d..3f2383a12c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,6 +122,7 @@ TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/trivial-merge
+TECH_DOCS += technical/unit-tests
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
 
diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
new file mode 100644
index 0000000000..7c575e6ef7
--- /dev/null
+++ b/Documentation/technical/unit-tests.txt
@@ -0,0 +1,47 @@
+= Unit Testing
+
+In our current testing environment, we spend a significant amount of effort
+crafting end-to-end tests for error conditions that could easily be captured by
+unit tests (or we simply forgo some hard-to-setup and rare error conditions).
+Unit tests additionally provide stability to the codebase and can simplify
+debugging through isolation. Writing unit tests in pure C, rather than with our
+current shell/test-tool helper setup, simplifies test setup, simplifies passing
+data around (no shell-isms required), and reduces testing runtime by not
+spawning a separate process for every test invocation.
+
+Unit testing in C requires a separate testing harness that we ideally would
+like to be TAP-style and to come with a non-restrictive license. Fortunately,
+there already exists a https://github.com/rra/c-tap-harness/[C TAP harness
+library] with an MIT license (at least for the files needed for our purposes).
+We might also consider implementing
+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[our
+own TAP harness] just for Git.
+
+We believe that a large body of unit tests, living alongside the existing test
+suite, will improve code quality for the Git project.
+
+== Open questions
+
+=== TAP harness
+
+We'll need to decide on a TAP harness. The C TAP library is easy to integrate,
+but has a few drawbacks:
+* (copy objections from lore thread)
+* We may need to carry local patches against C TAP. We'll need to decide how to
+  manage these. We could vendor the code in and modify them directly, or use a
+  submodule (but then we'll need to decide on where to host the submodule with
+  our patches on top).
+
+Phillip Wood has also proposed a new implementation of a TAP harness (linked
+above). While it hasn't been thoroughly reviewed yet, it looks to support a few
+nice features that C TAP does not, e.g. lazy test plans and skippable tests.
+
+== Milestones
+
+* Settle on final TAP harness
+* Add useful tests of library-ish code
+* Integrate with CI
+* Integrate with
+  https://lore.kernel.org/git/20230502211454.1673000-1-calvinwan@google.com/[stdlib
+  work]
+* Run along with regular `make test` target

-- 
2.40.1.606.ga4b1b128d6-goog

