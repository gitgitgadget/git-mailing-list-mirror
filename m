Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C74C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7AC61A6F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353570AbhJAK33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhJAK32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:29:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716FC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:27:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d6so14639993wrc.11
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nEZ+CiLMX9A8WNPRMVocLFWENLyOXJKAIX3T9UhuYYw=;
        b=Fa2To/Ivs0AJJzHadLhsauQFzmazcfdPvPtEF1sLnNUZh/HfZrwseqtkx8Yy5p4VGl
         ADgqEs1yhVTjKygBkURwXrahKr82i6iaZLULMIqcfBEiT1lXZJ1kHUnzNp38dd5G5q3r
         WlYwj0XLJK4JXm78ctaQFYFmMHyQZvHXWCmgLmF/GKYPs1JYCVpyLt4lZKz20Gu2i20l
         rLEGBT6/VdYjyzdFttKBdEpu8SpeYsboW1d60iSj7N4iAeW1OYm4i9k2jb52fFL88inZ
         m1bVj3/YInWuW4svBHeb8WuJUx8AzTV0iUcdTs8LgYTVXWP/pEsXBu1XH86h/cCf3X4s
         uLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nEZ+CiLMX9A8WNPRMVocLFWENLyOXJKAIX3T9UhuYYw=;
        b=EWMhssCoxU+y1JvMql3BubFOOAItcyZfRAVTMJFpcPF1uZOX8vjW1CYtOJb/AaHIs2
         ljxy0ROtwPakPptMzUKSMoI2c096KaM12yMrJ/2nuSW18RGB4+FZadouxCLqynZqvLky
         CQYNKnZ7egSbOwYimX0LlMIYHS3k/i71fs4E6HUcjYygAhNl2LTQOn65O3yEGPQ7wwfG
         CIr7zp7afXIn8gAFt3n1NUpT7w4atvBEr2NqKAYDHBMUwjgsVQgDJAur+kFeIJ/WbsTj
         s83EKmXBazSxbIYoM0E/+WEJk7l/JrxGqQJWWc+ue5dyMjIH8N/DBxvwJvjMuZ1TGJIW
         W9mA==
X-Gm-Message-State: AOAM533LCGlXx643x2FwA1u4wFsjEESG91GtT3D9ZkPe1tUm3vQF3iER
        yFl3jKvIgxnYbGGWixyZmqPmG/gW3Eqx4Q==
X-Google-Smtp-Source: ABdhPJw+4qyuzMcMMzplvOLEhtN5zuGGyzsmWgY6wXMMV6P9nPbRezDIe8xwXsZMABejo0No4KEdDQ==
X-Received: by 2002:adf:fb04:: with SMTP id c4mr11575495wrr.244.1633084063136;
        Fri, 01 Oct 2021 03:27:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h7sm5398952wrx.14.2021.10.01.03.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:27:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] Non-trivial designated initializer conversion
Date:   Fri,  1 Oct 2021 12:27:30 +0200
Message-Id: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See
http://lore.kernel.org/git/cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com
for the v1 & goals, and
https://lore.kernel.org/git/cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com/
for the v2.

This v3:

 * Addresses Junio's comments about URLMATCH_CONFIG_INIT use, I'm no
   longer removing explicit assignments to NULL related to it.

 * Updates the commit message of 5/6 for the discussion ending at
   https://lore.kernel.org/git/xmqqv92lmv2b.fsf@gitster.g/

 * I've added a new 6/6 with an UNPACK_TREES_OPTIONS_INIT. It's
   related to the discussion about how unpack-trees.[ch] memory
   management happens at [1], but is really orthagonal to the points
   Elijah and I were discussing there.

   I think whatever approach we'd decide to go with (his in
   en/removing-untracked-fixes, or my WIP suggestion) the move to an
   UNPACK_TREES_OPTIONS_INIT makes sense, and would be the same either
   way.

   It does make the WIP patches I've got at[1] to solve memory leaks &
   simplify the setup in unpack-trees.[ch] much smaller, and is like
   the other *_INIT changes here, so I've included it.

1. https://lore.kernel.org/git/87fstlrumj.fsf@evledraar.gmail.com/
2. https://github.com/avar/git/compare/avar/post-sanitize-leak-test-mode-add-and-use-revisions-release...avar/post-sanitize-leak-test-mode-unpack-trees-and-dir

