Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C4DC4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EDE20867
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theori-io.20150623.gappssmtp.com header.i=@theori-io.20150623.gappssmtp.com header.b="YQR7Un5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgKJOHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJOHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 09:07:02 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569FC0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 06:07:02 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i7so10243981pgh.6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XYbqTMqHnpB+j63Z49PF6fUJWZmbxh5cp5Ok1LuC2TE=;
        b=YQR7Un5qHGMuKdr0s6+g9rrPY/wEnhHhqt9rkIgOID3MfHJ3u3NlUGADS/AJho8gAe
         BoR+tlkdCVbi8cey44fSJY8bpv3T8Gq/J+LHCRpnPzRokIKirtnuc8k8jaqTAaARSyTn
         aXyk6AVnsd1m1vveUwll4QEcbZ3x4kDJp3VA/BAdd6atX6pFqeYP52dHpbvh28+gE9R0
         UoK7K5tNML/5o8Brk7zI1XHpkoRwWWdsjXABJWmM7V8avfCcUnF29t8rNLJ9mVzytwQQ
         lOfivZP9HMiUMbRbex7EbomKWPU7/mU1ojIoe/1ZqteCrUSjHqwk/qQB+/h1jpBoGmsK
         br2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYbqTMqHnpB+j63Z49PF6fUJWZmbxh5cp5Ok1LuC2TE=;
        b=Z/AWEwsL9ty0RZITHg0EaukvidKBxZBoqjmjn5vzLFnskUzLZfF0By419hfNbdbL7P
         5N3ATXMLYh5DHEH69fjtNElxu9LV/F4qsSlOAzeuK7mnLzJHAM09ND+e9emRWv86VN95
         1umjHfACNjSz7t+ZQ4nl7Jn2VsFvKD/zXcAO7+CvDv71lK0zWEuEuukkDHZw8PrmQr8X
         sh9wIA2cqmEgOSwUs8l1PVpyqipQo+k9m27B7QYtDK1FEseRHiHntwywUch0Sp6z/FqT
         QMTPGK3vgRnks5WJqLH9V5V/WO8TtdOKOnMmuRe+RBbrmPdaDJTZnG5GTwiTv62MsDuo
         ux2Q==
X-Gm-Message-State: AOAM533w4rPQUoTWxYjUcVGkGtgHD9h8mtUjKVJ1vozbqWTPVWksllvn
        P/YpD7Hp+SmQdS+bCmLeCbxfqw==
X-Google-Smtp-Source: ABdhPJz2FA7Zu1WRRsANzt7JG/H/E+q+7HmdFXubWRN6lUd/jNY0UxI+oPUlOvBzKPXgTm2JiB8HBw==
X-Received: by 2002:a62:b417:0:b029:18b:8c55:849f with SMTP id h23-20020a62b4170000b029018b8c55849fmr17906379pfn.27.1605017221639;
        Tue, 10 Nov 2020 06:07:01 -0800 (PST)
Received: from [127.0.0.1] ([222.99.114.187])
        by smtp.gmail.com with ESMTPSA id t18sm3454691pjs.56.2020.11.10.06.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 06:07:00 -0800 (PST)
From:   Jinoh Kang <luke1337@theori.io>
To:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
 <xmqq4km4lppy.fsf@gitster.c.googlers.com>
 <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
 <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
Subject: [PATCH v4] diff: make diff_free_filespec_data accept NULL
Message-ID: <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
Date:   Tue, 10 Nov 2020 14:06:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today, diff_free_filespec_data crashes when passed a NULL pointer.
Commit 3aef54e8b8 ("diff: munmap() file contents before running external
diff") introduced calls to diff_free_filespec_data in run_external_diff,
which may pass NULL pointers.

Git uses NULL filespecs to indicate unmerged files when merge conflict
resolution is in progress.  Fortunately, other code paths bail out early
even before NULL can reach diff_free_filespec_data(); however, difftool
is expected to do a full-blown diff anyway regardless of conflict
status.

Fix this and prevent any similar bugs in the future by making
`diff_free_filespec_data(NULL)` a no-op.

Also, add a test case that confirms that running difftool --cached with
unmerged files does not SIGSEGV.

Signed-off-by: Jinoh Kang <luke1337@theori.io>
---
 diff.c              |  3 +++
 t/t7800-difftool.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/diff.c b/diff.c
index d24f47df99..ace4a1d387 100644
--- a/diff.c
+++ b/diff.c
@@ -4115,6 +4115,9 @@ void diff_free_filespec_blob(struct diff_filespec *s)
 
 void diff_free_filespec_data(struct diff_filespec *s)
 {
+	if (!s)
+		return;
+
 	diff_free_filespec_blob(s);
 	FREE_AND_NULL(s->cnt_data);
 }
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 524f30f7dc..e9391abb54 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -728,6 +728,29 @@ test_expect_success 'add -N and difftool -d' '
 	git difftool --dir-diff --extcmd ls
 '
 
+test_expect_success 'difftool --cached with unmerged files' '
+	test_when_finished git reset --hard &&
+	echo base >file &&
+	git add file &&
+	git commit -m base &&
+	git checkout -B conflict-a &&
+	git checkout -B conflict-b &&
+	git checkout conflict-a &&
+	echo conflict-a >>file &&
+	git add file &&
+	git commit -m conflict-a &&
+	git checkout conflict-b &&
+	echo conflict-b >>file &&
+	git add file &&
+	git commit -m conflict-b &&
+	git checkout master &&
+	git merge conflict-a &&
+	test_must_fail git merge conflict-b &&
+	: >expect &&
+	git difftool --cached --no-prompt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'outside worktree' '
 	echo 1 >1 &&
 	echo 2 >2 &&
-- 
2.26.2
