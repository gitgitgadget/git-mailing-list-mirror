Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7171DC35242
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C407722522
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="G9Xgnw2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBHT5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 14:57:06 -0500
Received: from mout.web.de ([212.227.15.3]:51981 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbgBHT5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 14:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581191821;
        bh=e+IYpmYbBCEVQpmQ1ocL9oqQ8Gp9F+MZZSzwJztSdFs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=G9Xgnw2W2DLwW16h1dHGPfQWwC0+b9tyg+HeVWBU0D34gz7mMf7SrXu9uXvmHf+rT
         LWCmGG571ijVxgfh5O9JQoEvg9B9YzCILMYJoQmb0OkllI5z+ClZqLF0XopQCR7xqx
         QIYvRnnkzHjBaaSotDlom0XcMVCyk2jC3YkRteco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhNaa-1jMfhl0Lce-00mfIQ; Sat, 08
 Feb 2020 20:57:01 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: add and use strbuf_insertstr()
Message-ID: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
Date:   Sat, 8 Feb 2020 20:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XNjsRnZzt9my+BNCVBs4os6rk/+Zo6axWIsXR51XhMVdZ/1xOoX
 O3YjjUCvO7jNa6KmmP82v4iW15+iCa3KJJhX6WdnTRnbvpJXgTmU0pGuTn7npxPrJ0VYq6G
 p2Y4dGMLjSoxJq+awXOmBiWYl4jrR2ZRt6tbESSHBHr9d4Ij/+biuyz0dBktDfLCOME6UX+
 PKHidUlHBwjsfK9vhIFoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QBlxJCMFzbA=:SVThadNn6+0IZqjHKkSzm6
 M7I7oaBw8zrp44WDfPdvE2b4ej6aed6TW4PCJF7f7MBxcdPvziRZRlrcVR9DWOAKhPcP76TY7
 qd9OKQwtDLK95IJbUv2ZKrQOLp5M2Hepd5bFfZuvFqtF07gwpuqqhXyk23nSrv2fEWNfIai+z
 9xa5EfwnYk1YpqrJWNEbIHE0SVcARnm40smY9vBfZYXAxlcxHHmAHs+IU8noUqbsUjQyihL3h
 hIpAcduG5xRZ9YqzKw/olraAKtn6bBVBxHb5HAIJAeB1i6e9epQu7HqkT2W9V9Lwrqj4Mdpxp
 6MDvlNQQyQad2fI2aBCuFlHPSsbx9wd/SffhDYDUmqF+O5oyp70mcHo6yIt/mE/jNJRyU4Y1U
 +xCpVX298eUxQ5uxZQ1DcDZqaso1gFibOlpyE+8eTm7RJohi7WNMgphXrRqspwnSiUYIVBLOf
 TLgclzIH0n4QJvX6107+D0HDbiemW1pJMHRuezNj782MfO/RCHveLK5PVh/7V/7IIioR9Gzdz
 hYV1jCQOYP/U4NkDH4OtXvHp60ohF9U/ikLGT5q7+5gsNmw9PRNKRVmwdMW2AvE1Oczp8ruxV
 3pNHfkIQ6BW9+1IaXfcKfnd6tBi7pfIgMWupU8sFiAI+D/sp10sM2IWmjShcEU1kTNmdiEdr4
 29t1mU1faU2yiVmCXxqR2eqUONPDz+y39CpbLM6ff5ejBwjj9sxRKsGzNe4DS/G7/7C8EKBCV
 JQ+beSDTYLrPNTea3syV6d6J+1Zpxg4NqTvJNXbAB98zvH81q7EzvLau60IZm5891WTgu1A/q
 PkxWgMkQS4Gz49GnRfMwTsrNFz7VE3UXX63Td3/MhAem/Z+VvOV1GP/MCue5xN3EgzR+EY7Sy
 OCv7bXGwIPvDkZwWM5Q53XNJ1cA7wJUDxpemtkV5Jw3KO2PW55rIjU8BsI56g2zKlG2x7GVsU
 KoxsDnlA1qPbxzGWCO6GTT7RXFDbwqlKL3VBKGjymLfiQuTHc2Fogv8wht76UW9R58Ov65ly2
 g07EztTb5EaDxgeAO9/0J57qWYD+gGlpAMgfywdmBeEIDC13haNJq7SayvWjzshxOd6/kqU+9
 Z8sBy3r8lliePTmHFZ8aA97OyCc1xmEqWLGt7/MUJhC6m/GDlCAw9IKMFHIrEP2y7r8Bq6gzR
 +cZFeqTF2w273WyKBcaSMQ/qUL9C/YLWkpQgDfn1BsGvB693g/ZCdO48wXDk1uNMMxPk5vmop
 aeOm7DC9/goM84Fiu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function for inserting a C string into a strbuf.  Use it
throughout the source to get rid of magic string length constants and
explicit strlen() calls.

Like strbuf_addstr(), implement it as an inline function to avoid the
implicit strlen() calls to cause runtime overhead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/checkout.c        |  2 +-
 builtin/notes.c           |  4 ++--
 builtin/sparse-checkout.c |  2 +-
 commit.c                  |  2 +-
 config.c                  |  2 +-
 http.c                    |  4 ++--
 mailinfo.c                |  2 +-
 notes-utils.c             |  2 +-
 notes.c                   |  4 ++--
 pretty.c                  |  4 ++--
 strbuf.h                  | 12 ++++++++++++
 11 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc2eb1befc..d6773818b8 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -865,7 +865,7 @@ static void update_refs_for_switch(const struct checko=
ut_opts *opts,
 		strbuf_addf(&msg, "checkout: moving from %s to %s",
 			old_desc ? old_desc : "(invalid)", new_branch_info->name);
 	else
-		strbuf_insert(&msg, 0, reflog_msg, strlen(reflog_msg));
+		strbuf_insertstr(&msg, 0, reflog_msg);

 	if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info->path && =
!opts->force_detach) {
 		/* Nothing to do. */
diff --git a/builtin/notes.c b/builtin/notes.c
index 95456f3165..35e468ea2d 100644
=2D-- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -622,7 +622,7 @@ static int append_edit(int argc, const char **argv, co=
nst char *prefix)

 		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
-			strbuf_insert(&d.buf, 0, "\n", 1);
+			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
 		free(prev_buf);
@@ -745,7 +745,7 @@ static int merge_commit(struct notes_merge_options *o)
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
 	format_commit_message(partial, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
-	strbuf_insert(&msg, 0, "notes: ", 7);
+	strbuf_insertstr(&msg, 0, "notes: ");
 	update_ref(msg.buf, o->local_ref, &oid,
 		   is_null_oid(&parent_oid) ? NULL : &parent_oid,
 		   0, UPDATE_REFS_DIE_ON_ERR);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b3bed891cb..38d0d944b3 100644
=2D-- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -373,7 +373,7 @@ static void strbuf_to_cone_pattern(struct strbuf *line=
, struct pattern_list *pl)
 		return;

 	if (line->buf[0] !=3D '/')
-		strbuf_insert(line, 0, "/", 1);
+		strbuf_insertstr(line, 0, "/");

 	insert_recursive_pattern(pl, line);
 }
diff --git a/commit.c b/commit.c
index 3f91d3efc5..a6cfa41a4e 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -993,7 +993,7 @@ static int do_sign_commit(struct strbuf *buf, const ch=
ar *keyid)
 			strbuf_insert(buf, inspos, gpg_sig_header, gpg_sig_header_len);
 			inspos +=3D gpg_sig_header_len;
 		}
-		strbuf_insert(buf, inspos++, " ", 1);
+		strbuf_insertstr(buf, inspos++, " ");
 		strbuf_insert(buf, inspos, bol, len);
 		inspos +=3D len;
 		copypos +=3D len;
diff --git a/config.c b/config.c
index d75f88ca0c..b386c0c628 100644
=2D-- a/config.c
+++ b/config.c
@@ -204,7 +204,7 @@ static int prepare_include_condition_pattern(struct st=
rbuf *pat)
 		strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
 		prefix =3D slash - path.buf + 1 /* slash */;
 	} else if (!is_absolute_path(pat->buf))
