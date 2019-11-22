Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B8DC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3930B20715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9R8kM13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKVOlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:41:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38124 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKVOlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 09:41:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so8906603wro.5
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IxSqxarUv44dtRuXTg+T1t2Qk7SPpmGt/f4uvGizr6g=;
        b=n9R8kM13dvt+nuLcn3L1BIhpSmbdO8FRwBtggGnhslUMvfsOXAnEdNasnUb5xQv5Uj
         Enx9dBNAxI4MFg4X8Tlsfl98QS2uwiF+D8WSSttgM+RV8zPsaFbsdO+83OQOeU9KX0aW
         RJGIw2DuGOyZw76cBPwy/4fOp0FuBFQe/qmRYEJ1EaM3QVte94YNFTQ8CPGYWI/rIx3N
         U1xRqrM/vjX+A8573sY3rNwSi3Y+MAP+KUXtV7DRAFBemsP/AA2tEskaQzTHHnRHPQ3T
         MbMGdnKR3gFuWFzAvz2rVJHxIz71IN5wQZb36fSnWDfPjjS7mpmI5rKPA2TVa1PUmeeq
         KbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IxSqxarUv44dtRuXTg+T1t2Qk7SPpmGt/f4uvGizr6g=;
        b=NcWfvkGvPz3bYsXks3mLacNN61BP2L+wWuxEP34UCpVz0OQj018HZJ502ZeA/eB0Om
         ZjwzD9S7zBSr0nN+sLp5Fy/h10ckQsKq9e/zPQsgxHs11RifnAt4qNGuWR8MpibVNZSv
         U4H//Z5jRE0OQQrSMcD8F/0H+MhEi+pP8hDfBXl2IrdX+Go5EAUbXqfrZFm6YU+WaLdF
         AvZQ32rz0uG0lvPs8ZHpAoGRdF7uZTMlt6TgbfsKSAU6ONmtnF1+2KgO1Sh44NrfIO2/
         6QesfjP1yjpiclTvWQoPi3d/9DoU1ynL7HjbuZzqDJ/hDV29XpXn/MAWTffpbg2NU/tp
         Yp8g==
X-Gm-Message-State: APjAAAW7QrUzKuj1C5Yl8YhAkq3peKpF4K0bXh45HUd4iEyUZLjjOGq0
        2gbgMeynhDgjrkwh4z+xcRHbcuH4
X-Google-Smtp-Source: APXvYqw0pjVJloqBFe4LEwUX6qAdp1YhJxnKs3j4om3ZH6SNbHIEM8UVEBP3FFJEMeEtBlbnOJcRgw==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr17466991wru.242.1574433667677;
        Fri, 22 Nov 2019 06:41:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y78sm3756680wmd.32.2019.11.22.06.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:41:07 -0800 (PST)
Message-Id: <96608fd2e82b7337dea4ea9fb7a2f3f1f7e6c854.1574433665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 14:41:02 +0000
Subject: [PATCH 1/4] mingw: demonstrate that all file handles are inherited by
 child processes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When spawning child processes, we really should be careful which file
handles we let them inherit.

This is doubly important on Windows, where we cannot rename, delete, or
modify files if there is still a file handle open.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-run-command.c | 44 +++++++++++++++++++++++++++++++++++++
 t/t0061-run-command.sh      |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index ead6dc611a..40ec4dbb6e 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -200,6 +200,46 @@ static int testsuite(int argc, const char **argv)
 	return !!ret;
 }
 
+static int inherit_handle(const char *argv0)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char path[PATH_MAX];
+	int tmp;
+
+	/* First, open an inheritable handle */
+	xsnprintf(path, sizeof(path), "out-XXXXXX");
+	tmp = xmkstemp(path);
+
+	argv_array_pushl(&cp.args,
+			 "test-tool", argv0, "inherited-handle-child", NULL);
+	cp.in = -1;
+	cp.no_stdout = cp.no_stderr = 1;
+	if (start_command(&cp) < 0)
+		die("Could not start child process");
+
+	/* Then close it, and try to delete it. */
+	close(tmp);
+	if (unlink(path))
+		die("Could not delete '%s'", path);
+
+	if (close(cp.in) < 0 || finish_command(&cp) < 0)
+		die("Child did not finish");
+
+	return 0;
+}
+
+static int inherit_handle_child(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (strbuf_read(&buf, 0, 0) < 0)
+		die("Could not read stdin");
+	printf("Received %s\n", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 int cmd__run_command(int argc, const char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
@@ -207,6 +247,10 @@ int cmd__run_command(int argc, const char **argv)
 
 	if (argc > 1 && !strcmp(argv[1], "testsuite"))
 		exit(testsuite(argc - 1, argv + 1));
+	if (!strcmp(argv[1], "inherited-handle"))
+		exit(inherit_handle(argv[0]));
+	if (!strcmp(argv[1], "inherited-handle-child"))
+		exit(inherit_handle_child());
 
 	if (argc < 3)
 		return 1;
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 17c9c0f3bb..473a3405ef 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -12,6 +12,10 @@ cat >hello-script <<-EOF
 	cat hello-script
 EOF
 
+test_expect_failure MINGW 'subprocess inherits only std handles' '
+	test-tool run-command inherited-handle
+'
+
 test_expect_success 'start_command reports ENOENT (slash)' '
 	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
 	test_i18ngrep "\./does-not-exist" err
-- 
gitgitgadget

