Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BE1C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiKSNHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSNHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3348FE41
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s12so10601599edd.5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbXksdhX732h1dNfu6usEkedXSar4hKae7BowflEMX4=;
        b=cKwGSGril4Bd9qZZLOSVMLOtQQF7bQo0XoCRC1S8bD42SKINg8B3aEsgQJxPXmMAEa
         ArHSgEyngyW6ucS1egzHaNhqi2Q5pIZ80RtUKLpnzI4PssBF82fPmMAFjaAqZmHhcgrI
         /lw/GEudEgCjtxks1v32oGKmN/NL9/4vGQwBKg/bfNq3XYy7b91R4oh+1nUEGROCX27O
         bBuAs8CjEHNaP4eilWSQ7SQ+sLJgjMGn7XxewK+77bZJRW6ud3eVtwJfq4CT3CIc48oC
         BEIgjHllKajMcY0hpnYKHeTj7TQd/ltVJxef7NAaz1091xFjrz09JNQ0rV+hbzVaomhC
         PvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbXksdhX732h1dNfu6usEkedXSar4hKae7BowflEMX4=;
        b=eAox76dAvmuQ8YZ4BXcVyL4zHEBUulXZ8bkKs5ihrog+tKkyNpvjtBtGwq7b8AoVU3
         yvG8KLdlI6d/88h4dURr66hJ6ON49g7FnhxCapuklYq8f0NKLHmgQCxX09/N1MnBlIpo
         DYvIZP4XcBVyJK92b4vdtCs4a2jNHiCPClF9mEmVeQHDwtQw91FyEXR2a3+iJejfnqbY
         AFUV3Lghkz5SW1fN5Mnjl4ehNaPepu0DDumbR0tR9aDOBF34TzsPqYW7Iw2F+6M0bRfo
         lJVER11vDg3GyHEEdyhhfAv0Kf8utuUf4n9aATuVNBcf+jq9BG5q1YKRGT7TPkPRwQmu
         b1Ng==
X-Gm-Message-State: ANoB5pnRz9nkq1114Ww031haD8s5pfbEJjpKzQ3WbqUrK1tgHMT0ppky
        iPuEw775vHV+PiGjD3soxuul5i0I/F9R8w==
X-Google-Smtp-Source: AA0mqf6AsicjqSLG4kr303C0FfkGoGvfT144uLtfjZ0sYEKfHhyuxGUE1mVbjlhG2IdIsQMsLU2g5Q==
X-Received: by 2002:aa7:d0d4:0:b0:461:b1b9:bed0 with SMTP id u20-20020aa7d0d4000000b00461b1b9bed0mr1130483edo.122.1668863267664;
        Sat, 19 Nov 2022 05:07:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/11] cache.h: remove unused "the_index" compat macros
Date:   Sat, 19 Nov 2022 14:07:28 +0100
Message-Id: <patch-v2-01.11-3ddae1f5886-20221119T125550Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "active_alloc" macro added in 228e94f9357 (Move index-related
variables into a structure., 2007-04-01) has not been used since
4aab5b46f44 (Make read-cache.c "the_index" free., 2007-04-01). Let's
remove it.

The rest of these are likewise unused, so let's not keep them
around. E.g. 12cd0bf9b02 (dir: stop using the index compatibility
macros, 2017-05-05) is the last use of "cache_dir_exists".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/cache.h b/cache.h
index 26ed03bd6de..29bb0ad2b41 100644
--- a/cache.h
+++ b/cache.h
@@ -438,7 +438,6 @@ extern struct index_state the_index;
 
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
-#define active_alloc (the_index.cache_alloc)
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
 
@@ -452,7 +451,6 @@ extern struct index_state the_index;
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
-#define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
@@ -461,13 +459,10 @@ extern struct index_state the_index;
 #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-#define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
-#define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
-#define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
 
-- 
2.38.0.1509.g9445af83948