-		strbuf_insert(pat, 0, "**/", 3);
+		strbuf_insertstr(pat, 0, "**/");

 	add_trailing_starstar_for_dir(pat);

diff --git a/http.c b/http.c
index 5f348169c3..00a0e50763 100644
=2D-- a/http.c
+++ b/http.c
@@ -680,8 +680,8 @@ static void curl_dump_header(const char *text, unsigne=
d char *ptr, size_t size,
 	for (header =3D headers; *header; header++) {
 		if (hide_sensitive_header)
 			redact_sensitive_header(*header);
-		strbuf_insert((*header), 0, text, strlen(text));
-		strbuf_insert((*header), strlen(text), ": ", 2);
+		strbuf_insertstr((*header), 0, text);
+		strbuf_insertstr((*header), strlen(text), ": ");
 		strbuf_rtrim((*header));
 		strbuf_addch((*header), '\n');
 		trace_strbuf(&trace_curl, (*header));
diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..c535dec2e9 100644
=2D-- a/mailinfo.c
+++ b/mailinfo.c
@@ -254,7 +254,7 @@ static void handle_content_type(struct mailinfo *mi, s=
truct strbuf *line)
 	mi->delsp =3D has_attr_value(line->buf, "delsp=3D", "yes");

 	if (slurp_attr(line->buf, "boundary=3D", boundary)) {
-		strbuf_insert(boundary, 0, "--", 2);
+		strbuf_insertstr(boundary, 0, "--");
 		if (++mi->content_top >=3D &mi->content[MAX_BOUNDARIES]) {
 			error("Too many boundaries to handle");
 			mi->input_error =3D -1;
diff --git a/notes-utils.c b/notes-utils.c
index a819410698..5f94c513d4 100644
=2D-- a/notes-utils.c
+++ b/notes-utils.c
@@ -52,7 +52,7 @@ void commit_notes(struct repository *r, struct notes_tre=
e *t, const char *msg)
 	strbuf_complete_line(&buf);

 	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
-	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index =
7 */
+	strbuf_insertstr(&buf, 0, "notes: "); /* commit message starts at index =
7 */
 	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);

diff --git a/notes.c b/notes.c
index 0c79964c26..a24af53de6 100644
=2D-- a/notes.c
+++ b/notes.c
@@ -1332,9 +1332,9 @@ void expand_notes_ref(struct strbuf *sb)
 	if (starts_with(sb->buf, "refs/notes/"))
 		return; /* we're happy */
 	else if (starts_with(sb->buf, "notes/"))
-		strbuf_insert(sb, 0, "refs/", 5);
+		strbuf_insertstr(sb, 0, "refs/");
 	else
-		strbuf_insert(sb, 0, "refs/notes/", 11);
+		strbuf_insertstr(sb, 0, "refs/notes/");
 }

 void expand_loose_notes_ref(struct strbuf *sb)
diff --git a/pretty.c b/pretty.c
index f5fbbc5ffb..28afc701b6 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1609,9 +1609,9 @@ static size_t format_commit_item(struct strbuf *sb, =
/* in UTF-8 */
 			strbuf_setlen(sb, sb->len - 1);
 	} else if (orig_len !=3D sb->len) {
 		if (magic =3D=3D ADD_LF_BEFORE_NON_EMPTY)
-			strbuf_insert(sb, orig_len, "\n", 1);
+			strbuf_insertstr(sb, orig_len, "\n");
 		else if (magic =3D=3D ADD_SP_BEFORE_NON_EMPTY)
-			strbuf_insert(sb, orig_len, " ", 1);
+			strbuf_insertstr(sb, orig_len, " ");
 	}
 	return consumed + 1;
 }
diff --git a/strbuf.h b/strbuf.h
index bfa66569a4..aae7ac3a82 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -244,6 +244,18 @@ void strbuf_addchars(struct strbuf *sb, int c, size_t=
 n);
  */
 void strbuf_insert(struct strbuf *sb, size_t pos, const void *, size_t);

+/**
+ * Insert a NUL-terminated string to the given position of the buffer.
+ * The remaining contents will be shifted, not overwritten.  It's an
+ * inline function to allow the compiler to resolve strlen() calls on
+ * constants at compile time.
+ */
+static inline void strbuf_insertstr(struct strbuf *sb, size_t pos,
+				    const char *s)
+{
+	strbuf_insert(sb, pos, s, strlen(s));
+}
+
 /**
  * Insert data to the given position of the buffer giving a printf format
  * string. The contents will be shifted, not overwritten.
=2D-
2.25.0

