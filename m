Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E13C4332D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0223122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437020AbhALVhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436858AbhALUTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97641C0617BA
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:46 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y17so3812673wrr.10
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jURmx6GhDLLiSmp7AtWgrmCSWU/VLl1BGxVdDoZk7w=;
        b=jIx8TMdJt8e2P2czPNUEa9NXJvqTqnbeirR4p9CWebSBMT/BR+ka635zLhgcC8Djlj
         fLVcFxWnVVNQmoCBsZBF0gSj4cMJPKEK7ezCniim4zNg9kzsYrYm0Rp3b2uGjSdPSAp7
         nRSn5hSS6ZMuxrvxYFxEXbZGwMimxh1ylmLzSoReB/DwxVWL58lsFyZI8BmlY/Zhfb1g
         yVKTCnmJqzg4TusPBk6SAoOvRSBY1xRSrruyloLXlCAxf68gi3kybWMVDRuKEBZI7VNa
         NA4ZLz71ayXUtxrnXd9IP6qDl7VWRDhoXCGzZi/IhW8gxKxXBctt0oSRYdy38x+l8wDl
         0ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jURmx6GhDLLiSmp7AtWgrmCSWU/VLl1BGxVdDoZk7w=;
        b=BlmVD7gsa8ctxtTMx77tuW+QwDebM4NrJvRDTzUdEaRqPEQ86xyTpUgFyZN0hd0/Jq
         GZ1zQ5vmA1ZLiw/ICf5UGvXA+k/wAcr/9wH+56meOPzTeN0PBKjUnNT/vGIcDUSQvTQL
         ycDyaW8lxxiiqgkLwjV1m9Af8Q+ZUmO1A3FTHaOsQ/liJ5ZtCj1p6emSI5EdHAJmrUgo
         ChdOKRCYpG4yB6wndBDC2t7ElsZcBRTSthT1GlShkI5IEhGCaBq+vGlsxL7Xi7f3AMnz
         gqtvaWG1B6ymawdrlDaOFvm6In8RpR1teK9uPpJvRabwDkt8Cp1zIhbie73tNX39BAU6
         WlUg==
X-Gm-Message-State: AOAM531fOAldiM2ts43VBYAVn08vhSV7NIWgKM4HRIPpw0giVr4vUr0d
        V1II665x7mQGfAU5ipz7r8b5oAMXASjE7A==
X-Google-Smtp-Source: ABdhPJxKMELWYMQ/GMVbrZYIJNz+XtRbGWNa7aW1dOe3KcZqh3+ZT+9spvqjd7PsKRHP1CKv6HvdGg==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr531306wrq.229.1610482724978;
        Tue, 12 Jan 2021 12:18:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/22] mailmap doc + tests: add better examples & test them
Date:   Tue, 12 Jan 2021 21:18:01 +0100
Message-Id: <20210112201806.13284-18-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mailmap documentation added in 0925ce4d49 (Add map_user()
and clear_mailmap() to mailmap, 2009-02-08) to continue discussing the
Jane/Joe example. I think this makes things a lot less confusing as
we're building up more complex examples using one set of data which
covers all the things we'd like to discuss.

Also add tests to assert that what our documentation says is what's
actually happening. This is mostly (or entirely) covered by existing
tests which I'm not deleting, but having these tests for the synopsis
makes it easier to follow-along while reading the tests & docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitmailmap.txt | 49 ++++++++++++--------
 t/t4203-mailmap.sh           | 88 ++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 20 deletions(-)

diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index 4e4677018b..55dfebd1b1 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -53,7 +53,7 @@ commit matching both the specified commit name and email address.
 EXAMPLES
 --------
 
-Example 1: Your history contains commits by two authors, Jane
+Your history contains commits by two authors, Jane
 and Joe, whose names appear in the repository under several forms:
 
 ------------
@@ -65,36 +65,45 @@ Jane D. <jane@desktop.(none)>
 ------------
 
 Now suppose that Joe wants his middle name initial used, and Jane
-prefers her family name fully spelled out. A proper `.mailmap` file
-would look like:
+prefers her family name fully spelled out. A `.mailmap` file to
+correct the names would look like:
 
 ------------
-Jane Doe         <jane@desktop.(none)>
 Joe R. Developer <joe@example.com>
+Jane Doe <jane@example.com>
+Jane Doe <jane@desktop.(none)>
 ------------
 
