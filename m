Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACBC3A5A0
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D66214D8
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rclp7PEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDSMcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDSMcy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:32:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C555C061A0F
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m2so5555532lfo.6
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+N+04sq4fMELZipbi9nzCgI/nPNQSn6R7zicJ3dKUk=;
        b=Rclp7PEQG/Qgne8dsW/2wdlNWJ6pe45PD/rSi40Kz68aO/GtMxai5/B1mPZzKfYsej
         vpMQCd04jmi//UqzXJFFHw/07pY6p4YeAgvGZUjcfrCoJGEQGzmKSvOq139xiQuZXm35
         qNRDysYS5VDQtCZCPHI2R9EAkk7HY4Txq+qYPhG9M1CHl+pMxlwbT6gNi7/ujB50EdyF
         H6q3OO1iyvFSbKckgNYxKaOkz4pMfhBX+PyBnPGyUvxBDIMvZ1qVFiXl2WBA/3qyv8qL
         Y6EAPl4SvZ10WzyXDTHQwhEibvo+WmvcPR8N4bdoqxqmHgsuxl/VzDg7gjsSwPgXWVUl
         vazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+N+04sq4fMELZipbi9nzCgI/nPNQSn6R7zicJ3dKUk=;
        b=Zz/TT9MWguInAi2ExmdQCDI1ohG81Esy3tRpZcAR1BGTXk77oVmWWcLbDkfyl+ISDH
         IGCffrNQrAbpKvNz4Du1T6/UP+Eh7mGR7MjArs7BP6JeOVSx8AZIA7nDf2cXd7tt3zJR
         N6QHQE/85eS+d9LUSp0qHVQJmvZsptrVzTvu8WxcypqZANRANaFR6PBw6TwaMSXCXaFG
         19HPPzlizrtwIJWqlNl3GNr5S5TVeYYIVrepTUAIfNH5t6T0t9ncbQz+NuiRXHhwTQIO
         DWbqmR5nREc5WexU1grals3T9ptKRv5Bs42NMqxhCw5RIKGnx4xmzcMKRYV9tt2X/8H5
         mMTQ==
X-Gm-Message-State: AGi0PuY7dSd4PGtHw2tFBcE4gUPZ8+hy/fyCXlAJhl7sSfbnRG3j7s3y
        oEBgbsVN8V81/kdklyONfqMqv5Yr
X-Google-Smtp-Source: APiQypJfCPl6m0RUrjMdzuLUj2tKSXWFLm43hg4TZS0/NOUN7pWJEi1R5TSKInjDdzM8NDo6SpydDA==
X-Received: by 2002:a19:e04a:: with SMTP id g10mr7365457lfj.164.1587299571508;
        Sun, 19 Apr 2020 05:32:51 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm1843547ljj.72.2020.04.19.05.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 05:32:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/4] strbuf: introduce `strbuf_attachstr_len()`
Date:   Sun, 19 Apr 2020 14:32:28 +0200
Message-Id: <d9db28d6e6616017a4a8e57508d166ab5aa2f185.1587297254.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587297254.git.martin.agren@gmail.com>
References: <cover.1587240635.git.martin.agren@gmail.com> <cover.1587297254.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most callers of `strbuf_attach()` provide `len + 1` for the `mem`
parameter. That's a bit tedious and, as we will see in the next commit,
also fairly prone to mistakes.

Provide `strbuf_attachstr_len()` for this common case to simplify
several callers of `strbuf_attach()` by making this new function simply
assume that the size of the allocated buffer is one greater than the
length.

We know that the string has already been allocated with space for the
trailing NUL, meaning it is safe to compute `len + 1`.

Disallow NULL-pointers entirely. We could handle `(buf, len) == (NULL,
0)` specially, but none of the callers we convert here seem to worry
about such a case. Handling this corner case specially can still be done
using the regular `strbuf_attach()`.

