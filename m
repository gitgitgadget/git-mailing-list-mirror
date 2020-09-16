Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EAEC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1822083B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSGqnEY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgIPSMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgIPSK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:10:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A31C061788
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so2768587wmh.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0ybg95cjBoMd3k6bGS4hd0gm5wPr+J8ekwzSJZveA/s=;
        b=OSGqnEY7W/vxuOBhkGnccZXkyo4i4rGcqGaiNZdrw4zWZ8XcvEZf7UQbor96HQEnV0
         DlKf9CehwJEIsAI75G+de5syfEeJPMDxhpaHae0taQ4Lp0Hiyrn2UtsmZnj3n2L5Gr8n
         uVHyZP3xstsw7B/Q/llAhzU3085YeF88oBfji9k2Pm9LuNy7XGROzk2PFlejtUnzFjmz
         BLbsIloGYrEyE+feH3Ra+A3useAwvfrfFlFLeTjEJ0TbDQIgezfSQ8OUi6/gz+0K+5a+
         vaXNVQdxv19x9nfv0xXm+o93cKXakVJOPi+vGZWUNTkKaartqv9l4srxFFnahxqP6vX5
         YEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0ybg95cjBoMd3k6bGS4hd0gm5wPr+J8ekwzSJZveA/s=;
        b=h0XwgG5IGEdjS5BZ/9zl6PKNwuTxZ/9dSTOjS3NR5NWcoBiyYk2vJFVduSMewajtu5
         4PGkNtwcsYOR9IhxiaTqDpDz4hLZ434wHJqk3rBaztrRvXxwofGeXlgnwmXW2YWJbB3F
         6gSQauE9Y+qKVyIQ4QPD0DITW4DNZJN0SMgDc2hczw3S3xIE2iNhnyict3q/XdOkwUxl
         N/EZSMdGfD1i8tkv98opL566Qp0n/K55aCImsqakow7y2siernEmFrEnxXKFDo6iVw5I
         PnDD2V10Do5e/vDU7J3UEqeofxsSObtW1otZuNtAzQCQSX10+mXJz7C+bOCj/Dc8aaAU
         e68A==
X-Gm-Message-State: AOAM532ulYennrmkrkS/WePn2ZmkTozLUDhpfbnGXGkDW63/psd+Sneh
        3KGF6VaHrqLM7Vvxt9YG/4do/J+YHsg=
X-Google-Smtp-Source: ABdhPJyK3e/nirrlYHq41a4YCuY2ueiA2xGVO1VoEDNt4vuZem/SNPvmG5b9WAm0ghlEuyj7u9xeYw==
X-Received: by 2002:a1c:4886:: with SMTP id v128mr6133366wma.139.1600279855894;
        Wed, 16 Sep 2020 11:10:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm34229600wrv.72.2020.09.16.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:10:55 -0700 (PDT)
Message-Id: <3b4ae48d4a3a7e2d6aae259ead19b6643d2533e8.1600279853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.git.1600279853.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 18:10:50 +0000
Subject: [PATCH 2/5] t/test-terminal: avoid non-inclusive language
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the ongoing effort to make the Git project a more inclusive place,
let's try to avoid names like "master" where possible.

In this instance, the use of the term `slave` is unfortunately enshrined
in IO::Pty's API. We simply cannot avoid using that word here. But at
least we can get rid of the usage of the word `master` and hope that
IO::Pty will be eventually adjusted, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-terminal.perl | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 46bf618479..680caf48dd 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -81,24 +81,24 @@ sub copy_stdio {
 	die "usage: test-terminal program args";
 }
 $ENV{TERM} = 'vt100';
-my $master_in = new IO::Pty;
-my $master_out = new IO::Pty;
-my $master_err = new IO::Pty;
-$master_in->set_raw();
-$master_out->set_raw();
-$master_err->set_raw();
-$master_in->slave->set_raw();
-$master_out->slave->set_raw();
-$master_err->slave->set_raw();
-my $pid = start_child(\@ARGV, $master_in->slave, $master_out->slave, $master_err->slave);
-close $master_in->slave;
-close $master_out->slave;
-close $master_err->slave;
-my $in_pid = copy_stdin($master_in);
-copy_stdio($master_out, $master_err);
+my $primary_in = new IO::Pty;
+my $primary_out = new IO::Pty;
+my $primary_err = new IO::Pty;
+$primary_in->set_raw();
+$primary_out->set_raw();
+$primary_err->set_raw();
+$primary_in->slave->set_raw();
+$primary_out->slave->set_raw();
+$primary_err->slave->set_raw();
+my $pid = start_child(\@ARGV, $primary_in->slave, $primary_out->slave, $primary_err->slave);
+close $primary_in->slave;
+close $primary_out->slave;
+close $primary_err->slave;
+my $in_pid = copy_stdin($primary_in);
+copy_stdio($primary_out, $primary_err);
 my $ret = finish_child($pid);
 # If the child process terminates before our copy_stdin() process is able to
-# write all of its data to $master_in, the copy_stdin() process could stall.
+# write all of its data to $primary_in, the copy_stdin() process could stall.
 # Send SIGTERM to it to ensure it terminates.
 kill 'TERM', $in_pid;
 finish_child($in_pid);
-- 
gitgitgadget

