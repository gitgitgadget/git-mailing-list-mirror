Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1439B1F424
	for <e@80x24.org>; Wed,  9 May 2018 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965387AbeEIU4a (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 16:56:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43910 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935200AbeEIU42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 16:56:28 -0400
Received: by mail-wr0-f195.google.com with SMTP id v15-v6so36812844wrm.10
        for <git@vger.kernel.org>; Wed, 09 May 2018 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAtDpnOCyWLL0Q0m22Qpl+i+N3fLvhPdVN1YtU/BHq8=;
        b=SnlHQ/7OYj9g/FdlAyXblcEWEuA2iiZMziqpA37gCEGYxCkrAsuu3kvrCce8wDS2Hs
         xT7b1d9D9ft2UhoEuJFNJCnjc9C6LzeuC0MU1Zeb8f5+SU8yrxxYW7zrZGZWpifetbGD
         8WfaPH+BaI9iBqneIO/TCfGVEl/rUfwXwjzyKsBZiMv31gI7Ik78EcNAOO2FjCDlJVx0
         1XcVtyIjGGxvfVpKs/ABw0znjvfx++MyYUIAQ5t/qw4aP6RHH+XxiuWYt1MF5c4f9Ure
         EI4KOQZo8nMNPGP3C252U/SykGrbDtOBZl913YRpt9AMVyrgoDRBtgb7eukG42ir2+b6
         L/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAtDpnOCyWLL0Q0m22Qpl+i+N3fLvhPdVN1YtU/BHq8=;
        b=XsNmE0PGmaGcGJuDx/Qxn3WlX+PVfPzCEYsSQ9UOA5vASp0j3qVlpsPeHjxdwUUfDT
         ZQaW9KmUEBqHUmfASTm1E7ITV7qasRDPG8QxLAOJFjzn8EEZgLj5eie46u8+fkXbWNb8
         4yv4ollnPpz+Oqgf7UMS5S5GvzwGoFyUvGbz53klRBVfk4uXNxibUuk/jpfjwuPJin4N
         Q85749GwD7WtThV+zQav2FiovWOm+Zc8yTb6l+yIJVPHM5t86k4ugR4+V2LqHTirQG3Q
         UhFlCmiXqTeviumfZxNfEzO51bDcAgRa02zht1qEeUsskmcNUrNw/FmpZtWFZPoXsR6I
         QgzQ==
X-Gm-Message-State: ALQs6tAbrCaytsEBlXtL8GgatQLZMW3eMWxawDsoKAx2s6JpDvQh57co
        SW9nfALJVw1RDGQ4Jshq7GA=
X-Google-Smtp-Source: AB8JxZo8zI7WlixnrWDYttb8tMerahPu2Say2YeybjcY21ty0V7y1UvM0KcKfYrwQQVhmpOIKEptVw==
X-Received: by 2002:adf:d1cc:: with SMTP id m12-v6mr29767563wri.214.1525899387463;
        Wed, 09 May 2018 13:56:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id r14-v6sm40073008wra.41.2018.05.09.13.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 May 2018 13:56:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/5] refs.c: do not die if locking fails in `write_pseudoref()`
Date:   Wed,  9 May 2018 22:55:36 +0200
Message-Id: <c1240491bc9029e2a72b0330a85820c1c272f537.1525898125.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
In-Reply-To: <cover.1525898125.git.martin.agren@gmail.com>
References: <20180508182548.GD7210@sigill.intra.peff.net> <cover.1525898125.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we could not take the lock, we add an error to the `strbuf err` and
return. However, this code is dead. The reason is that we take the lock
using `LOCK_DIE_ON_ERROR`. Drop the flag to allow our more gentle
error-handling to actually kick in.

We could instead just drop the dead code and die here. But everything is
prepared for gently propagating the error, so let's do that instead.

There is similar dead code in `delete_pseudoref()`, but let's save that
for the next patch.

While at it, make the lock non-static. (Placing `struct lock_file`s on
the stack used to be a bad idea, because the temp- and
lockfile-machinery would keep a pointer into the struct. But after
076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05), we
can safely have lockfiles on the stack.)

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8b7a77fe5e..8c50b8b139 100644
--- a/refs.c
+++ b/refs.c
@@ -644,7 +644,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 {
 	const char *filename;
 	int fd;
-	static struct lock_file lock;
+	struct lock_file lock = LOCK_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	int ret = -1;
 
@@ -654,8 +654,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 
 	filename = git_path("%s", pseudoref);
-	fd = hold_lock_file_for_update_timeout(&lock, filename,
-					       LOCK_DIE_ON_ERROR,
+	fd = hold_lock_file_for_update_timeout(&lock, filename, 0,
 					       get_files_ref_lock_timeout_ms());
 	if (fd < 0) {
 		strbuf_addf(err, "could not open '%s' for writing: %s",
-- 
2.17.0.411.g9fd64c8e46

