Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FAE784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjJBClb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjJBClO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948CF1AE
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fd60f40ebso60584139f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214456; x=1696819256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK/zLNASM4NMsxXUNo/o2FZi7vdcD789Xby5LHgAm5U=;
        b=P33xejOGwnr30LxIuS0Qccz+r8b8AhWbZ57QBzaAYjOZ2SuC856ZXFgmlDiE1ltg3D
         gFn6YTMebvXg45JJDtYdN+XiMwtbMWgbf7w4Os1Hp3jdWVElRbgB8gU3CIM8tP93/X7B
         j39xpYerJj7ON+Zq8BvbAyJz6AF6+zSycn71yND0DgttrZnsBlaXYQHARCycLtn9efGO
         CQLY8Iw3veeGvHEHQy6far4pn4aCBG2mW+yRtYXIAtli6oQmNR5juWZMn6iaNSTWE/o1
         acfSJw6nPTmGGgB9x6jeBTfN+SvF58XKPVX1xwo2mw+cvjR3+I9/Q+RqEOeJ6fBhPO04
         h/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214456; x=1696819256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK/zLNASM4NMsxXUNo/o2FZi7vdcD789Xby5LHgAm5U=;
        b=Z5TojZ/xZzDpG/S2nCwuP6aNoxPvPcLBxdlJql9DgOnAOt0e+q/7ZYdb6IR6nKNQZe
         mCTEwTs0z8fOQ/tuke31YC1uYBJi9zqzTfzf98evWl7XOK6gEXa8CHx0jeMzco+ThG49
         2hsLyAtmKbRfpf9uunnQSGtmE3b0jSoe7LFJGk9yxxM4+5lBtvfjXpSoCEhCN/PAtmxr
         Y4IoqtQAu9U5cWUL+EpxXgN0jf/FyNPo2opBf0LyNbfmtySkOGr/tl2yCxKmgn/8y9Ba
         GgKHS+R/IQ0M3D9lWd2YPRdYjFT4dpRi+yFPLneOGo+RUGCQvfF8TatNKZybmPUyXfCp
         SI8A==
X-Gm-Message-State: AOJu0YxMvGl9HgCnVZmq4mohGbOr85w0VlTjIdWrePsd/9cVf78ePmzQ
        IiuNjE/M3/k+pl72kENTVjg=
X-Google-Smtp-Source: AGHT+IFPRUsi71V0djRGPFXsumG2NBynXmv7GJ1DawCQGQvFaUmO/mjF620UlBXpgxI4/4T6KtESsg==
X-Received: by 2002:a5e:a519:0:b0:79f:b4f1:186a with SMTP id 25-20020a5ea519000000b0079fb4f1186amr8714929iog.1.1696214455890;
        Sun, 01 Oct 2023 19:40:55 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:55 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 19/30] object-file-convert: convert commits that embed signed tags
Date:   Sun,  1 Oct 2023 21:40:23 -0500
Message-Id: <20231002024034.2611-19-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

As mentioned in the hash function transition plan commit mergetag
lines need to be handled.  The commit mergetag lines embed an entire
tag object in a commit object.

Keep the implementation sane if not fast by unembedding the tag
object, converting the tag object, and embedding the new tag object,
in the new commit object.

In the long run I don't expect any other approach is maintainable, as
tag objects may be extended in ways that require additional
translation.

To keep the implementation of convert_commit_object maintainable I
have modified convert_commit_object to process the lines in any order,
and to fail on unknown lines.  We can't know ahead of time if a new
line might embed something that needs translation or not so it is
better to fail and require the code to be updated instead of silently
mistranslating objects.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 104 +++++++++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 22 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 0da081104ed4..4f6189095be8 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -146,35 +146,95 @@ static int convert_commit_object(struct strbuf *out,
 	const int tree_entry_len = from->hexsz + 5;
 	const int parent_entry_len = from->hexsz + 7;
 	struct object_id oid, mapped_oid;
-	const char *p;
+	const char *p, *eol;
 
 	tail += size;
-	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
-			bufptr[tree_entry_len] != '\n')
-		return error("bogus commit object");
-	if (parse_oid_hex_algop(bufptr + 5, &oid, &p, from) < 0)
-		return error("bad tree pointer");
 
