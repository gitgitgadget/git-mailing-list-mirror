Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF5C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A612075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ten0aWBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgAGExa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39698 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgAGEx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so41601410qko.6
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2TqR0WDW8Y+NBJDh6OoLq+hfofgn+oUtQjnL9CRszHo=;
        b=ten0aWBmcTXUlA2V/M51lrQGuizgczPLByCXiDDL0DZ8F3FgnagOJ20FktTkjf/t/G
         SQMA/OEI8sWI1vhWSg3YMXOh8v25NrGTNpHoG/3+xJ3wA0lIZdJ2oznWLDwbF/dy1zGG
         KhOeIwJzwzWvV2czCZm3IgmaS5QGYmnjmHFjq0hzDMkkxVEpGk94pxHYPG1fsal37o1P
         /tjZF77TJ68Xz9DVXU7fUfd8PvHYaGj23FvapBEG3YALREqeGs/z6qT8S888/rE2lHiZ
         Ghan//57RVApF2BBbgsnyy263d4LGn/FEROmC+jWDlVxzi1/v5fYhsJ2EXdLqglu+iIu
         CYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2TqR0WDW8Y+NBJDh6OoLq+hfofgn+oUtQjnL9CRszHo=;
        b=HmhkHigPfqFnJUf92nmTfq9t5xclFL8GlMeA0gdo0jtuAn2QMHYK01GOMhS+qmfYPH
         m1RiYsEh58tDGHGC2GyWTJeVGNMSNskq70Tr9iFEg2xaEQprpYXFlqMykNaCINYnfJSo
         DOj+7UqAQ071Vy5yNd1agja3Uxpnhs1alnAH5en0/+O1Z9jVZclSSjUQPvZj7F/8R6tF
         fg0rkUk7zFDS/3G2b18tHd26kBnVD3ws//q6KJDf86uc+wJ6yEJGMkyLtp9u7f025nir
         KPWbzaHbaEng15NUVCI0NwK+1aeIOTtbKqeykAtrMSzm+VNsB6PtriCk0M0cNUezcCLO
         JvAQ==
X-Gm-Message-State: APjAAAXgXiqa6Pos2s3yhRpj+76UBXhwCtKijcPPsu6pEgCqssB8RqGS
        bC1JC2e7lCg6YaDxyeFB5V36rgDe
X-Google-Smtp-Source: APXvYqwA5hyCDEHvTWWwAK2qpSLmE7wAR7ER26hS78khhC+0Mh1bexM4nFP9+T9cCmrct7HVrdNa0g==
X-Received: by 2002:a05:620a:910:: with SMTP id v16mr86670545qkv.194.1578372808616;
        Mon, 06 Jan 2020 20:53:28 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:28 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/16] t2018: add space between function name and ()
Date:   Mon,  6 Jan 2020 23:52:59 -0500
Message-Id: <f0f541b520daaf910986a38130c21279afb396ed.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a space between the function name and () which brings the style in
line with Git's coding guidelines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index e18abce3d2..79b16e4677 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -12,7 +12,7 @@ test_description='checkout'
 #   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
 #
 # If <checkout options> is not specified, "git checkout" is run with -b.
-do_checkout() {
+do_checkout () {
 	exp_branch=$1 &&
 	exp_ref="refs/heads/$exp_branch" &&
 
@@ -32,19 +32,19 @@ do_checkout() {
 	test $exp_sha = $(git rev-parse --verify HEAD)
 }
 
-test_dirty_unmergeable() {
+test_dirty_unmergeable () {
 	! git diff --exit-code >/dev/null
 }
 
-setup_dirty_unmergeable() {
+setup_dirty_unmergeable () {
 	echo >>file1 change2
 }
 
-test_dirty_mergeable() {
+test_dirty_mergeable () {
 	! git diff --cached --exit-code >/dev/null
 }
 
-setup_dirty_mergeable() {
+setup_dirty_mergeable () {
 	echo >file2 file2 &&
 	git add file2
 }
-- 
2.25.0.rc1.180.g49a268d3eb

