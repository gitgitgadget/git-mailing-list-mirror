Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B8D20281
	for <e@80x24.org>; Tue, 23 May 2017 19:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933134AbdEWTcT (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:32:19 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33019 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764886AbdEWTcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:32:12 -0400
Received: by mail-qt0-f174.google.com with SMTP id t26so137415302qtg.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MElQy5tKEDWvXffZYjPn7Kofy+x/oXuiRxF9493DP0c=;
        b=FqYFXSbp/ilrY7WGYQn3VB+tAsNWz14GFF+jTp6IJ3XVYdGh5ewvVodL1xPbDqa50a
         8YQBaki2zxO4Ej2Jd4I2eKhaiWZqTncx8wdjQmlAMXhtLmAjxeuf2/DEMUSk5NmMfpA3
         v6ikBxpesZ9cy3gB8yEBuwdf3cmMlOarZdZ2mYVWjiOUNASgW4vMsXw/slnseKfUeRi7
         MeygX35JE7EUXmStuDo9u+tI/kbmzZRVlkoUTbcQuige37x5XWFNpffWMM+da+54wgIG
         aCg5wZ5Whys3U4cjpoZ/xBvyIoldYF8t0+aaQfcPkIJkvm5k3PraMvPdkbUViBEP/18K
         Fi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MElQy5tKEDWvXffZYjPn7Kofy+x/oXuiRxF9493DP0c=;
        b=GAAEcDD470hNmWIKHQAm7l+o9clh3Tj3+LPC4f7uAYYoTg0zjN9IJDsNdFVPjj+QV2
         cv1w7wy2iIWBiVAXZvL1ILACk7JDSRzEjk9ni3TTvpzWMjAHkI7cY53H79nJSSixK0Ev
         MZJuxcqHqBzm3pswclluBH/m0CnyIh0eI4maAC+5c5SHLgukKof+A89ylLguyZ8FUpk0
         E9eD4CUQUT0Hzn+LJ10phQz3NMT3itQfvCRnrK8MxSuxCGmIFa3NRg7vA/FFZlDZG/Wi
         PjaiZ56DjVdsLlm1jwWxYar1J9zUzqGctW0R8avdbx/3GFGEkm92AfeGj/YQKxHAyzu6
         ktiQ==
X-Gm-Message-State: AODbwcACNh6Y/bFpw/pz/QhvCYb3SfmxEOCutMsZEr49NmY9k7ojftYg
        90Oh7/ynA1AB+Vp8kd8=
X-Received: by 10.237.62.229 with SMTP id o34mr32121975qtf.4.1495567930704;
        Tue, 23 May 2017 12:32:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id f94sm1058506qtb.16.2017.05.23.12.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:32:10 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v6 6/6] clean: teach clean -d to preserve ignored paths
Date:   Tue, 23 May 2017 06:09:37 -0400
Message-Id: <20170523100937.8752-7-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523100937.8752-1-sxlijin@gmail.com>
References: <20170523100937.8752-1-sxlijin@gmail.com>
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
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

A memory leak is also fixed in cmd_clean().

This also fixes the known breakage in t7300, since clean -d now skips
untracked directories containing ignored paths.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 builtin/clean.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 t/t7300-clean.sh |  2 +-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..937eb17b6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -857,6 +857,38 @@ static void interactive_main_loop(void)
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
+			struct dir_entry *ent = dir->entries[src++];
+
+			/* entries[src] does not contain an ignored path, so we keep it */
+			dir->entries[dst++] = ent;
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
@@ -916,6 +948,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
+	if (remove_directories)
+		dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
+
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
@@ -931,6 +966,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		       prefix, argv);
 
 	fill_directory(&dir, &pathspec);
+	correct_untracked_entries(&dir);
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
@@ -958,6 +994,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		string_list_append(&del_list, rel);
 	}
 
+	for (i = 0; i < dir.nr; i++)
+		free(dir.entries[i]);
+
+	for (i = 0; i < dir.ignored_nr; i++)
+		free(dir.ignored[i]);
+
 	if (interactive && del_list.nr > 0)
 		interactive_main_loop();
 
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

