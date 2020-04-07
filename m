Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F08C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3342078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNgGlPyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgDGO2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:22 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43559 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgDGO2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:22 -0400
Received: by mail-qv1-f66.google.com with SMTP id c28so1869434qvb.10
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ub/Rqz/ZQ52smebEp7L5zy/sTdobfJ66/yCyFnDZTAI=;
        b=lNgGlPyz+xWgJHvDZ1qEzG5chHtWy53dZ/RONoKqOPGs8KhGOmlYjVhG4utOIjndgB
         i9R9ozVh5nQMehW5mr1IlAF86nMP/J/37fA0Do/LXQU9voRitP7kw8rZgGA4x1aQ6x6R
         8FZaID6oh6ZEH/oqZSpiiwmCBsKByvujTJwipsyKvzeOL9er+IMSU1fs4EuGQIPdHNmX
         HcfC3HvRsO9dmoBDp/TRRWsTnQoKImv+GkBPSqL2aenyY/OxfVMX6F7g3+PHUPlfXZeC
         mFVGmF/TOrdxR8jrKmw+51pNHIkAsVHeDsdMkgGSuuOMyzXlpGkZ7zr6Ye4F5gODZBFY
         WsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ub/Rqz/ZQ52smebEp7L5zy/sTdobfJ66/yCyFnDZTAI=;
        b=PMNnZLuIr2s2uml9srno5QdXgEi3E9Yl+pZmulG7Bl9nscyOIJLUmGQl4iiu0JjrPU
         2c8AakVlbtYlFHEpBKjBJ0AGtbFt57OtiSDdeG1oPwtWw7mPNjP23zyEIzNAnQEjB1Yk
         6SmydbDUgWi0Azi9C0A5VDN/2/Oq7/j+Zu/YHQQxQCY/+uEtg3aj9yc35iB4FNhlHcoM
         gwtW6LI/1YeprFGA4LMU1iIDGEHPGM9gNPIz9ViCJ2N3g4uMbPCfTzWOCUpHKDChHDD0
         0dFMB1FmHaSZFoK355tgHka3fgP8MlfDgftFzO/uI8JlZK7ejtXdPaF2tI9s//ZByzWd
         nqaQ==
X-Gm-Message-State: AGi0PuYSmwPcH6phlOgk8hJqIPuCWTNWpKT4oHkltukXNsxT/4QC30Ka
        BfC08fCXNZmlHY8Jkgm7/KqODs7C
X-Google-Smtp-Source: APiQypJDS+uBtPkIQ/CQPd9fSwy/jxnllZDwBFoKpvEVBKh+TZweZm/kCMvBvS7Vea8OAQ7e/VXceA==
X-Received: by 2002:a0c:ffca:: with SMTP id h10mr2500949qvv.100.1586269700786;
        Tue, 07 Apr 2020 07:28:20 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:20 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 02/22] t7600: use test_write_lines()
Date:   Tue,  7 Apr 2020 10:27:49 -0400
Message-Id: <059e0e8e43f633086fc297f8328288047b45d0e0.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
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

