Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4019CC4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FA923A63
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYkU5CbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgIUWBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgIUWBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:01:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76CC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so1072250wme.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rhnqNcQm0x++W3hvpSYVdA8rvQO0+VPmQ0qhsoSVUNs=;
        b=BYkU5CbMgkK/wQyY9YB7LIeq8X0glvcCaD/ujhZkiaqWOaBp7rpKKPMlmeryyI2vNG
         zVkkZwMv2yfhfM9wlsSncfzRbER2arw+CKfZSPcD6cCGQM7HWhLQrd6uOqU0Iy3GmVuE
         idHAWDkBaO/uYgtfCASMHGKfvFq4DfPHyd6oe1eTVOnGXNibBAIFHeG8q79LQfzhScxV
         bPavaaTEwZ8lCKFRm2ivMIHOLWCByJteZ2zufw+Hwdv3TTPm8bW0UfTEydqxCg9Dy4Fy
         MJU0Ubxvn3s3L3oWurAzViyML7fDzDuSULh1sxRLaslf7JI5JW2FgDB7f1BJcAsKR7e2
         n4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rhnqNcQm0x++W3hvpSYVdA8rvQO0+VPmQ0qhsoSVUNs=;
        b=KRSmNIbp+0pMoQvNiixfX317vgXxmF/HqwSfKGLvLLzFtofY2EPT+oqMqxQBWsVKAj
         J+MNq3R27KhMnjRWFxS2j51Ju2hGJdPWpwXV5LRv49ongAnK6aU2ndPdTELUhKshfe0Z
         XoOfloxclpfKxfNaJQXiN9NkAlNVXAAxuSAdL5bqt27DyedZGZQqqmyYlqffUqahfudR
         +Aa0muQhXKDaPok2OWEKH9Pd7gQwmN/yO2oAoduCDneSHbP4rzqKC/24o7L4EtVE7Wsb
         hrRHRK7ypPaXqgth0X9H3El2cXDklvuIywl4Md7YVYDCBXdWXRARY2vuGicsritslyJd
         B5zQ==
X-Gm-Message-State: AOAM530LPCa6RaZPO1qyeQI1iIdNgIOjRfxVVN1/rHbL1BIJCIWhznQc
        jxx0JIGhz+wFsPP56cnR9Kx01jW2d+k=
X-Google-Smtp-Source: ABdhPJyTTeQ0Xa7ot326W9UjDwcnCYkFrq4eU9N3Byp3cSVw/TWbeQTR1l18rfx2z9jBIBxh2PhPrQ==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr1336658wmj.174.1600725690241;
        Mon, 21 Sep 2020 15:01:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8sm1231236wmd.12.2020.09.21.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:01:29 -0700 (PDT)
Message-Id: <80e1d46ccefeb39bf3a10c5c973d62fa887210d1.1600725687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:01:23 +0000
Subject: [PATCH v2 2/5] t/test-terminal: avoid non-inclusive language
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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

Guessing that IO::Pty might follow Python's lead, we replace the name
`master` by `parent` (hoping that IO::Pty will adopt the parent/child
nomenclature, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-terminal.perl | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 46bf618479..1bcf01a9a4 100755
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
+my $parent_in = new IO::Pty;
+my $parent_out = new IO::Pty;
+my $parent_err = new IO::Pty;
+$parent_in->set_raw();
+$parent_out->set_raw();
+$parent_err->set_raw();
+$parent_in->slave->set_raw();
+$parent_out->slave->set_raw();
+$parent_err->slave->set_raw();
+my $pid = start_child(\@ARGV, $parent_in->slave, $parent_out->slave, $parent_err->slave);
+close $parent_in->slave;
+close $parent_out->slave;
+close $parent_err->slave;
+my $in_pid = copy_stdin($parent_in);
+copy_stdio($parent_out, $parent_err);
 my $ret = finish_child($pid);
 # If the child process terminates before our copy_stdin() process is able to
-# write all of its data to $master_in, the copy_stdin() process could stall.
+# write all of its data to $parent_in, the copy_stdin() process could stall.
 # Send SIGTERM to it to ensure it terminates.
 kill 'TERM', $in_pid;
 finish_child($in_pid);
-- 
gitgitgadget

