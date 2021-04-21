Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8786DC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E6A6142B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhDUIrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhDUIrR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 04:47:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4756C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:46:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z16so29116153pga.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4gWzbqaEhZTPTSbsKAyXC3bIThfNjlWgsscapN+ugqk=;
        b=VGLJVnnVvXdUq3ihlPHWeHrQ2DVfrYQ2xY5uOVo7nAFqP6NmOVRLEXFEVjViZYZl2f
         AOKeV6dJEIr/o6rpwBFi/3CYXAS6U31mYa0Nuyx+YIwI1LknyXM27GeLNYwkBikn4gfj
         CevK7Df/M+HntWrsOH5FVqqoWPF8HrY6CYRTMRM3HD0FcN82/3evQ0AD1V4at144FwSf
         NGj29HPEr8S4+AkyRyiaTJCjDrruo+4wnFWoPwcG/8kt89iVERmpepv+5VAoQmmjOJrs
         i8QOBzwl2CfmHE9nPqD+/Ja2Ev92LfXRYFpVTkmhD0cHHJpSPhriJdPekZjMXhu8W6ug
         BVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gWzbqaEhZTPTSbsKAyXC3bIThfNjlWgsscapN+ugqk=;
        b=KjyBUpK+yfM3ehi4j17yGuYPL0CVGXCGAHbfFwbgZQddIRYjz84+kjuyZXxmJ7KpAA
         Y6Y4mGN3F82oIFUBtPz9hiPrz/s/xy3XbatHgCEkdT3nLBBSLw+ZuyrNhdgUj9FqdYPA
         fMRsFOgz4cygifLMv9m9IJAKanOBbADi4ZkKob84tgZV3/aL0IhABRDiawenCKugXHP1
         hxWgsaxnlcj0qZakJ3VZgoL0hiuy5mkkD6zfNg8VKKaHP7AeP+nadSl0MimVqMxSH11o
         k6xi1Ia/p9Hof2OI8O0HRO30HLFJrOB6e5j0cHX/ncVHvQwvhhkg9EAq0EMN+UCxkGoX
         StXA==
X-Gm-Message-State: AOAM530CMj8oWJETGLYca1PbQOvW0f7a7Ag/0a0GTAk2UkV7jNqBLDz2
        5w8j2oIzwfZgi3yEokX8rcdnLn7QjARUf9WK
X-Google-Smtp-Source: ABdhPJyItERHvS9ts9dtXo9iPESBC6csKmu/zOlh3NaBqAQikk0G3ugKyRSc4Ecbv5sFyh+RxEmrNg==
X-Received: by 2002:a17:90a:e50a:: with SMTP id t10mr10136687pjy.32.1618994804006;
        Wed, 21 Apr 2021 01:46:44 -0700 (PDT)
Received: from localhost.localdomain ([142.93.93.167])
        by smtp.googlemail.com with ESMTPSA id x17sm4435523pjr.0.2021.04.21.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:46:43 -0700 (PDT)
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
To:     git@vger.kernel.org, tboegi@web.de, tzadik.vanderhoof@gmail.com
Subject: [PATCH] add git-p4.fallbackEncoding config variable, to prevent git-p4 from crashing on non UTF-8 changeset descriptions
Date:   Wed, 21 Apr 2021 01:46:04 -0700
Message-Id: <20210421084604.3095-1-tzadik.vanderhoof@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210412040614.gqiot5qcsfpiae3a@tb-raspi4>
References: <20210412040614.gqiot5qcsfpiae3a@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-p4.txt                   | 10 ++++
 git-p4.py                                  | 11 +++-
 t/t9835-git-p4-config-fallback-encoding.sh | 65 ++++++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100755 t/t9835-git-p4-config-fallback-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f89e68b..e0131a9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -638,6 +638,16 @@ git-p4.pathEncoding::
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
 	often uses "cp1252" to encode path names.
 
+git-p4.fallbackEncoding::
+	Perforce changeset descriptions can be in a mixture of encodings.
+	Git-p4 first tries to interpret each description as UTF-8. If that
+	fails, this config allows another encoding to be tried. You
+	can specify, for example, "cp1252". If instead of an encoding,
+	you specify "replace", UTF-8 will be used, with invalid UTF-8
+	characters replaced by the Unicode replacement character. If you
+	specify "none" (the default), there is no fallback, and any non
+	UTF-8 character will cause git-p4 to immediately fail.
+
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
 	that large file systems do not support the 'git p4 submit' command.
diff --git a/git-p4.py b/git-p4.py
index 09c9e93..173f78a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                 for key, value in entry.items():
                     key = key.decode()
                     if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value = value.decode()
+                        try:
+                            value = value.decode()
+                        except UnicodeDecodeError as ex:
+                            fallbackEncoding = gitConfig("git-p4.fallbackEncoding").lower() or 'none'
+                            if fallbackEncoding == 'none':
+                                raise Exception("UTF8 decoding failed. Consider using git config git-p4.fallbackEncoding") from ex
+                            elif fallbackEncoding == 'replace':
+                                value = value.decode(errors='replace')
+                            else:
+                                value = value.decode(encoding=fallbackEncoding)
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
diff --git a/t/t9835-git-p4-config-fallback-encoding.sh b/t/t9835-git-p4-config-fallback-encoding.sh
new file mode 100755
index 0000000..56a245e
--- /dev/null
+++ b/t/t9835-git-p4-config-fallback-encoding.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='test git-p4.fallbackEncoding config'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./lib-git-p4.sh
+
+if test_have_prereq !MINGW,!CYGWIN; then
+	skip_all='This system is not subject to encoding failures in "git p4 clone"'
+	test_done
+fi
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'add cp1252 description' '
+	cd "$cli" &&
+	echo file1 >file1 &&
+	p4 add file1 &&
+	p4 submit -d documentación
+'
+
+test_expect_success 'clone fails with git-p4.fallbackEncoding unset' '
+	test_might_fail git config --global --unset git-p4.fallbackEncoding &&
+	test_when_finished cleanup_git &&
+	(
+		test_must_fail git p4 clone --dest="$git" //depot@all 2>> actual &&
+		grep "UTF8 decoding failed. Consider using git config git-p4.fallbackEncoding" actual
+	)
+'
+test_expect_success 'clone fails with git-p4.fallbackEncoding set to "none"' '
+	git config --global git-p4.fallbackEncoding none &&
+	test_when_finished cleanup_git &&
+	(
+		test_must_fail git p4 clone --dest="$git" //depot@all 2>> actual &&
+		grep "UTF8 decoding failed. Consider using git config git-p4.fallbackEncoding" actual
+	)
+'
+
+test_expect_success 'clone succeeds with git-p4.fallbackEncoding set to "cp1252"' '
+	git config --global git-p4.fallbackEncoding cp1252 &&
+	test_when_finished cleanup_git &&
+	(
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git log --oneline >log &&
+		desc=$(head -1 log | awk '\''{print $2}'\'') &&	[ "$desc" = "documentación" ]
+	)
+'
+
+test_expect_success 'clone succeeds with git-p4.fallbackEncoding set to "replace"' '
+	git config --global git-p4.fallbackEncoding replace &&
+	test_when_finished cleanup_git &&
+	(
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git log --oneline >log &&
+		desc=$(head -1 log | awk '\''{print $2}'\'') &&	[ "$desc" = "documentaci�n" ]
+	)
+'
+
+test_done
-- 
2.31.1.windows.1

