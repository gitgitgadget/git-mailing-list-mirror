Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE2EC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhLGNmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhLGNly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1BC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y196so10745013wmc.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pAThymhhYTMrdcgVqu1z3K+8coGppwT1UXcTC1jJ7x4=;
        b=UPpRC1kXfBeez+sV/2eumabjQVC8QdNQuZZrobNIylRm7bRZnQTARF6cjESZYkXghR
         ovs/5Jr2rf4APtC/2Iihl7jXyPkQrN/2N4HEOQLumYe1K2KyTSTfFWGu+NcAQ274D4vn
         pXCd4PlXN2S7ED4NYjDyTlnlA9w1iTUR0kRs+Hjr0lRqksp7/NXeDoxnPfIJlpM+OA/5
         Y3AED1NHuZfV26u7l+8xWWb8ar8Jiww4poq/Tls0g4TpkHM+ZO2Pu+6AxqHAwhOCcZdD
         fcmCnZgQOxMSGfDJgK4MO6T4364eTlEXjh8U6edhBpLrWMTtfU9kkX/pErD0y2nmjlIV
         TCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pAThymhhYTMrdcgVqu1z3K+8coGppwT1UXcTC1jJ7x4=;
        b=H6cY9MR0r8JLxZiwiAxDGoZphGaiowfJkU9gbNvTdyga0cUQSNvLmO4wPa9YQb943U
         EdmQoZ+XN3Tbvct5ULAEygKAaL9asaYcvC7fRUFlR6fjkFJdtIIjgOtmdLwMcgRgYLj1
         S0As37EpN0Jl9UqdSm5i7JuPjVoxueNoTTl5xd2AbntgJQgQHn4/G4gg0/uFNWK147T/
         rsSnhGmYc+9S1f2yJj8Ng1QHs5ZVm45Heb0vOf3jx0i9bmEDsu5FfLQ5UvIxeSjqrvxV
         8JzH4svrALVIXAT7tBWc5UVgeoX8B3Xr/MsioRYhz/u169uk97WwYV9id41QdR0+ckYi
         USjQ==
X-Gm-Message-State: AOAM532zuEQkMSJQDMa3Z3t0oi9JJWl5HIjBh0hk5GaZ2XCAuUd/QlyK
        uoMRzPOz+5cuwIhkMhN9cMsrxjvNSu0=
X-Google-Smtp-Source: ABdhPJxGIHqQLcwsGStTYRMHEZXf3YM4UawrNNl4AGEhyKSGu56QkBXCgtDYlpsDIUv6Q6t8ndZugg==
X-Received: by 2002:a1c:8015:: with SMTP id b21mr6850875wmd.161.1638884302080;
        Tue, 07 Dec 2021 05:38:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm14477218wrs.88.2021.12.07.05.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:21 -0800 (PST)
Message-Id: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:12 +0000
Subject: [PATCH v4 0/8] Allow writing invalid OIDs into refs for testing purposes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this covers a few cases of direct filesystem access to the ref database in
tests.

v4:

 * fix stack OOB read due to missing array terminator.

Han-Wen Nienhuys (8):
  test-ref-store: remove force-create argument for create-reflog
  test-ref-store: parse symbolic flag constants
  test-ref-store: plug memory leak in cmd_delete_refs
  refs: update comment.
  refs: introduce REF_SKIP_OID_VERIFICATION flag
  refs: introduce REF_SKIP_REFNAME_VERIFICATION flag
  t1430: remove refs using test-tool
  t1430: create valid symrefs using test-helper

 refs.c                         |  7 +--
 refs.h                         | 16 +++++-
 refs/files-backend.c           | 53 ++++++++++---------
 t/helper/test-ref-store.c      | 75 +++++++++++++++++++++++----
 t/t1006-cat-file.sh            |  5 +-
 t/t1405-main-ref-store.sh      |  8 ++-
 t/t1406-submodule-ref-store.sh |  2 +-
 t/t1430-bad-ref-name.sh        | 93 ++++++++++++++++++----------------
 t/t3800-mktag.sh               |  6 ++-
 9 files changed, 172 insertions(+), 93 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1147%2Fhanwen%2Fskip-verification-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1147/hanwen/skip-verification-v4
Pull-Request: https://github.com/git/git/pull/1147

Range-diff vs v3:

 1:  3649ef6d0fa = 1:  3649ef6d0fa test-ref-store: remove force-create argument for create-reflog
 2:  3cdebd2dbca ! 2:  865458bc0cb test-ref-store: parse symbolic flag constants
     @@ t/helper/test-ref-store.c
      +	return result;
      +}
      +
     -+static struct flag_definition empty_flags[] = {
     -+	{ NULL, 0 },
     -+};
     ++static struct flag_definition empty_flags[] = { { NULL, 0 } };
      +
       static const char *notnull(const char *arg, const char *name)
       {
     @@ t/helper/test-ref-store.c: static const char **get_store(const char **argv, stru
       	return argv + 1;
       }
       
     -+static struct flag_definition pack_flags[] = {
     -+	FLAG_DEF(PACK_REFS_PRUNE),
     -+	FLAG_DEF(PACK_REFS_ALL),
     -+};
     ++static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
     ++					       FLAG_DEF(PACK_REFS_ALL),
     ++					       { NULL, 0 } };
       
       static int cmd_pack_refs(struct ref_store *refs, const char **argv)
       {
     @@ t/helper/test-ref-store.c: static int cmd_create_symref(struct ref_store *refs,
      +static struct flag_definition transaction_flags[] = {
      +	FLAG_DEF(REF_NO_DEREF),
      +	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
     -+	{ NULL, 0 },
     ++	{ NULL, 0 }
      +};
      +
       static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 3:  536005d65a2 = 3:  dcd4e9f5f26 test-ref-store: plug memory leak in cmd_delete_refs
 4:  466b4451015 = 4:  67d22211ac4 refs: update comment.
 5:  89d692a34b8 ! 5:  a8713dd59ee refs: introduce REF_SKIP_OID_VERIFICATION flag
     @@ t/helper/test-ref-store.c: static int cmd_create_symref(struct ref_store *refs,
       	FLAG_DEF(REF_NO_DEREF),
       	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
      +	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
     - 	{ NULL, 0 },
     + 	{ NULL, 0 }
       };
       
      
 6:  af9e94935bf ! 6:  577726dc9df refs: introduce REF_SKIP_REFNAME_VERIFICATION flag
     @@ t/helper/test-ref-store.c: static struct flag_definition transaction_flags[] = {
       	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
       	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
      +	FLAG_DEF(REF_SKIP_REFNAME_VERIFICATION),
     - 	{ NULL, 0 },
     + 	{ NULL, 0 }
       };
       
      
 7:  d4f1d209468 = 7:  d85cfa3fee1 t1430: remove refs using test-tool
 8:  ca7f8aea3d9 = 8:  7597620ec83 t1430: create valid symrefs using test-helper

-- 
gitgitgadget
