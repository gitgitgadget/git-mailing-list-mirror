Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2FB1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeFHUdL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:33:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52257 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeFHUdA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:33:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so5356424wmb.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yvs9+MsGcUI39Bng5ViK/5DCoT+os0MnzxtR5+219yw=;
        b=NVyRtJHCvqBcqypIu0kkQK3V6yTUvBm2PX9pBIbEXqnid1vUMVKxCJ4DJPh417bkLJ
         yMH46P0Lduc3LBQnItv9F4K7QM/8I/yxiw4weNZArCgYvZaE/52ywwioq+JUu8vs+XiC
         j7oC/wyFLrQdmySdsV6BYUCXtIqfKX3Za37rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yvs9+MsGcUI39Bng5ViK/5DCoT+os0MnzxtR5+219yw=;
        b=U6ZsgN7wgjgF+/QdxSGNpIhGipiSPhpCCMGRjjxpvwnqqTJF8/P3gxNgDQnlfTnhMB
         xYlsCVq/TxYbD1LoOfWKHYLBHsJTsDjGWmWrR3oUfLGuIsjG0nEpsmUq250Qwc1y1LjA
         ob79X4YZkWljhdEwOFAHz6EAHbjOb1pmaYYNJKbzvv/ERgAYhPWcPYgQutmUCsa+ijVD
         ps7/srI/8Ho5lr0edFLnmZZxqCWVhn1E9TLJIk4Q9OiVBVEa2BmPT+s4/E7917uK8710
         wmo5QWExZhxD44gAtcG/FTbojTtbZF3jP/MNL2JbA+GU01EvEFojf3FeQ5g4bv4kKG4r
         kn9g==
X-Gm-Message-State: APt69E3UssFJJPKSJCYY+YL8vnqInflPUm2iFP48491pV34WkNcO/2qO
        OsZRgqqK22io35P96FDLXINZPvjT
X-Google-Smtp-Source: ADUXVKJIkDvuPWCqsUdtmW0Hsf+NLAXBkdpxrdW4ClK9GniJD3e62I9FMyLo6aWLUMFF+UmQ6+cHyw==
X-Received: by 2002:a1c:f509:: with SMTP id t9-v6mr2718038wmh.13.1528489978442;
        Fri, 08 Jun 2018 13:32:58 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id k82-v6sm240001wmg.10.2018.06.08.13.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:32:57 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Eric Scouten <eric@scouten.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, viniciusalexandre@gmail.com,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 3/6] git-p4: better error reporting when p4 fails
Date:   Fri,  8 Jun 2018 21:32:45 +0100
Message-Id: <20180608203248.16311-4-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180608203248.16311-3-luke@diamand.org>
References: <20180608203248.16311-1-luke@diamand.org>
 <20180608203248.16311-2-luke@diamand.org>
 <20180608203248.16311-3-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when p4 fails to run, git-p4 just crashes with an obscure
error message.

For example, if the P4 ticket has expired, you get:

  Error: Cannot locate perforce checkout of <path> in client view

This change checks whether git-p4 can talk to the Perforce server when
the first P4 operation is attempted, and tries to print a meaningful
error message if it fails.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py         | 55 +++++++++++++++++++++++++++++++++
 t/t9833-errors.sh | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100755 t/t9833-errors.sh

diff --git a/git-p4.py b/git-p4.py
index b61f47cc61..3de12a4a0a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -50,6 +50,8 @@ def __str__(self):
 # Grab changes in blocks of this many revisions, unless otherwise requested
 defaultBlockSize = 512
 
+p4_access_checked = False
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -91,6 +93,13 @@ def p4_build_cmd(cmd):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
     else:
         real_cmd += cmd
+
+    # now check that we can actually talk to the server
+    global p4_access_checked
+    if not p4_access_checked:
+        p4_access_checked = True    # suppress access checks in p4_check_access itself
+        p4_check_access()
+
     return real_cmd
 
 def git_dir(path):
@@ -264,6 +273,52 @@ def p4_system(cmd):
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
 
+def die_bad_access(s):
+    die("failure accessing depot: {0}".format(s.rstrip()))
+
+def p4_check_access(min_expiration=1):
+    """ Check if we can access Perforce - account still logged in
+    """
+    results = p4CmdList(["login", "-s"])
+
+    if len(results) == 0:
+        # should never get here: always get either some results, or a p4ExitCode
+        assert("could not parse response from perforce")
+
+    result = results[0]
+
+    if 'p4ExitCode' in result:
+        # p4 returned non-zero status, e.g. P4PORT invalid, or p4 not in path
+        die_bad_access("could not run p4")
+
+    code = result.get("code")
+    if not code:
+        # we get here if we couldn't connect and there was nothing to unmarshal
+        die_bad_access("could not connect")
+
+    elif code == "stat":
+        expiry = result.get("TicketExpiration")
+        if expiry:
+            expiry = int(expiry)
+            if expiry > min_expiration:
+                # ok to carry on
+                return
+            else:
+                die_bad_access("perforce ticket expires in {0} seconds".format(expiry))
+
+        else:
+            # account without a timeout - all ok
+            return
+
+    elif code == "error":
+        data = result.get("data")
+        if data:
+            die_bad_access("p4 error: {0}".format(data))
+        else:
+            die_bad_access("unknown error")
+    else:
+        die_bad_access("unknown error code {0}".format(code))
+
 _p4_version_string = None
 def p4_version_string():
     """Read the version string, showing just the last line, which
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
new file mode 100755
index 0000000000..9ba892de7a
--- /dev/null
+++ b/t/t9833-errors.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='git p4 errors'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'add p4 files' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "file1"
+	)
+'
+
+# after this test, the default user requires a password
+test_expect_success 'error handling' '
+	git p4 clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		P4PORT=: test_must_fail git p4 submit 2>errmsg
+	) &&
+	p4 passwd -P newpassword &&
+	(
+		P4PASSWD=badpassword test_must_fail git p4 clone //depot/foo 2>errmsg &&
+		grep -q "failure accessing depot.*P4PASSWD" errmsg
+	)
+'
+
+test_expect_success 'ticket logged out' '
+	P4TICKETS="$cli/tickets" &&
+	echo "newpassword" | p4 login &&
+	(
+		cd "$git" &&
+		test_commit "ticket-auth-check" &&
+		p4 logout &&
+		test_must_fail git p4 submit 2>errmsg &&
+		grep -q "failure accessing depot" errmsg
+	)
+'
+
+test_expect_success 'create group with short ticket expiry' '
+	P4TICKETS="$cli/tickets" &&
+	echo "newpassword" | p4 login &&
+	p4_add_user short_expiry_user &&
+	p4 -u short_expiry_user passwd -P password &&
+	p4 group -i <<-EOF &&
+	Group: testgroup
+	Timeout: 3
+	Users: short_expiry_user
+	EOF
+
+	p4 users | grep short_expiry_user
+'
+
+test_expect_success 'git operation with expired ticket' '
+	P4TICKETS="$cli/tickets" &&
+	P4USER=short_expiry_user &&
+	echo "password" | p4 login &&
+	(
+		cd "$git" &&
+		git p4 sync &&
+		sleep 5 &&
+		test_must_fail git p4 sync 2>errmsg &&
+		grep "failure accessing depot" errmsg
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+
+test_done
-- 
2.17.0.392.gdeb1a6e9b7

