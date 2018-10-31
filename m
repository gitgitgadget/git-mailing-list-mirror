Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B6D1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 10:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeJaTNj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 15:13:39 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:2941 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeJaTNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 15:13:38 -0400
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HnXagXodRpXFjHnXhgCXrI; Wed, 31 Oct 2018 10:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540980965;
        bh=gmlLG6ULGNr0pTnGQMiLHixdLXi2MCCbo+PjeNOxpVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=I+seEOEjmbM1X7HcWBvUQnpBv43d2pR2ejqwFhb3inL5LQUYnMWMm1uh+PanKpQjY
         HWyaZlygOqBtZtrDxORdOZ922nc1mv77nOlh+ztAH29PR9/w3nBojkJAtcG8zYDVP3
         75+1BC6E7O+caCPNOlefQf5QRACSWiYUgeNKvVYQ=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=ptTNLviJEnKM3T6GpPoA:9
 a=heuzG9CbuoGQlGrz:21 a=leqmCWAxiTIHHbsw:21 a=RfR_gqz1fSpA9VikTjo0:22
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 4/5] add read_author_script() to libgit
Date:   Wed, 31 Oct 2018 10:15:55 +0000
Message-Id: <20181031101556.27169-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031101556.27169-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181031101556.27169-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfH0WBvjXayG5EUSWJso4ZfaPJU67mQCEnXoPAKnr1QcPOjkbwvgXGlSJAMtxgAvJPFLuqOAiyBu9tjSv3AxxCmL9PjKFp5YvIQ6OyzTszjLL2mAJ2Qlv
 Ct9xc1/ULR0DhLQC3mdwMc7wsP3v+HITrPNf2opnE2A5g9HKqFSFWUTmHtHSqvNm4iASiyPKH992qt1DPkfwC6Yg6Lammi6J5niOdjvx2BJvNHJ1p8m2ZD8P
 MjWGC43LUV2q9ixjIs00jJhMDtYD73ta8ihSbxQBJY7Ghx5fiBDABssfWd3v2cBsHH+FDrOCJhRykxFJznKrtCdHWHPFUXYTY6nMSqmqFpo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add read_author_script() to sequencer.c based on the implementation in
builtin/am.c and update read_am_author_script() to use
read_author_script(). The sequencer code that reads the author script
will be updated in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - tweaked an error message as suggested by Junio
     - fixed corner case where a key is given three times (Thanks to Junio
       for pointing this out)
    
    changes since v1:
     - added comment above read_author_script()
     - rebased to reflect changes added in patch 2

 builtin/am.c |  86 +----------------------------------------
 sequencer.c  | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h  |   3 ++
 3 files changed, 110 insertions(+), 84 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 991d13f9a2..c5373158c0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -260,36 +260,6 @@ static int read_state_file(struct strbuf *sb, const struct am_state *state,
 	die_errno(_("could not read '%s'"), am_path(state, file));
 }
 
-/**
- * Take a series of KEY='VALUE' lines where VALUE part is
- * sq-quoted, and append <KEY, VALUE> at the end of the string list
- */
-static int parse_key_value_squoted(char *buf, struct string_list *list)
-{
-	while (*buf) {
-		struct string_list_item *item;
-		char *np;
-		char *cp = strchr(buf, '=');
-		if (!cp) {
-			np = strchrnul(buf, '\n');
-			return error(_("unable to parse '%.*s'"),
-				     (int) (np - buf), buf);
-		}
-		np = strchrnul(cp, '\n');
-		*cp++ = '\0';
-		item = string_list_append(list, buf);
-
-		buf = np + (*np == '\n');
-		*np = '\0';
-		cp = sq_dequote(cp);
-		if (!cp)
-			return error(_("unable to dequote value of '%s'"),
-				     item->string);
-		item->util = xstrdup(cp);
-	}
-	return 0;
-}
-
 /**
  * Reads and parses the state directory's "author-script" file, and sets
  * state->author_name, state->author_email and state->author_date accordingly.
@@ -309,65 +279,13 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 static int read_am_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list kv = STRING_LIST_INIT_DUP;
-	int retval = -1; /* assume failure */
-	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
-	int fd;
 
 	assert(!state->author_name);
 	assert(!state->author_email);
 	assert(!state->author_date);
 
