Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22DC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0354021D41
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCo5CEvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793226AbgJZTdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42842 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793184AbgJZTdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:33:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id j7so14014506wrt.9
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zVIK+epOFJwa8gAuRtkhk+wC/W8LUB+JZP9Y34/sbNs=;
        b=NCo5CEvDCLK7crX1a3oebshDQDCJXBMkbFTsPoldOX0gMWcGTp+/GfGLZ8pnrmpy9F
         6jrPuZiJxXmAdeOzQveRgrBIx0XvkncIiJ21Jc/7sI7+JtB2JjjX9LHVFk3rPTB5jjhB
         /UehLbeEMHsHGgjvZ7cRvTT9+MAQfvhyBWTWx9yjZhSPXcb9mU1wLLj8otKzUC6cwINs
         83wxouNdy1SIO9ugHvG/XUMezDa/0WfKERaL9yqn/isYGJhBhehO8gRsKSDR3ml3GtW3
         Ek2L1UC7jEvmCf6HQm4MLI12gzjNYqM+bl2i8NYGyIFbE98JZ40Epv8UJnyEu2PbjYu+
         y5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zVIK+epOFJwa8gAuRtkhk+wC/W8LUB+JZP9Y34/sbNs=;
        b=R8amnsDw4FFf0yRK3Tls7noMbvuFUweK3HDRJza0Sgj0JK8LHpRWcrCOQI/5pI0hhf
         iPiiJ45KfADkYFGWSfUIVYvp0sr+E+uHwI2CD5pTTDiUxoYNTRZCw0y1LlQMYMwcpJoa
         M8Lkn5KFAsMsWzp2nMHmikmjDpGGgACqcoF6eNHRV+0a584XyLkOMzyfw5UbXonXrGZ8
         Dye+zI9Zt9+45Zb4OoZdUmgF1aq4u0uL9ApRvBqSe1ahVwdI8WTrVm4GZU5wId96rzs9
         V736oVyGJfXdtLWruNpJmb1AeE8uPsSnsNrBg3JGm4ZMV9S0Hu3ZMRksJleUQN6qMUfD
         y/RQ==
X-Gm-Message-State: AOAM533LdfgRgOb44OhDHHvUAr5m29fA+hAd8V2gWq6XYzgkfhcFppB8
        vCUYq/9i6n/lr91MdUGUpA2a1jTOzhU=
X-Google-Smtp-Source: ABdhPJxLZfPmI+rD1esV/x72X/i+WG2E9mZAFcEEqhWCPE4BvHH5vikjXRRsosjdK4UFxQmMS+RIZg==
X-Received: by 2002:adf:f182:: with SMTP id h2mr19494087wro.199.1603740780233;
        Mon, 26 Oct 2020 12:33:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t23sm14112213wmn.13.2020.10.26.12.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:59 -0700 (PDT)
Message-Id: <409f400376dadd81335cb32e026bec1b4f0f5a26.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:50 +0000
Subject: [PATCH 07/10] t/perf/fsmonitor: factor setup for fsmonitor into
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

This prepares for it being called multiple times when
testing different hooks

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 970caff3d2..087f66ecc2 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -103,7 +103,7 @@ test_expect_success "one time repo setup" '
 	fi
 '
 
-test_expect_success "setup for fsmonitor" '
+setup_for_fsmonitor() {
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$GIT_PERF_7519_FSMONITOR"
 	then
@@ -130,7 +130,7 @@ test_expect_success "setup for fsmonitor" '
 	cat error &&
 	[ ! -s error ] && # ensure no silent error
 	git status  # Warm caches
-'
+}
 
 test_perf_w_drop_caches () {
 	if test -n "$GIT_PERF_7519_DROP_CACHE"; then
@@ -188,6 +188,10 @@ test_fsmonitor_suite() {
 	'
 }
 
+test_expect_success "setup for fsmonitor" '
+	setup_for_fsmonitor
+'
+
 test_fsmonitor_suite
 
 test_expect_success "setup without fsmonitor" '
-- 
gitgitgadget

