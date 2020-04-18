Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6739C352BE
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971D521D93
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHTfWtFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgDRUT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUT3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 16:19:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F48C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n6so2348849ljg.12
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXQtMFHLBfwe2wMAlhVR4+U0+uV8blgB79RLYOhlQCc=;
        b=GHTfWtFG95wk3cRJ1FBygpLqll8D1i7IGTJXN/KAivukUGE4a1fyZ6p3A4aDTRtfYY
         wTnbLPwUeIKP01pdXn4STuTuyNrrCNBQuL28SOZhiMARqZrZhmd+56rAVlylgw/fAmC5
         F/3Rn201fbRI+DM3Y3H+pKIgnyyKG3Nb0TeDmI4lot2w29VqHZAqkbNIfKYJI1YURLEC
         tex7oCGQTe2QqfXw0nQGjozSr2LGK50HOGHXQN+kx2zSjefIMJ2uM5qaNCkb5fRhHMFB
         xlpTC67Ct8pQRfvlgB48RIELWaY2pLn0G6buJZgO7oXBi8LGwgKo8R6LKFZu6oFa+kFE
         hkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXQtMFHLBfwe2wMAlhVR4+U0+uV8blgB79RLYOhlQCc=;
        b=jB1ThfseuDdl1tZei5KyccfatuagMInEtK+yDSjnq22HNQ2wybYFSX/yf35zspKG+O
         kGHh4cWbYGSeokU2ffCCzZILQG5LcIGXbqM7mto5Y0uODfLYuIx7slcINNHjYyhusU34
         0daS+WZC1IdU54E+vVhHsaDQf1PGByddq2zpxtD3PxDuQgy+2eF81RE6DxzPRGQQW9aL
         1b/XgJuH9EpeynFrG0/6JbMKPfPB6TZnMxpcs8oe75c0C1LCB/rQgoYkQxwx3gbboSyZ
         cJrRSQub9ct4n12hQieZRSVrU08QilfB54fNCQiadv8a1ip16xiaMCMRm5gFCSlM4nQj
         xtqw==
X-Gm-Message-State: AGi0PuaxzqSMWTUMGlJT/vdkMpuGwlySZGHON/0Nisd7rAlXmKDKILsk
        hVYPFUuNE2hWvpPPm2c17PKJTW+z
X-Google-Smtp-Source: APiQypLpfKo42yRlJh/yZGMIDJhsQ3xW/ZCO802VX5G3yd/Ts9t3IYsbj4Ydjx/EoYYuBPskTc/yOQ==
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr5847655ljc.8.1587241166895;
        Sat, 18 Apr 2020 13:19:26 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm218713ljj.72.2020.04.18.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:19:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 6/6] strbuf: simplify `strbuf_attach()` usage
Date:   Sat, 18 Apr 2020 22:18:29 +0200
Message-Id: <ff6febad652f3e31642f3a39fd501c4c31f93a38.1587240635.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com> <cover.1587240635.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last few commits have fixed a decent number of call sites that pass
in the same value for `alloc` and `len` when attaching a string to a
strbuf, despite the documentation being quite clear about this not being
ok. As a result, all users currently pass in `len + 1`.

Because this interface was used incorrectly (albeit not necessarily
insecurely) before, simplify it by making `strbuf_attach()` simply assume that
the allocated length is exactly `len + 1`. If and when we do gain one or
two call sites that know better, we can either keep on using this
pessimistic assumption and it might not actually hurt much, or we could
give them a dedicated function similar to the current more flexible (and
proven error-prone) `strbuf_attach()`.

This means we can drop the call to `strbuf_grow()`. It really only
served to do the alloc+copy+free dance that we were supposedly avoiding.

That said, we should consider the edge case of `buf == NULL`. Let's
check for this and BUG. Even for a zero-length string, you need
somewhere to stick the trailing NUL.

(Also: If someone used to pass `alloc == len` for the case `len == 0`,
we used to end up leaking `buf` on the assumption that we were using
`strbuf_slopbuf`. Not the biggest leak ever, but still.)

