Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F48C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9878F2064B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theori-io.20150623.gappssmtp.com header.i=@theori-io.20150623.gappssmtp.com header.b="Aa3HJza9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgKKMQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgKKMPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:15:16 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039ABC0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:15:16 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id m13so1332116pgl.7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori-io.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xdjkohjXv8J5Ri1Mh936C+ho5HKbkz3x49T9nCQTj3c=;
        b=Aa3HJza9IpUBin17RQhf0fqsdPLoPCVwX6go/dPICAfQQUtA8KxmQ8f3XADZemu/+W
         BZiofbpqFKBBEDlUGiHhdxqiCscHCeKs7Q3rajVANebCeDMbMrRl2hrO323AF9+waFjv
         ZpfftDf6bHOYhnvTZK1GhKUh/io19OQJfZqrBqyzjTQY9gdxW/+TKlkgJ5kZncWxAaap
         pqDByL0tKUfXdrw3bzx9ETd/iPLjyVcSvKXAWBvSW1/v+NERPszSbs+xy8efp8jC9Qyl
         4A2iAhv/CVZS1yoDFGRA9EDPIro0ZDavG+ZqvgTvkTrBdX8f5cPGuhs6zZems/p89tJC
         tSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xdjkohjXv8J5Ri1Mh936C+ho5HKbkz3x49T9nCQTj3c=;
        b=rnPLHJmoklNbhE11/8TPbLrV37vakNTf2kaFvbL6duEHJxGBMvYOLK4IH/81Ej5dLs
         bo/Af2PWFViFh3plR0LvYF1U/DXe7tEYbP4KtXhuxKaIJwd2x3MfCdO+fzTcIBNYWo0T
         6Fy0Q31nTtGC9K9kzwF18Lkduzutidxj6ZdXShlDqgKJBBw/vgZM22v89Qf2mNyJbN0x
         d/XSg91FlTyTUXpF633G0J2s/vx7gX+jRWfFWqGm/umUZ+bDYrizTZ6TPcf/VEpj4A6d
         Dbu6wv3ekxu1gRMQzRJvPGtNSz/YUthzZHUyczD6GJEHLAX0QcJumMYgh8ShBUOHLcg6
         8+Tw==
X-Gm-Message-State: AOAM530IAtpGlxI2cl8voyImWuOyOJAaNyeT7DzkgzqK8jZGic7/eQ9a
        docyyN74uezW25m8wjzWc3SLQGEw5HVJKSa/
X-Google-Smtp-Source: ABdhPJzaPy71ebyJlsuqhx//AAS763QnLjJm5ALphDWdF81Gzh3/l+ArzsiwJLHrt+k03DFOB3cQ4w==
X-Received: by 2002:a63:4855:: with SMTP id x21mr21596608pgk.382.1605096914917;
        Wed, 11 Nov 2020 04:15:14 -0800 (PST)
Received: from [127.0.0.1] ([14.33.99.107])
        by smtp.gmail.com with ESMTPSA id r73sm2625151pfc.20.2020.11.11.04.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 04:15:13 -0800 (PST)
Subject: [PATCH v5] diff: make diff_free_filespec_data accept NULL
From:   Jinoh Kang <luke1337@theori.io>
To:     Junio C Hamano <junio@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
 <xmqq4km4lppy.fsf@gitster.c.googlers.com>
 <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
 <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
 <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
Message-ID: <5d4315c5-a0ae-2857-fbcc-ec6166d025b6@theori.io>
Date:   Wed, 11 Nov 2020 12:15:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff_free_filespec_data crashes when passed a NULL fillspec pointer.
Commit 3aef54e8b8 ("diff: munmap() file contents before running external
diff", 2019-07-11) introduced calls to diff_free_filespec_data in
run_external_diff without also checking if the argument is NULL.

Git uses NULL filespecs to indicate unmerged files when merge conflict
resolution is in progress.  Fortunately, other code paths bail out early
even before NULL can reach diff_free_filespec_data(); however, difftool
is expected to do a full-blown diff anyway regardless of conflict
status.

Fix this and prevent any similar bugs in the future by making
`diff_free_filespec_data(NULL)` a no-op.

Add a test case that confirms that running difftool --cached with
unmerged files does not result in a SIGSEGV.

Signed-off-by: Jinoh Kang <luke1337@theori.io>
---
 diff.c              |  3 +++
 t/t7800-difftool.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

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
index 524f30f7dc..a578b35761 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -728,6 +728,19 @@ test_expect_success 'add -N and difftool -d' '
 	git difftool --dir-diff --extcmd ls
 '
 
+test_expect_success 'difftool --cached with unmerged files' '
+	test_when_finished git reset --hard &&
+
+	test_commit conflicting &&
+	test_commit conflict-a conflict.t a &&
+	git reset --hard conflicting &&
+	test_commit conflict-b conflict.t b &&
+	test_must_fail git merge conflict-a &&
+
+	git difftool --cached --no-prompt >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'outside worktree' '
 	echo 1 >1 &&
 	echo 2 >2 &&
-- 
2.26.2

