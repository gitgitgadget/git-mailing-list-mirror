Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7301C1FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbdDIT7N (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:59:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35962 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdDIT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:59:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id q125so6453469wmd.3
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkXJOxOW6sUYbSnvK50HZn2ZdKGltmRjQfVO6zYGqPY=;
        b=Lrlpa7E/LCgxGrP22++BoxgxoJtt391riI1qQUr+AGLsomyM3LscdhKD3tz854VdiE
         KDv42PmsMSdF+vx/XWJJvhRPmnDLQuk73iTCsFuAaC7sRCqBB7rOt9FQqZusW9mfJB2Z
         +LIw3+EAzsQv2XLDBMRBGdWpfuPeH8oL8vsxz0ajTLJhCXt/ML3lOlofcm+ddXr86UsA
         luXDOMVm/ospivv4uiIAayFV3QdYJ4gy9b3ZBG9bUyxoaprHKAAwoHc3dICcY52for5N
         M+zzgxyAY4f2hu5Lc65PbYTYwkuPVFWbByNz3/fhEb8yPqC7tTJ6O+62rzTLInbDCyEp
         brqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkXJOxOW6sUYbSnvK50HZn2ZdKGltmRjQfVO6zYGqPY=;
        b=ZssE1KgwScDx1KtdGZT/6TNT4blXCvoKYGGsl6vkOu7wqU+woPPvdTQKo+l9staAM7
         Lu/8a2whs/m9mNwzte2gSfTXmRcXC5KUynkIs8WVTflsOTus+WEijTXKaHTA0oGgO66V
         tOk0Ssn9VSZEXxKgzWpg7sblAJlKW56F9SNHSmrYLSUmrr7aswQqjp6X51jKdIoUTpgj
         ObnqeQH/6U0lCClLlfCWd07pta+f3xR35XcEswIV2oIYUfd6XNddYRdz8w+yNDY3+Itz
         DQs0cazWQ3NvwMSRPaeLpL2/eeaBwdu50NUqwmzQALNhEI+yDz9XtoQDtUmXmd0fv9AK
         DTyw==
X-Gm-Message-State: AN3rC/5vawSEcLWe0D5kjL8OdPUyDcyx4a3f32i9Q3tC7g7amYxwjGmw
        TSBq7NV5ePvIsA==
X-Received: by 10.28.226.4 with SMTP id z4mr7187713wmg.135.1491767949824;
        Sun, 09 Apr 2017 12:59:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v186sm7480131wmv.2.2017.04.09.12.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Apr 2017 12:59:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] grep: plug a trivial memory leak
Date:   Sun,  9 Apr 2017 19:59:00 +0000
Message-Id: <20170409195900.32701-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the cleanup phase for the grep command to free the pathspec
struct that's allocated earlier in the same block, and used just a few
lines earlier.

With "grep hi README.md" valgrind reports a loss of 239 bytes now,
down from 351.

The relevant --num-callers=40 --leak-check=full --show-leak-kinds=all
backtrace is:

    [...] 187 (112 direct, 75 indirect) bytes in 1 blocks are definitely lost in loss record 70 of 110
    [...]    at 0x4C2BBAF: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
    [...]    by 0x60B339: do_xmalloc (wrapper.c:59)
    [...]    by 0x60B2F6: xmalloc (wrapper.c:86)
    [...]    by 0x576B37: parse_pathspec (pathspec.c:652)
    [...]    by 0x4519F0: cmd_grep (grep.c:1215)
    [...]    by 0x4062EF: run_builtin (git.c:371)
    [...]    by 0x40544D: handle_builtin (git.c:572)
    [...]    by 0x4060A2: run_argv (git.c:624)
    [...]    by 0x4051C6: cmd_main (git.c:701)
    [...]    by 0x4C5901: main (common-main.c:43)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Since pretty much any non-trivial git command leaks because it skips
cleanup are patches in this category even accepted? Worth a try...

 builtin/grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 65070c52fc..3ffb5b4e81 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1299,6 +1299,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
+	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
 	return !hit;
 }
-- 
2.11.0

