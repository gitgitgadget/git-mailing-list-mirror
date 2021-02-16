Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE4DC433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E58B64DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhBPM5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBPM5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:57:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D582C061756
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:56:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a207so1212348wmd.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bE7de1oWyFui9lFI0Diii+04czYAxJb6LtUvpuJ9VIw=;
        b=JHo5ytZv+8K4n1utQWjLXOeg0Vf9TdOvyOmjFK42i1HZ9B5xz4VfijwcGHpdRfb7wT
         GmwMxG7f3OiFEzL98EiFg+ruBepp1iudiuCBSm2o3H342XGkIlnrDvLQ+vYJ/nmslfLu
         W1jEz3ZjfpnQSmTEd0UYmi92ubgMgi1N1Qat1mGJ6VdGG1rlNHDAQu4L3ttGJ+uYV8Xs
         C0Kme2o/uhdbCKfhxmBefAqVP5vbcoXRQNtMVp13XjqugEWCIx2HNDT83H8FsJaV0lNX
         68GnYAULK4IISWTnMVEi95ldzgOLplSYxMCg0AVO2pmJmRvfp04o4GLeMKafvDIQgKjM
         JYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bE7de1oWyFui9lFI0Diii+04czYAxJb6LtUvpuJ9VIw=;
        b=H9LhdhrTcRAQxtZ44yHnHGdjDaaLDa6iEvY+2IR/Ni5cWvPxDCBwHLtMGPFa90jQjt
         ukc32yCMO1msOJYP70w8GwmuyLxJ6QQNXlenuvhS7KXBfbIov0ais0PKSfLD3S+rglNI
         oslBR+Y2OdLoqeb1TiABmf4Jdec6+5sFz0scpuhHXanSpTWwF2ZfiOYbfuc6nQuF1tMh
         /9gsbcawbZAVd8l8sMPUroJfQNr4cnKKHBdu3ayKvJIWwNWm6wummoBLSYgEnGHQqq+2
         CO9TMuZq6wX2ORkN9UrFXx7o4y46PfPOdZmZazxDfS3n0KCKCGkftI1lMa820FfJ75Y7
         EJ3g==
X-Gm-Message-State: AOAM531I5i4QGq9eVjTRQsuqQmpaeacTAx8n8Qxs+mBschz8fjNPYjoQ
        fLXwxYikRzzRt4vOk0NvsagfJtHDblk=
X-Google-Smtp-Source: ABdhPJwNbzPo97MNEjYTgb7W3ORILvVGBmw87XEqBJ1pRVSoAJ3VBM/e9mVbOZo6bFy5N1lBtGYgGQ==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr3255555wmh.147.1613480201344;
        Tue, 16 Feb 2021 04:56:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm4582842wrw.88.2021.02.16.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 04:56:41 -0800 (PST)
Message-Id: <98e2707ee2faf653e972b0706311ddd099765ce5.1613480198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
        <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Feb 2021 12:56:37 +0000
Subject: [PATCH v5 2/2] difftool.c: learn a new way start at specified file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

`git difftool` only allow us to select file to view in turn.
If there is a commit with many files and we exit in the search,
We will have to traverse list again to get the file diff which
we want to see. Therefore, here is a new method: user can use
`git difftool --rotate-to=<filename>` or `git difftool --skip-to=<filename>`
to start viewing from the specified file, This will improve the
user experience.

`git difftool --rotate-to=<file>` or `git difftool --skip-to=<filename>`
will pass the path to `diffcore-rotate`, and diff-core will
adjust the order of files, make the specified file sorted to
the first.`git difftool --rotate-to=<file>` will move files before
the  specified path to the last output, and
`git difftool --skip-to=<filename>`  will ignore these files output.
It is an error when there is no patch for specified file is shown.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/diff-options.txt |  2 +-
 Documentation/git-difftool.txt | 10 ++++++++++
 t/t7800-difftool.sh            | 30 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7c5b3cf42bcc..aa2b5c11f20b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -701,7 +701,7 @@ components matches the pattern.  For example, the pattern "`foo*bar`"
 matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
 
 --skip-to=<file>::
---rotate-to=<file::
+--rotate-to=<file>::
 	Discard the files before the named <file> from the output
 	(i.e. 'skip to'), or move them to the end of the output
 	(i.e. 'rotate to').  These were invented primarily for use
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 484c485fd06c..c64dff69c976 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -34,6 +34,16 @@ OPTIONS
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
+--rotate-to=<file>::
+	Internally call `git diff --rotate-to=<file>`,
+	show the change in the specified path first.
+	Files before the specified path will be moved to the last output.
+
+--skip-to=<file>::
+	Internally call `git diff --skip-to=<file>`,
+	skip the output to the specified path.
+	Files before the specified path will not output.
+
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.  Valid values include
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9192c141ffc6..112b798b1c23 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -762,4 +762,34 @@ test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive'
 	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
 '
 
+test_expect_success 'difftool --rotate-to' '
+	difftool_test_setup &&
+	test_when_finished git reset --hard &&
+	echo 1 >1 &&
+	echo 2 >2 &&
+	echo 4 >4 &&
+	git add 1 2 4 &&
+	git commit -a -m "124" &&
+	git difftool --no-prompt --extcmd=cat --rotate-to="2" HEAD^ >output&&
+	cat >expect <<-\EOF &&
+	2
+	4
+	1
+	EOF
+	test_cmp output expect &&
+	test_must_fail git difftool --no-prompt --extcmd=cat --rotate-to="3" HEAD^
+'
+
+test_expect_success 'difftool --skip-to' '
+	difftool_test_setup &&
+	test_when_finished git reset --hard &&
+	git difftool --no-prompt --extcmd=cat --skip-to="2" HEAD^ >output &&
+	cat >expect <<-\EOF &&
+	2
+	4
+	EOF
+	test_cmp output expect &&
+	test_must_fail git difftool --no-prompt --extcmd=cat --skip-to="3" HEAD^
+'
+
 test_done
-- 
gitgitgadget
