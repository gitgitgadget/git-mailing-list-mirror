Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C95C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A353822202
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theori-io.20150623.gappssmtp.com header.i=@theori-io.20150623.gappssmtp.com header.b="d4XCpLNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKFRO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFRO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:14:59 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E98AC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 09:14:59 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so1428052pgk.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori-io.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rbh4Acwgj2n8JEoxEW6LgBUaXJjkB7W7ILQyNn1fYm8=;
        b=d4XCpLNy6aSFC3cRLQDZToHdd2SkfI9PA7+9622t+mxIUuNqU0nlmBA+0rnwGb4E7k
         xG7MQGMfJXzbiv2hS3jItjlSq5abH0D2JJnaRm0vYk9fNSgFSomzdIFbquhuZSnEsqEw
         g3Owd0DGIfrzYk43rA9ntyldiD3QlK6Q1Aszf1IY/zL0d4KlpoiyOULqia0Z2XsWr6Vb
         BSCf96YzbSGvm+BI7lYwd79UXggDFuQUgF5yypCl+hvPISuNPmg8OrxX95BW/KQ1FQhz
         oB0Ieum87u9sUQUSA3Y7CBtICjPqr7CunfSxc179nUP8Cp+y0D+XN5F05YW0jhOAECss
         kWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbh4Acwgj2n8JEoxEW6LgBUaXJjkB7W7ILQyNn1fYm8=;
        b=muZ496VVHCCdqtqU7cSURaSps4KJsW4mYJPU7otyCzvjMbEVubINTI3OCvbN/g8bUE
         RvbrH7kGcKRX3BY0hIcjgPD68JhLGpspIDLee0PonhExt+E95EBOAujJ5B6y9NyTOP3i
         GfztHGTjXEAcT086DdOJcFm610XXtg/aJP8D7o2LPpMMnPOdWqZuxFVLAYSp+iPq1y5J
         gPt6VOufJkSu+hb6lg/RRZBoDCkhkEdCNZ60/3oTfiFL0wr1Eu4MYZSmEw2iYDyORc/9
         4BI2EUCHVDbjbwZmpJAeuxvsG0KwboSQmZl+6/YTmi7cVMq606LqJkuPLY8anM7GrUVU
         8Vbw==
X-Gm-Message-State: AOAM533vcNBLZzulTn1bk2bhyYKxSTvc5p97HgrGirZLRrolWMkm758k
        YFd6yGCWaDjBEeP2r8/sVuE5DA==
X-Google-Smtp-Source: ABdhPJwtrEMuDiQBxn5FxlEGSv3Zv4qjrmv9Dep7eiwr0Bo8UGI0WJ/WNs3wFgNRE/1oDGyOBuccZA==
X-Received: by 2002:a63:5b5b:: with SMTP id l27mr2537311pgm.11.1604682898671;
        Fri, 06 Nov 2020 09:14:58 -0800 (PST)
Received: from [127.0.0.1] ([118.34.160.70])
        by smtp.gmail.com with ESMTPSA id i11sm2710491pfd.211.2020.11.06.09.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:14:58 -0800 (PST)
Subject: [PATCH v3] diff: make diff_free_filespec_data accept NULL
From:   Jinoh Kang <luke1337@theori.io>
To:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
 <xmqq4km4lppy.fsf@gitster.c.googlers.com>
 <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
Message-ID: <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
Date:   Fri, 6 Nov 2020 17:14:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 3aef54e8b8 ("diff: munmap() file contents before running external
diff") introduced calls to diff_free_filespec_data in
run_external_diff, which may pass NULL pointers.

Fix this and prevent any such bugs in the future by making
`diff_free_filespec_data(NULL)` a no-op.

Fixes: 3aef54e8b8 ("diff: munmap() file contents before running external diff")
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

