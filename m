Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1321F404
	for <e@80x24.org>; Sun, 11 Feb 2018 16:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeBKQkf (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 11:40:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39972 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKQke (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 11:40:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id v123so5749982wmd.5
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 08:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXqmlSXlr9/I1R4WrtHMhjKGETZoXCIcxnuoTSe018o=;
        b=JY6bw0bNQv/6rp5g6JfkjKTxOgoEmEkyhtWC2cJqLYORJkpa5KiJfIMRzUQ0a/FrOy
         pYvCfQehBWhAVO1PHcCKGakH3+hop73imCJbfIi/MGV7ax4R4O9+GcLBfU3vkNFQvZFX
         BdjYjTyj8cEdFV3f7NojvJmDDY/ep5VH3Ja0owc2pXvp8g5ydaNELjRWWaEURxEmdYSc
         +H7Ddw/1wiN6jdyt+/PNfGfq2EMDEavpoI+AMCblZHIois4lNDUjxHel3ctayYHcAKaa
         onTjctpsY/5OaZtnC5FdxtI9h4zhVxbmZY7x4c9FFyyuHKemhGSDrnvpKoMg4XNlc+zU
         lLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXqmlSXlr9/I1R4WrtHMhjKGETZoXCIcxnuoTSe018o=;
        b=WDHqkxrEP6CgNfpvYCYReerwCxMZJTi1BK5J50ikyx88qDFfofM7BiAocosIppnVC0
         t6LQz+i5ZsK21j2aW1hQYgf/03/bS+joIC9LdqvYctMRB8vABJJnxQRtyrVzSOmzZiG1
         mgmxl0eASPQQYtaM/mLZ/KU9mSlWFpVgnYKuGK9Ms0nrBC0puFDwijj4xDdJnUCNXysi
         PVQn5bhjBSby1Z9CPMNiNqSYEjxipCsIYPSssTY80wxK82ngtF9Ktv2NCqpHlJOc1WZI
         1M9EalGL127xWDkCUIowyJ6+Q5aPBCYcfYm2zyaj7dc8E33MPzOw6b2nOXhbSGo70h53
         8glQ==
X-Gm-Message-State: APf1xPBb2f/Xi/+JQFsOPvPukRZfFLsRzcQ/yPey5+7Id4/5nNkypRo7
        hfewJ3gk6qiAv8UgZs7TF348O8Vn
X-Google-Smtp-Source: AH8x224IdC/ih3u5Tq/v8cqhNfOhpGU2Sss6CSow9rzvBIkDq9z9ERR+pnk9Ll0rKSf3844octiPlQ==
X-Received: by 10.28.141.212 with SMTP id p203mr1658550wmd.39.1518367233051;
        Sun, 11 Feb 2018 08:40:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z73sm10012551wrb.50.2018.02.11.08.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Feb 2018 08:40:31 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] t7006: add tests for how git config paginates
Date:   Sun, 11 Feb 2018 17:40:23 +0100
Message-Id: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next couple of commits will change how `git config` handles
`pager.config`, similar to how de121ffe5 (tag: respect `pager.tag` in
list-mode only, 2017-08-02) and ff1e72483 (tag: change default of
`pager.tag` to "on", 2017-08-02) changed `git tag`. Similar work has
also been done to `git branch`.

Add tests in this area to make sure that we don't regress and so that
the upcoming commits can be made clearer by adapting the tests. Add some
tests for `--list` and `--get`, one for `--edit`, and one for simple
config-setting.

In particular, use `test_expect_failure` to document that we currently
respect the pager-configuration with `--edit`. The current behavior is
buggy since the pager interferes with the editor and makes the end
result completely broken. See also b3ee740c8 (t7006: add tests for how
git tag paginates, 2017-08-02).

Remove the test added in commit 3ba7e6e29a (config: run
setup_git_directory_gently() sooner, 2010-08-05) since it has some
overlap with these. We could leave it or tweak it, or place new tests
like these next to it, but let's instead make the tests for `git config`
similar to the ones for `git tag` and `git branch`, and place them after
those.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7006-pager.sh | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index f5f46a95b4..5a7b757c94 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -110,13 +110,6 @@ test_expect_success TTY 'configuration can disable pager' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git config uses a pager if configured to' '
-	rm -f paginated.out &&
-	test_config pager.config true &&
-	test_terminal git config --list &&
-	test -e paginated.out
-'
-
 test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	rm -f paginated.out &&
 	mkdir -p subdir &&
@@ -252,6 +245,41 @@ test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
 	! test -e paginated.out
 '
 
+test_expect_success TTY 'git config respects pager.config when setting' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.config config foo.bar bar &&
+	test -e paginated.out
+'
+
+test_expect_failure TTY 'git config --edit ignores pager.config' '
+	rm -f paginated.out editor.used &&
+	write_script editor <<-\EOF &&
+		touch editor.used
+	EOF
+	EDITOR=./editor test_terminal git -c pager.config config --edit &&
+	! test -e paginated.out &&
+	test -e editor.used
+'
+
+test_expect_success TTY 'git config --get defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git config --get foo.bar &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git config --get respects pager.config' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.config config --get foo.bar &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git config --list defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git config --list &&
+	! test -e paginated.out
+'
+
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
-- 
2.16.1.72.g5be1f00a9a

