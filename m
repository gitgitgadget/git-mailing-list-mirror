Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA800EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjFTTDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFTTDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:03:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E819B
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:03:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30adc51b65cso5209494f8f.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687287784; x=1689879784;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vZStTun0CEhieYmvg+kmLlBXrIfewSJl/g3lbUcPAjo=;
        b=egEewLXtmxeX56CeQEqDPYKXC7Gzi0mnPLsrwnfiGtnGH8mp6Yp8eAAEP1qPeGBHKb
         ryv+yRCCVGm22hDyOF3TWLr4oY1qpyqxcE6/Q64nNgY+pOAh5R+QiJcZuSCMfDTSPWQ0
         l6iOCIEOBbzfxjoSdUfKUkS/dSv10UfG0xLFCVzboq26Rbz3RkmCm/P1qlmwWW/aVgbN
         +goWbRAZOjCBmzfVlDWjaWOjglpcChmNTwpy+lm7t76C3/DBO74UqpqDfqLPA+2vxrZg
         HTW3s6GSsDH5ZwgeYqD+1JDPjmD3qDZxK4HWJt71wyFLx31M4axII6YFcT86WDIAGKc7
         A9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287784; x=1689879784;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZStTun0CEhieYmvg+kmLlBXrIfewSJl/g3lbUcPAjo=;
        b=AmYvQFfrdwHTPjxA0J043Cdazk5e8MW2n/PNAheSAWvF+Gxgb1xM4p+rNyzKzS0lOQ
         or7a0lwJY4GRAOuK4eilSMgPBatQuNPwv0ZrtNUoeDAzznC1dDJUNdcK9n25XkJ5ZbE7
         O3xOCT2V+tacdRSJCy6EmvqU5EfYWQFmS4Cg+jGZp52O5TA5NiVxp4peyZV1p6qPY7oS
         p4WaQOabU3uulUt9E9YunIszRtgZpHqHTYIcjABtRIM4CUw43WjVaqod3V7yBafR+8Yt
         A8gtfJf0ff82YrADgKzu3GNIjQ4BxMPyI+GEm7nVtNTYUrDweGNMyU5PgVpcE92QIPB7
         m3Ig==
X-Gm-Message-State: AC+VfDyS3sJAnNYpDBp1R2JrZR/CyRPmA6YE/RKzDwokBYFsAkjtGw66
        giMqulmLCnkrcF70vsNLIq1HHuCYwzk=
X-Google-Smtp-Source: ACHHUZ6oTdqw0lQ20ICoStUmfKaF3wOUoX85wHIWEENLLay2LyGowdT27HRw9k6Ax6m/Rezy4FDzMQ==
X-Received: by 2002:adf:d08f:0:b0:30f:bbec:216b with SMTP id y15-20020adfd08f000000b0030fbbec216bmr10814314wrh.65.1687287783612;
        Tue, 20 Jun 2023 12:03:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d6807000000b003127741d7desm2582080wru.58.2023.06.20.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:03:03 -0700 (PDT)
Message-Id: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:03:02 +0000
Subject: [PATCH] repack: only repack .packs that exist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In 73320e49add (builtin/repack.c: only collect fully-formed packs,
2023-06-07), we switched the check for which packs to collect by
starting at the .idx files and looking for matching .pack files. This
avoids trying to repack pack-files that have not had their pack-indexes
installed yet.

However, it does cause maintenance to halt if we find the (problematic,
but not insurmountable) case of a .idx file without a corresponding
.pack file. In an environment where packfile maintenance is a critical
function, such a hard stop is costly and requires human intervention to
resolve (by deleting the .idx file).

This was not the case before. We successfully repacked through this
scenario until the recent change to scan for .idx files.

Further, if we are actually in a case where objects are missing, we
detect this at a different point during the reachability walk.

In other cases, Git prepares its list of packfiles by scanning .idx
files and then only adds it to the packfile list if the corresponding
.pack file exists. It even does so without a warning! (See
add_packed_git() in packfile.c for details.)

