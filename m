Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B921F453
	for <e@80x24.org>; Fri,  1 Feb 2019 13:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfBANzs (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 08:55:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33026 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBANzs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 08:55:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id a16so1590981wrv.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 05:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVUQcb83G17aUqobW9I0rJk/KlWSlXX0t/Cr1/LAYho=;
        b=bLGL3Wcua+iuAGRquHeE/uhvoZBkHoT9ISUOP67wgACpv66F8wuVjRUaYuwCMQhjbn
         4E3tJfxqghfiwufQu8Z6qFCsIQEH8IYI9ZGdZGz1qD0pRk+VZ2R6SfJ64a2lshrf3Jax
         y4OK3uxxSPdRWAItrfmMEmi1D2wvSVmBiI4bvV+H01DQhvyjnHdGEHW23E7Dcy93qYiO
         oTLfbmaavvXSgfoZsGsiqXTw246e6RcLD6OwF5f9o2If2x+FHd4NaATbGx1nBk5s/l8O
         hPLTzjhfLSbZy89TpZnwAPQlwQOiVl4ewbaV44oclPE1JptYD/ZM8Lg7FbqPDFi0V0Hn
         Hrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVUQcb83G17aUqobW9I0rJk/KlWSlXX0t/Cr1/LAYho=;
        b=jwwNo4Tvsd2bESRUzP9JI5B6lX/gmZgb5l47bK00sXPoamgR/D1G3X+TVqNSgYwy++
         CnE/b5exbzbA9XdHotlib5iSaYT9zqMz5+etMz5yoFVGM+oQ4zGXb0Xpru91NQYp9c5D
         2a1ceZRY6sSWnrDR79CMbU9K2ulqE3ST2ayCnwSLTuOmwsDtXFfz1DkmnAqrLym6tL4r
         aFSS9Pgr+um+YnQpC5L6X/jG63lvbWr2mt0aXuX36saCGcPhnPK+gjvNDnqATOf2iL7T
         noWVEPjCWubXxkOCwfAlKL7ln5zHlwzp40N5WhwPpMPXbR1IiXGyzlmPTilMeJ6AoD5Q
         R2SA==
X-Gm-Message-State: AJcUukcX6ZTP8uspEHNerozr3I5aTzaq3ZuEgZEYTm0MSaEuSI4sZcjG
        G72oqNiSHCNwED4X0SH7807xToijBiw=
X-Google-Smtp-Source: ALg8bN5pLjJ2rjK7GwYREwCBvnR44omgOLC0oBJpEl+gB9bBw9lHJS7b8QkpjVQzzyWl5ShjW/ixIQ==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr38523237wrv.236.1549029345676;
        Fri, 01 Feb 2019 05:55:45 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id f130sm3949513wme.41.2019.02.01.05.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 05:55:44 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v4 1/2] describe: setup working tree for --dirty
Date:   Fri,  1 Feb 2019 14:55:11 +0100
Message-Id: <20190201135512.68220-1-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't use NEED_WORK_TREE when running the git-describe builtin,
since you should be able to describe a commit even in a bare repository.
However, the --dirty flag does need a working tree. Since we don't call
setup_work_tree(), it uses whatever directory we happen to be in. That's
unlikely to match our index, meaning we'd say "dirty" even when the real
working tree is clean.

We can fix that by calling setup_work_tree() once we know that the user
has asked for --dirty.

The --broken option also needs a working tree. But because its
implementation calls git-diff-index we don‘t have to setup the working
tree in the git-describe process.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 builtin/describe.c  |  1 +
 t/t6120-describe.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index cc118448ee..b5b7abdc8f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			struct argv_array args = ARGV_ARRAY_INIT;
 			int fd, result;
 
+			setup_work_tree();
 			read_cache();
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index d639d94696..7cfed77c52 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -145,14 +145,38 @@ check_describe A-* HEAD
 
 check_describe "A-*[0-9a-f]" --dirty
 
+test_expect_success 'describe --dirty with --work-tree' '
+	(
+		cd "$TEST_DIRECTORY" &&
+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
+	) &&
+	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+$" out
+'
+
 test_expect_success 'set-up dirty work tree' '
 	echo >>file
 '
 
 check_describe "A-*[0-9a-f]-dirty" --dirty
 
+test_expect_success 'describe --dirty with --work-tree' '
+	(
+		cd "$TEST_DIRECTORY" &&
+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
+	) &&
+	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+-dirty$" out
+'
+
 check_describe "A-*[0-9a-f].mod" --dirty=.mod
 
+test_expect_success 'describe --dirty=.mod with --work-tree' '
+	(
+		cd "$TEST_DIRECTORY" &&
+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
+	) &&
+	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+.mod$" out
+'
+
 test_expect_success 'describe --dirty HEAD' '
 	test_must_fail git describe --dirty HEAD
 '
@@ -303,8 +327,17 @@ test_expect_success 'describe chokes on severely broken submodules' '
 	mv .git/modules/sub1/ .git/modules/sub_moved &&
 	test_must_fail git describe --dirty
 '
+
 test_expect_success 'describe ignoring a broken submodule' '
 	git describe --broken >out &&
+	grep broken out
+'
+
+test_expect_success 'describe with --work-tree ignoring a broken submodule' '
+	(
+		cd "$TEST_DIRECTORY" &&
+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --broken >"$TRASH_DIRECTORY/out"
+	) &&
 	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
 	grep broken out
 '
-- 
2.20.1

