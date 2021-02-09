Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0CBC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168F264E53
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhBIXGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhBIW1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:27:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819CAC03C063
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g6so10827714wrs.11
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBdhwMrgtLU5uFKaxMQM3ZkRyxENTCFTJn8gM4jRsbI=;
        b=QtDwmEKOfPHTn6nQnvgaSz0A7TTIyhv5FikGgbT1TT0XoM9wHOfzs0yBRUG7/IfzJf
         Z9Xer0kRkr6oIbwylbOjuZOuEjOgytokMlUFaa31qItePKQR05S1ItMVyMteNuVs0inc
         KF85i1nVXvT++plaUT3VscrM4DlFf5djmy0I8cnPTJgOhv/sffKT/+FVwomTgbZtnG2K
         iEF/Nh/AwoBuP+GQ3XGc7Rs4z/GdDp/irT1Y7z92RfnOWZpCSAZYSA0LuzpP8j63C5/S
         f11yafqs24Yee3WuXBoCMhbyN4zWBkXggQbpVEa3HKYkWqBqmVYOUz7vlTM5F5vTjGYL
         RzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBdhwMrgtLU5uFKaxMQM3ZkRyxENTCFTJn8gM4jRsbI=;
        b=Sr12U7kB6y6CQB177g+r+bLVDtQ+D1GCBHEQYxbQ1ylyc6lUIPDUoPIyGfHInU5X5N
         VMQHSJFYCoLBWWKCwsqc3RGsy4QIwpnCmtf1vRBTuqW4M7bgnpSjVBymlvsiEtcHFASM
         PEuqMgSRDAQpFdb8hMK/gaFROr7bNXU1c++0eUJfCE54yhkRm6j5FUQYeQ5cmZPmsyTr
         4rjwJPYFF/i7ISQ03ClaZ86URU/f1ENYB0hbiS0yIGoLrV3HXjO0C0ieGhH6Ra0GyfWB
         GyRkYu6q2kk0x+wFHPKyUgTMBRcGmQoHOqOKBFnQWnDAD3t8QtVO7E5Pe2Zt3HJ0afEV
         JCqw==
X-Gm-Message-State: AOAM530oQ3bO/CaJGbWqJs5KLiGeHG/xBRb79MvidP3DQ3IVm68hbu8B
        2jxggCJsS93V0Mzvi1EA44VihnAfIEql8g==
X-Google-Smtp-Source: ABdhPJzNQG/YpKQRZizSkSr9aSK1BUm4pRoZikPzfqxlTreSC6DrpozC/HEHBW5daGB916HxCeI84g==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr137884wrt.338.1612906943920;
        Tue, 09 Feb 2021 13:42:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/12] test-lib-functions: assert correct parameter count
Date:   Tue,  9 Feb 2021 22:41:58 +0100
Message-Id: <20210209214159.22815-12-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add assertions of the correct parameter count of various functions, in
particularly the wrappers for the shell "test" built-in.

In an earlier commit we fixed a bug with an incorrect number of
arguments being passed to "test_path_is_{file,missing}". Let's also
guard other similar functions from the same sort of misuse.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 109d1b548ce..8ec06eb67a0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -728,6 +728,7 @@ test_path_is_file () {
 }
 
 test_path_is_dir () {
+	test "$#" -ne 1 && BUG "1 param"
 	if ! test -d "$1"
 	then
 		echo "Directory $1 doesn't exist"
@@ -746,6 +747,7 @@ test_path_exists () {
 
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
+	test "$#" -ne 1 && BUG "1 param"
 	test_path_is_dir "$1" &&
 	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
 	then
@@ -757,6 +759,7 @@ test_dir_is_empty () {
 
 # Check if the file exists and has a size greater than zero
 test_file_not_empty () {
+	test "$#" = 2 && BUG "2 param"
 	if ! test -s "$1"
 	then
 		echo "'$1' is not a non-empty file."
@@ -765,6 +768,7 @@ test_file_not_empty () {
 }
 
 test_path_is_missing () {
+	test "$#" -ne 1 && BUG "1 param"
 	if test -e "$1"
 	then
 		echo "Path exists:"
@@ -801,6 +805,7 @@ test_line_count () {
 }
 
 test_file_size () {
+	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
 }
 
@@ -973,6 +978,7 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp () {
+	test "$#" -ne 2 && BUG "2 param"
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
@@ -1002,6 +1008,7 @@ test_cmp_config () {
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin () {
+	test "$#" -ne 2 && BUG "2 param"
 	cmp "$@"
 }
 
@@ -1071,6 +1078,7 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
+	test "$#" -ne 1 && BUG "1 param"
 	test_path_is_file "$1" &&
 	if test -s "$1"
 	then
-- 
2.30.0.284.gd98b1dd5eaa7

