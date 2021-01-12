Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23977C4332D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0306723123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436899AbhALVhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436887AbhALUTp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D65CC061795
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:19:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g10so1579983wmh.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JH09G29nKhQTNzNCjrlB0T1G8yYLr/574/1r+2W5oow=;
        b=jtLNPlq2FSn08gkqWg5seKXX6NUediOG9bB4G+UvewveTeNj7GcXtR0btCtFWrTzad
         g+y4c9jiuUXxsoUFJv/acOLWKvPWJk8VuE1RRB94u6XQsgYqWOEyjwDoUsy1HuWL9CzJ
         /sFeIPicurb5JxBgmgfOmBTvKf6PMNLrVmIMouxKUOfcPG7K9t9q7ZRKxXJny785nSAD
         +pbClKElWL3p7rB8zFkZqw9b7nkX0RBpCWseG5c1gMwmo64Epk7TZFp6gZ2g1YKULFvB
         08dQDXvvuLxCENa9z4zkbSosulEl8wOzTjtejczeOrMgpjPDrbCbyJpyD8md98Up3IhR
         RuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JH09G29nKhQTNzNCjrlB0T1G8yYLr/574/1r+2W5oow=;
        b=PbQW/DgaTiUEHnhiUUk5V3auRZXOAKPODlUUmGtcsG61yKOI+dU3mi762xUoHqB1gR
         OxEqnq68gztyvRlBM9cV0CKjCQqeYxttU3lAvNOtSyP40qAzPu+YHaxpk/wcosrNKVVd
         ySpR6IFyZ8zvXVDXe/RjWzRpsBlnOmOBsjyMKlL1LmuzwpQKw7WP3TR5t4mvySXtpzR9
         AIS66Luyf6Rc0X9AjCHT8olqL1quoKDLiLRHaG/rZRgRMJnphiEYlByz77gQr9LBJJOf
         NKPjf9l9AZIgbfL4L+VFNegoFyMBIULnrXJuSgztXzQSqS8f8dDwRf8c0seeO4Y73XKR
         vM5w==
X-Gm-Message-State: AOAM530sZvP3kVM4nYdGmHoNL5ZoU8UHfnSqmUULw2ZH+x4PWQs50e/O
        3ms/ARga9BAR4nEYozJJSpa57UYX71w3dQ==
X-Google-Smtp-Source: ABdhPJwH4Td/+SJNJGLoq6FLrAeUwLASNhXd+ckw1k8TJJAHA8ZOvpD7Fvn73RT9C7aBjUVtLddZZA==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr878378wmj.170.1610482743457;
        Tue, 12 Jan 2021 12:19:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:19:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 22/22] shortlog: remove unused(?) "repo-abbrev" feature
Date:   Tue, 12 Jan 2021 21:18:06 +0100
Message-Id: <20210112201806.13284-23-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove support for the magical "repo-abbrev" comment in .mailmap
files. This was added to .mailmap parsing in [1], as a generalized
feature of the git-shortlog Perl script added earlier in [2].

There was no documentation or tests for this feature, and I don't
think it's used in practice anymore.

What it did was to allow you to specify a single string to be
search-replaced with "/.../" in the .mailmap file. E.g. for
linux.git's current .mailmap:

    git archive --remote=git@gitlab.com:linux-kernel/linux.git \
        HEAD -- .mailmap | grep -a repo-abbrev
    # repo-abbrev: /pub/scm/linux/kernel/git/

Then when running e.g.:

    git shortlog --merges --author=Linus -1 v5.10-rc7..v5.10 | grep Merge

We'd emit (the [...] is mine):

      Merge tag [...]git://git.kernel.org/.../tip/tip

But will now emit:

      Merge tag [...]git.kernel.org/pub/scm/linux/kernel/git/tip/tip

I think at this point this is just a historical artifact we can get
rid of. It was initially meant for Linus's own use when we integrated
the Perl script[2], but since then it seems he's stopped using it.

Digging through Linus's release announcements on the LKML[3] the last
release I can find that made use of this output is Linux 2.6.25-rc6
back in March 2008[4]. Later on Linus started using --no-merges[5],
and nowadays seems to prefer some custom not-quite-shortlog format of
merges from lieutenants[6].

You will still see it on linux.git if you run "git shortlog" manually
yourself with --merges, with this removed you can still get the same
output with:

    git log --pretty=fuller v5.10-rc7..v5.10 |
    sed 's!/pub/scm/linux/kernel/git/!/.../!g' |
    git shortlog