-Note how there is no need for an entry for `<jane@laptop.(none)>`, because the
-real name of that author is already correct.
+Note that there's no need to map the name for 'jane@laptop.(none)' to
+only correct the names. However, leaving the obviously broken
+`<jane@laptop.(none)>' and '<jane@desktop.(none)>' E-Mails as-is is
+usually not what you want. A `.mailmap` file which also corrects those
+is:
 
-Example 2: Your repository contains commits from the following
-authors:
+------------
+Joe R. Developer <joe@example.com>
+Jane Doe <jane@example.com> <jane@laptop.(none)>
+Jane Doe <jane@example.com> <jane@desktop.(none)>
+------------
+
+Finally, let's say that Joe and Jane shared an E-Mail address, but not
+a name, e.g. by having these two commits in the history generated by a
+bug reporting system. I.e. names appearing in history as:
 
 ------------
-nick1 <bugs@company.xx>
-nick2 <bugs@company.xx>
-nick2 <nick2@company.xx>
-santa <me@company.xx>
-claus <me@company.xx>
-CTO <cto@coompany.xx>
+Joe <bugs@example.com>
+Jane <bugs@example.com>
 ------------
 
-Then you might want a `.mailmap` file that looks like:
+A full `.mailmap` file which also handles those cases (an addition of
+two lines to the above example) would be:
+
 ------------
-<cto@company.xx>                       <cto@coompany.xx>
-Some Dude <some@dude.xx>         nick1 <bugs@company.xx>
-Other Author <other@author.xx>   nick2 <bugs@company.xx>
-Other Author <other@author.xx>         <nick2@company.xx>
-Santa Claus <santa.claus@northpole.xx> <me@company.xx>
+Joe R. Developer <joe@example.com>
+Jane Doe <jane@example.com> <jane@laptop.(none)>
+Jane Doe <jane@example.com> <jane@desktop.(none)>
+Joe R. Developer <joe@example.com> Joe <bugs@example.com>
+Jane Doe <jane@example.com> Jane <bugs@example.com>
 ------------
 
 
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 5d92880a5a..96ba5367c6 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -419,6 +419,94 @@ test_expect_success 'preserve canonical email case' '
 	test_cmp expect actual
 '
 
+test_expect_success 'gitmailmap(5) example output: setup' '
+	test_create_repo doc &&
+	test_commit -C doc --author "Joe Developer <joe@example.com>" A &&
+	test_commit -C doc --author "Joe R. Developer <joe@example.com>" B &&
+	test_commit -C doc --author "Jane Doe <jane@example.com>" C &&
+	test_commit -C doc --author "Jane Doe <jane@laptop.(none)>" D &&
+	test_commit -C doc --author "Jane D. <jane@desktop.(none)>" E
+'
+
+test_expect_success 'gitmailmap(5) example output: example #1' '
+	test_config -C doc mailmap.file ../doc.map &&
+	cat >doc.map <<-\EOF &&
+	Joe R. Developer <joe@example.com>
+	Jane Doe <jane@example.com>
+	Jane Doe <jane@desktop.(none)>
+	EOF
+
+	cat >expect <<-\EOF &&
+	Author Joe Developer <joe@example.com> maps to Joe R. Developer <joe@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Joe R. Developer <joe@example.com> maps to Joe R. Developer <joe@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Jane Doe <jane@example.com> maps to Jane Doe <jane@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@laptop.(none)>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@desktop.(none)>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+	EOF
+	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'gitmailmap(5) example output: example #2' '
+	test_config -C doc mailmap.file ../doc.map &&
+	cat >doc.map <<-\EOF &&
+	Joe R. Developer <joe@example.com>
+	Jane Doe <jane@example.com> <jane@laptop.(none)>
+	Jane Doe <jane@example.com> <jane@desktop.(none)>
+	EOF
+
+	cat >expect <<-\EOF &&
+	Author Joe Developer <joe@example.com> maps to Joe R. Developer <joe@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Joe R. Developer <joe@example.com> maps to Joe R. Developer <joe@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Jane Doe <jane@example.com> maps to Jane Doe <jane@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+	EOF
+	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'gitmailmap(5) example output: example #3' '
+	test_config -C doc mailmap.file ../doc.map &&
+	cat >>doc.map <<-\EOF &&
+	Joe R. Developer <joe@example.com> Joe <bugs@example.com>
+	Jane Doe <jane@example.com> Jane <bugs@example.com>
+	EOF
+
+	test_commit -C doc --author "Joe <bugs@example.com>" F &&
+	test_commit -C doc --author "Jane <bugs@example.com>" G &&
+
+	cat >>expect <<-\EOF &&
+
+	Author Joe <bugs@example.com> maps to Joe R. Developer <joe@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author Jane <bugs@example.com> maps to Jane Doe <jane@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+	EOF
+	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
+	test_cmp expect actual
+'
+
+
 test_expect_success 'Shortlog output (complex mapping)' '
 	test_config mailmap.file complex.map &&
 	cat >complex.map <<-EOF &&
-- 
2.29.2.222.g5d2a92d10f8

