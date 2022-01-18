Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA03C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 17:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbiARRrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiARRrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 12:47:46 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEABC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:47:45 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 67-20020a630746000000b003443fe43bbaso9983562pgh.12
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5qg8ibaZTnQyb/PEZT0jOHJ3SVf/BfG//B3VsADDnPI=;
        b=lCSZ1iQkgKnFHgqsEve7+5YI9jMXzeIyTp5nBL90PkJxwZ5yOTjF7Lmcsloghv5EhW
         eeUYtXYU01Zu13h2fjfkDx14N5CQlcsXuDsR32l/9IjqGXA7+h+YAs6w9O0lWQgkBprF
         T8C7H0pbA2MkdyAbkDj3yveDggzgOKFemVQnsoUYmOSr183chylvL8XQHO0XdUO3QYjf
         HIRDa93Gv1Srcmt3aIv3ddD2Gnin4+5YI/avjp5qSuLymek1xliUUmSMFhAR+cVfvAst
         6Gv21255RVqQkuu5VI+WEpj//h2dNPuJIK4C94xUhS8xIlnUaPJmUm99vAGkO9dDoqs+
         zwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5qg8ibaZTnQyb/PEZT0jOHJ3SVf/BfG//B3VsADDnPI=;
        b=JNGo70drrklal6mMOBYQh9HKmB3FX+D3Sm/jS7z0kl6vVJTR8sxPcW6eqm0ySHJY3n
         ZcTeXPBltl2gP5ZeMWKeUmQLp5oknBBcJjyg5wZPoSjFjdhlcRr1rnM02ee4SPxrV2+7
         HpMn/GnH7GCXRq3EPkCSSAqQitarMokFUBjEAIpV/gzWj/mtF1hu2EmuWYhDS7CL+/mo
         DtODcPOAw0IUjIHBSWoWO2bsZ5LiqN3XlCfGFW80iutlYPARLAVO9J49DKfislduT1oo
         0oWMtS5JcQCsvjSwE491VbrtE9SIrSIaB+pgsp6ydlu/3lqvmXnFvs9o55IqZXF0YYE2
         IuZg==
X-Gm-Message-State: AOAM533IUr0ESKX5gl08Dwamsikalk9BS7KmOiXaU3wixCraIEzTycYc
        Ry/vNGk/nLOhXVS6JN8ipmMXCq3NrvxXpaCT9SyXliMCKUOwIj2uB9fMjJ9KLrC1y6XsQrUKveH
        KCZv9jrRRXQhFldf0doOonwY+c88Hlx43P6cJ9PEt6dgyi/suWZN83f3oXNls2HxanEGpcyhq2f
        AA
X-Google-Smtp-Source: ABdhPJxITj5zsj4OcCU470hy3CxOKi709SmIpNue7WTUx3WwpTakGlHPC8iOxnUJXWIonKOaSzAhRGzZ78WZAna1wzzB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3906:: with SMTP id
 ob6mr41584752pjb.170.1642528064983; Tue, 18 Jan 2022 09:47:44 -0800 (PST)
Date:   Tue, 18 Jan 2022 09:47:38 -0800
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <cover.1642527965.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v8 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your review. v8 follows Elijah Newren's comments
about making URLs more identifiable in tests, and also including an
example in documentation.

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 Documentation/config.txt |  35 +++++++++++
 config.c                 | 132 ++++++++++++++++++++++++++++++++++++---
 config.h                 |  46 ++++----------
 t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 41 deletions(-)

Range-diff against v7:
1:  b2dcae03ed = 1:  b2dcae03ed config: make git_config_include() static
2:  7c70089074 ! 2:  6691e39c82 config: include file if remote URL matches a glob
    @@ Documentation/config.txt: all branches that begin with `foo/`. This is useful if
      A few more notes on matching via `gitdir` and `gitdir/i`:
      
       * Symlinks in `$GIT_DIR` are not resolved before matching.
    +@@ Documentation/config.txt: Example
    + ; currently checked out
    + [includeIf "onbranch:foo-branch"]
    + 	path = foo.inc
    ++
    ++; include only if a remote with the given URL exists (note
    ++; that such a URL may be provided later in a file or in a
    ++; file read after this file is read, as seen in this example)
    ++[includeIf "hasconfig:remote.*.url:https://example.com/**"]
    ++	path = foo.inc
    ++[remote "origin"]
    ++	url = https://example.com/git
    + ----
    + 
    + Values
     
      ## config.c ##
     @@ config.c: struct config_include_data {
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +		that = that-is-not-included
     +	EOF
     +	cat >>hasremoteurlTest/.git/config <<-EOF &&
    -+	[includeIf "hasconfig:remote.*.url:foo"]
    ++	[includeIf "hasconfig:remote.*.url:foourl"]
     +		path = "$(pwd)/include-this"
    -+	[includeIf "hasconfig:remote.*.url:bar"]
    ++	[includeIf "hasconfig:remote.*.url:barurl"]
     +		path = "$(pwd)/dont-include-that"
     +	[remote "foo"]
    -+		url = foo
    ++		url = foourl
     +	EOF
     +
     +	echo this-is-included >expect-this &&
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +	EOF
     +	cat >>hasremoteurlTest/.git/config <<-EOF &&
     +	[remote "foo"]
    -+		url = foo
    ++		url = foourl
     +	[user]
     +		one = main-config
     +		two = main-config
    -+	[includeIf "hasconfig:remote.*.url:foo"]
    ++	[includeIf "hasconfig:remote.*.url:foourl"]
     +		path = "$(pwd)/include-two-three"
     +	[user]
     +		three = main-config
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +
     +	cat >include-with-url <<-\EOF &&
     +	[remote "bar"]
    -+		url = bar
    ++		url = barurl
     +	EOF
     +	cat >>hasremoteurlTest/.git/config <<-EOF &&
    -+	[includeIf "hasconfig:remote.*.url:foo"]
    ++	[includeIf "hasconfig:remote.*.url:foourl"]
     +		path = "$(pwd)/include-with-url"
     +	EOF
     +
-- 
2.34.1.703.g22d0c6ccf7-goog

