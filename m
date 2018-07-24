Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA551F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbeGXRln (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55377 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbeGXRln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so3169005wmc.5
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNaWXPNbcvzK5+fAClAyofcVMZR1ucMDKT5iy0YFjy0=;
        b=OX57fU9EwUuqa4i40nFRlohLlYOscCVKD8Zyy0GgVMsT1KdmkTWwkBWlG/tiInEzkq
         /Vis+9BpEgHXMyKIVMaq/tEjGxCPuLuOCX3pqL9URnwZkx7g9b3D73zmTzVDh3i01stb
         KTZ9nE/YtbaQpD/YGjFu37zQAH9QtneggtGwGx/tFZeSX2Wg9Y5ymPhygtRKYrUC8K9V
         1fwab4ILIO/wUww+49eR/Uc1kg4MojAZg4F0shsl/VgYtxuzAS5Qh00k52891ow70Fvb
         YS0POkNwFwL80wV0JS9b9kUAHJ9n6MelcQJDonaXPl0F0oGAY++jZp8JLxQD++b62cWg
         X0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNaWXPNbcvzK5+fAClAyofcVMZR1ucMDKT5iy0YFjy0=;
        b=McHs6OGkD00exuTBMpDPkQWJQV12DBM+v4YZIXfstTBpBXNn1HqDGMWzJKzfLo1uvB
         SBx7pBvXDWL0tJ00UZAAL/Lgn6XvV/KOphvSDkM6PP5IAXXPtclQhTnFYaoOQKFT6xAZ
         fa5Ev6o+tdwEysn0ZYzu5uJDgmn+e+oIkva7gGQyqu9hfYeGmttU/x6M/NgRl60WFnSz
         dgxE4CpQmQNT0dTvyvpLAS3EFe+u59c3Y82KguarBUBNEOpiXAOR6BgH339LUi5J8SmI
         O496/PVxMaexOMI+Ob4pwstGmIQE1fgKTBm3pqmSCsifnxToLyK/SZEmwlWSNoLP1Qn7
         yqoQ==
X-Gm-Message-State: AOUpUlH0c/cEPZIc8NJ+pUwQnuf1lU/oeOL7hh5lZvk4YzNdxMbwAF1U
        iHEnjju4jCgTl5erBSv/Pocn4g8u
X-Google-Smtp-Source: AAOMgpejLZWOpXOloVUP+PRtaQhZkbxXz1ZUqERguSyhOg9JWoCHqZCoK3hGfOg43AlXbX1xvFyzYw==
X-Received: by 2002:a1c:d942:: with SMTP id q63-v6mr2556793wmg.78.1532450064506;
        Tue, 24 Jul 2018 09:34:24 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:23 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 09/20] sequencer: change the way skip_unnecessary_picks() returns its result
Date:   Tue, 24 Jul 2018 18:32:10 +0200
Message-Id: <20180724163221.15201-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of skip_unnecessary_picks() printing its result to stdout, it
returns it into a struct object_id, as the rewrite of complete_action()
(to come in the next commit) will need it.

rebase--helper then is modified to fit this change.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c | 10 ++++++++--
 sequencer.c              | 13 ++++++-------
 sequencer.h              |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 313092c465..bed3dd2b95 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -90,8 +90,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
-		return !!skip_unnecessary_picks();
+	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
+		struct object_id oid;
+		int ret = skip_unnecessary_picks(&oid);
+
+		if (!ret)
+			puts(oid_to_hex(&oid));
+		return !!ret;
+	}
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
diff --git a/sequencer.c b/sequencer.c
index c7d01d60b3..238c534049 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4416,17 +4416,17 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(void)
+int skip_unnecessary_picks(struct object_id *output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
-	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
+	struct object_id *parent_oid;
 	int fd, i;
 
 	if (!read_oneliner(&buf, rebase_path_onto(), 0))
 		return error(_("could not read 'onto'"));
-	if (get_oid(buf.buf, &onto_oid)) {
+	if (get_oid(buf.buf, output_oid)) {
 		strbuf_release(&buf);
 		return error(_("need a HEAD to fixup"));
 	}
@@ -4456,9 +4456,9 @@ int skip_unnecessary_picks(void)
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (hashcmp(parent_oid->hash, oid->hash))
+		if (hashcmp(parent_oid->hash, output_oid->hash))
 			break;
-		oid = &item->commit->object.oid;
+		oidcpy(output_oid, &item->commit->object.oid);
 	}
 	if (i > 0) {
 		int offset = get_item_line_offset(&todo_list, i);
@@ -4487,11 +4487,10 @@ int skip_unnecessary_picks(void)
 
 		todo_list.current = i;
 		if (is_fixup(peek_command(&todo_list, 0)))
-			record_in_rewritten(oid, peek_command(&todo_list, 0));
+			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
 	}
 
 	todo_list_release(&todo_list);
-	printf("%s\n", oid_to_hex(oid));
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index 11a5334612..f11dabfd65 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -88,7 +88,7 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(void);
+int skip_unnecessary_picks(struct object_id *output_oid);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.18.0

