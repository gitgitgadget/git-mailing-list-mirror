Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F441C433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiAXTB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbiAXS7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A25C0619C6
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r65so550666wma.0
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DXZZJDCDLve1Q2lw1hcqjmq9lJ9AxwHRnRwUJFeatvM=;
        b=co8ZTz4zUv5xnClwWhM4rY2UP4Iy61JhoC/URwrH5kqCsP6noBl82QGYPqdS2nT79q
         LVSfciUveikClffQmZKlFewZAMAMffagJBRafH8N2yN5JaOnXFM0QJBCHewXvRDaZW7W
         SQAxinUCHz43dBynNHlolAcI9fyAQp0xK5DLZFeZGVO663IAfmwLg8c03WTEAMy/lF2v
         DFaUSqDybC7URAeMuCdyw95adatSMU9ac6vzi6HNNV+7i5FbVil4QNdNFWDZtO8Z5vi2
         36PIuDb/ALZPXqN1rAujSVIV97qWbBim0xNGTIaPVvYR2gUF9wmAROXMkpq418Tk0PK3
         1Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DXZZJDCDLve1Q2lw1hcqjmq9lJ9AxwHRnRwUJFeatvM=;
        b=niegIFWLGBTJbBeBVLSW5nop3NkmvcbdfPp1nQFPp7iPT361+vBgMidElhF+wNk3Dh
         fCdAJQC5EzkV2JZEBHci2AlNhVqDjKYuWpNvw/f0te5WWIUSdTj/0JLCnWxWO22IJ5wv
         JfEFhGbcpdi8CV1IrYrKvxxjLz68+a7fRXOyuSBNujg567PAmTPwzbhknabzTTnqTn3v
         URCuz2fEC2SIf5ylSPz5Ho0C9qXS4nUl8JJdi0T4iucBUpc5FN4GSxnBdPv8mdIuyvzF
         FFeK/m9x825QkHFHCvopefvbj4/2PlOmOg6xyrLDHlX+TXqvg+XzXpU5ObMpKD6TAo4p
         bhuA==
X-Gm-Message-State: AOAM5339c9K3NoewHCHxTPOuk+QE/QceLcJYPPnPnBsDxrOr5g0WdO0b
        eMA7KF5ZaaRu2qk9RvJANSWS5qLMndY=
X-Google-Smtp-Source: ABdhPJyXvVgc2Vap+nJgGv+FbcNL6zLdDOX/D8KjUOnazHDDIyslpqKJk3Wu7IICZmefo+RgxOk97g==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr2934731wmq.64.1643050589654;
        Mon, 24 Jan 2022 10:56:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm32269wrc.65.2022.01.24.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:29 -0800 (PST)
Message-Id: <992b157588975803faf6747cca94f197611fc5c5.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:14 +0000
Subject: [PATCH 9/9] ci: call `finalize_test_case_output` a little later
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We used to call that function already before printing the final verdict.
However, now that we added grouping to the GitHub workflow output, we
will want to include even that part in the collapsible group for that
test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 076bee58c19..1e683ad879b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -732,30 +732,31 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	finalize_test_case_output ok "$@"
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
+	finalize_test_case_output ok "$@"
 }
 
 test_failure_ () {
-	finalize_test_case_output failure "$@"
+	failure_label=$1
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || _error_exit
+	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
-	finalize_test_case_output fixed "$@"
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
+	finalize_test_case_output fixed "$@"
 }
 
 test_known_broken_failure_ () {
-	finalize_test_case_output broken "$@"
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
+	finalize_test_case_output broken "$@"
 }
 
 test_debug () {
@@ -1081,10 +1082,10 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		finalize_test_case_output skip "$@"
 
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
+		finalize_test_case_output skip "$@"
 		;;
 	*)
 		false
-- 
gitgitgadget