Another edge case is where someone doesn't have a NUL at `buf[len]`,
i.e., they are (hopefully) trying to attach a substring of some larger
string. One could argue that they should be using `strbuf_attach()` and
that this is BUG-worthy, or that it would be easy enough for us to place
a NUL there for robustness and carry on. This commit does the latter,
but does not have a strong opinion about it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 strbuf.h          | 19 +++++++++++++++++++
 apply.c           |  2 +-
 archive.c         |  2 +-
 blame.c           |  2 +-
 convert.c         |  4 ++--
 imap-send.c       |  2 +-
 merge-recursive.c |  2 +-
 pretty.c          |  2 +-
 8 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 2a462f70cc..7d0aeda434 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -121,6 +121,25 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz);
  */
 void strbuf_attach(struct strbuf *sb, void *str, size_t len, size_t mem);
 
+/**
+ * Attach a string to a buffer. You should specify the string to attach
+ * and its length.
+ *
+ * The amount of allocated memory will be assumed to be one greater than
+ * its length. The string you pass _must_ be a NUL-terminated string.
+ * This string _must_ be malloc()ed, and after attaching, the pointer
+ * cannot be relied upon anymore, nor should it be free()d directly.
+ *
+ * Do _not_ use this to truncate the string. That is, the length really
+ * must be `len` already. To truncate (yet keeping track of the amount
+ * of allocated memory), use `strbuf_attach()`.
+ */
+static inline void strbuf_attachstr_len(struct strbuf *sb,
+					char *str, size_t len)
+{
+	strbuf_attach(sb, str, len, len + 1);
+}
+
 /**
  * Swap the contents of two string buffers.
  */
diff --git a/apply.c b/apply.c
index 144c19aaca..cab4055ea4 100644
--- a/apply.c
+++ b/apply.c
@@ -3251,7 +3251,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
-		strbuf_attach(buf, result, sz, sz + 1);
+		strbuf_attachstr_len(buf, result, sz);
 	}
 	return 0;
 }
diff --git a/archive.c b/archive.c
index fb39706120..17b8add930 100644
--- a/archive.c
+++ b/archive.c
@@ -89,7 +89,7 @@ void *object_file_to_archive(const struct archiver_args *args,
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
 
-		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
+		strbuf_attachstr_len(&buf, buffer, *sizep);
 		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, &meta);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
diff --git a/blame.c b/blame.c
index 29770e5c81..12ce104fcb 100644
--- a/blame.c
+++ b/blame.c
@@ -241,7 +241,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		case S_IFREG:
 			if (opt->flags.allow_textconv &&
 			    textconv_object(r, read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
-				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
+				strbuf_attachstr_len(&buf, buf_ptr, buf_len);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
 			break;
diff --git a/convert.c b/convert.c
index 5aa87d45e3..9b3a1218a7 100644
--- a/convert.c
+++ b/convert.c
@@ -467,7 +467,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		free(re_src);
 	}
 
-	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	strbuf_attachstr_len(buf, dst, dst_len);
 	return 1;
 }
 
@@ -492,7 +492,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 		return 0;
 	}
 
-	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	strbuf_attachstr_len(buf, dst, dst_len);
 	return 1;
 }
 
diff --git a/imap-send.c b/imap-send.c
index 6c54d8c29d..37e5b13e51 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1212,7 +1212,7 @@ static void lf_to_crlf(struct strbuf *msg)
 			new_msg[j++] = '\r';
 		lastc = new_msg[j++] = msg->buf[i];
 	}
-	strbuf_attach(msg, new_msg, j, j + 1);
+	strbuf_attachstr_len(msg, new_msg, j);
 }
 
 /*
diff --git a/merge-recursive.c b/merge-recursive.c
index d92e2acf1e..ef259e4b74 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2963,7 +2963,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 		free(buf);
 		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
 	}
-	strbuf_attach(dst, buf, size, size + 1);
+	strbuf_attachstr_len(dst, buf, size);
 	return 0;
 }
 
diff --git a/pretty.c b/pretty.c
index 28afc701b6..e171830389 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1687,7 +1687,7 @@ void repo_format_commit_message(struct repository *r,
 		char *out = reencode_string_len(sb->buf, sb->len,
 						output_enc, utf8, &outsz);
 		if (out)
-			strbuf_attach(sb, out, outsz, outsz + 1);
+			strbuf_attachstr_len(sb, out, outsz);
 	}
 
 	free(context.commit_encoding);
-- 
2.26.1

