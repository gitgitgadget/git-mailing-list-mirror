Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E92C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiGAKbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiGAKbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:31:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE76876E97
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:31:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so1299405wmb.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xU52FBcfxZ9ugBZ7xxVNn67LAE+EUvzV05uvkZse/RU=;
        b=lNqwjOHEIb3kvFfwnbMTT0cK2S1P1liqkgo/+IQPec+jdwG0w4O1tjdhZh0lofeCvy
         Lvan9UFa+j3WRYuwEGW2vr9eOYVuAWfUgW2XWk4RxnDt3pUOmHOL6/zD2til7NQfz1ov
         W/pdAEvySGDHDARYZ+SuCmFaPeZEk1BPrSWRcJ/DJbYSzgLRbEQkmbfClAs2rhzWK+LN
         DIbqEBjOYJ44vNeBaMgqOvnDORYoKD4Px+Th0zsecPGZaiKGPbc9V9ap3fhdlj4SjmA8
         MHLibVgRlzkQn4K1RghJCPhe2uqftIBICjbN1EWI09O4UqL+MVhlHIk+dnZuU73Rl8ip
         AS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xU52FBcfxZ9ugBZ7xxVNn67LAE+EUvzV05uvkZse/RU=;
        b=CGcWLUfmR3M8V84TMLvNkTnbvuGCpwVbLEmSH83FSkfTGr1e9U7xuIIH1+7jLrq+qH
         6+WfsmOUTL0fGeVvkFvk05VVhheD8LCVaIe7qX5inLjOSYlBvAcds1ukny+rD6GElt7w
         epSYD6NqfJyrCiRWjLI3hCpff5yg1maR3hiN0K8Fd/iUnnj94mGleXMEmmqgM9eeT9/U
         dylcFlYeUBEM7ECzv59/NG8H+0cLL6/1gfQ5owLTj4/OPkzvjqf/9+uRz2BEtlYB5oai
         mZNFnogIGWHxqM2/KAQpupW2GZZ/jqXzL/cITOUN91+OEG219F9mu2mkmjjfXviuaIp5
         jpjA==
X-Gm-Message-State: AJIora9UHLXgK+Q6IuuIa74MmPHJi965rWfTCMZcvbskhfrCqniVljbT
        uVel6ExutJZpAeZkpyMOKVSawbFVPg/4qg==
X-Google-Smtp-Source: AGRyM1tthAlrmzxf8Oie4kbotTO5LZUSK1jmARD42r7LOzZmTd9xwBn0EY7NoQFSM9lxjxN13rsurw==
X-Received: by 2002:a05:600c:acb:b0:3a0:30f8:8a45 with SMTP id c11-20020a05600c0acb00b003a030f88a45mr14892133wmr.55.1656671486935;
        Fri, 01 Jul 2022 03:31:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c12c600b0039c811077d3sm9712790wmd.22.2022.07.01.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:31:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] cocci: remove "when strict" from unused.cocci
Date:   Fri,  1 Jul 2022 12:30:58 +0200
Message-Id: <patch-v3-3.4-9a5e7208dec-20220701T102506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "when strict" constraint from the newly introduced rule to
find unused code. As seen in the change this will help us find cases
where a "return" was causing spatch in the middle of our match was
causing spatch to abort its analysis.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c                 | 2 --
 contrib/coccinelle/unused.cocci | 2 --
 2 files changed, 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bbd70b17bc6..23170f2d2a6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
 	if (is_null_oid(stash))
@@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	strbuf_release(&sb);
 	refresh_cache(REFRESH_QUIET);
 }
 
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
index 43942f3cd4f..9f0101c1350 100644
--- a/contrib/coccinelle/unused.cocci
+++ b/contrib/coccinelle/unused.cocci
@@ -47,7 +47,6 @@ identifier REL1 =~ "^strbuf_release$";
 // ... Optionally followed by lines that make no use of "buf", "&buf"
 // etc., but which ...
 <... when != \( I \| &I \)
-     when strict
 (
 // .. (only) make use of "buf" or "&buf" to call something like
 // "strbuf_init(&buf, ...)" ...
@@ -67,7 +66,6 @@ identifier REL1 =~ "^strbuf_release$";
 // init/strbuf_release() patterns, where "&buf" could be used
 // afterwards.
   ... when != \( I \| &I \)
-      when strict
 // This rule also isn't capable of finding cases where &buf is used,
 // but only to e.g. pass that variable to a static function which
 // doesn't use it. The analysis is only function-local.
-- 
2.37.0.900.g4d0de1cceb2

