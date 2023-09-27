Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8DE82CCE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjI0T4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjI0T4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E55CC7
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:05 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fa425855cso347637739f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844564; x=1696449364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhSn7P7v6ympvS94OsSp5itQ+Qg0o5Mo0tjhO0FEJvw=;
        b=HuZstK91NMmVGB2CG1oMa/6BAC2Ug8cOXmL09RsEzRu3R56R2GqnFORm+Bxl13GMER
         cmDmdAhWAGnsc/ttdNUBkbZdw5earXjvF1qozPf0/QpvNQNL5GGt51177iAPNlcknqPH
         KXLVtVG+8Hu6sjPuf8LKPljGghmF326beLgGXMNkLbMC61FFKACiY2HugcCYTyVoejzS
         Jl6CylbjHU5+3SxlwfibQQMrLs/uwuiGJwvbyOPPeilbnAH/Vsr9R0HpCFt6Ka6ikpFo
         WFULZgErwigkJiMqY9eS51ysd2BjoVDHtpsv3dTE9kiSnF+b2QE9MZgS69wonehvzlLI
         jp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844564; x=1696449364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhSn7P7v6ympvS94OsSp5itQ+Qg0o5Mo0tjhO0FEJvw=;
        b=f/2jhy8ZW+agqPTHJrfy0B4GhKjfG9wcFkcZM0nBc3TezvLegv0Os3F2adguW/axJu
         772BD+yGy+Wok8IycmavklFXAeqbaZb4ZAQJZUJA5eHg3f4qoz7eFbKdtgPJ6K71l1SF
         37cZ7jSg+AFFWs40eVz8reTk3wgf8S47TYKi+CissSd78qxMeo4QQZifQsCh2uY3U8qk
         mFmfvi2/daj7nVm+OGctbobo9ZivD/X9qMGSfJZVSATBNthFE5aWKU5GbIQnAbgjq2NK
         H+ILJz8NY9v1OqtIYAkjq09aAa+XpvV389JTr+DzyuCdp8RwQ2QQHdpEIS9VsnkXWj4r
         slNQ==
X-Gm-Message-State: AOJu0YyAmTAUITiVr6BGTzAGDEvEIM4yuO1ruAHrE7NzhBfHeyCNiyj1
        kpIhUDwHfSvN4XC//1ldt4nYToKcxHU=
X-Google-Smtp-Source: AGHT+IEf1cCnoOZ+2HhXUsSxk1Ja2qcS4BWUYFM2AeqSHgmwpOJ/zm5W5coK3BgRtC8FgB30elQKNA==
X-Received: by 2002:a6b:fe14:0:b0:787:4b5f:b6cf with SMTP id x20-20020a6bfe14000000b007874b5fb6cfmr3115877ioh.5.1695844564559;
        Wed, 27 Sep 2023 12:56:04 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:04 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 19/30] object-file-convert: Convert commits that embed signed tags
Date:   Wed, 27 Sep 2023 14:55:26 -0500
Message-Id: <20230927195537.1682-19-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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
index f53e14e5a170..8ede9889a7ab 100644
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