Finally, one might wonder if we could go further and make
`strbuf_attach()` call `strlen()`. Some call sites wouldn't mind, but
others do have the length already and we might as well use it. Those
that don't have the length will figure it out as they call this
function. Before this commit, they'd do two calls to `strlen()` so they
either didn't care much or they trusted the compiler to optimize for
them. They're not any worse off now.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 strbuf.h             | 16 ++++++++--------
 apply.c              |  2 +-
 archive.c            |  2 +-
 blame.c              |  2 +-
 builtin/am.c         |  2 +-
 convert.c            |  4 ++--
 imap-send.c          |  2 +-
 mailinfo.c           |  2 +-
 merge-recursive.c    |  2 +-
 path.c               |  3 +--
 pretty.c             |  4 ++--
 refs/files-backend.c |  2 +-
 strbuf.c             | 11 +++++++----
 trailer.c            |  3 +--
 14 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index ce8e49c0b2..72dcb43795 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -110,14 +110,14 @@ void strbuf_release(struct strbuf *sb);
 char *strbuf_detach(struct strbuf *sb, size_t *sz);
 
 /**
- * Attach a string to a buffer. You should specify the string to attach,
- * the current length of the string and the amount of allocated memory.
- * The amount must be larger than the string length, because the string you
- * pass is supposed to be a NUL-terminated string.  This string _must_ be
- * malloc()ed, and after attaching, the pointer cannot be relied upon
- * anymore, and neither be free()d directly.
- */
-void strbuf_attach(struct strbuf *sb, void *str, size_t len, size_t mem);
+ * Attach a string to a buffer. You should specify the string to attach
+ * and its length. The amount of allocated memory will be assumed to be
+ * one greater than the length. The string you pass is supposed to be a
+ * NUL-terminated string.  This string _must_ be malloc()ed, and after
+ * attaching, the pointer cannot be relied upon anymore, nor should it
+ * be free()d directly.
+ */
+void strbuf_attach(struct strbuf *sb, void *str, size_t len);
 
 /**
  * Swap the contents of two string buffers.
diff --git a/apply.c b/apply.c
index 144c19aaca..678cee5535 100644
--- a/apply.c
+++ b/apply.c
@@ -3251,7 +3251,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
-		strbuf_attach(buf, result, sz, sz + 1);
+		strbuf_attach(buf, result, sz);
 	}
 	return 0;
 }
diff --git a/archive.c b/archive.c
index fb39706120..bef66f8574 100644
--- a/archive.c
+++ b/archive.c
@@ -89,7 +89,7 @@ void *object_file_to_archive(const struct archiver_args *args,
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
 
-		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
+		strbuf_attach(&buf, buffer, *sizep);
 		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, &meta);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
diff --git a/blame.c b/blame.c
index 29770e5c81..64218c2c6e 100644
--- a/blame.c
+++ b/blame.c
@@ -241,7 +241,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		case S_IFREG:
 			if (opt->flags.allow_textconv &&
 			    textconv_object(r, read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
-				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
+				strbuf_attach(&buf, buf_ptr, buf_len);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
 			break;
diff --git a/builtin/am.c b/builtin/am.c
index e6a9fe8111..0986ea4af2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1101,7 +1101,7 @@ static void am_append_signoff(struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len + 1);
+	strbuf_attach(&sb, state->msg, state->msg_len);
 	append_signoff(&sb, 0, 0);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
diff --git a/convert.c b/convert.c
index 5aa87d45e3..ee1941c662 100644
--- a/convert.c
+++ b/convert.c
@@ -467,7 +467,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		free(re_src);
 	}
 
-	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	strbuf_attach(buf, dst, dst_len);
 	return 1;
 }
 
@@ -492,7 +492,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 		return 0;
 	}
 
-	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	strbuf_attach(buf, dst, dst_len);
 	return 1;
 }
 
diff --git a/imap-send.c b/imap-send.c
index 6c54d8c29d..b36b9ff62d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1212,7 +1212,7 @@ static void lf_to_crlf(struct strbuf *msg)
 			new_msg[j++] = '\r';
 		lastc = new_msg[j++] = msg->buf[i];
 	}
-	strbuf_attach(msg, new_msg, j, j + 1);
+	strbuf_attach(msg, new_msg, j);
 }
 
 /*
diff --git a/mailinfo.c b/mailinfo.c
index af5d2cad31..cdcb6af8c1 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -459,7 +459,7 @@ static int convert_to_utf8(struct mailinfo *mi,
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, strlen(out), strlen(out) + 1);
+	strbuf_attach(line, out, strlen(out));
 	return 0;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index d92e2acf1e..5cdd797ada 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2963,7 +2963,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 		free(buf);
 		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
 	}
-	strbuf_attach(dst, buf, size, size + 1);
+	strbuf_attach(dst, buf, size);
 	return 0;
 }
 
diff --git a/path.c b/path.c
index 5745a71d36..5474bbd079 100644
--- a/path.c
+++ b/path.c
@@ -815,8 +815,7 @@ const char *enter_repo(const char *path, int strict)
 			char *newpath = expand_user_path(used_path.buf, 0);
 			if (!newpath)
 				return NULL;
-			strbuf_attach(&used_path, newpath, strlen(newpath),
-				      strlen(newpath) + 1);
+			strbuf_attach(&used_path, newpath, strlen(newpath));
 		}
 		for (i = 0; suffix[i]; i++) {
 			struct stat st;
diff --git a/pretty.c b/pretty.c
index 28afc701b6..e1abe8ac89 100644
--- a/pretty.c
+++ b/pretty.c
@@ -590,7 +590,7 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 		return buf; /* should not happen but be defensive */
 	len = cp + 1 - (buf + start);
 
