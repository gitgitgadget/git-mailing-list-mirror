Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D831F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 18:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfJHSrq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 14:47:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41116 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 14:47:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so17745942qkg.8
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCPjhvsxKdlD2n5BYD1rxmP+Hwn0cTQ8TkcetDMY1bA=;
        b=PHUW1ceAV4D4o9bjHsG17qrPh32EJ76TS3HvlNQxz96pPxtTVhUsB73AH0vnvZuqK3
         Nil0dYFg2qfihXgvEvfgS6VHCmuL4AKtzZr5SfMv/8D6LElG8a4UgksROQLDIgtv+SrB
         httZg+ym6toAOPqYcxHfWHLMA1+ycgPgd79OMYmtVzD6RJ6ErFgI0qhUvunWcckgUINg
         Q/+NcbTmgO5Cns98i722udd2Q4cji+A6NZhIjq6b9NDADWHmgn1HrlDDoNU0UJL9hss1
         Q72UCx7+0kTRea2HenHtagLQl/w91Q0hSWJPI/OE23HsvMqFRHOZLk08q02yvPlwFMG8
         IM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCPjhvsxKdlD2n5BYD1rxmP+Hwn0cTQ8TkcetDMY1bA=;
        b=oDOmNljucZkP4swQsRWSdLFPoXUMPaM7gzgI0uMWhwhszxzX4jxKSU3g3gmUvN7/OV
         Dsi40GgZoiBfJBeWXmYVqdH+D9z2tYRMYnVMTuZE3AtxzE3+jNOwNkdzHgf4VZLBEPAt
         McSIZi29eN7JCIEu6pbxZ4PN1v5Qk3nflSP3J1B9f0QcDRKhULCcHpSKI6KnHi0jJ3Ra
         wk+jDO4+9z1m8wI2HEeOGkSz/r67MSuE++XeoFtjQgzJ299vG4fvgUeuP3RcmWM84k24
         W8rxDSqIp38mvhPem+WupENtjpkg1Vkytn0lS19i5Wnrg48kYfRACt9R3OksjnoqHGta
         pFmg==
X-Gm-Message-State: APjAAAUze7zZMB3zJx7GBBjQ8mQdzWqTdvZH9aMTR8hacJyZiaNL6D2V
        YCLbMbQG4vT+6f05MsJjV3ZP1d4z
X-Google-Smtp-Source: APXvYqz9Z8hTxlTCAWpCE+OO9mtfgrKlElaqNfY4Zsgah78ZSycXweNJ6Fv+yo+DWPu/loZN9iEzrQ==
X-Received: by 2002:a37:4e48:: with SMTP id c69mr30341527qkb.182.1570560465704;
        Tue, 08 Oct 2019 11:47:45 -0700 (PDT)
Received: from wall-e.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s16sm8185118qkg.40.2019.10.08.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:47:45 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     git@vger.kernel.org
Cc:     kernel-usp@googlegroups.com, rcdailey.lists@gmail.com,
        me@ttaylorr.com, peff@peff.net, matheus.bernardino@usp.br,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.dcf@gmail.com>
Subject: [RFC WIP PATCH 1/3] tag: factor out tag reading from write_tag_body()
Date:   Tue,  8 Oct 2019 15:47:25 -0300
Message-Id: <20191008184727.14337-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve code readability by moving tag reading to a new function called
get_tag_body, which will be used in the implementation of the git tag
--amend functionality.

Add warning in write_tag_body() in case the tag body is not successfully
recovered.

Co-authored-by: Bárbara Fernandes <barbara.dcf@gmail.com>
Signed-off-by: Bárbara Fernandes <barbara.dcf@gmail.com>
Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/tag.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c25382..e1e3549af9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -170,26 +170,52 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
 
-static void write_tag_body(int fd, const struct object_id *oid)
+/* 
+ * Returns the tag body of the given oid or NULL, in case of error. If size is
+ * not NULL it is assigned the body size in bytes (excluding the '\0').
+ */
+static char *get_tag_body(const struct object_id *oid, size_t *size) 
 {
-	unsigned long size;
+	unsigned long buf_size;
 	enum object_type type;
-	char *buf, *sp;
+	char *buf, *sp, *tag_body;
+	size_t tag_body_size, signature_offset;
 
-	buf = read_object_file(oid, &type, &size);
+	buf = read_object_file(oid, &type, &buf_size);
 	if (!buf)
-		return;
+		return NULL;
 	/* skip header */
 	sp = strstr(buf, "\n\n");
 
-	if (!sp || !size || type != OBJ_TAG) {
+	if (!sp || !buf_size || type != OBJ_TAG) {
 		free(buf);
-		return;
+		return NULL;
 	}
 	sp += 2; /* skip the 2 LFs */
-	write_or_die(fd, sp, parse_signature(sp, buf + size - sp));
+	signature_offset = parse_signature(sp, buf + buf_size - sp);
+	sp[signature_offset] = '\0';
 
+	/* detach sp from buf */
+	tag_body_size = strlen(sp) + 1;
+	tag_body = xmalloc(tag_body_size);
+	xsnprintf(tag_body, tag_body_size, "%s", sp);
 	free(buf);
+	if (size)
+		*size = tag_body_size - 1; /* exclude '\0' */
+	return tag_body;
+}
+
+static void write_tag_body(int fd, const struct object_id *oid)
+{
+	size_t size;
+	const char *tag_body = get_tag_body(oid, &size);
+
+	if (!tag_body) {
+		warning("failed to get tag body for %s", oid->hash);
+		return;
+	}
+	printf("tag_body: <%s>\n", tag_body);
+	write_or_die(fd, tag_body, size);
 }
 
 static int build_tag_object(struct strbuf *buf, int sign, struct object_id *result)
-- 
2.23.0

