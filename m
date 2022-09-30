Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B1C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiI3SKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiI3SJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:09:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0A31EDF49
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c11so7995650wrp.11
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5YydqJYlqL+ejjNMalXPgwmc003Vvxn3JQcGnr2p2Fg=;
        b=WBO+pItsZyTmEzYy6n6PxYrFZ4TdXSo+xjPGJNW0k+ExsZT3osWVn4yJctFB274ADz
         oGesWsRLWY2Doq4aIkA6dgcpFBJvj6T/BS7hhHX4lRAVj9vM6oAByFfyFYypBBwunBub
         kVE2m9uNo7p73akeEbHJcVv8kkGptPHu3nVHEfGQUpFkVUmHoaNSnlco1ggiB+JG2WPC
         CnySKGy+fsMA7BV9x55Z9GI9XFSOW9UPNbpFRuXkoDnsp0o11JbpR3D3Ux9g/genlWM7
         16GMm0UzTVvf7B1NbjdOnp7eWstjm19a98koaI3WUyN5x0yYMY1l3aM4HXOAQY17JQvg
         5bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5YydqJYlqL+ejjNMalXPgwmc003Vvxn3JQcGnr2p2Fg=;
        b=KcXp20+pvg10jebEiUO2ZOQGdgA4/qdTAqMHE1Kva+ZoDVberv6l7Y4nNOtwVCYPrw
         ZTVFP3D2Bn1YD0U6Ar9g8DNwa4D4x8FLTQJnmjleUJZ4NQF5dUTE2TX9NxaCcV9tyHk8
         LtdMg91X+w0lX9gXYeONLIY2oDva40NlE3NkoGslsPLGXYZfaK9g+IIYYzS8n1DjXwiM
         rqvJyb/FqiTu+TsOvTupqK3TK3k/slYwybNE39HRFgQHcPXvlxoelXc+jJpUf/hr39W4
         T/xwKMonUfKworGLikU6LdW5EBgISWvU72/JU5tAJMQq+H+RUCYvQh0uR5bSGhMy4kmS
         jw7A==
X-Gm-Message-State: ACrzQf3pWguG8qSZV0QNzfhVya35Vw8UPJlGZD8Ti9T13GB1inNZnZbR
        axeIF+MIuvhjHu1/4VjuCgXdFscQz/9BtA==
X-Google-Smtp-Source: AMsMyM514wkbT247AZqd1/MPv3YRROxd1KGe45W34MEQhFz3JJ8Ln+OV8LyQCI7g8hVbPbre5PQHwg==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr6597851wrq.718.1664561353787;
        Fri, 30 Sep 2022 11:09:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 19/36] doc txt & -h consistency: add or fix optional "--" syntax
Date:   Fri, 30 Sep 2022 20:07:42 +0200
Message-Id: <patch-v3-19.36-3bfdd3fb79e-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the "[--]" for those cases where the *.txt and -h were
inconsistent, or where we incorrectly stated in one but not the other
that the "--" was mandatory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c | 2 +-
 builtin/rev-list.c      | 2 +-
 builtin/verify-pack.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index c6379b783c8..d45d873f579 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 
 static const char * const for_each_repo_usage[] = {
-	N_("git for-each-repo --config=<config> <arguments>"),
+	N_("git for-each-repo --config=<config> [--] <arguments>"),
 	NULL
 };
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ada68a4af5e..3cc8aad52ed 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 
 static const char rev_list_usage[] =
-"git rev-list [<options>] <commit>... [-- <path>...]\n"
+"git rev-list [<options>] <commit>... [[--] <path>...]\n"
 "\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index db9ac5c4606..27d6f75fd8a 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -56,7 +56,7 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 }
 
 static const char * const verify_pack_usage[] = {
-	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>.idx..."),
+	N_("git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx..."),
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