Ævar Arnfjörð Bjarmason (6):
  daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
  builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
  urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
  builtin/remote.c: add and use a REF_STATES_INIT
  builtin/remote.c: add and use SHOW_INFO_INIT
  unpack-trees.[ch]: define and use a UNPACK_TREES_OPTIONS_INIT

 archive.c                 |   3 +-
 builtin/am.c              |   6 +--
 builtin/blame.c           |  30 +++++------
 builtin/checkout.c        |   6 +--
 builtin/clone.c           |   3 +-
 builtin/commit.c          |   3 +-
 builtin/config.c          |   2 +-
 builtin/merge.c           |   3 +-
 builtin/read-tree.c       |   3 +-
 builtin/remote.c          | 111 +++++++++++++++++++-------------------
 builtin/reset.c           |   3 +-
 builtin/sparse-checkout.c |   3 +-
 builtin/stash.c           |   6 +--
 credential.c              |   2 +-
 daemon.c                  |  19 +++----
 diff-lib.c                |   3 +-
 http.c                    |   2 +-
 merge-ort.c               |   3 +-
 merge-recursive.c         |   4 +-
 reset.c                   |   2 +-
 sequencer.c               |   3 +-
 unpack-trees.h            |   1 +
 urlmatch.h                |   4 ++
 23 files changed, 103 insertions(+), 122 deletions(-)

Range-diff against v2:
1:  3130693b416 = 1:  8f3f3f97fcb daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
2:  65c5295c1ac = 2:  ced1d581f15 builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
3:  3783788b553 ! 3:  266948e604c urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
    @@ Commit message
         urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
     
         Change the initialization pattern of "struct urlmatch_config" to use
    -    an *_INIT macro and designated initializers.
    +    an *_INIT macro and designated initializers. Right now there's no
    +    other "struct" member of "struct urlmatch_config" which would require
    +    its own *_INIT, but it's good practice not to assume that. Let's also
    +    change this to a designated initializer while we're at it.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/config.c: static int get_urlmatch(const char *var, const char *url)
      	struct string_list values = STRING_LIST_INIT_DUP;
      
      	config.collect_fn = urlmatch_collect_fn;
    --	config.cascade_fn = NULL;
    - 	config.cb = &values;
    - 
    - 	if (!url_normalize(url, &config.url))
     
      ## credential.c ##
     @@ credential.c: static int match_partial_url(const char *url, void *cb)
    @@ credential.c: static int match_partial_url(const char *url, void *cb)
      	struct strbuf url = STRBUF_INIT;
      
      	if (!c->host)
    -@@ credential.c: static void credential_apply_config(struct credential *c)
    - 		return;
    - 
    - 	config.section = "credential";
    --	config.key = NULL;
    - 	config.collect_fn = credential_config_callback;
    --	config.cascade_fn = NULL;
    - 	config.select_fn = select_all;
    - 	config.fallback_match_fn = match_partial_url;
    - 	config.cb = c;
     
      ## http.c ##
     @@ http.c: void http_init(struct remote *remote, const char *url, int proactive_auth)
    @@ http.c: void http_init(struct remote *remote, const char *url, int proactive_aut
     +	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
      
      	config.section = "http";
    --	config.key = NULL;
    - 	config.collect_fn = http_options;
    - 	config.cascade_fn = git_default_config;
    --	config.cb = NULL;
    - 
    - 	http_is_verbose = 0;
    - 	normalized_url = url_normalize(url, &config.url);
    + 	config.key = NULL;
     
      ## urlmatch.h ##
     @@ urlmatch.h: struct urlmatch_config {
4:  13ef9566903 ! 4:  41fcb0a45e5 builtin/remote.c: add and use a REF_STATES_INIT
    @@ Commit message
         initialize it in those three places, skip the memset(), and pass those
         structs down appropriately.
     
    +    This would be a behavior change if we had codepaths that relied say on
    +    implicitly having had "new_refs" initialized to STRING_LIST_INIT_NODUP
    +    with the memset(), but only set the "strdup_strings" on some other
    +    struct, but then called string_list_append() on "new_refs". There
    +    isn't any such codepath, all of the late assignments to
    +    "strdup_strings" assigned to those structs that we'd use for those
    +    codepaths.
    +
    +    So just initializing them all up-front makes for easier to understand
    +    code, i.e. in the pre-image it looked as though we had that tricky
    +    edge case, but we didn't.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/remote.c ##
5:  b78a9ec0846 = 5:  25fec54877b builtin/remote.c: add and use SHOW_INFO_INIT
-:  ----------- > 6:  18358f5d57a unpack-trees.[ch]: define and use a UNPACK_TREES_OPTIONS_INIT
-- 
2.33.0.1375.gbbd823cc90f

