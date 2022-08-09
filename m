Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4E1C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbiHITJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbiHITI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:08:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E41CFDA
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l4so15268628wrm.13
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gtJJT2CWN5LP9jVWyKeIJcyps2N5tS2OX869fEppxYk=;
        b=JIl4jXJSN6Me+brH5JEng056KikOySU14/bvK3+X+YpFbWFTbrDm4AP+OAXQBj4k0O
         JIcqoe6v8Id/V2DVHiEJ9LlSfAhJGTn+2/UgVwCmie+gxCnfd3yTfgHOavJ6Ffmey5zz
         QhzPJ7yqdGYkOroP8BNTrikU5C3D2qvB/EDl5a313i6e2PWjESxoCVlVrjnGADfKMx8N
         QJghU4h00oXYJftlH0f8WAVLXiKO+f6XdhkpwHfBn4Jimy88fX1toDtql5+VctelGqMW
         mh+OZaKd86Po90S53pZebtZEofxFEIsmXw0YqQ1ASGXvgr1C02b5pIAzqZsZ1+bI/Vz+
         Jv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gtJJT2CWN5LP9jVWyKeIJcyps2N5tS2OX869fEppxYk=;
        b=ZUzK3r25jlC2PYJ+FBUO6YpFQUI93LLlxEn7u3kz/HYBpnLU6YCEGeQa5SBee7Hbj/
         HsUxrIpv/kDbbjbi+cTQ870iyYZiqdr3gY68wvg3rxeGJu8KwAqexXa3OMUx4vZNPDn0
         sXzU3oKo76WoZOZQfLTa9jDr1//FKVBmiNkGwYQX/NyQrvZQ+rWtQKtGFtsPeyT6Dhnq
         LZYg5u7MuVdf5/WvVk5qjD0hvyVEpa+ExBt/yE2OjlqEbTyvMY1ul+OY5MHqwm6oxlQZ
         9lHo90DPZGFrP31rligg2+qt1Y9db+1XuMvVk26uP8enc5cCCALGB+Tw8HgpIPx6XrZi
         2uhA==
X-Gm-Message-State: ACgBeo00AvY8oQ+pdwWukLeFMtKpZj546soOb/IEYbJS6Adg6HlCxNs5
        nh6jH9ot9/KK5eBSRMbZmhCb8WFxrKg=
X-Google-Smtp-Source: AA6agR4NgvmJKK/GfUXkIJy+VC5Ipx7vGpWJA0H673wnZ/SpUhde834mHxgKG3SurBV/DP35tCbAog==
X-Received: by 2002:a5d:59a5:0:b0:222:c5a5:59c4 with SMTP id p5-20020a5d59a5000000b00222c5a559c4mr8456006wrr.656.1660071324932;
        Tue, 09 Aug 2022 11:55:24 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:24 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 01/14] t6060: modify multiple files to expose a possible issue with merge-index
Date:   Tue,  9 Aug 2022 20:54:16 +0200
Message-Id: <20220809185429.20098-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 t/t6060-merge-index.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index ed449abe55..d0d6dec0c8 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -5,16 +5,19 @@ test_description='basic git merge-index / git-merge-one-file tests'
 
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
@@ -33,8 +36,11 @@ ten
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
2.37.1.412.gcfdce49ffd

