Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90EF1FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935512AbdEWJSv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:18:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34171 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762691AbdEWJSn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:18:43 -0400
Received: by mail-qt0-f196.google.com with SMTP id l39so21458896qtb.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dvL559uDqil9ZumHFcsvSISM31utzoSnEo/kc9MvLvQ=;
        b=SOKEhwC+ru9HY1l+5Nb+k1xqKfJ6Xc9VekeDz/RPCVe1om8roPbgrveilMrCj7KI3p
         MEj8K/cgRaksmcqRNa2Tvq35oK7zbyZlFMsTuAxVclTUTLlEMND4IbNdg5ZaSkfLEBpt
         85OCNjLJNDgyvnRmwixWWXhveUWPIQcaqm27jEXJEN1FEo5hHEwzNDU4pajKWBDxmLBt
         dTcCLIUA+yvmKpkkAwmfhLxbmimJtS3bHRJVO6MKGU7dU66ckbdApYw3JmSV7AE2wyW8
         7YIDcI8VjAt2+AoRV5BchPSV3xfFXEc5/hl0TLlPALpsQuew92jO8SbKlgMv2ChUJb75
         rvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dvL559uDqil9ZumHFcsvSISM31utzoSnEo/kc9MvLvQ=;
        b=t7kO2DR/NvOjoBD4qL760MdfiD8DUYxDDfwWfzxBuH5Tb45/Cwrd7Saq52u543AMF4
         +0KUZnjFeLu+oKJaG4qkD7Lu4ynbRKXoz+RfyqATzf/xgx1aZT0RJeg54LrXnCjCp/vK
         swM22izu+zOM1TU0PKLqhBuhvf8YPtN41xgFB8vVZKiId4PIcRIJMZGjSbFD/f4Dq0tY
         eCUKfqsviEhuO7hsRPmUTZHBqmpODC/2afK2ynYvWMtuzsso9Dd1/jAvzZZkxuo0lNmD
         EyaN02wIz/XMdafN6yjrzg4VcZW5+9hWiWnf0Yrrchd/lzTh68znjwUuboolNBVz0Tb/
         iQfA==
X-Gm-Message-State: AODbwcAgfQAyceXdQRaPuGodoTx6+WX8XxlL6Gtq8Aw0AIw2h5Jzg0/l
        +dWKJcGO9GXjZA==
X-Received: by 10.237.37.209 with SMTP id y17mr28774643qtc.140.1495531122682;
        Tue, 23 May 2017 02:18:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id a45sm83105qta.39.2017.05.23.02.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 02:18:42 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v5 6/6] clean: teach clean -d to preserve ignored paths
Date:   Tue, 23 May 2017 05:18:29 -0400
Message-Id: <20170523091829.1746-7-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an implicit assumption that a directory containing only
untracked and ignored paths should itself be considered untracked. This
makes sense in use cases where we're asking if a directory should be
added to the git database, but not when we're asking if a directory can
be safely removed from the working tree; as a result, clean -d would
assume that an "untracked" directory containing ignored paths could be
deleted, even though doing so would also remove the ignored paths.

To get around this, we teach clean -d to collect ignored paths and skip
an untracked directory if it contained an ignored path, instead just
removing the untracked contents thereof. To achieve this, cmd_clean()
has to collect all untracked contents of untracked directories, in
addition to all ignored paths, to determine which untracked dirs must be
skipped (because they contain ignored paths) and which ones should *not*
be skipped.

For this purpose, correct_untracked_entries() is introduced to prune a
given dir_struct of untracked entries containing ignored paths and those
untracked entries encompassed by the untracked entries which are not
pruned away.

This also fixes the known breakage in t7300, since clean -d now skips
untracked directories containing ignored paths.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 builtin/clean.c  | 31 +++++++++++++++++++++++++++++++
 t/t7300-clean.sh |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..45dbdcd18 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -857,6 +857,36 @@ static void interactive_main_loop(void)
 	}
 }
 
+static void correct_untracked_entries(struct dir_struct *dir)
+{
+	int src, dst, ign;
+
+	for (src = dst = ign = 0; src < dir->nr; src++) {
+		/* skip paths in ignored[] that cannot be inside entries[src] */
+		while (ign < dir->ignored_nr &&
+		       0 <= cmp_dir_entry(&dir->entries[src], &dir->ignored[ign]))
+			ign++;
+
+		if (ign < dir->ignored_nr &&
+		    check_dir_entry_contains(dir->entries[src], dir->ignored[ign])) {
+			/* entries[src] contains an ignored path, so we drop it */
+			free(dir->entries[src]);
+		} else {
+			/* entries[src] does not contain an ignored path, so we keep it */
+			dir->entries[dst++] = dir->entries[src++];
+
+			/* then discard paths in entries[] contained inside entries[src] */
+			while (src < dir->nr &&
+			       check_dir_entry_contains(ent, dir->entries[src]))
+				free(dir->entries[src++]);
+
+			/* compensate for the outer loop's loop control */
+			src--;
+		}
+	}
+	dir->nr = dst;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
@@ -931,6 +961,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		       prefix, argv);
 
 	fill_directory(&dir, &pathspec);
+	correct_untracked_entries(&dir);
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 3a2d709c2..7b36954d6 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,7 +653,7 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
-test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
 	echo /foo/bar >.gitignore &&
 	echo ignoreme >>.gitignore &&
 	rm -rf foo &&
-- 
2.13.0

