Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8644DC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE8E2070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVI0/Asr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCUJWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:12 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44320 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgCUJWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:12 -0400
Received: by mail-qv1-f68.google.com with SMTP id w5so4435551qvp.11
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnIa+ZqBno7V8ODa2J7tI2V+bmWCguOTvHF0mu2bJDs=;
        b=IVI0/AsriNo2nrDU5rivOI+x4X9ns8mMUpa39VKXvWgpP1jETVtzwjellHYrg+A0i7
         otjCpav6uWRH83wbx4kIwzlDfn3XcX4bvci6bWOrs+wPpMbd3bB1uxTrBQbveM5JFFyb
         1oN02tW0E3Ya3bQudeJKLeCXbrjQAsbET8ELin68gjfWsI5fjAPUQSA6F+PjS4uuWXCW
         oQGHnpX7x6CLf3s1fkHAqPGtn6wIIWVrkhgfQ+NSkLMsvEBIzsu24re5Y1VkuDA5Esn/
         nsE/gN+/LsVHyUJcxmFFlGPKR7cUqKFxG3QsmSre9PN5WY32deImRZTI922FXrcLiqu0
         zaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnIa+ZqBno7V8ODa2J7tI2V+bmWCguOTvHF0mu2bJDs=;
        b=lIue8Wlp+m1l9jjDgblzWzKRtwPUhIOA2BHLHgBweFlj0t/jdkR0o9N+kKUQOhZJrO
         WOXxHKcUIiMpCb/cFRUJrFYRClrHJscNWHigSaD4iVxyLdQ8NVroyqfbJP+IG9IRkmIZ
         OVjznhFg7Oj7s78igCoIe1dGUnHcWS3ZVONtkglwtX29mqhiGX0qvOkvfQaDKgbaXthL
         z8M7iQb/sADEYcoR/zbUZIhGFsSxeRzb3d18aeOgO7jRhFmnMsxpbT+YkLe4bUN1GHB8
         HqtTj+st17oRaMLQsecVrXfqbayfqJgrPKPszhGJK26ftgxumtOQcKynuUwwwXjb40RQ
         fBjg==
X-Gm-Message-State: ANhLgQ0FAPWsPtkVgVrulNFkXDrvZ63EnNGbiwcY370Ged4O5KMOV5xQ
        I0JHxeEn0UH7kC11DtOnBIDMjXt5
X-Google-Smtp-Source: ADFU+vtyMnb5+73P3I5cS7ARK14Avxl+wvGoBWpajWmaROPLMOaNHsX2Nc8DtC5t7u2C0GDEzWFLqw==
X-Received: by 2002:a05:6214:110d:: with SMTP id e13mr11729926qvs.60.1584782530699;
        Sat, 21 Mar 2020 02:22:10 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 02/19] t7600: use test_write_lines()
Date:   Sat, 21 Mar 2020 05:21:21 -0400
Message-Id: <70699b8b73c1e86cdbe47d9d4162bf0b678a9dbc.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
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
2.25.0.114.g5b0ca878e0

