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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6DAC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1042364E7C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBILnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhBILhA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 06:37:00 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E8BC061356
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 03:32:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so4908856wrw.6
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JFVBRHg6s2ehfRB8eUQwTpqlarz3y3sOyRm0WMS1zsU=;
        b=fM6NvMRNIk69ebjhe0dtH6HVblU11RrglUeJQa5PzGQClwzUyZgKR10ZoLjPyhQJto
         GoVlFQwXdrQidzlh/qthsl3L80bckG3Cknp6FQ7GwB6ARilzHQy0ccxF3jmp/sy9JEgu
         T2boYygpxtCrSFn2LX3NdC+YyZ7NBMg/4YMO/fiaZypKqM0tI/9HKDndwhhqys+NmRQa
         CwNbw+SShDFD7mSKZvWWa8g9fZ4H7my7x8kkn6bGGpP8irJ7qFt4AFRrpBvVz/o5lknJ
         ihFUGyPgJMayBpoHO9GkyrLJZpE2+aKhCxQYO0RwSB8/h87BM1tJMs5sh09KvIbk/t4i
         Wkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JFVBRHg6s2ehfRB8eUQwTpqlarz3y3sOyRm0WMS1zsU=;
        b=Rk5CD3YJrvnGwle/r0K3RS7uewj731XMO66AyK23hSsw0UkCOjOvu30kLXbTyYBPjK
         tUsVt5saoa7scYxRMrcBu3NHmS28hV/I4WnB6e9j38CZkjVMHtapfVjWCi3BzIRBHpYG
         L9yjHynBsbX63x1px8rH8Lpz7k+IShs6anyLWPqtl1FxG+NyJ4JyGhSjM+V3tgsbBRIu
         /TGQr6X5aO2/D4AJpDyF8wjYXKiOQC72q+AkFLqDjxsuT5hityeFakazf6FvwHQAuqtd
         7GdrAFA/3BAIjBvG0SlTLE8yki9VOzt5hG6A5EanF4ng+9snzj1YEA/uiXr3zNScET8x
         lMWQ==
X-Gm-Message-State: AOAM530Y9WrzH6lMJZoXXbqT+kTQWyiz1sqCX5Ucp3bkK9xshz0mv7eJ
        LWCX+N6YR7hPTIijKN/zTP13w7zk2FQ=
X-Google-Smtp-Source: ABdhPJyfLjRWbTFL3ZEa97InmpyPF4mmd64c6Y1mO7+IdlpBnQH7bdEykFYqkw/R5fpxfGt8LsyM0w==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr24801163wro.142.1612870332696;
        Tue, 09 Feb 2021 03:32:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm4071253wmc.32.2021.02.09.03.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:32:11 -0800 (PST)
Message-Id: <a0e75d8cd6bd32fb1ab2a209bc2079c30995b257.1612870326.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 11:32:06 +0000
Subject: [PATCH v2 4/4] gitdiffcore doc: mention new preliminary step for
 rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The last few patches have introduced a new preliminary step when rename
detection is on but both break detection and copy detection are off.
Document this new step.  While we're at it, add a testcase that checks
the new behavior as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/gitdiffcore.txt | 15 +++++++++++++++
 t/t4001-diff-rename.sh        | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c970d9fe438a..954ae3ef1082 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -168,6 +168,21 @@ a similarity score different from the default of 50% by giving a
 number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
 8/10 = 80%).
 
+Note that when rename detection is on but both copy and break
+detection are off, rename detection adds a preliminary step that first
+checks files with the same basename.  If files with the same basename
+are sufficiently similar, it will mark them as renames and exclude
+them from the later quadratic step (the one that pairwise compares all
+unmatched files to find the "best" matches, determined by the highest
+content similarity).  So, for example, if docs/extensions.txt and
+docs/config/extensions.txt have similar content, then they will be
+marked as a rename even if it turns out that docs/extensions.txt was
+more similar to src/extension-checks.c.  At most, one comparison is
+done per file in this preliminary pass; so if there are several
+extensions.txt files throughout the directory hierarchy that were
+added and deleted, this preliminary step will be skipped for those
+files.
+
 Note.  When the "-C" option is used with `--find-copies-harder`
 option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index c16486a9d41a..bf62537c29a0 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -262,4 +262,28 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
 	grep "myotherfile.*myfile" actual
 '
 
+test_expect_success 'basename similarity vs best similarity' '
+	mkdir subdir &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			 line6 line7 line8 line9 line10 >subdir/file.txt &&
+	git add subdir/file.txt &&
+	git commit -m "base txt" &&
+
+	git rm subdir/file.txt &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			  line6 line7 line8 >file.txt &&
+	test_write_lines line1 line2 line3 line4 line5 \
+			  line6 line7 line8 line9 >file.md &&
+	git add file.txt file.md &&
+	git commit -a -m "rename" &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
+	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
+	# but since same basenames are checked first...
+	cat >expected <<-\EOF &&
+	A	file.md
+	R078	subdir/file.txt	file.txt
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
gitgitgadget
