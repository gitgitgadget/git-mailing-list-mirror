Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A4C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E3122AAF
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLVVzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgLVVzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 16:55:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A2C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 13:54:23 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r29so9277342pga.20
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Oeyc0ckaC9ojwGpPqRKkqMMF0Gl4DAOxxEutQoaPIq4=;
        b=hrgZxct1AEGxrdiGQn3/T3cy+EsDUxRzkkt3iCAZ0PdSwKkcvACFXAosDTfco+hokz
         kqpfK/HhyyzuT3LRGYVpG8wdvFZIFAP9TmYmP91rcYOKgQ6DX7NEU0gXyXSeMUaydHsc
         VEL/v6wwweKqXJYamokoxM0ETvS0WpeR1ghZRTh7BNC1UsWuFW8+4mWBpJ07ukvc5SkW
         eQj8lRm4s+wuJQ+5TgNzp1tYcUpLW+9DokOJIG+sCt5ZFVt82F1+Y/7VcvZ2dpc0V4qF
         QwNN/840mKMIj8ftiJ0DbusSdSuyx0M25rFqe31HvfwoI10TkdSTHlYgeB9vuQew307b
         sKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Oeyc0ckaC9ojwGpPqRKkqMMF0Gl4DAOxxEutQoaPIq4=;
        b=QogpDt6wXOkisOyXd8t1/IPt9zwFMUanarTxp7cglWp1QzeTmRQscM4MYg3yM6OmfM
         mF2bGgL74ouK/l1FOnNfM5CKrq6qHxImKTOEnEfnilCWPkOccqTdvYzVRdeBNV5yGkHa
         7p+3Ce2q1yfWOyEtl3fBAF7lZauYVL3NiJNe2Btq5WY7o4te0Gg5alC+BWpLQAwq2xqm
         tre/uZfvXVuei1LiOnE0X648vlalQEwnBlYKD8VqV8WHZQwrk4H1OWXtT7m6uDfutNw3
         lc7Pd1RVIZv7T5UYQw0txgEXRDgyLyEMddgxKGZWeWonYoc9nH0hymvivauhQ40d0gQm
         mCbg==
X-Gm-Message-State: AOAM532HdB05NMqd1ev1iQAy1A4jvVg/iS4f5rVqsQitRUsOzYDkRgoL
        Ye1sAXf86yYaTmkOSFLnvEa0Ugd9T9I757nuucsfB1OjLI5VCbKOC2NjqG7XJxaNIAbQ59bhNy8
        pqWsDAoKZLfSGNbMXE3d2q1U3IhV5g4buAau647CpLvn/8j/22eRfGbZzLHONyEsF3b+BJOS9F6
        P/
X-Google-Smtp-Source: ABdhPJzXXeipHz0UQQlKt1m2C+upJsfzWuLVSdASNZpV7iA+uVQNKZSPq9dDI2HiO3fL7PBJUvbsUDhvll0o7jyFxz69
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:e213:0:b029:19e:59d3:a76a with
 SMTP id a19-20020a62e2130000b029019e59d3a76amr5861131pfi.53.1608674062891;
 Tue, 22 Dec 2020 13:54:22 -0800 (PST)
Date:   Tue, 22 Dec 2020 13:54:17 -0800
In-Reply-To: <20201211210508.2337494-1-jonathantanmy@google.com>
Message-Id: <cover.1608673963.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201211210508.2337494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v4 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for informing me of the test failures. Turns out that it
was partly because I didn't memset oid (and in some code paths, it gets
read without being written to), and partly because I didn't set
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME. Here's an updated patch set with
the fixes.

Jonathan Tan (3):
  ls-refs: report unborn targets of symrefs
  connect, transport: add no-op arg for future patch
  clone: respect remote unborn HEAD

 Documentation/config.txt                |  2 +
 Documentation/config/init.txt           |  2 +-
 Documentation/config/lsrefs.txt         |  3 ++
 Documentation/technical/protocol-v2.txt | 10 ++++-
 builtin/clone.c                         | 19 +++++++--
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         |  2 +-
 builtin/ls-remote.c                     |  2 +-
 builtin/remote.c                        |  2 +-
 connect.c                               | 29 ++++++++++++--
 ls-refs.c                               | 52 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 remote.h                                |  3 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  8 ++--
 t/t5702-protocol-v2.sh                  | 11 ++++++
 transport-helper.c                      |  7 +++-
 transport-internal.h                    | 13 +++----
 transport.c                             | 29 ++++++++------
 transport.h                             |  7 +++-
 20 files changed, 164 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

Range-diff against v3:
1:  7d20ec323a ! 1:  a66e50626e ls-refs: report unborn targets of symrefs
    @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     +	int flag;
     +	int oid_is_null;
     +
    ++	memset(&oid, 0, sizeof(oid));
     +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
     +	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
     +	oid_is_null = is_null_oid(&oid);
2:  b5a78857eb = 2:  14f3962adc connect, transport: add no-op arg for future patch
3:  c2303dc976 ! 3:  e770fc46eb clone: respect remote unborn HEAD
    @@ t/t5606-clone-options.sh: test_expect_success 'redirected clone -v does show pro
      
      test_expect_success 'chooses correct default initial branch name' '
     -	git init --bare empty &&
    ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=foo init --bare empty &&
     +	test_config -C empty lsrefs.allowUnborn true &&
      	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
    @@ t/t5702-protocol-v2.sh: test_expect_success 'clone with file:// using protocol v
      '
      
     +test_expect_success 'clone of empty repo propagates name of default branch' '
    ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
     +	test_config -C file_empty_parent lsrefs.allowUnborn true &&
     +
    ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=main -c protocol.version=2 \
     +		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
     +	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
-- 
2.29.2.729.g45daf8777d-goog

