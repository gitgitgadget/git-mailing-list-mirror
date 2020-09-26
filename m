Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3142C4727D
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E53C21531
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWaggYTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgIZVE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIZVE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:04:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F7C0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so7581860wrm.9
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rhnqNcQm0x++W3hvpSYVdA8rvQO0+VPmQ0qhsoSVUNs=;
        b=OWaggYTi7mnUuMzK492OUJbyaBgkh7rn4bBY6qutj8hEV91dAFH+8PH/c6kUOnwBAI
         JTubrvoKwyWudbQoiSU8THRsJywFtvZ17e7Y2Tv19gqqMeCbOmvhJyozFMiuNGkSkasZ
         mBbZQBLmbeo+5x3o8DG0ujic3dpILHYIkNfHn7ZJ0MjFj7eJYqOIg3mMKuPfekEEOezW
         sJj83JkFc20etYHbf95/fzcu1RRJsA7FfzGxdBUnCmgsKrVx9/rQ1I6Vnx5ssgk85mir
         IQ5GHIZrsCpu7I9xy6QWqEL9SIJPmZa2V8xDCLj+2ABDbVEFcT9wIMkrmJuA3qLHkw1l
         n4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rhnqNcQm0x++W3hvpSYVdA8rvQO0+VPmQ0qhsoSVUNs=;
        b=qkGB/2urWTWhXBtGcsPjd+Gk2Csq0eAhmzOTRNXNpkhHHrBFGI19oHD4bYVugseJVZ
         ostuSd1I0CSp31sK6L6gsWBrVmUnRrSt2u38NgyK4lhff4LsN2eU/vxKdQfG3OFPf1R9
         BJVU18WFc9Ao7kNrmYw8ghVQ0jiu9AcBfoMYW+vuHZVRpgdn1Vo2nn1hBY4EhLaptxqu
         CetzaYB2AIFBPmYDgGrNO5+S8mwSy8H+PQTs9Yt7+k4KhQYJE+lVkTxPXULQ6y4mx2V4
         BOWu/CczaEgumN0W1Wy5i+Y9RBr9TkN+GS73k4WIIRl/A1D6Fl9ZaJAm058PYqgOoJBM
         qVyA==
X-Gm-Message-State: AOAM530DAzwCYq65Y3Lq3I+krld5M/mW54YqIB7hzlKZSoxpx75vkCTd
        bKcx4INbR480TY7OvXmu5f2dtZI6xO0=
X-Google-Smtp-Source: ABdhPJz/FzN0fmyBSH073Xev5W63VIZn0TPgaTwNeQLYh6S7VJ2gEyhRuINK/YjVsUk8wYWCKhebCg==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr10584038wrp.376.1601154265047;
        Sat, 26 Sep 2020 14:04:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm7455982wrm.10.2020.09.26.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:04:24 -0700 (PDT)
Message-Id: <80e1d46ccefeb39bf3a10c5c973d62fa887210d1.1601154262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
References: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
        <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:04:19 +0000
Subject: [PATCH v3 2/5] t/test-terminal: avoid non-inclusive language
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