Arguably we should do the same for the search-replacing of "[PATCH]"
at the beginning with "". That seems to be another relic of a bygone
era when linux.git patches would have their E-Mail subject lines
applied as-is by "git am" or whatever. But we documented that feature
in "git-shortlog(1)", and it seems more widely applicable than
something purely kernel-specific.

1. 7595e2ee6ef (git-shortlog: make common repository prefix
   configurable with .mailmap, 2006-11-25)
2. fa375c7f1b6 (Add git-shortlog perl script, 2005-06-04)
3. https://lore.kernel.org/lkml/
4. https://lore.kernel.org/lkml/alpine.LFD.1.00.0803161651350.3020@woody.linux-foundation.org/
5. https://lore.kernel.org/lkml/BANLkTinrbh7Xi27an3uY7pDWrNKhJRYmEA@mail.gmail.com/
6. https://lore.kernel.org/lkml/CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com/

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c         |  2 +-
 builtin/check-mailmap.c |  2 +-
 builtin/commit.c        |  2 +-
 builtin/log.c           |  2 +-
 builtin/shortlog.c      | 16 ++------------
 mailmap.c               | 48 +++++++++++------------------------------
 mailmap.h               |  2 +-
 pretty.c                |  2 +-
 shortlog.h              |  1 -
 9 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6f7e32411a..712ae8e742 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1151,7 +1151,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.xdl_opts = xdl_opts;
 	sb.no_whole_file_rename = no_whole_file_rename;
 
-	read_mailmap(&mailmap, NULL);
+	read_mailmap(&mailmap);
 
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index cdce144f3b..7dc47e4793 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -47,7 +47,7 @@ int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 	if (argc == 0 && !use_stdin)
 		die(_("no contacts specified"));
 
-	read_mailmap(&mailmap, NULL);
+	read_mailmap(&mailmap);
 
 	for (i = 0; i < argc; ++i)
 		check_mailmap(&mailmap, argv[i]);
diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..739110c5a7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1039,7 +1039,7 @@ static const char *find_author_by_nickname(const char *name)
 	av[++ac] = NULL;
 	setup_revisions(ac, av, &revs, NULL);
 	revs.mailmap = &mailmap;