-	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
-		return error("unable to map tree %s in commit object",
-			     oid_to_hex(&oid));
-	strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
-	bufptr = p + 1;
+	while ((bufptr < tail) && (*bufptr != '\n')) {
+		eol = memchr(bufptr, '\n', tail - bufptr);
+		if (!eol)
+			return error(_("bad %s in commit"), "line");
+
+		if (((bufptr + 5) < eol) && !memcmp(bufptr, "tree ", 5))
+		{
+			if (((bufptr + tree_entry_len) != eol) ||
+			    parse_oid_hex_algop(bufptr + 5, &oid, &p, from) ||
+			    (p != eol))
+				return error(_("bad %s in commit"), "tree");
+
+			if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+				return error(_("unable to map %s %s in commit object"),
+					     "tree", oid_to_hex(&oid));
+			strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
+		}
+		else if (((bufptr + 7) < eol) && !memcmp(bufptr, "parent ", 7))
+		{
+			if (((bufptr + parent_entry_len) != eol) ||
+			    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
+			    (p != eol))
+				return error(_("bad %s in commit"), "parent");
 
-	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
-		if (tail <= bufptr + parent_entry_len + 1 ||
-		    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
-		    *p != '\n')
-			return error("bad parents in commit");
+			if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+				return error(_("unable to map %s %s in commit object"),
+					     "parent", oid_to_hex(&oid));
 
-		if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
-			return error("unable to map parent %s in commit object",
-				     oid_to_hex(&oid));
+			strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
+		}
+		else if (((bufptr + 9) < eol) && !memcmp(bufptr, "mergetag ", 9))
+		{
+			struct strbuf tag = STRBUF_INIT, new_tag = STRBUF_INIT;
 
-		strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
-		bufptr = p + 1;
+			/* Recover the tag object from the mergetag */
+			strbuf_add(&tag, bufptr + 9, (eol - (bufptr + 9)) + 1);
+
+			bufptr = eol + 1;
+			while ((bufptr < tail) && (*bufptr == ' ')) {
+				eol = memchr(bufptr, '\n', tail - bufptr);
+				if (!eol) {
+					strbuf_release(&tag);
+					return error(_("bad %s in commit"), "mergetag continuation");
+				}
+				strbuf_add(&tag, bufptr + 1, (eol - (bufptr + 1)) + 1);
+				bufptr = eol + 1;
+			}
+
+			/* Compute the new tag object */
+			if (convert_tag_object(&new_tag, from, to, tag.buf, tag.len)) {
+				strbuf_release(&tag);
+				strbuf_release(&new_tag);
+				return -1;
+			}
+
+			/* Write the new mergetag */
+			strbuf_addstr(out, "mergetag");
+			strbuf_add_lines(out, " ", new_tag.buf, new_tag.len);
+			strbuf_release(&tag);
+			strbuf_release(&new_tag);
+		}
+		else if (((bufptr + 7) < tail) && !memcmp(bufptr, "author ", 7))
+			strbuf_add(out, bufptr, (eol - bufptr) + 1);
+		else if (((bufptr + 10) < tail) && !memcmp(bufptr, "committer ", 10))
+			strbuf_add(out, bufptr, (eol - bufptr) + 1);
+		else if (((bufptr + 9) < tail) && !memcmp(bufptr, "encoding ", 9))
+			strbuf_add(out, bufptr, (eol - bufptr) + 1);
+		else if (((bufptr + 6) < tail) && !memcmp(bufptr, "gpgsig", 6))
+			strbuf_add(out, bufptr, (eol - bufptr) + 1);
+		else {
+			/* Unknown line fail it might embed an oid */
+			return -1;
+		}
+		/* Consume any trailing continuation lines */
+		bufptr = eol + 1;
+		while ((bufptr < tail) && (*bufptr == ' ')) {
+			eol = memchr(bufptr, '\n', tail - bufptr);
+			if (!eol)
+				return error(_("bad %s in commit"), "continuation");
+			strbuf_add(out, bufptr, (eol - bufptr) + 1);
+			bufptr = eol + 1;
+		}
 	}
-	strbuf_add(out, bufptr, tail - bufptr);
+	if (bufptr < tail)
+		strbuf_add(out, bufptr, tail - bufptr);
 	return 0;
 }
 
-- 
2.41.0

