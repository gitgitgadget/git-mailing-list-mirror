Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8041C2D0D5
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704B820706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM13H0Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLXLFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:50 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43633 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLXLFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:49 -0500
Received: by mail-qt1-f173.google.com with SMTP id d18so15172320qtj.10
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjOU2K7Uk41XDxasv1W2GCcRamYrZpRuMlCN34TchkI=;
        b=NM13H0Vsco+GxYsv/1UNtX8t7cexkVKNgHu/8ULrmuW0+nqRGYremO6l3HAdpQOUG0
         ff4Bgr3ReZsh8kDjXIsq2rJy8q4nvgB3Ybbq5pZQCX9GV8uzT7B/oIsC1oz+ZYX+18H4
         6ihWsm9AF7aDitHM7zkJzd7URiv03l/8VOAhR5sAAuZindvwVUuXDo1H3EADgchBeCjh
         5JvTme2JcwFFx2o5xrCfvbDiPdsq/8wce5qEU4tctQPDBxOb2NJMAExcMc+c9hGbP4Pi
         k/hVMSv3IdpayqaLJJxUPrDbm+pLnFzC1BZw5k/AAqs2C2duIv9JA+i5z+tALBrVxfEB
         eLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjOU2K7Uk41XDxasv1W2GCcRamYrZpRuMlCN34TchkI=;
        b=cgFAwMHu9yl9ilAimV+m8D4CWEo1lPZKr9LOnzM10MwU9Utxkf5ttVXxI5rZhm+YvW
         6RsjZmin+mQXHQ4d3hXZ/q9yGVoYiuojkS60p+6xNpnbuF0jfXPfRcU8d1Tf2+9phxhk
         2yTAVHmQhby/2G5N9vTuOzlY83qqbiE9yTglf2OtkUliLmO1d7ky08vSfzVFC87FZMtA
         euTcORwXWYeVj3kjRlMErMdV4lKakT3Y7HpkEWLU65n0vFdHa6Gpncze+gkiJI/HG5NL
         umUii0LdMd6J6b1LQmKIDf22UUEvFeaYwzqB0uDa20edxlfoRdeZb0VHMCWzz0lPhXzP
         Hmrw==
X-Gm-Message-State: APjAAAXS0REZ7QuHxGdhuaGobRPsTMh3Wuxl7IjSRvwhCEA2srjLB4Nh
        Rn0zRLI55Kfc+8HZ8gn0RwX7b0uF
X-Google-Smtp-Source: APXvYqwFxnlYRNhCMvc1GeTEW//zLyMvFrUYEIyfuL11/WvXui/eAxNFkkXQKWcSHT0Oah9k4Pg/XQ==
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr26616197qth.311.1577185548489;
        Tue, 24 Dec 2019 03:05:48 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:48 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 02/17] t7600: use test_write_lines()
Date:   Tue, 24 Dec 2019 06:04:59 -0500
Message-Id: <2e0020b3e3d58d4be4fe9fabfb079d17b30cc994.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t7600, we were rewriting `printf '%s\n' ...` to create files from
parameters, one per line. However, we already have a function that wraps
this for us: test_write_lines(). Rewrite these instances to use that
function instead of open coding it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 132608879a..4fa0ef8e3b 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -29,15 +29,15 @@ Testing basic merge operations/option parsing.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-printf '%s\n' 1 2 3 4 5 6 7 8 9 >file
-printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >file.1
-printf '%s\n' 1 2 3 4 '5 X' 6 7 8 9 >file.5
-printf '%s\n' 1 2 3 4 5 6 7 8 '9 X' >file.9
-printf '%s\n' 1 2 3 4 5 6 7 8 '9 Y' >file.9y
-printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >result.1
-printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
-printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
-printf '%s\n' 1 2 3 4 5 6 7 8 '9 Z' >result.9z
+test_write_lines 1 2 3 4 5 6 7 8 9 >file
+test_write_lines '1 X' 2 3 4 5 6 7 8 9 >file.1
+test_write_lines 1 2 3 4 '5 X' 6 7 8 9 >file.5
+test_write_lines 1 2 3 4 5 6 7 8 '9 X' >file.9
+test_write_lines 1 2 3 4 5 6 7 8 '9 Y' >file.9y
+test_write_lines '1 X' 2 3 4 5 6 7 8 9 >result.1
+test_write_lines '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
+test_write_lines '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
+test_write_lines 1 2 3 4 5 6 7 8 '9 Z' >result.9z
 
 create_merge_msgs () {
 	echo "Merge tag 'c2'" >msg.1-5 &&
@@ -81,7 +81,7 @@ verify_head () {
 }
 
 verify_parents () {
-	printf '%s\n' "$@" >parents.expected &&
+	test_write_lines "$@" >parents.expected &&
 	>parents.actual &&
 	i=1 &&
 	while test $i -le $#
@@ -95,7 +95,7 @@ verify_parents () {
 }
 
 verify_mergeheads () {
-	printf '%s\n' "$@" >mergehead.expected &&
+	test_write_lines "$@" >mergehead.expected &&
 	while read sha1 rest
 	do
 		git rev-parse $sha1
-- 
2.24.1.810.g65a2f617f4

