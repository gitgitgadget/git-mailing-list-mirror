Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B5120357
	for <e@80x24.org>; Thu, 13 Jul 2017 07:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdGMHBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 03:01:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33168 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdGMHBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 03:01:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id n18so415855wrb.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBfyI3yNhMzTVHnxpyRSQumTxCp498VNzpyepiFUzoM=;
        b=IJXuE7lf2kSXqsAtl59aH3ydqaDGAHWAdcIylfbTLQqjGhevpqXjlVt/PRKxqA80Xm
         lGMOGU2lkH6RcRT8YHzqzN/Ugu10NY5upuNpByxF5sb7Vl020lEgrLk4j2iH7mN/fX5Y
         X6VFtTnC4l24ja23XugWIynybYd20+jxca9USxy4dNnYwDdGNAOp9I6aLyU5OWaNr0vT
         oaY+zxOTimkhg1cs0cxIwJ78SKSlSUzp0KePzQqGvfsTsIRF3W3HHcD711N55HD8IvUq
         Kx3PC8LZb96PXejqOjUElKsjWCi5HFhCLWN/VA5ngnsE2mKm7i/i2PPBLhM/kWM1CdeC
         uusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sBfyI3yNhMzTVHnxpyRSQumTxCp498VNzpyepiFUzoM=;
        b=guq5HxqiucWjvJUPz/uIGJTGRqHx8JPj/yqUOD0EYrTxX+q1j93kMNK2VxD6u0icZO
         Dc7bSMSfPXXXGufi/g5TU7bDQ/DLH5OSZ9EvgfvQh0Al1f34QvsWf+p+U5L8CJEYEfrD
         MXnVSziu3dzq9q2AYuAXxd0CBDQ3Kx3tZVVoujyob1fDOQ+Pfk5CzI+eTJoTpKnVvA+C
         cjzM6ganwJLTnx4V36khR1IrbIagg6OEketiJqbnEde4Qv4G5lfYgFI7bX9XOFJk+oP6
         cZQBArPvwnSypM426Q8Ys7KtVPdVOHAqjhJ5qNwrQpnI/vdInlKknLHkXeScuaWn9KbN
         ZB5Q==
X-Gm-Message-State: AIVw113MCwYv5ireGEl6LeKMBAG5cV6NVWS8lMaUsVA+GYiKxmGyzqv3
        KY/LFAr1gG2CEQ==
X-Received: by 10.223.152.3 with SMTP id v3mr644925wrb.8.1499929264391;
        Thu, 13 Jul 2017 00:01:04 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id r200sm4049927wmd.20.2017.07.13.00.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 00:01:03 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 3/3] git-p4: filter for {'code':'info'} in p4CmdList
Date:   Thu, 13 Jul 2017 09:00:35 +0200
Message-Id: <20170713070035.12731-3-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170713070035.12731-1-miguel.torroja@gmail.com>
References: <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
 <20170713070035.12731-1-miguel.torroja@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function p4CmdList accepts a new argument: skip_info. When set to
True it ignores any 'code':'info' entry (skip_info=False by default).

That allows us to fix some of the tests in t9831-git-p4-triggers.sh
known to be broken with verobse p4 triggers

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 git-p4.py                  | 9 ++++++---
 t/t9831-git-p4-triggers.sh | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e3a2791e0..2fa581789 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -313,7 +313,7 @@ def p4_move(src, dest):
     p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
 
 def p4_last_change():
-    results = p4CmdList(["changes", "-m", "1"])
+    results = p4CmdList(["changes", "-m", "1"], skip_info=True)
     return int(results[0]['change'])
 
 def p4_describe(change):
@@ -321,7 +321,7 @@ def p4_describe(change):
        the presence of field "time".  Return a dict of the
        results."""
 
-    ds = p4CmdList(["describe", "-s", str(change)])
+    ds = p4CmdList(["describe", "-s", str(change)], skip_info=True)
     if len(ds) != 1:
         die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
 
@@ -509,7 +509,7 @@ def isModeExec(mode):
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
-def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
+def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False):
 
     if isinstance(cmd,basestring):
         cmd = "-G " + cmd
@@ -545,6 +545,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
     try:
         while True:
             entry = marshal.load(p4.stdout)
+            if skip_info:
+                if 'code' in entry and entry['code'] == 'info':
+                    continue
             if cb is not None:
                 cb(entry)
             else:
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index 871544b1c..bbcf14c66 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -20,7 +20,7 @@ test_expect_success 'init depot' '
 	)
 '
 
-test_expect_failure 'clone with extra info lines from verbose p4 trigger' '
+test_expect_success 'clone with extra info lines from verbose p4 trigger' '
 	test_when_finished cleanup_git &&
 	(
 		p4 triggers -i <<-EOF
@@ -38,7 +38,7 @@ test_expect_failure 'clone with extra info lines from verbose p4 trigger' '
 	)
 '
 
-test_expect_failure 'import with extra info lines from verbose p4 trigger' '
+test_expect_success 'import with extra info lines from verbose p4 trigger' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.11.0

