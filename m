Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793BD1F453
	for <e@80x24.org>; Sun,  3 Feb 2019 06:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfBCGAt (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 01:00:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35189 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfBCGAt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 01:00:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so5204369wrp.2
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 22:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DE1ePj/NQKh42A3e3Z8GI7pUl7Y/0sl/kZK5Aluvbwg=;
        b=ec7oudrgGGT9sj/r73TahjqxHiW8HQrMii0yAFRyzFR8mvaBmPFqOO/+CYKluEcmnJ
         OZd1wnKtMdhmbNBB8dEqBbKtZc8maxEGPVDLBYBDKNfMCKXyuAzVDQILtKAS9o9hy773
         66cOVKRCEcgjwAnkylbn6mPxf73vfWcL0L8DFw50jTsWdSk4XKUUueP88EGRW8bUenoJ
         LG65hZMz+2hkE3lN16mA5u9irBnR/ZCOAIEdZCJDSbC0ulRSCaGmsOBai4x+qwGBJDP+
         Ql+G0JvFIfHpxtvzVoxtdDQi3grirwS28pCc4QjMKZh6fTW2EBb+YUw6s80VUfbPbcBL
         IFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DE1ePj/NQKh42A3e3Z8GI7pUl7Y/0sl/kZK5Aluvbwg=;
        b=JEHIyZ7kHCIF8N1BeoM331gXSj0w7oecb19vPA6aBBGjx00gB1aWpRpY2JmzG8x83a
         ZAFGPs3n79JC5j6E8S0qr4JTsQNpb5De6WDREALIIkHQeq6mkx52uoXTozHTy1dz0UqY
         fyWarRbt+K5JRS5qbhrxTty457YKJkf/Y2U5F+Reh6U70QA3FGpPiZ1XVmsQVH/0kqsW
         MBNIV8DfnYb4jnu4sUo9bKnO6MWdEDcCiHW4txp+Pu0Y4/sJbi3U9Gl3pD3GssIx7c/P
         m1z8/witb/JXyM5EtzaqarJcul0BHYq4E+5PS0VzxZ2Pj9x1fkoO9kzmvTWACqYd67bD
         WE1A==
X-Gm-Message-State: AJcUukf4qfcZYvhlo0jq/beeHOuD+Sw7oZVKMflDaDLSgSwhX0moLGS2
        Xd15f2vnv6ADFT2xPl1oAyahyxmZCqk=
X-Google-Smtp-Source: ALg8bN5d4l7wdvGKbBd6oIT2ynKWJi9/evPhTa/OX/hRa2keAw186MumU0fOSYBaOAhAPWK+T970DQ==
X-Received: by 2002:adf:b783:: with SMTP id s3mr46513546wre.274.1549173647027;
        Sat, 02 Feb 2019 22:00:47 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id c202sm15146179wmd.40.2019.02.02.22.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 22:00:45 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v5 1/2] describe: setup working tree for --dirty
Date:   Sun,  3 Feb 2019 07:00:24 +0100
Message-Id: <20190203060025.7486-1-koraktor@gmail.com>
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
index d639d94696..a9e3bf0ce0 100755
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
 
+test_expect_success 'describe --dirty with --work-tree (dirty)' '
+	(
+		cd "$TEST_DIRECTORY" &&
+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
+	) &&
+	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+-dirty$" out
+'
+
 check_describe "A-*[0-9a-f].mod" --dirty=.mod
 
+test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
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

