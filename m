Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE54C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA1F20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGKfRAxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDDBMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:02 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42838 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgDDBMC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:02 -0400
Received: by mail-qt1-f173.google.com with SMTP id b10so2483905qtt.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ub/Rqz/ZQ52smebEp7L5zy/sTdobfJ66/yCyFnDZTAI=;
        b=rGKfRAxVGtQOZPMFvjObtEYwmEqqtxzdbKqd4ZZ8b/QeDCPWmEwgCbq94VZlnKGQc1
         mK/J6E76o1LRswhuDvKN+veY0ZlLhXp/l805GvhY/UF5UgS7XGyKMsTfuSgYRPh3Rnw8
         NcgQC8X5cfKJBzLoo3dazoB5C4vFhe9zBq3bB5Gpd573v2zlZNPMFO1mkvvHuhOvHFTN
         tkdfTyO9+v8zRrjwouhdVv9xmnMtw5gXStBJUy2ORW6yO2f9io7YzZujrua9fIGldIHh
         n07IIgfcBtx3vIBU7VYHFwwdWk2tLawvMUNz9AodLZNVtQ+FCysMSv/PsLq5YTeC+HOe
         Sjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ub/Rqz/ZQ52smebEp7L5zy/sTdobfJ66/yCyFnDZTAI=;
        b=Hub7Ofngty0u60EdHY5UbTWIYFM2SncCYAI6Lzqt/9mtbApDBQPF9L5t0eGr5Icp3K
         Mv+ZOYU9n5Jgjo8bIp0tQdzhG1KP/AIz5fyoxHg/XE5gxYpEW8Tl9LxyvM127o4AR9Dw
         HSeFuLq/mRZ5LKzpH6hEYilFUS/TVFNzM6CrUcVYvEOQxQ2t3NVFsVSXcFS+Mx9JBt0I
         PUVnyUenSEcUAZdkiUfWQuRFqMsaqgAyDO6dhtmUTqNoP97sRKTmL4+qNTGwf94GZEtn
         IHCPc6nLewJKzl6uVr/j/lM3ThsgBmE4TrRWjtoFnpAMZgToer2+d4AaISHVbzVLH/UW
         +cCg==
X-Gm-Message-State: AGi0PuZ5/mtwTekoHIn2W3dudD/oto0IJCzoctqsZX+duDw2bjZe3p0h
        zvQbxICHGoME7e05gQSW52mYvlS0
X-Google-Smtp-Source: APiQypId84ZTgVKzRxo5hHdc3xi/9wwkzlP3JAouSB5r2g8v3qlXaNJuqwbSddUGbBBpT7W57oTcbQ==
X-Received: by 2002:ac8:342b:: with SMTP id u40mr10536993qtb.83.1585962721187;
        Fri, 03 Apr 2020 18:12:01 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:00 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 02/23] t7600: use test_write_lines()
Date:   Fri,  3 Apr 2020 21:11:15 -0400
Message-Id: <059e0e8e43f633086fc297f8328288047b45d0e0.1585962672.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
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
2.26.0.159.g23e2136ad0

