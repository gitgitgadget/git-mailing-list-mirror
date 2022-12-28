Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48FC46467
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiL1SAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiL1SAh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5718399
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id co23so15540792wrb.4
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14ZREzeD+V9g9eiFMBaVSo7ewXHvb5PlTR/vuI6RjLk=;
        b=pCUxTZt/EPjwZnwBw3wUFyPhCV283g/fhQ8JdT+OF5qGJDvUSCOOnbt9OrYTDRa9l2
         IdFVyEDKHxYSoBDdgXdcfkzogZK8B6z8ovZMzOVW5k3bsXj5joF63/TmWNgGZk2TGXLa
         7NrWVAMuYDk/Vife5xrVOmCB6TeklhxclDOxkPIu9ak1t1XNYKNS5/93/M95gwaV8Jv1
         Dl2/dXxmpsvlqCDwHmtbn8v/SKZ+1TzMRSFngWtJwDTUBPBqm7OqmAGZYA8WsV5AQXB4
         8xad8dNC8Jd5lLIsi7yAdNXRkRRCxvHrhWoJK8+elb7aYQO5zxSysKIpDfHBvSv7FnYO
         VMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14ZREzeD+V9g9eiFMBaVSo7ewXHvb5PlTR/vuI6RjLk=;
        b=k155IOgh2uT+5r/qqod3GnFrpCGUm2s3bwqblIMH5059W5doOR46ftyHVaXhF42Tfm
         ab25n082uPsoWtTzhqX+WnZZXCF9A2dI+iVfrI5sv0KRQ5XC54sBPbr7qlftb2lwJerc
         NJ1/sFg7wQiCDCnWtG38OLp5y49FIU+Fpy0uhfRvEEhKGDGbdLhAoHjfLyy4LK+k9E6o
         15VbGHyh7ag30ylhIcFt48GKq08cWJ0PLRuxwqZJafAsLWn/WcZA3NTl6SSMYhIoqad1
         itgMJR0sA6NKiORALqOpzJ2/JM3zkBnPFWtOTm33V8gon9zTv5OETQgV4OeHowVniEN7
         oP7A==
X-Gm-Message-State: AFqh2krUq9whAvumlb5akMKs731CEdMD3pHacPGbYLSKdGMImtDLq9+q
        329M857jFmyhkppioySP2Lg2Xk4FIQxc3A==
X-Google-Smtp-Source: AMrXdXs1ysiydpnb6SUkCTQtWd1QT4kKs0ZMavs1nXgw+yLvJu5SYAuEblBfaAHooBUcjtlmr5xVWQ==
X-Received: by 2002:adf:f285:0:b0:270:57d:d1c9 with SMTP id k5-20020adff285000000b00270057dd1c9mr14303655wro.39.1672250432103;
        Wed, 28 Dec 2022 10:00:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/20] archive.c: call clear_pathspec() in write_archive()
Date:   Wed, 28 Dec 2022 19:00:06 +0100
Message-Id: <patch-06.20-bc45aee530c-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a leak in the "struct archiver_args", and clear_pathspec() the
"pathspec" member that the "parse_pathspec_arg()" call in this
function populates.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c                       | 1 +
 t/t5001-archive-attr.sh         | 1 +
 t/t5004-archive-corner-cases.sh | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/archive.c b/archive.c
index 941495f5d78..a2d813e50db 100644
--- a/archive.c
+++ b/archive.c
@@ -710,6 +710,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 
 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
 	free(args.refname);
+	clear_pathspec(&args.pathspec);
 
 	return rc;
 }
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 2f6eef5e372..04d300eeda7 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -3,6 +3,7 @@
 test_description='git archive attribute tests'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT='%H (%h)%n'
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index ae508e21623..9f2c6da80e8 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test corner cases of git-archive'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # the 10knuls.tar file is used to test for an empty git generated tar
-- 
2.39.0.1153.gb0033028ca9