This case is much less likely to occur than the failures seen before
73320e49add. Packfiles are "installed" by writing the .pack file before
the .idx and that process can be interrupted. Packfiles _should_ be
deleted by deleting the .idx first, followed by the .pack file, but
unlink_pack_path() does not do this: it deletes the .pack _first_,
allowing a window where this process could be interrupted. We leave the
consideration of changing this order as a separate concern. Knowing that
this condition is possible from interrupted Git processes and not other
tools lends some weight that Git should be more flexible around this
scenario.

Add a check to see if the .pack file exists before adding it to the list
for repacking. This will stop a number of maintenance failures seen in
production but fixed by deleting the .idx files.

This brings us closer to the case before 73320e49add in that 'git
repack' will not fail when there is an orphaned .idx file, at least, not
due to the way we scan for packfiles. In the case that the .pack file
was erroneously deleted without copies of its objects in other installed
packfiles, then 'git repack' will fail due to the reachable object walk.

This does resolve the case where automated repacks will no longer be
halted on this case. The tests in t7700 show both these successful
scenarios and the case of failing if the .pack was truly required.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    [RFC] repack: only repack .packs that exist
    
    This is based on tb/collect-pack-filenames-fix.
    
    This is an RFC since there is some internal disagreement as to whether
    this is a safe scenario to "ignore" during a repack.
    
    I'm of the opinion that blocking on the case where there are no missing
    objects is unnecessary noise, and matches our behavior before the change
    to scan for '.idx' files.
    
    I'm submitting this to the list to gather more opinions about the safety
    and/or necessity of this change before moving forward with a full
    review.
    
    This is related to the deletion of .packs before .idx files that I
    submitted as [1]
    
    [1]
    https://lore.kernel.org/git/pull.1547.git.1687287675248.gitgitgadget@gmail.com
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1546%2Fderrickstolee%2Frepack-ignore-idx-no-pack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1546/derrickstolee/repack-ignore-idx-no-pack-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1546

 builtin/repack.c  |  3 +++
 t/t7700-repack.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1e21a21ea82..b1695c9b2eb 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -123,6 +123,9 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		strbuf_add(&buf, e->d_name, len);
 		strbuf_addstr(&buf, ".pack");
 
+		if (!file_exists(mkpath("%s/%s", packdir, buf.buf)))
+			continue;
+
 		for (i = 0; i < extra_keep->nr; i++)
 			if (!fspathcmp(buf.buf, extra_keep->items[i].string))
 				break;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 08b5ba0c150..e780efe5e0c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -239,6 +239,10 @@ test_expect_success 'repack --keep-pack' '
 			mv "$from" "$to" || return 1
 		done &&
 
+		# A .idx file without a .pack should not stop us from
+		# repacking what we can.
+		touch .git/objects/pack/pack-does-not-exist.idx &&
+
 		git repack --cruft -d --keep-pack $P1 --keep-pack $P4 &&
 
 		ls .git/objects/pack/*.pack >newer-counts &&
@@ -247,6 +251,36 @@ test_expect_success 'repack --keep-pack' '
 	)
 '
 
+test_expect_success 'repacking fails when missing .pack actually means missing objects' '
+	test_create_repo idx-without-pack &&
+	(
+		cd idx-without-pack &&
+
+		# Avoid producing difference packs to delta/base choices
+		git config pack.window 0 &&
+		P1=$(commit_and_pack 1) &&
+		P2=$(commit_and_pack 2) &&
+		P3=$(commit_and_pack 3) &&
+		P4=$(commit_and_pack 4) &&
+		ls .git/objects/pack/*.pack >old-counts &&
+		test_line_count = 4 old-counts &&
+
+		# Remove one .pack file
+		rm .git/objects/pack/$P2 &&
+
+		ls .git/objects/pack >before-pack-dir &&
+
+		test_must_fail git fsck &&
+		test_must_fail git repack --cruft -d 2>err &&
+		grep "bad object" err &&
+
+		# Before failing, the repack did not modify the
+		# pack directory.
+		ls .git/objects/pack >after-pack-dir &&
+		test_cmp before-pack-dir after-pack-dir
+	)
+'
+
 test_expect_success 'bitmaps are created by default in bare repos' '
 	git clone --bare .git bare.git &&
 	rm -f bare.git/objects/pack/*.bitmap &&

base-commit: 73320e49add4b56aba9bf5236a216498fa8ccc22
-- 
gitgitgadget
