Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF3DC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjARQOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjARQNf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:13:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3730291
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so84471579ejc.4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVTsF1YvHVZQ6LaAVYrS8xmFanWi5QI72DX8NIwv4NQ=;
        b=RpCzk5eV9zUVa9PynRhUCPj3pfdfFbejK3aKhsdVHhGV+jzS2f93fAoLf2rCNJHtvK
         NpacCPWK8f0GpEJAtKwDzGFud+T3Ppa1vozNzTccFpE6SBJPl+Lvkkiad9c3hjvYRREJ
         9DbCVhImvtu0FdZ26Kho0KF08s2wiZ0en5Zh9kfI/MSGuyleKNXB1TLnlAyzW31V77dc
         OxDEvjVbkjACcyr8sMB6x5VngDuhhlOjtb4bBsetFFOw8hgNsbz6IThyRNYKsaKN7HFC
         erSq8yAyNLZc9mbEwXdVuRfPuHk5t56UgChgFtOufbKkzRW+qTDAk99hxaReUl1E7zLu
         XHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVTsF1YvHVZQ6LaAVYrS8xmFanWi5QI72DX8NIwv4NQ=;
        b=eFx5mZwOXzhYkEjJ7Qwhrib+UpLMa9GZ+92KrgvShr8MwO5Lk0KdR1JIppL8AjaoiU
         pT0VGDt4YTb7IcptzpVtiWJDr729uOQG7n8YTp6AX5JU/8CjwnJDQGk22gVOnBs8tpPp
         f8tbOj9EQniEn8afMsD9y1Y4rsCvyVkEGMHCzH8SR/wBA4irQ3iB3TW/zmMG73D4TqIm
         2JuIUn9aTtxvZ9dlGp2jxQTrEg80+qJABdcTlni0Lf3QR/1a9hqj+a2BU2FmqK8aZG0w
         DXlPkGbj2bpGDREXHZ4RAi4zzOzctdLQ0J3u8ML2ojNNNK9/gtuLyx8JAaPnkzC8KoS4
         m/qQ==
X-Gm-Message-State: AFqh2kp50mK+h2SDvQYM4f+256/auiWtCSLB8lfmvnW2w6xs5gXvcueo
        z/g8HLcj6fTy2Iqq+uRW/fL+BECQNdXADQ==
X-Google-Smtp-Source: AMrXdXtP2niRejT/+q0e4JYcGG6rNAPL1tS/fIcx7+F/ub6xYR6kf8St9F35AmW2QvhF9e0+VZ6+JA==
X-Received: by 2002:a17:907:7424:b0:872:a754:da73 with SMTP id gj36-20020a170907742400b00872a754da73mr6189114ejc.63.1674058166615;
        Wed, 18 Jan 2023 08:09:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm14778202ejc.162.2023.01.18.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:09:26 -0800 (PST)
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
Subject: [PATCH v3 1/8] rebase: use "cleanup" pattern in do_interactive_rebase()
Date:   Wed, 18 Jan 2023 17:09:09 +0100
Message-Id: <patch-v3-1.8-b223429df33-20230118T160600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

