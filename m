Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A5C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903F2083B
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jvDDNRF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgBOVea (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:34:30 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45226 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgBOVe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:34:29 -0500
Received: by mail-qv1-f66.google.com with SMTP id l14so5959600qvu.12
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CY75xxh9Otw3y5X8gFoWhIG98FQnsPDpzWq9PuEmhQ=;
        b=jvDDNRF4jWgnCTEnHruk8raqlJwi8QpZ4+PA/S3lnR3V9hdgJR6SFx6I8LQ7nHIY8N
         39FIyVDTRu2umBHcfaxN+j5yP/sbxF1SBTrGKODfPFsKlxOLviDysYwIXFsJp80FoxTy
         qG68HopFBSITKb7dsmmK+VSJSjmHEXoBUeAbuVziSFo3dErsiRdqboHS3FKZMGWddftq
         HNynsk/YxqssERO440FRxTgjgQ7kiVZySpsFUGVs+asHyyePKDiSchrD5MpcUo4LRCa4
         9+mdpf3QBMIn+oxukFOG96K0K3OH7HOjtUGgjcvbRtDBtNtnxT7XO7JODNBkjib4TJkO
         HMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CY75xxh9Otw3y5X8gFoWhIG98FQnsPDpzWq9PuEmhQ=;
        b=IqWbQx6E5x1S87/MZ/KXWR0gF/GvDJepyQVKrxwkzO7lV+dMM63lSvAFzbfo+ksItA
         awNzLKSjyDVJnQswYr5K6CQkqIj45nURiWj+wVjIm9RZLKLUYKGwM0ljN5ZQo1xGXjy3
         SDuHKSOmlj23y96U8DLbQUf2BLmGGZt4tJqJK9VOUMh8z+aLY++xREvqxU7GHYuMhhZz
         edPIx2fGunAqc6NSjRqy3N9ESZdpLswiuOCQ/VEtBM11+KubdLMz4JthkOuo8AztGovM
         nXzo1BFosCVcW3wT+CQ5HDQDGkSVqSjCbI7G2rA1hxe7xM1Wx6vUFgM8OSP8lfUUqv6e
         tdRA==
X-Gm-Message-State: APjAAAVhvn8B/3MYS66S4LdTerpJ0yTp1GPYhKKVMY+CPvqixXGXr7KT
        9sfV0mNhmEir46KBaxwE3/J3ZooBbXk=
X-Google-Smtp-Source: APXvYqw6J0d+P1SVKo6kwzOfDOPn8og66vGk2Xal/D2Ng+3Oyv9FiqARdt9zGiz4cypNTwWqj1FU9A==
X-Received: by 2002:a05:6214:6aa:: with SMTP id s10mr7580662qvz.138.1581802466427;
        Sat, 15 Feb 2020 13:34:26 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id c17sm5962244qko.134.2020.02.15.13.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:34:25 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, rhi@pengutronix.de
Subject: [PATCH] describe: output tag's ref instead of embedded name
Date:   Sat, 15 Feb 2020 18:34:13 -0300
Message-Id: <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a tag describes a commit, we currently output not the tag's ref but
its embedded name. This means that when the tag is locally stored under
a different name, the output given cannot be used to access the tag in
any way. A warning is also emitted in this case, but the message is not
very enlightening:

$ git tag -am "testing tag body" testing-tag
$ mv .git/refs/tags/testing-tag .git/refs/tags/testing-tag-with-new-name
$ git describe --tags --abbrev=0
warning: tag 'testing-tag' is really 'testing-tag-with-new-name' here
testing-tag

Let's make git-describe output the tag's local name instead and
rephrase the warning to reflect the situation a little better.

Since the embedded name will no longer be needed for correct output, we
can convert the die() call in append_name() when a tag doesn't have the
embedded name to a warning(). Also, this function will now have two
disconnected responsibilities: verifying if the tag's embedded name
matches the ref and actually appending the ref to a given buffer (which
does not depend on the parsed tag object itself). Thus, to increase
intelligibility, let's make the function specialize in the former and do
the latter outside it.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/describe.c  | 23 ++++++++---------------
 t/t6120-describe.sh |  4 ++--
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b6df81d8d0..6a11604d2e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -267,7 +267,7 @@ static unsigned long finish_depth_computation(
 	return seen_commits;
 }
 
-static void append_name(struct commit_name *n, struct strbuf *dst)
+static void verify_tag_embedded_name(struct commit_name *n)
 {
 	if (n->prio == 2 && !n->tag) {
 		n->tag = lookup_tag(the_repository, &n->oid);
@@ -276,19 +276,11 @@ static void append_name(struct commit_name *n, struct strbuf *dst)
 	}
 	if (n->tag && !n->name_checked) {
 		if (!n->tag->tag)
-			die(_("annotated tag %s has no embedded name"), n->path);
-		if (strcmp(n->tag->tag, all ? n->path + 5 : n->path))
-			warning(_("tag '%s' is really '%s' here"), n->tag->tag, n->path);
+			warning(_("annotated tag %s has no embedded name"), n->path);
+		else if (strcmp(n->tag->tag, all ? n->path + 5 : n->path))
+			warning(_("tag '%s' is externally known as '%s'"), n->path, n->tag->tag);
 		n->name_checked = 1;
 	}
-
-	if (n->tag) {
-		if (all)
-			strbuf_addstr(dst, "tags/");
-		strbuf_addstr(dst, n->tag->tag);
-	} else {
-		strbuf_addstr(dst, n->path);
-	}
 }
 
 static void append_suffix(int depth, const struct object_id *oid, struct strbuf *dst)
@@ -313,7 +305,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		/*
 		 * Exact match to an existing ref.
 		 */
-		append_name(n, dst);
+		verify_tag_embedded_name(n);
+		strbuf_addstr(dst, n->path);
 		if (longformat)
 			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : oid, dst);
 		if (suffix)
@@ -447,8 +440,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 				oid_to_hex(&gave_up_on->object.oid));
 		}
 	}
-
-	append_name(all_matches[0].name, dst);
+	verify_tag_embedded_name(all_matches[0].name);
+	strbuf_addstr(dst, all_matches[0].name->path);
 	if (abbrev)
 		append_suffix(all_matches[0].depth, &cmit->object.oid, dst);
 	if (suffix)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 09c50f3f04..d34c091e0b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -129,9 +129,9 @@ test_expect_success 'rename tag A to Q locally' '
 	mv .git/refs/tags/A .git/refs/tags/Q
 '
 cat - >err.expect <<EOF
-warning: tag 'A' is really 'Q' here
+warning: tag 'Q' is externally known as 'A'
 EOF
-check_describe A-* HEAD
+check_describe Q-* HEAD
 test_expect_success 'warning was displayed for Q' '
 	test_i18ncmp err.expect err.actual
 '
-- 
2.25.0

