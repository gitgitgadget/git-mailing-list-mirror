Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90041F597
	for <e@80x24.org>; Sun,  5 Aug 2018 04:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeHEGXq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 02:23:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37309 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeHEGXq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 02:23:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so4237745pll.4
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 21:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=al5D2/NMnY9G+thso6nWecgqPA7eZZODUUeFTa+5VO8=;
        b=Qh+u9G5cJOL/o0OSQPmg+xjwMWBK1napPO7bFdrQ1vdSGy1biEDaM35kdRmsZjmXn/
         te2qe3ixHmLCDsr0GVToZ46kjRNFlofMtiGBmDiCTO9+/xwMBk8RVB441tJa0F8VZP2k
         0WgA2FatUWQBtv+3fH+ZdsTnnA/eznkIqbfXEZTk779cqukHZZYRuVe9fTGWRfdWWKc4
         Ok9P7775zx7GVSKjE/hGzMOJ0lo7PyA5VWm37WAqJujmkjCvMY1UBaaDLEAoW5w1X2Fd
         hmNxvtkhqUMZo/r8M3D4u5OY/DUuHW1YyLeYOyIcUpv0ViNMQ/J//j9J26rxZSfFizFW
         3ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=al5D2/NMnY9G+thso6nWecgqPA7eZZODUUeFTa+5VO8=;
        b=A/ZGQufyT4U+psD8WfbO9iYNcFLyo8Qkib6n8966PGr25RxllgHUaU+6WMlTH1R9Av
         1iVNuObcODauehUiokks31sUwVW4yE26xaYjHHo2Jp2euY2hsMwivs/pnhdXBlPgAuXx
         Wfh9XQaTxoaqi/dH1RKo67YqUuHi6C+iv+66fazyHG5jJkPMjosBmtE4Fs0DBnHCI/YS
         RzLXSYniq0HOZ9vzcmqQHzPWzuFKxmsOhWscfre7QhThUcjofqEsg+k8zMdRNyLbZOg9
         Fbovo/uAMfXwn+jjFlKyrBB3w2dh/nsIW6XgKrfVi2uitZeA/dHSGI4Jrh+DpLEuKXx2
         hDGQ==
X-Gm-Message-State: AOUpUlFr/b2xO/pRbMpZPOrcF6RU1bF58JPHNOoFyRO2e1cHQMnYrWKZ
        ww1jaajoT45I4xZlv3Im47I=
X-Google-Smtp-Source: AAOMgpd1Vah0OrXqdVMsoKoZN3kh+4RKsfwzkfbMXwU7Y8uK9ht/mVxsuh8obkdgViVrDN+3DAPVfQ==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19-v6mr9166938pls.238.1533442837419;
        Sat, 04 Aug 2018 21:20:37 -0700 (PDT)
Received: from wchargin-t440s.attlocal.net (99-4-123-58.lightspeed.sntcca.sbcglobal.net. [99.4.123.58])
        by smtp.gmail.com with ESMTPSA id 87-v6sm18209914pfn.103.2018.08.04.21.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 21:20:36 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, wchargin@gmail.com
Subject: [PATCH v2] t/test-lib: make `test_dir_is_empty` more robust
Date:   Sat,  4 Aug 2018 21:20:31 -0700
Message-Id: <20180805042031.20447-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.548.geb6c14151
In-Reply-To: <20180805033629.GH258270@aiede.svl.corp.google.com>
References: <20180805033629.GH258270@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the `test_dir_is_empty` function appears correct in most normal
use cases, it can fail when filenames contain newlines. This patch
changes the implementation to use `ls -A`, which is specified by POSIX.
The output should be empty exactly if the directory is empty.

The newly added unit test fails before this change and passes after it.

Signed-off-by: William Chargin <wchargin@gmail.com>
---

I originally wrote this patch for the standalone Sharness library, but
that library advises that such patches be sent to the Git mailing list
first.

 t/t0000-basic.sh        | 29 +++++++++++++++++++++++++++++
 t/test-lib-functions.sh |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 34859fe4a..3885b26f9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,35 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_expect_success 'test_dir_is_empty behaves even in pathological cases' "
+	run_sub_test_lib_test \
+		dir-empty 'behavior of test_dir_is_empty' <<-\\EOF &&
+	test_expect_success 'should pass with actually empty directory' '
+		mkdir empty_dir &&
+		test_dir_is_empty empty_dir
+	'
+	test_expect_success 'should fail with a normal filename' '
+		mkdir nonempty_dir &&
+		touch nonempty_dir/some_file &&
+		test_must_fail test_dir_is_empty nonempty_dir
+	'
+	test_expect_success 'should fail with dot-newline-dot filename' '
+		mkdir pathological_dir &&
+		printf \"pathological_dir/.\\\\n.\\\\0\" | xargs -0 touch &&
+		test_must_fail test_dir_is_empty pathological_dir
+	'
+	test_done
+	EOF
+	check_sub_test_lib_test dir-empty <<-\\EOF
+	> ok 1 - should pass with actually empty directory
+	> ok 2 - should fail with a normal filename
+	> ok 3 - should fail with dot-newline-dot filename
+	> # passed all 3 test(s)
+	> 1..3
+	EOF
+"
+
+
 ################################################################
 # Basics of the basics
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca..f7ff28ef6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -568,7 +568,7 @@ test_path_is_dir () {
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
 	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	if test "$(ls -A1 "$1" | wc -c)" != 0
 	then
 		echo "Directory '$1' is not empty, it contains:"
 		ls -la "$1"
-- 
2.18.0.548.geb6c14151