-	read_mailmap(revs.mailmap, NULL);
+	read_mailmap(revs.mailmap);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
diff --git a/builtin/log.c b/builtin/log.c
index bd6ff4f9f9..4ee81bc976 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -230,7 +230,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 
 	if (mailmap) {
 		rev->mailmap = xcalloc(1, sizeof(struct string_list));
-		read_mailmap(rev->mailmap, NULL);
+		read_mailmap(rev->mailmap);
 	}
 
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c52e4ccd19..e7c21ab620 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -61,8 +61,7 @@ static void insert_one_record(struct shortlog *log,
 	if (log->summary)
 		item->util = (void *)(UTIL_TO_INT(item) + 1);
 	else {
-		const char *dot3 = log->common_repo_prefix;
-		char *buffer, *p;
+		char *buffer;
 		struct strbuf subject = STRBUF_INIT;
 		const char *eol;
 
@@ -82,17 +81,6 @@ static void insert_one_record(struct shortlog *log,
 		format_subject(&subject, oneline, " ");
 		buffer = strbuf_detach(&subject, NULL);
 
-		if (dot3) {
-			int dot3len = strlen(dot3);
-			if (dot3len > 5) {
-				while ((p = strstr(buffer, dot3)) != NULL) {
-					int taillen = strlen(p) - dot3len;
-					memcpy(p, "/.../", 5);
-					memmove(p + 5, p + dot3len, taillen + 1);
-				}
-			}
-		}
-
 		if (item->util == NULL)
 			item->util = xcalloc(1, sizeof(struct string_list));
 		string_list_append(item->util, buffer);
@@ -342,7 +330,7 @@ void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
 
-	read_mailmap(&log->mailmap, &log->common_repo_prefix);
+	read_mailmap(&log->mailmap);
 
 	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
diff --git a/mailmap.c b/mailmap.c
index 962fd86d6d..eb77c6e77c 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -143,31 +143,13 @@ static char *parse_name_and_email(char *buffer, char **name,
 	return (*right == '\0' ? NULL : right);
 }
 
-static void read_mailmap_line(struct string_list *map, char *buffer,
-			      char **repo_abbrev)
+static void read_mailmap_line(struct string_list *map, char *buffer)
 {
 	char *name1 = NULL, *email1 = NULL, *name2 = NULL, *email2 = NULL;
-	if (buffer[0] == '#') {
-		static const char abbrev[] = "# repo-abbrev:";
-		int abblen = sizeof(abbrev) - 1;
-		int len = strlen(buffer);
 
-		if (!repo_abbrev)
-			return;
-
-		if (len && buffer[len - 1] == '\n')
-			buffer[--len] = 0;
-		if (!strncmp(buffer, abbrev, abblen)) {
-			char *cp;
-
-			free(*repo_abbrev);
-
-			for (cp = buffer + abblen; isspace(*cp); cp++)
-				; /* nothing */
-			*repo_abbrev = xstrdup(cp);
-		}
+	if (buffer[0] == '#')
 		return;
-	}
+
 	if ((name2 = parse_name_and_email(buffer, &name1, &email1, 0)) != NULL)
 		parse_name_and_email(name2, &name2, &email2, 1);
 
@@ -175,8 +157,7 @@ static void read_mailmap_line(struct string_list *map, char *buffer,
 		add_mapping(map, name1, email1, name2, email2);
 }
 
-static int read_mailmap_file(struct string_list *map, const char *filename,
-			     char **repo_abbrev)
+static int read_mailmap_file(struct string_list *map, const char *filename)
 {
 	char buffer[1024];
 	FILE *f;
@@ -192,13 +173,12 @@ static int read_mailmap_file(struct string_list *map, const char *filename,
 	}
 
 	while (fgets(buffer, sizeof(buffer), f) != NULL)
-		read_mailmap_line(map, buffer, repo_abbrev);
+		read_mailmap_line(map, buffer);
 	fclose(f);
 	return 0;
 }
 
-static void read_mailmap_string(struct string_list *map, char *buf,
-				char **repo_abbrev)
+static void read_mailmap_string(struct string_list *map, char *buf)
 {
 	while (*buf) {
 		char *end = strchrnul(buf, '\n');
@@ -206,14 +186,12 @@ static void read_mailmap_string(struct string_list *map, char *buf,
 		if (*end)
 			*end++ = '\0';
 
-		read_mailmap_line(map, buf, repo_abbrev);
+		read_mailmap_line(map, buf);
 		buf = end;
 	}
 }
 
-static int read_mailmap_blob(struct string_list *map,
-			     const char *name,
-			     char **repo_abbrev)
+static int read_mailmap_blob(struct string_list *map, const char *name)
 {
 	struct object_id oid;
 	char *buf;
@@ -231,13 +209,13 @@ static int read_mailmap_blob(struct string_list *map,
 	if (type != OBJ_BLOB)
 		return error("mailmap is not a blob: %s", name);
 
-	read_mailmap_string(map, buf, repo_abbrev);
+	read_mailmap_string(map, buf);
 
 	free(buf);
 	return 0;
 }
 
-int read_mailmap(struct string_list *map, char **repo_abbrev)
+int read_mailmap(struct string_list *map)
 {
 	int err = 0;
 
@@ -247,10 +225,10 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
 
-	err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
+	err |= read_mailmap_file(map, ".mailmap");
 	if (startup_info->have_repository)
-		err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
-	err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
+		err |= read_mailmap_blob(map, git_mailmap_blob);
+	err |= read_mailmap_file(map, git_mailmap_file);
 	return err;
 }
 
diff --git a/mailmap.h b/mailmap.h
index d0e65646cb..7e99fccb46 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,7 +3,7 @@
 
 struct string_list;
 
-int read_mailmap(struct string_list *map, char **repo_abbrev);
+int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
 int map_user(struct string_list *map,
diff --git a/pretty.c b/pretty.c
index 05eef7fda0..3922f6f9f2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -679,7 +679,7 @@ static int mailmap_name(const char **email, size_t *email_len,
 	static struct string_list *mail_map;
 	if (!mail_map) {
 		mail_map = xcalloc(1, sizeof(*mail_map));
-		read_mailmap(mail_map, NULL);
+		read_mailmap(mail_map);
 	}
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
diff --git a/shortlog.h b/shortlog.h
index 64be879b24..3f7e9aabca 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -23,7 +23,6 @@ struct shortlog {
 	} groups;
 	struct string_list trailers;
 
-	char *common_repo_prefix;
 	int email;
 	struct string_list mailmap;
 	FILE *file;
-- 
2.29.2.222.g5d2a92d10f8

