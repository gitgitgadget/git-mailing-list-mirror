Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E332036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbdKUX1c (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:27:32 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40382 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdKUX1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:27:31 -0500
Received: by mail-pg0-f67.google.com with SMTP id u3so11436784pgn.7
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FUiZ/XIXaAc6Ka5GJXeqKBOd8R7VGKy6yylaFzHrJK0=;
        b=uFjMoeY2c0lyCOOLjfcsdATEXwVTMQByIwmpCCnYIuhbTq/CgrOgxL6unYtdRAb+Ur
         4i5qf2vHZB72NjLHebHCocwVVaimoByAill3YdneUyoaWIWkxsQiqXsSiQUO5a5DN+w9
         9l+P1FbDet1DSyycT3lOEEo7UhxUZ7yqHya7E5vYqT8iH+8VaiEhgMAfGt8xER1JYPOE
         rTmsKcZ1OxOfF7Iz7e/Jx7iDOWG11L08Cwalsh8AjUCKyI4kIW4oQ/eF9ic4epFlg9F/
         6yQehJ9pxn39HgOdNDu8mr0Ybm0hpwevwBz+z+AdbG9l0u8+yPqtccPclBEVFnkgtbv4
         g3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FUiZ/XIXaAc6Ka5GJXeqKBOd8R7VGKy6yylaFzHrJK0=;
        b=gVC72piCGaTb49X7UJmy+WfPRsZpfVWudv+8W8vYbjMoBMM5ov9ywtlsFJcgMhou7V
         7nRwdNB16bTWSPSW+v7KP2/a1nYDobnTKm95wxytjgXyArXZ7mLUOuklZxmK3js3zO3N
         SNi0dxSOEOU6BF2bxNvx9V9TLBD8ZI/94YaYXvyJICqCLES+QzFZnERDzZJ4YA4JusqF
         p65HOSIvLmdreuEr0RaITTI5FIIYX+DTYmJySBiod8I9stpwrENGZbFxpS2lk46+o/SZ
         3ziSavzeeYsiURK1xt2oSxGC2jhOgGuxIVJF51jxLIAd7Q7MBb/XKoffpZUGsm/P6bkC
         W8gQ==
X-Gm-Message-State: AJaThX7Dxrw5ubjGIZEJt7wrUjH/oRBdAV99hMVNMMcqW32DEuS3vgXc
        0GG5U4jn14MBDVhzrPo0tTAwv2aK
X-Google-Smtp-Source: AGs4zMaSS1bJ/DPlhCtxAOz7FKJ4ogWG06NHKRwfconxcAWMoSi0LH8W4MbFtb9XhczOOuU0pHFZZg==
X-Received: by 10.99.127.88 with SMTP id p24mr18304370pgn.377.1511306850039;
        Tue, 21 Nov 2017 15:27:30 -0800 (PST)
Received: from phord-x1.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id r18sm22829004pge.87.2017.11.21.15.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 15:27:28 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
To:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>
Subject: [PATCH] stash: Learn to parse -m/--message like commit does
Date:   Tue, 21 Nov 2017 15:26:42 -0800
Message-Id: <20171121232643.8380-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.15.0.471.g17a719cfe.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git stash push -m foo` uses "foo" as the message for the stash. But
`git stash push -m"foo"` does not parse successfully.  Similarly
`git stash push --message="My stash message"` also fails.  Nothing
in the documentation suggests this syntax should work, but it does
work for `git commit`, and my fingers have learned this pattern long
ago.

Teach `git stash` to parse -mFoo and --message=Foo the same as
`git commit` would do.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 git-stash.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 4b7495144..1114005ce 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -76,6 +76,12 @@ create_stash () {
 			shift
 			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
 			;;
+		-m*)
+			stash_msg=${1#-m}
+			;;
+		--message=*)
+			stash_msg=${1#--message=}
+			;;
 		-u|--include-untracked)
 			shift
 			untracked=${1?"BUG: create_stash () -u requires an argument"}
@@ -193,6 +199,12 @@ store_stash () {
 			shift
 			stash_msg="$1"
 			;;
+		-m*)
+			stash_msg=${1#-m}
+			;;
+		--message=*)
+			stash_msg=${1#--message=}
+			;;
 		-q|--quiet)
 			quiet=t
 			;;
@@ -251,6 +263,12 @@ push_stash () {
 			test -z ${1+x} && usage
 			stash_msg=$1
 			;;
+		-m*)
+			stash_msg=${1#-m}
+			;;
+		--message=*)
+			stash_msg=${1#--message=}
+			;;
 		--help)
 			show_help
 			;;
-- 
2.15.0.471.g17a719cfe.dirty

