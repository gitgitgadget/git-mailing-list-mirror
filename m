Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B09C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 03:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiCWDuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbiCWDth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 23:49:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79857663
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u16so334615wru.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kc9xyU4A4N92Qz57vodtadkMQU0owiZYne8jttlBN5c=;
        b=S4jIxPWCGMUhbN5nM1AQxJjNK4jM+MSyxwDDFhr8V6QyfuqciKWfU5KNfDMtX8qH7j
         DlE01gNi+cr+wZr2YusIDiZGYLoKjsAGO5Rb9Lx4FnvWSFG9/Lq2spCORepIEIq7HHXL
         C8QHRLCMQu6fNKNeaqPJrMG3R4mhMMp6xXTujXV98vns7ko0VU/cU8hmjYVmmbL9cBEq
         NHu54nggPuFAdn8PPa/HtrdOtiH4ViXOPMaub22JQWCtLG9fkLGvv1LnfYJwoDD3DFcb
         2mliza6KLHgtR5PwnHSwn9r+9Wy3paiV2i7G0sIJX2VrGnVCCHh3fJJNogrujwf2o5is
         xwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kc9xyU4A4N92Qz57vodtadkMQU0owiZYne8jttlBN5c=;
        b=QzLrLFPltLUiExNvaDPXUi6C1NDVvXUIJRO8zQanQF/g/1xp70K4a78MUWbZmvaAvJ
         rqLEGX7XYXn5Y2X6m+CfJUqQjU4rx5IrgbC5HgyEQHYroXbDH1PbWu/MjhRhwAv21ety
         4/qAgWWuwmzfsligShzoYBoe2f2gZd2TEPTMhmRYbVUgzgdj5sM17PzoSPrxxUKmmyfQ
         v/9lQ24rdwuK2HWHGIssFHIaCUPqRoWrRq8Oj2UzgcYlEgbPnwFCQ6MzDcc2aaVi2BMX
         rX8lUiu+SsCme+Waqzhy/gjRNv2kuSrbSTTFmoAXvbfggKzEufN2TlfiAgE4php0DsNc
         Vchw==
X-Gm-Message-State: AOAM533z3cAqtQPxxHq1mk46vbEq8N2ZaYABxxi4PEr3c8R7kZyX3gYp
        /8XCYQGS/94wg3LxBvS+vT7pdDDdGO5z3A==
X-Google-Smtp-Source: ABdhPJySmbkYDrqLhbBSsYo+XNgy6Rp91xbPat7jCRQGuo1SsKPWqpo5vdbC/cxLLWOS6SQDDN3XOw==
X-Received: by 2002:a05:6000:1688:b0:203:8efe:e0b0 with SMTP id y8-20020a056000168800b002038efee0b0mr24526581wrd.289.1648007286006;
        Tue, 22 Mar 2022 20:48:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm3028830wms.16.2022.03.22.20.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:48:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 7/7] update-index: make use of HASH_N_OBJECTS{,_{FIRST,LAST}} flags
Date:   Wed, 23 Mar 2022 04:47:36 +0100
Message-Id: <RFC-patch-7.7-481f1d771cb-20220323T033928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com> <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with unpack-objects in a preceding commit have update-index.c make
use of the HASH_N_OBJECTS{,_{FIRST,LAST}} flags. We now have a "batch"
mode again for "update-index".

Adding the t/* directory from git.git on a Linux ramdisk is a bit
faster than with the tmp-objdir indirection:

	git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=-O3' -p 'rm -rf repo && git init repo && cp -R t repo/' 'git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' --warmup 1 -r 10
	Benchmark 1: git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'ns/batched-fsync
	  Time (mean ± σ):     289.8 ms ±   4.0 ms    [User: 186.3 ms, System: 103.2 ms]
	  Range (min … max):   285.6 ms … 297.0 ms    10 runs

	Benchmark 2: git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'HEAD
	  Time (mean ± σ):     273.9 ms ±   7.3 ms    [User: 189.3 ms, System: 84.1 ms]
	  Range (min … max):   267.8 ms … 291.3 ms    10 runs

	Summary
	  'git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'HEAD' ran
	    1.06 ± 0.03 times faster than 'git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'ns/batched-fsync'

And as before running that with "strace --summary-only" slows things
down a bit (probably mimicking slower I/O a bit). I then get:

	Summary
	  'git ls-files -- t | strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'HEAD' ran
	    1.21 ± 0.02 times faster than 'git ls-files -- t | strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'ns/batched-fsync'

We also go from ~51k syscalls to ~39k, with ~2x the number of link()
and unlink() in ns/batched-fsync.

In the process of doing this conversion we lost the "bulk" mode for
files added on the command-line. I don't think it's useful to optimize
that, but we could if anyone cared.

We've also converted this to a string_list, we could walk with
getline_fn() and get one line "ahead" to see what we have left, but I
found that state machine a bit painful, and at least in my testing
buffering this doesn't harm things. But we could also change this to
stream again, at the cost of some getline_fn() twiddling.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index af02ff39756..c7cbfe1123b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1194,15 +1194,38 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_from_stdin) {
+		struct string_list list = STRING_LIST_INIT_NODUP;
 		struct strbuf line = STRBUF_INIT;
 		struct strbuf unquoted = STRBUF_INIT;
+		size_t i, nr;
+		unsigned oflags;
 
 		setup_work_tree();
-		while (getline_fn(&line, stdin) != EOF)
-			line_from_stdin(&line, &unquoted, prefix, prefix_length,
-					nul_term_line, set_executable_bit, 0);
+		while (getline_fn(&line, stdin) != EOF) {
+			size_t len = line.len;
+			char *str = strbuf_detach(&line, NULL);
+
+			string_list_append_nodup(&list, str)->util = (void *)len;
+		}
+
+		nr = list.nr;
+		oflags = nr > 1 ? HASH_N_OBJECTS : 0;
+		for (i = 0; i < nr; i++) {
+			size_t nth = i + 1;
+			unsigned f = i == 0 ? HASH_N_OBJECTS_FIRST :
+				  nr == nth ? HASH_N_OBJECTS_LAST : 0;
+			struct strbuf buf = STRBUF_INIT;
+			struct string_list_item *item = list.items + i;
+			const size_t len = (size_t)item->util;
+
+			strbuf_attach(&buf, item->string, len, len);
+			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
+					nul_term_line, set_executable_bit,
+					oflags | f);
+			strbuf_release(&buf);
+		}
 		strbuf_release(&unquoted);
-		strbuf_release(&line);
+		string_list_clear(&list, 0);
 	}
 
 	if (split_index > 0) {
-- 
2.35.1.1428.g1c1a0152d61

