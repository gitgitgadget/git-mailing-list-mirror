Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D105FC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLOIwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLOIw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF352656B
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f18so2302922wrj.5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu6ClcJcCzmOu/KeLiipByWWC3wZc8dcCKrdQDY3Y74=;
        b=qnZFi+Vc7dbLMLmktZnl5KVIfSkRM/1HZlsnd2PxXRJyLGSNWuzgN2JYqmjgCY4TrG
         /kDuzNUSfR6wXEQN0NSHqvsw1GIzEHMohXd4Smlv/jRSUNvqv25lNYbYG2ChOj9/ZDzY
         EeQTn8iJAp+YTvT4vISK7dO7rzRhBu+kBCtmPRwCxAqLg+R/2kAK8z1MaHCwPePHobf9
         Ny+GixXajqioENMn3HSBaKCGSFEfv1T6CORqLfZZf3QuaZwk84HB6gQ5V8+AGbHwEiFf
         eVKQ12Zmo7k/vZwCQ43yPN2bRYQG4zU2VAS0o+RkGNGMVTJd690woWHmLZPFSBQDTZFJ
         WgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu6ClcJcCzmOu/KeLiipByWWC3wZc8dcCKrdQDY3Y74=;
        b=d63MuZt6qarovKnjDTqhhllIlec9nRABAotlh+Qg0pDgovByStCjhlLtIjf+i/UEiL
         TCr5XkLBFp+TXD3ua13EH3L3nojv5Qgj7Uhw/gePucYIrWeFIKmPzUahpIqH7V/ds2Of
         doPDhT1dGq0oOaH0oeppaFexWC+0VRZRfHg7nV8v2AjAJGsoChVEPhtca4fhA2Xm6Giu
         VPzDUvskR0/rxR/a7xwwhzJ+LKYyvHFQ2yci9rtPstD+J4DmoobQsDbOuAWs2Ya0LtbX
         YLtHOv9xCmX5oV9VDQ0BSBRTpUJs1+13UdwQL0hEvlb7Lxd/kZXKx5G2elb6Dns4R14t
         qtGg==
X-Gm-Message-State: ANoB5pkNxLm7WmDQu2PRPmlKabk4Igw2pguiRCGE2/FW1E74mS/c3i9B
        WbmHP4js1fIjIJAL/0QMytdNOqWlTQkcwA==
X-Google-Smtp-Source: AA0mqf5Js8MEVJeMyUecn6RBxOs4IZyMumQfLotvQgJ5lvYAKQNkyiEHDBwN9Z3b4vqEaY9NyNqMjg==
X-Received: by 2002:adf:e5d1:0:b0:242:849:745 with SMTP id a17-20020adfe5d1000000b0024208490745mr19227398wrn.25.1671094346313;
        Thu, 15 Dec 2022 00:52:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 02/12] t6060: modify multiple files to expose a possible issue with merge-index
Date:   Thu, 15 Dec 2022 09:52:06 +0100
Message-Id: <patch-v10-02.12-de36b52286b-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alban Gruin <alban.gruin@gmail.com>

Currently, merge-index iterates over every index entry, skipping stage0
entries.  It will then count how many entries following the current one
have the same name, then fork to do the merge.  It will then increase
the iterator by the number of entries to skip them.  This behaviour is
correct, as even if the subprocess modifies the index, merge-index does
not reload it at all.

But when it will be rewritten to use a function, the index it will use
will be modified and may shrink when a conflict happens or if a file is
removed, so we have to be careful to handle such cases.

Here is an example:

 *    Merge branches, file1 and file2 are trivially mergeable.
 |\
 | *  Modifies file1 and file2.
 * |  Modifies file1 and file2.
 |/
 *    Adds file1 and file2.

When the merge happens, the index will look like that:

 i -> 0. file1 (stage1)
      1. file1 (stage2)
      2. file1 (stage3)
      3. file2 (stage1)
      4. file2 (stage2)
      5. file2 (stage3)

merge-index handles `file1' first.  As it appears 3 times after the
iterator, it is merged.  The index is now stale, `i' is increased by 3,
and the index now looks like this:

      0. file1 (stage1)
      1. file1 (stage2)
      2. file1 (stage3)
 i -> 3. file2 (stage1)
      4. file2 (stage2)
      5. file2 (stage3)

`file2' appears three times too, so it is merged.

With a naive rewrite, the index would look like this:

      0. file1 (stage0)
      1. file2 (stage1)
      2. file2 (stage2)
 i -> 3. file2 (stage3)

`file2' appears once at the iterator or after, so it will be added,
_not_ merged.  Which is wrong.

A naive rewrite would lead to unproperly merged files, or even files not
handled at all.

This changes t6060 to reproduce this case, by creating 2 files instead
of 1, to check the correctness of the soon-to-be-rewritten merge-index.
The files are identical, which is not really important -- the factors
that could trigger this issue are that they should be separated by at
most one entry in the index, and that the first one in the index should
be trivially mergeable.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6060-merge-index.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 1a8b64cce18..30513351c23 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -7,16 +7,19 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success 'setup diverging branches' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
-	git add file &&
+	cp file file2 &&
+	git add file file2 &&
 	git commit -m base &&
 	git tag base &&
 	sed s/2/two/ <file >tmp &&
 	mv tmp file &&
+	cp file file2 &&
 	git commit -a -m two &&
 	git tag two &&
 	git checkout -b other HEAD^ &&
 	sed s/10/ten/ <file >tmp &&
 	mv tmp file &&
+	cp file file2 &&
 	git commit -a -m ten &&
 	git tag ten
 '
@@ -35,8 +38,11 @@ ten
 EOF
 
 test_expect_success 'read-tree does not resolve content merge' '
+	cat >expect <<-\EOF &&
+	file
+	file2
+	EOF
 	git read-tree -i -m base ten two &&
-	echo file >expect &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
 	test_cmp expect unmerged
 '
-- 
2.39.0.rc2.1048.g0e5493b8d5b

