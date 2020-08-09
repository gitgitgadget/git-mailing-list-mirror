Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D5C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 06:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD0C20709
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 06:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKKyigyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgHIGJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHIGJG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 02:09:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B94C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 23:09:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so5797728iod.12
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6kykpUdDMEHTK70zz/yyCZ0oHxqsVGFP90X+Q8DfDk=;
        b=gKKyigyIGizyMT5OJf9ttTaQNogOyYIdiJkYPlBvXkXWSpfJKKznKfs6v7hdeMdarB
         CjsskvDecGpKvjXGgdpxk2jCf8cppF6Tibp8DrhiOHM5l/7AtnBrAec91aHS7y84+NqQ
         evR/fUO2tGucFJP/TntnqpORSripwqylyd1mYMmtIurlwum5tkM3dWdy5vC8t0nvnSza
         LK6EkPswWMH14fEp9wzFHcrDN2G23FouiUEYhthhDRAF7gEalaShWSR3V3JXTurIFiBg
         h1mv+PifAXY3TDJrjLo4rIWjwCVQgz9EV/IDNZC3Wqtf6X+i0ZmqTp7a1xfyaKlJ6uXd
         1CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=q6kykpUdDMEHTK70zz/yyCZ0oHxqsVGFP90X+Q8DfDk=;
        b=BxCLVfZn15oV+FS7XInNcA8sn9HvSu1n5nIlDDB1ohrzZ0EIuhh80ZTmSyAidMmF41
         1AE1jvaf/3qP+SeCliNMrYxtBqlxfbNqc8EYKy60eY1BgixCEEph7rUQYvcttCYqK5GR
         J9Qu5gShnTd6oX8o6O/L+MIbPVsTl39V/2Li6HhJpT4/iQCmi1v2vxTbKUQuVNVKVWhE
         dRrRGhULglTSzXAQKLLi39xkyYpmOCxoyWMdXmnDxidR4dIYIjNHipSUAPpBZIGDvb3M
         er7at7EU1JIsobQHjpEGEeGTHVJIM7vwdNBRNJY6RTQPQzwTjsEX4PCp3+sjchmxB445
         zR5Q==
X-Gm-Message-State: AOAM531ww2Q6+y/lF4yeEGXTrzxysrNaiErtidPjfUqtUrVfXGKyxynt
        hNmgmXxdPlkaxUGh953skpLUiNxS
X-Google-Smtp-Source: ABdhPJz+fwzqcen35KPTzSX7AJABENAVpTdpWuhkBR/HvDZo9NUHfNbS830Tz97zKb+7Cb6ARcTR+Q==
X-Received: by 2002:a05:6638:bc2:: with SMTP id g2mr13981548jad.21.1596953343689;
        Sat, 08 Aug 2020 23:09:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id y8sm8709157iom.26.2020.08.08.23.09.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 23:09:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] test_cmp: diagnose incorrect arguments
Date:   Sun,  9 Aug 2020 02:08:10 -0400
Message-Id: <20200809060810.31370-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.213.gdd9653da77
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under normal circumstances, if a test author misspells a filename passed
to test_cmp(), the error is quickly discovered when the test fails
unexpectedly due to test_cmp() being unable to find the file. However,
if the test is expected to fail, as with test_expect_failure(), a
misspelled filename as argument to test_cmp() will go unnoticed since
the test will indeed fail, but for the wrong reason. Make it easier for
test authors to discover such problems early by sanity-checking the
arguments to test_cmp(). To avoid penalizing all clients of test_cmp()
in the general case, only check for missing files if the comparison
fails.

While at it, make test_cmp_bin() sanity-check its arguments, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    This change was motivated by seeing Elijah's patch[1] which fixed
    several cases of bogus test_cmp() invocations which perhaps could
    have been discovered earlier had test_cmp() done some
    sanity-checking of its arguments. It turns out that the tests in
    question[1] fail before test_cmp() is ever called, so this patch
    would not have helped catch those mistakes after all. It also only
    helps catch mistakes in test_expect_failure() cases, which are
    relatively rare compared with test_expect_success() cases, thus may
    not have a lot of value. Nevertheless, it's a relatively small and
    simple change which only kicks in when test_cmp() fails, thus should
    not penalize the typical case; there are a handful of `! test_cmp`
    cases, however, which will trigger the additional argument sanity
    checking but that cost is probably small enough to go unnoticed.
    
    [1]: https://lore.kernel.org/git/7f408b7d4069403b969d334f4940ebf87f1dc797.1596906081.git.gitgitgadget@gmail.com/

 t/test-lib-functions.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b791933ffd..8d77deebd2 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -952,7 +952,13 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp() {
-	eval "$GIT_TEST_CMP" '"$@"'
+	test $# -eq 2 || BUG "test_cmp requires two arguments"
+	if ! eval "$GIT_TEST_CMP" '"$@"'
+	then
+		test -e "$1" || BUG "test_cmp 'expect' file missing"
+		test -e "$2" || BUG "test_cmp 'actual' file missing"
+		return 1
+	fi
 }
 
 # Check that the given config key has the expected value.
@@ -981,7 +987,13 @@ test_cmp_config() {
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin() {
-	cmp "$@"
+	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
+	if ! cmp "$@"
+	then
+		test -e "$1" || BUG "test_cmp_bin 'expect' file missing"
+		test -e "$2" || BUG "test_cmp_bin 'actual' file missing"
+		return 1
+	fi
 }
 
 # Use this instead of test_cmp to compare files that contain expected and
-- 
2.28.0.213.gdd9653da77

