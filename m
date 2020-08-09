Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90260C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE25206C0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI2lvFWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHIRnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIRnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 13:43:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD3EC061756
        for <git@vger.kernel.org>; Sun,  9 Aug 2020 10:43:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c6so5753184ilo.13
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Guo+6xyXMMVf1ikhrYASV1gt3QZ1ce5jsdXG7aMqm/Q=;
        b=LI2lvFWwCiJnpXLyDRW2YZQyJvkgsTgYAcjrkJLjkY0veZnL/P2vpMz0etkjRKlQWf
         nhMHPu6pw5WhIszUK8FuxEwM8qEHZWrm5JRe90K3uP5j7l5yyR/bc+gMwEUjniiM1LfH
         M8dvHJA8UfkkcXFuIyQZpjxZZU48jRSYXsUPiTJrDlRD0hJcngo/YifVsBymPBToItmp
         75Xom4r3jxsjMO4VMqx1nUI+PufEjY8rhuoAZ4OqizdjjFtvwXdFxz4xtpyYed3g9jbs
         ZB/qtVj56us/4hQti9NVhsslrYTK3QaOuUeZTCIlMKib1tcb5PakvtBX7lr7+PPsmUGC
         gA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Guo+6xyXMMVf1ikhrYASV1gt3QZ1ce5jsdXG7aMqm/Q=;
        b=b8r+g1xWfJbFNv18L7im/VGQgNKG1F/nzLpHKRq6ltFIKxpjXhlpe7X5fdkg5nVpoK
         5Tu0y6sCx7BsntVLx2Jd67OD7xlK2wPujP2GWWgRx0HTNnsLfgfSpOeg0bT2hwS8lhxH
         lny+72vS5u9202ELNXlDc753FooGmMkl//yvkoFxzpFQ9Msx4rNPAb8S4Br2kvciF7u/
         RjOhtP7vV/KhXNgz9kIo3UrDZ8eC4S7u4+0paokAbyUvamFBoXWVOK808tqFfCy5+6i+
         sbI0IyB22MmDAPPZr4g8zKAEbya8Ma0neKwDVyKYvKsjiyIkw+KIW7DoqrLDSdIOL0VN
         eoWw==
X-Gm-Message-State: AOAM531auVaeiYDBc0v5SUf2fVYPYfMfnxRXAECKwTzzrmzujzTcg8jZ
        AV/GucFcJaakDtRwqp7PWqqQihJ2
X-Google-Smtp-Source: ABdhPJxgMsAlrYeZnnQf0AEM1kmAA91IJjaDk7iuuf2nop6gG9LLNrNl3OF2U8/3tws0nsMbv/qBCg==
X-Received: by 2002:a92:4957:: with SMTP id w84mr10679810ila.164.1596994996292;
        Sun, 09 Aug 2020 10:43:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id v8sm10245307ile.74.2020.08.09.10.43.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2020 10:43:15 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] test_cmp: diagnose incorrect arguments
Date:   Sun,  9 Aug 2020 13:42:09 -0400
Message-Id: <20200809174209.15466-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693
In-Reply-To: <20200809060810.31370-1-sunshine@sunshineco.com>
References: <20200809060810.31370-1-sunshine@sunshineco.com>
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
    This is a re-roll of [1] which was motivated by seeing Elijah fix[2]
    several cases of bogus test_cmp() calls which perhaps could have
    been detected earlier.
    
    Changes since v1:
    
    * take into account that some callers pass "-" (meaning standard
      input) as an argument to test_cmp() (pointed out privately by
      Junio)
    
    * show the name of the missing file rather than a placeholder
      (Shourya[3])
    
    [1]: https://lore.kernel.org/git/20200809060810.31370-1-sunshine@sunshineco.com/
    [2]: https://lore.kernel.org/git/7f408b7d4069403b969d334f4940ebf87f1dc797.1596906081.git.gitgitgadget@gmail.com/
    [3]: https://lore.kernel.org/git/20200809083227.GA11219@konoha/

Interdiff against v1:
  diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
  index 8d77deebd2..a12d6a3fc9 100644
  --- a/t/test-lib-functions.sh
  +++ b/t/test-lib-functions.sh
  @@ -955,8 +955,8 @@ test_cmp() {
   	test $# -eq 2 || BUG "test_cmp requires two arguments"
   	if ! eval "$GIT_TEST_CMP" '"$@"'
   	then
  -		test -e "$1" || BUG "test_cmp 'expect' file missing"
  -		test -e "$2" || BUG "test_cmp 'actual' file missing"
  +		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
  +		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
   		return 1
   	fi
   }
  @@ -990,8 +990,8 @@ test_cmp_bin() {
   	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
   	if ! cmp "$@"
   	then
  -		test -e "$1" || BUG "test_cmp_bin 'expect' file missing"
  -		test -e "$2" || BUG "test_cmp_bin 'actual' file missing"
  +		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
  +		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
   		return 1
   	fi
   }

 t/test-lib-functions.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b791933ffd..a12d6a3fc9 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -952,7 +952,13 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp() {
-	eval "$GIT_TEST_CMP" '"$@"'
+	test $# -eq 2 || BUG "test_cmp requires two arguments"
+	if ! eval "$GIT_TEST_CMP" '"$@"'
+	then
+		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
+		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
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
+		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
+		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
+		return 1
+	fi
 }
 
 # Use this instead of test_cmp to compare files that contain expected and
-- 
2.28.0.220.ged08abb693

