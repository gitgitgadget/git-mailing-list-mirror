Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB9C2D0D1
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 22:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9FF20748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 22:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oleOLkWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfL2W1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 17:27:15 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44456 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfL2W1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 17:27:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so11806377qvg.11
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oEEfwVWkDhZjTlwpKVNYrr8kj+OdnY9ryddHHPIv6k=;
        b=oleOLkWu0nSyITpvoFriR2HdKkxMBoN93StH4X8BVhPvlI/Yintt0YuTm18KFzIU25
         OimVaC2M5Ci4nzvkifq8xMj/iLnnHJ3ptfoNdNpP7wjpirTCoAmavXwBUIJcjkr2i9te
         7Y4P6CmgvHmDh8iqGU0shttYf52o73cTR4tSyq6tNfLm1eE/GvKpkiyGchZo/6Vuoh2z
         OMRSwmps6dAodjl01POk2vMNdnUWMOFMypZ+azHqsJQJZNi82FTQUcFQZVzpqyPsVogV
         Wg5H5WOiG0jmZAhRD+ZmRSYJgv6I/yDee5/dqY/FLoxik16MAYebrRXhFGi7Wr6u5k7j
         7pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5oEEfwVWkDhZjTlwpKVNYrr8kj+OdnY9ryddHHPIv6k=;
        b=kh8ffUOxkhx+qPAM3K28zthB7xWWwYrOHh3ua0B5w7g2Uk+X0hkHvt9zcrlEqs6TZl
         z5EoAmh/3ujZcmZa/BK9oQIRGSchQRaKhD41oWHT9d6kjnYTp5Azb9fTu7oQiijuP7kl
         hHnyjjjsl3g7tr9RNfDIwtCvGYq65FCnw7TSVgTzLBkl+6ILDYioXwLsCSz/kyImIeiR
         AH5ouJ2ydSETWZ+he8nl1mI13ZJX79j7cVgxkB6Iyk58P2TlkpbMstCsOHcEzRXnPmPb
         GKCSznVvZgfh1OPYZRlorIirnJUfaPWF+CtlfzpP2eg+5tPCyXE5Puf6oayuJAlKfej/
         wP8A==
X-Gm-Message-State: APjAAAXdWBSFseGK88tTOcE5O/K1KjFbEBUJj6UlowOQMm5Njingyg+w
        2HbK8iDeh5Xq4ciL5ryUHGTovP5FS/n0Mg==
X-Google-Smtp-Source: APXvYqwQM53ouTdD/lXe43qtlBYiY1eM2yzAkUNou3eHGIeC8grg5Xih0WAmrr4UZ0Q1LWSgEywLwg==
X-Received: by 2002:a05:6214:42c:: with SMTP id a12mr47450732qvy.172.1577658433882;
        Sun, 29 Dec 2019 14:27:13 -0800 (PST)
Received: from vmi286618.contaboserver.net (vmi286618.contaboserver.net. [164.68.111.199])
        by smtp.gmail.com with ESMTPSA id w20sm13200640qtj.4.2019.12.29.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 14:27:13 -0800 (PST)
From:   Arnaud Bertrand <arnaud.bertrand@abalgo.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Arnaud Bertrand <xda@abalgo.com>
Subject: [RFC PATCH 1/1] Add branchname in commit header
Date:   Sun, 29 Dec 2019 23:26:33 +0100
Message-Id: <20191229222633.23815-2-arnaud.bertrand@abalgo.com>
X-Mailer: git-send-email 2.25.0.rc0.7.g17b02bf28a
In-Reply-To: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
References: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arnaud Bertrand <xda@abalgo.com>

Add the branchname in the commit header before the commit message
the following line is added:

branch <branchname>

where <branchname> comes from the function resolve_ref_unsafe("HEAD",...)
without the prefix refs/heads/
A placeholder is added to the pretty format "%Xb" to print the branch information,
X if for "extra-header" and can be use in the future for new features
b is of course for "branch"

the %Xb returns an empty string when branchname information is not found
---
 Documentation/pretty-formats.txt |  1 +
 commit.c                         | 11 +++++++++++
 pretty.c                         | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1a7212ce5a..bd52908f53 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -241,6 +241,7 @@ endif::git-rev-list[]
 '%gE':: reflog identity email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%gs':: reflog subject
+'%Xb':: branchname in which commit was done
 '%(trailers[:options])':: display the trailers of the body as
 			  interpreted by
 			  linkgit:git-interpret-trailers[1]. The
diff --git a/commit.c b/commit.c
index 434ec030d6..f64a0698be 100644
--- a/commit.c
+++ b/commit.c
@@ -1425,6 +1425,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
+	const char *branch = "Unknown";
+	int flags;
+	const char *lbranch =resolve_ref_unsafe("HEAD",0,NULL,&flags);
 
 	assert_oid_type(tree, OBJ_TREE);
 
@@ -1453,6 +1456,14 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
+	if (lbranch) {
+	   skip_prefix(lbranch,"refs/heads/",&branch);
+	   strbuf_addf(&buffer, "branch %s\n", branch);
+	}
+	else {
+	   strbuf_addf(&buffer, "branch Unknown\n");
+	}
+
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 
diff --git a/pretty.c b/pretty.c
index 305e903192..5961c39398 100644
--- a/pretty.c
+++ b/pretty.c
@@ -804,6 +804,7 @@ struct format_commit_context {
 
 	/* The following ones are relative to the result struct strbuf. */
 	size_t wrap_start;
+	char *branch;
 };
 
 static void parse_commit_header(struct format_commit_context *context)
@@ -1367,6 +1368,20 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	}
 
+
+	/* Now add extra header info */
+	if (placeholder[0] == 'X') {
+		switch (placeholder[1]) {
+		case 'b': /* branch ... */
+			c->branch = get_header(msg,"branch");
+			if (c->branch)
+				strbuf_addstr(sb, c->branch);
+			free(c->branch);
+			return 2;
+		}
+	}
+
+
 	/* Now we need to parse the commit message. */
 	if (!c->commit_message_parsed)
 		parse_commit_message(c);
-- 
2.25.0.rc0.7.g17b02bf28a