-	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT)
-			return 0;
-		return error_errno(_("could not open '%s' for reading"),
-				   filename);
-	}
-	strbuf_read(&buf, fd, 0);
-	close(fd);
-	if (parse_key_value_squoted(buf.buf, &kv))
-		goto finish;
-
-	for (i = 0; i < kv.nr; i++) {
-		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
-			if (name_i >= 0)
-				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
-			else
-				name_i = i;
-		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
-			if (email_i >= 0)
-				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
-			else
-				email_i = i;
-		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
-			if (date_i >= 0)
-				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
-			else
-				date_i = i;
-		} else {
-			err = error(_("unknown variable '%s'"),
-				    kv.items[i].string);
-		}
-	}
-	if (name_i == -2)
-		error(_("missing 'GIT_AUTHOR_NAME'"));
-	if (email_i == -2)
-		error(_("missing 'GIT_AUTHOR_EMAIL'"));
-	if (date_i == -2)
-		error(_("missing 'GIT_AUTHOR_DATE'"));
-	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
-		goto finish;
-	state->author_name = kv.items[name_i].util;
-	state->author_email = kv.items[email_i].util;
-	state->author_date = kv.items[date_i].util;
-	retval = 0;
-finish:
-	string_list_clear(&kv, !!retval);
-	strbuf_release(&buf);
-	return retval;
+	return read_author_script(filename, &state->author_name,
+				  &state->author_email, &state->author_date, 1);
 }
 
 /**
diff --git a/sequencer.c b/sequencer.c
index dc2c58d464..af9987c807 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -660,6 +660,111 @@ static int write_author_script(const char *message)
 	return res;
 }
 
+/**
+ * Take a series of KEY='VALUE' lines where VALUE part is
+ * sq-quoted, and append <KEY, VALUE> at the end of the string list
+ */
+static int parse_key_value_squoted(char *buf, struct string_list *list)
+{
+	while (*buf) {
+		struct string_list_item *item;
+		char *np;
+		char *cp = strchr(buf, '=');
+		if (!cp) {
+			np = strchrnul(buf, '\n');
+			return error(_("no key present in '%.*s'"),
+				     (int) (np - buf), buf);
+		}
+		np = strchrnul(cp, '\n');
+		*cp++ = '\0';
+		item = string_list_append(list, buf);
+
+		buf = np + (*np == '\n');
+		*np = '\0';
+		cp = sq_dequote(cp);
+		if (!cp)
+			return error(_("unable to dequote value of '%s'"),
+				     item->string);
+		item->util = xstrdup(cp);
+	}
+	return 0;
+}
+
+/**
+ * Reads and parses the state directory's "author-script" file, and sets name,
+ * email and date accordingly.
+ * Returns 0 on success, -1 if the file could not be parsed.
+ *
+ * The author script is of the format:
+ *
+ *	GIT_AUTHOR_NAME='$author_name'
+ *	GIT_AUTHOR_EMAIL='$author_email'
+ *	GIT_AUTHOR_DATE='$author_date'
+ *
+ * where $author_name, $author_email and $author_date are quoted. We are strict
+ * with our parsing, as the file was meant to be eval'd in the old
+ * git-am.sh/git-rebase--interactive.sh scripts, and thus if the file differs
+ * from what this function expects, it is better to bail out than to do
+ * something that the user does not expect.
+ */
+int read_author_script(const char *path, char **name, char **email, char **date,
+		       int allow_missing)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list kv = STRING_LIST_INIT_DUP;
+	int retval = -1; /* assume failure */
+	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
+
+	if (strbuf_read_file(&buf, path, 256) <= 0) {
+		strbuf_release(&buf);
+		if (errno == ENOENT && allow_missing)
+			return 0;
+		else
+			return error_errno(_("could not open '%s' for reading"),
+					   path);
+	}
+
+	if (parse_key_value_squoted(buf.buf, &kv))
+		goto finish;
+
+	for (i = 0; i < kv.nr; i++) {
+		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
+			if (name_i == -2)
+				name_i = i;
+			else
+				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
+			if (email_i == -2)
+				email_i = i;
+			else
+				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
+			if (date_i == -2)
+				date_i = i;
+			else
+				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+		} else {
+			err = error(_("unknown variable '%s'"),
+				    kv.items[i].string);
+		}
+	}
+	if (name_i == -2)
+		error(_("missing 'GIT_AUTHOR_NAME'"));
+	if (email_i == -2)
+		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+	if (date_i == -2)
+		error(_("missing 'GIT_AUTHOR_DATE'"));
+	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
+		goto finish;
+	*name = kv.items[name_i].util;
+	*email = kv.items[email_i].util;
+	*date = kv.items[date_i].util;
+	retval = 0;
+finish:
+	string_list_clear(&kv, !!retval);
+	strbuf_release(&buf);
+	return retval;
+}
 
 /*
  * write_author_script() used to fail to terminate the last line with a "'" and
diff --git a/sequencer.h b/sequencer.h
index c751c9d6e4..3713f955f5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -107,4 +107,7 @@ void commit_post_rewrite(const struct commit *current_head,
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
 			  unsigned int flags);
+
+int read_author_script(const char *path, char **name, char **email, char **date,
+		       int allow_missing);
 #endif
-- 
2.19.1

