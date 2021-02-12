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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB51C43381
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ACA64E70
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhBLNch (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhBLNbs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2FEC06121D
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l17so940442wmq.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPic/xLTcx3bb+Ugez8Vgdk5BC0LPW9tB0Fo+b3nX3E=;
        b=aquVVql8fVGQdgzBcgqqFnZxySTTiDHMZ4MrKl3j7ucvyi1XdQXc5vpmxOoo5ITGU+
         pTJKel+bfY0kRop3YmoPueO9z7B3ymTnyvl6nk4pGIfgqO1PAXwbMK2Zi7D7tj3a945e
         LC6/XfvMIBIA1FOuUePboLmUM7pak1VeA0brCPpg59yQRX3nlchqH0qd1jYp0MA/DJrC
         0piQP02SQa3BtIX/wsoI/d07dVzBcEhEJG1sUt6BnapUF8XCMF7OohroBA1E329mWxyR
         eE/TVfFBSJPEnpioQFgwFtVu574ojHjQPiMa+pyW+vRFV3f2+nJFKBR7Um5XZVBzuH/6
         +f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPic/xLTcx3bb+Ugez8Vgdk5BC0LPW9tB0Fo+b3nX3E=;
        b=I2lQuVWp3o4eRKYI2nNkf9TurvRyfni3Uam9QYrVLfaDZaE0mIaPYwWkwak7CvgRCd
         UUdOFOHbiZYHqrCxG47fdFx52lYWKodirf8YjKYM5oFkr/VW4LqVBiFHWBDKwbq3jJGp
         mH4dmAzVz11teJMKkG2i5cQeoxV2EEXOeTIlD0RXFBqpvyhyo6tnKkgsKyLYS4XQf756
         gOGPCAnWKmy6MHblxFLeh3YZO45QpizoLiYsDgqteIntOTHSvRm289O/GwsDjHu/0+bN
         vygRxJd8fZXw1ag/JkBGBdktohLrNpp3LpQagiEUpiZn3lMM6U1DBsp+Q1gOuYVueicv
         eipQ==
X-Gm-Message-State: AOAM5308xn99nCSoe5gsZz0fP7IXs4yfv4ks8ovBpdtfZvmP9/Kz51xG
        9KaMBZ5JaaadQ7sjPbQrOtVQRYd27WMumg==
X-Google-Smtp-Source: ABdhPJzmrqMu9Fdi1F95aJrkEN3Cy78tSdQRYUzfn67L0ga6q++huJ6nIKiQkEqOqWpz7dicdwyRSw==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr2706282wmh.164.1613136604537;
        Fri, 12 Feb 2021 05:30:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/11] test-lib-functions: assert correct parameter count
Date:   Fri, 12 Feb 2021 14:29:42 +0100
Message-Id: <20210212132942.17325-12-avarab@gmail.com>
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
index a5f63c0af6b..a52eb16846c 100644
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
 
@@ -1062,6 +1069,7 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
+	test "$#" -ne 1 && BUG "1 param"
 	test_path_is_file "$1" &&
 	if test -s "$1"
 	then
-- 
2.30.0.284.gd98b1dd5eaa7

