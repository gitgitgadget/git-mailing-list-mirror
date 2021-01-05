Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACF7C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E96322AAC
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbhAENEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbhAENEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 08:04:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC0C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 05:04:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c133so2949961wme.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAt4pHkGYman66hA6IZHvkuPuD1zf00L3YgZ1K5X9wo=;
        b=W0pT5UoSlrs5G0CBf3q3WEVXfLTDkTar3QsH6+J626IstOxFG0tEv/6TvL29KAlgYn
         pJ4qTfc876ISno5rKtOUypxGYwcISJq4L4PWbHQ0VD70JBypaZ3d9HzwLp2RfG1jGCVn
         LcySQSNvdkfi5IwS1DJQxnSZnyNXLuLLR36aphm91EixpsZyBVObN+IFkvYHPtkh1K7a
         6jb7XUzIEmaOheGYJQy+e/lWR2aM8kKDq7qIUbmSEc2fnLKpwr+6aC539JlHN6e0ANFi
         VWOcgwdJRHdR69yUdNd9ThTNQnkGQ7RtXLEqDct047Rm6BeTL4a+Vy1SpM8dEeM8XON7
         euFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAt4pHkGYman66hA6IZHvkuPuD1zf00L3YgZ1K5X9wo=;
        b=MCl3Frlij+Dx149M3YZR/mnswwATcmJoB0WvJ7aMBaOyew4bDZTtLBohPfi/DOz/QR
         6t2vsixxobojeF3c34gQJj4l6BQ/wkW80kZxkRAH8ea+7q92yPKXp2SVwrmSA8ICbU3D
         qTp3JWfbCqL9cQ1H0GkhAoPEaGbRGKRiEdqEf5G4Vv6jvVW4/vQUJ6m6HfodQ/MQYVBD
         YW8oZYXTRd0OGmTovSFMjy+BdyxkM+EDVqnDVOe4TmLOwoEXCe9kggVDCs501+5hH/tW
         am1ZQ01nATyO7tHSTwK3f/nN8tE5Phf/aSoQNoxX9dPqd2Xs5nghko9s741MIaVa95/D
         YnSA==
X-Gm-Message-State: AOAM532gBbYh1ni1HZN9qOQQj/aB4CjyPzuSY+ckgqxm/1z2HLkAEWG4
        UB6pwHRO1f+CiUOubM5m9tWRImUCcbQ=
X-Google-Smtp-Source: ABdhPJw86FN0fqRLkc9TYM36dkzipegVgQ+Ja1wJ3YaIPcbdqZY91Jtl5BzzPMJvIvYrHGX5ELYsoA==
X-Received: by 2002:a1c:a9cc:: with SMTP id s195mr3423844wme.97.1609851852637;
        Tue, 05 Jan 2021 05:04:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a65sm3899630wmc.35.2021.01.05.05.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:04:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] shortlog: remove unused(?) "repo-abbrev" feature
Date:   Tue,  5 Jan 2021 14:03:59 +0100
Message-Id: <20210105130359.21139-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <7vejrs54kp.fsf@assigned-by-dhcp.cox.net>
References: <7vejrs54kp.fsf@assigned-by-dhcp.cox.net>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I wondered what this repo-abbrev thing was while reading thorugh
recent mailmap.c traffic. I was a bit on the fence about this being a
RFC/PATCH, but I guess if people hate this & want to keep it that's
fine, but if not this should be ready for inclusion.

Surely has some conflicts with brian's recent submission, but I wanted
to get it out of my queue sooner than later.

 builtin/blame.c         |  2 +-
 builtin/check-mailmap.c |  2 +-
 builtin/commit.c        |  2 +-
 builtin/log.c           |  2 +-
 builtin/shortlog.c      | 16 ++------------
 mailmap.c               | 47 ++++++++++-------------------------------
 mailmap.h               |  2 +-
 pretty.c                |  2 +-
 shortlog.h              |  1 -
 9 files changed, 19 insertions(+), 57 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6f7e32411a8..712ae8e7425 100644
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
index cdce144f3b7..7dc47e47932 100644
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
index 505fe60956d..739110c5a7f 100644
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
index bd6ff4f9f95..4ee81bc976d 100644
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
index c52e4ccd19a..e7c21ab6201 100644
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
index 962fd86d6d7..f1da233adb9 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -143,31 +143,10 @@ static char *parse_name_and_email(char *buffer, char **name,
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
-		return;
-	}
 	if ((name2 = parse_name_and_email(buffer, &name1, &email1, 0)) != NULL)
 		parse_name_and_email(name2, &name2, &email2, 1);
 
@@ -175,8 +154,7 @@ static void read_mailmap_line(struct string_list *map, char *buffer,
 		add_mapping(map, name1, email1, name2, email2);
 }
 
-static int read_mailmap_file(struct string_list *map, const char *filename,
-			     char **repo_abbrev)
+static int read_mailmap_file(struct string_list *map, const char *filename)
 {
 	char buffer[1024];
 	FILE *f;
@@ -192,13 +170,12 @@ static int read_mailmap_file(struct string_list *map, const char *filename,
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
@@ -206,14 +183,12 @@ static void read_mailmap_string(struct string_list *map, char *buf,
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
@@ -231,13 +206,13 @@ static int read_mailmap_blob(struct string_list *map,
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
 
@@ -247,10 +222,10 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
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
index d0e65646cb5..7e99fccb46c 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,7 +3,7 @@
 
 struct string_list;
 
-int read_mailmap(struct string_list *map, char **repo_abbrev);
+int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
 int map_user(struct string_list *map,
diff --git a/pretty.c b/pretty.c
index 7a7708a0ea7..fe0a66623e3 100644
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
index 64be879b241..3f7e9aabcae 100644
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

