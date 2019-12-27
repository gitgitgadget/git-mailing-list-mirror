Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37FDC2D0CE
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B38220882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoaiYiGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfL0Nri (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43866 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfL0Nri (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:38 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so21895992qtj.10
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Pp7Dl0Gu4TqqiuksI/FRtAqn/pmHfsRgMB+1F8YfIvE=;
        b=HoaiYiGMBXOdliHGbpyXDf1dUTGc03woOve/1+bym5nBOu2Rm6X4KPNC7+qri+5pUy
         dALvNY7ZNV4HtGtGNPgd08pmV9CNnRv2gMlbpHVOKvxhT2RIpZ8uzMNDqVqUeN+OgluR
         p+Mt4BV7ET0EuMlkAQ27xyDL9xeZC980fBBGBhPPMe5JoRCYNP08UM54qqbKe+bAaX8M
         MOkkoNGJprtLgDyLVNLV8R8FgvxZe9B0kXrI9hYmNybVaXh22hPAjWb9xLhCG1xCX10p
         sYTCmUrAYVIHzQOL9cijP8CKQN1rKvQrEhj+j7oMAk3vlJmZiRCFnainkbN4X8XKJrjL
         30Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pp7Dl0Gu4TqqiuksI/FRtAqn/pmHfsRgMB+1F8YfIvE=;
        b=a99eEXLPu23zdtxvQwPXoMh/iYqAH9FbNi266LeoOHgHd103D2C3vy0oR1yBp4f7Lz
         2PoxO2igDxZL01rYS4CqR/XhK7QA2Rdcqs2T3mi2nHio3NVCxBd1j49JmbC0UMGhUZ1V
         //vswcCjjdQirkZuDC4YaLK+9nmbMuo0KQwxC01PF+7ZNeoApCGzkCoKVD17rNlt3ZOJ
         G7LWEVTfi5Ez3wrAvQwikbI5S2sah5b0f1Qv/gQYkaZRnjVeDQbB9pYos94YRXtefDx0
         T4L7WnLoJg3uJZrHDskWzMSIS3wzua6+DpeKjqBZoKaiBH4Nstf9Y16pWcBDFz1hYN0j
         gXUw==
X-Gm-Message-State: APjAAAWLksILe98aVA7N9v/SJrhLYvk4u2cor5Me9js392mLiJqCEIkA
        ues2rxXKnBDGBJfoeNHKSnfHG8Po
X-Google-Smtp-Source: APXvYqzNWcPdy4Hz5sujdIEXO8QpNG4O07AoyQvzvox20GTzJ+hvM3CSMOkWe0Z8Sfie3mzmYTzDwQ==
X-Received: by 2002:aed:2f62:: with SMTP id l89mr37817998qtd.358.1577454457330;
        Fri, 27 Dec 2019 05:47:37 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:36 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 02/16] t2018: add space between function name and ()
Date:   Fri, 27 Dec 2019 08:47:11 -0500
Message-Id: <9558d2491fa8dc68603426c1528154b4fe352650.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.24.1.810.g65a2f617f4