-	strbuf_attach(&tmp, buf, strlen(buf), strlen(buf) + 1);
+	strbuf_attach(&tmp, buf, strlen(buf));
 	if (is_encoding_utf8(encoding)) {
 		/* we have re-coded to UTF-8; drop the header */
 		strbuf_remove(&tmp, start, len);
@@ -1687,7 +1687,7 @@ void repo_format_commit_message(struct repository *r,
 		char *out = reencode_string_len(sb->buf, sb->len,
 						output_enc, utf8, &outsz);
 		if (out)
-			strbuf_attach(sb, out, outsz, outsz + 1);
+			strbuf_attach(sb, out, outsz);
 	}
 
 	free(context.commit_encoding);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 76bb2ef490..4ce9f2cda4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1514,7 +1514,7 @@ static int commit_ref(struct ref_lock *lock)
 		size_t len = strlen(path);
 		struct strbuf sb_path = STRBUF_INIT;
 
-		strbuf_attach(&sb_path, path, len, len + 1);
+		strbuf_attach(&sb_path, path, len);
 
 		/*
 		 * If this fails, commit_lock_file() will also fail
diff --git a/strbuf.c b/strbuf.c
index deb338412e..e74253f91d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -77,13 +77,16 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 	return res;
 }
 
-void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
+void strbuf_attach(struct strbuf *sb, void *buf, size_t len)
 {
+	if (!buf)
+		BUG("NULL-buffer in strbuf_attach");
+	if (unsigned_add_overflows(len, 1))
+		die("you want to use way too much memory");
 	strbuf_release(sb);
 	sb->buf   = buf;
 	sb->len   = len;
-	sb->alloc = alloc;
-	strbuf_grow(sb, 0);
+	sb->alloc = len + 1;
 	sb->buf[sb->len] = '\0';
 }
 
@@ -152,7 +155,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 	if (!out)
 		return -1;
 
-	strbuf_attach(sb, out, len, len + 1);
+	strbuf_attach(sb, out, len);
 	return 0;
 }
 
diff --git a/trailer.c b/trailer.c
index 135f71aef1..30bc622723 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1095,8 +1095,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	for (ptr = trailer_lines; *ptr; ptr++) {
 		if (last && isspace((*ptr)->buf[0])) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last),
-				      strlen(*last) + 1);
+			strbuf_attach(&sb, *last, strlen(*last));
 			strbuf_addbuf(&sb, *ptr);
 			*last = strbuf_detach(&sb, NULL);
 			continue;
-- 
2.26.1

