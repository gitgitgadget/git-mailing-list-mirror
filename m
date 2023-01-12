Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE3CC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjALMqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjALMqL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8912ABE
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:07 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u9so44524101ejo.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Dj9oU82Zo7IAjusFNhK0kFFJBb8/jbusJ6L7C32Oo=;
        b=N47iXIr6B2tbVz/idjfRZSN4/i5hEMazE6+4UaCOFyJ8YjmiT1gIGDx0fuJt+eVAD2
         kERRZakAPI5cDy/48awIqHDH9mBa8cloEysdHhDjQAIx0eUYgaNSMBYKQJpHUwXvtJz2
         OlccoEJDptvHvEdokhT+0QiIZ2GuqOp29xw45uioSp+p6KIdv7dbvxe86paPkR7fyX8+
         g0ssIot3D4ybooqsAMxwI4WJLi2fvwGXTJ/YAn8rqggxSWIE5xb2Gopj6AAY2xzPcw0R
         nKJscVTFxr6CCtXbiD7GwMjQAgflnjt8qGe+8ZEMXNh6cHKU898vqU0w5ZHrGhVup6eb
         9USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0Dj9oU82Zo7IAjusFNhK0kFFJBb8/jbusJ6L7C32Oo=;
        b=0K+U6k+1frZrmMHLUUAQ8CiEjZSfVRZ9BIAJL/hjVlovOsNiwx+3NQeafzB1l71gDz
         R/onx9ftxT0xNobZMCh3ww1GRVu/3s6lt4a67eFqR6U3484YZrrRY4bOA9lZO88bsNPp
         QnKqdcQA//4BBZZtZJYWcKY8WHNuGFCVkP8pRHKyfkGOtkfpIUeI8szYIxE3mjkBiPqU
         BXnH8NHuH5BMxiNvhmjBXOXk0sWlpJ+NGCA+ufMPTnn6pop2OJsFeI2colhip+PpxIuP
         SU9hgHpYUE391Zk4JN6Qr6/O+Y4JaPQOFuU6NJwgj0ihNQxsuD50tZJMQAef7DM2RRda
         Gssw==
X-Gm-Message-State: AFqh2kruyjz5cvpX33PC3SiNngDa0cXl0mRHi8CshsBRAat9xneGiVa8
        98p8SSJJ4iolg9XU27OczWLJQzcjpcdFoQ==
X-Google-Smtp-Source: AMrXdXvksDXZ182EOsFPJjGYEvOAJFCYlzpjOc0oZ4BT1X+wRVd1OAR/66zyA8LA10VHouuksmNz/g==
X-Received: by 2002:a17:906:1baa:b0:859:1a3c:8b5c with SMTP id r10-20020a1709061baa00b008591a3c8b5cmr7444862ejg.53.1673527565846;
        Thu, 12 Jan 2023 04:46:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] rebase: use "cleanup" pattern in do_interactive_rebase()
Date:   Thu, 12 Jan 2023 13:45:53 +0100
Message-Id: <patch-v2-1.9-d0a0524f3d4-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a "goto cleanup" pattern in do_interactive_rebase(). This
eliminates some duplicated free() code added in 53bbcfbde7c (rebase
-i: implement the main part of interactive rebase as a builtin,
2018-09-27), and sets us up for a subsequent commit which'll make
further use of the "cleanup" label.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..7141fd5e0c1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -256,7 +256,7 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
 
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
-	int ret;
+	int ret = -1;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -265,16 +265,12 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
 				&revisions, &shortrevisions))
-		return -1;
+		goto cleanup;
 
 	if (init_basic_state(&replay,
 			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, &opts->orig_head->object.oid)) {
-		free(revisions);
-		free(shortrevisions);
-
-		return -1;
-	}
+			     opts->onto, &opts->orig_head->object.oid))
+		goto cleanup;
 
 	if (!opts->upstream && opts->squash_onto)
 		write_file(path_squash_onto(), "%s\n",
@@ -304,6 +300,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			opts->autosquash, opts->update_refs, &todo_list);
 	}
 
+cleanup:
 	string_list_clear(&commands, 0);
 	free(revisions);
 	free(shortrevisions);
-- 
2.39.0.1205.g2ca064edc27

