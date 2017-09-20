Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A436920A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 19:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbdITTrz (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:47:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36945 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdITTry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:47:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id f4so3326021wmh.4
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 12:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnDQvBQ2MmuiAV8MyAbpGgJYpDdf6+vgMnvZo4XtfWk=;
        b=DAK65SvTU+nc1fKEtU7OqUCsTMhae1+fyDl0RQZg+Yl8qOo6nUPyPtMq9fZ2VzJ1JA
         wA0kCC1rowwjVs4GHfbFy49/1TeBj2sfnri6z51x9soNcmCwU3gEmAkgiuqw54wX56nj
         Mipcw3ieHAajGw9yuIsAyAUb3agkahXzuP98x0eW2ZvpRNMHRQtM5DYUOvBTBD4ITSCk
         4N0CFsJ/oOXCmXK4Y044vG0XNroFh4i7N0k12lJzZROjOqk6CNGDGZ7hZtCJhYT1IR3M
         yCY58QScNV++GHKdSVGYrCSiQ9BLKLAeVt/gnY0MCR84pZoCrpiIer0amlo+qQ+SWJw5
         /zTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnDQvBQ2MmuiAV8MyAbpGgJYpDdf6+vgMnvZo4XtfWk=;
        b=iVF76vuXUIA/86PmfNVcTUc2PgnDkrMV+F9XlBgO8n+sgYrscp7V7KcXSWmizfjUXf
         31n7evYLfcK0W48P7KejdtDOudVQ+UCsdzD7MA0ceqbeK6/30gVyf46fzSfejxKsRtaU
         w5DZBAn3sQ4A3JShbqp7Q5SvDj9MaC4W1YwgpYO67PEQioKQqeA/kewyJyEWMZY2eV8a
         u0S0uMKAoFSU6h8c+ZjKnv77OJIesobSJFTv5EFGmbR3+SclhHZfza+W6abNqzNP7Lfc
         TGjDEL1EkaO+az8ur/a+nGZCxCLIduxABMoxus7gVPPOBbPGtNNf2/KIKVeQKnkTJTUw
         ub5Q==
X-Gm-Message-State: AHPjjUic33qaDYxrBpi4b+Q++ImbGIXiEVLSebbyvw3kOafwmDflCknw
        GqqN0xUoL6c6SoNU0d6FBZ53Wg==
X-Google-Smtp-Source: AOwi7QDkLLy2/wQkty2fKVRFhONEfAMgNgAex3uN0roJ5OqZY1rSu+32YOKDhoO379hG7t9Mq5yTpA==
X-Received: by 10.28.71.25 with SMTP id u25mr4492875wma.126.1505936872679;
        Wed, 20 Sep 2017 12:47:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t141sm2419652wme.33.2017.09.20.12.47.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 12:47:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] commit: fix memory leak in `prepare_index()`
Date:   Wed, 20 Sep 2017 21:47:23 +0200
Message-Id: <1505936846-2195-1-git-send-email-martin.agren@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release `pathspec` and the string list `partial`.

When we clear the string list, make sure we do not free the `util`
pointers. That would result in double-freeing, since we set them up as
`item->util = item` in `list_paths()`.

Initialize the string list early, so that we can always release it. That
introduces some unnecessary overhead in various code paths, but means
there is one and only one way out of the function. If we ever accumulate
more things we need to free, it should be straightforward to do so.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/commit.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 58f9747..721e5f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -335,7 +335,7 @@ static void refresh_cache_or_die(int refresh_flags)
 static const char *prepare_index(int argc, const char **argv, const char *prefix,
 				 const struct commit *current_head, int is_status)
 {
-	struct string_list partial;
+	struct string_list partial = STRING_LIST_INIT_DUP;
 	struct pathspec pathspec;
 	int refresh_flags = REFRESH_QUIET;
 	const char *ret;
@@ -380,7 +380,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			warning(_("Failed to update main cache tree"));
 
 		commit_style = COMMIT_NORMAL;
-		return get_lock_file_path(&index_lock);
+		ret = get_lock_file_path(&index_lock);
+		goto out;
 	}
 
 	/*
@@ -403,7 +404,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
-		return get_lock_file_path(&index_lock);
+		ret = get_lock_file_path(&index_lock);
+		goto out;
 	}
 
 	/*
@@ -429,7 +431,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			rollback_lock_file(&index_lock);
 		}
 		commit_style = COMMIT_AS_IS;
-		return get_index_file();
+		ret = get_index_file();
+		goto out;
 	}
 
 	/*
@@ -460,7 +463,6 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("cannot do a partial commit during a cherry-pick."));
 	}
 
-	string_list_init(&partial, 1);
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, &pathspec))
 		exit(1);
 
@@ -490,6 +492,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	discard_cache();
 	ret = get_lock_file_path(&false_lock);
 	read_cache_from(ret);
+out:
+	string_list_clear(&partial, 0);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
-- 
2.14.1

