Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A05D1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 09:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeFEJOA (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 05:14:00 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:56218 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeFEJN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 05:13:59 -0400
Received: by mail-wm0-f48.google.com with SMTP id v16-v6so3421063wmh.5
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QBnvaUo15+pyoalaCJA0jjQMhBzqatufY+1v7MPvWxU=;
        b=ea1m/sQhJmw/cceq0Ix7LlU9pydCXrKaSStOxLRtbMGrwh0HkaenTYnmNB+crebUI/
         aRas9VVA4gZGDE1XsNd03Qp28Tvh99a0CKh6TYUFEQnRoTNer63vCwRyErcen0Qb4OYB
         xXQQhO5Sm7FK5KKtwxR4AFLlE4XYnr0pAvpN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QBnvaUo15+pyoalaCJA0jjQMhBzqatufY+1v7MPvWxU=;
        b=d1OUZUlnfWtrZMCGVy8Reo0nEse375pCxOvMAPrI9cP0nMnRM0tTwwVMuHXRIepiOm
         HWMisM39D+i9h4C1T1UAOdcqzuFXCQiMZ1IhnvToe42ofUhEUGnVz9P7YACYYkPWimIi
         MGO1dUfARbqkxa0YFipHYYEIdD8K2JQ8keKOqC8iLBQ361XctwP8lx589KNt86shYpc8
         jWfv94KvaamPuOdcjgiIG8zBlga5+5n1o2q0nAsR39uVpkIVov8yap8n4rU+bH6e57tA
         yPFhEO9+rUGmsh32j/px/j0HtBXZ+quc0Fwq/cQWqJXRKsjFZV0As6nDFgoHalziW09n
         JMJA==
X-Gm-Message-State: APt69E2E6aKgMHoidqpM/eO0i26VGMs/HWCz9jLOLK7/sQ+nwF+e0Bac
        XGLXPdUu0fvMiS23KkAPFXCvWD/oaHI=
X-Google-Smtp-Source: ADUXVKIRxEeVHQbsccXcCiFY3ta3d8wLStoTcXatjdyFJEqtfjKEmoPZOLHBak4Qstk2pGGsw1YZvg==
X-Received: by 2002:a1c:8ec1:: with SMTP id q184-v6mr10924496wmd.48.1528190037782;
        Tue, 05 Jun 2018 02:13:57 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id i46-v6sm42018545wra.36.2018.06.05.02.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 02:13:57 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/3] git-p4: raise exceptions from p4CmdList based on error from p4 server
Date:   Tue,  5 Jun 2018 10:13:48 +0100
Message-Id: <20180605091350.14476-2-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180605091350.14476-1-luke@diamand.org>
References: <20180605091350.14476-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change lays some groundwork for better handling of rowcount errors
from the server, where it fails to send us results because we requested
too many.

It adds an option to p4CmdList() to return errors as a Python exception.

The exceptions are derived from P4Exception (something went wrong),
P4ServerException (the server sent us an error code) and
P4RequestSizeException (we requested too many rows/results from the
server database).

This makes makes the code that handles the errors a bit easier.

The default behavior is unchanged; the new code is enabled with a flag.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 66652f8280..d856078ec8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -566,10 +566,30 @@ def isModeExec(mode):
     # otherwise False.
     return mode[-3:] == "755"
 
+class P4Exception(Exception):
+    """ Base class for exceptions from the p4 client """
+    def __init__(self, exit_code):
+        self.p4ExitCode = exit_code
+
+class P4ServerException(Exception):
+    """ Base class for exceptions where we get some kind of marshalled up result from the server """
+    def __init__(self, exit_code, p4_result):
+        super(P4ServerException, self).__init__(exit_code)
+        self.p4_result = p4_result
+        self.code = p4_result[0]['code']
+        self.data = p4_result[0]['data']
+
+class P4RequestSizeException(P4ServerException):
+    """ One of the maxresults or maxscanrows errors """
+    def __init__(self, exit_code, p4_result, limit):
+        super(P4RequestSizeException, self).__init__(exit_code, p4_result)
+        self.limit = limit
+
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
-def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False):
+def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
+        errors_as_exceptions=False):
 
     if isinstance(cmd,basestring):
         cmd = "-G " + cmd
@@ -616,9 +636,25 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False):
         pass
     exitCode = p4.wait()
     if exitCode != 0:
-        entry = {}
-        entry["p4ExitCode"] = exitCode
-        result.append(entry)
+        if errors_as_exceptions:
+            if len(result) > 0:
+                data = result[0].get('data')
+                if data:
+                    m = re.search('Too many rows scanned \(over (\d+)\)', data)
+                    if not m:
+                        m = re.search('Request too large \(over (\d+)\)', data)
+
+                    if m:
+                        limit = int(m.group(1))
+                        raise P4RequestSizeException(exitCode, result, limit)
+
+                raise P4ServerException(exitCode, result)
+            else:
+                raise P4Exception(exitCode)
+        else:
+            entry = {}
+            entry["p4ExitCode"] = exitCode
+            result.append(entry)
 
     return result
 
-- 
2.17.0.392.gdeb1a6e9b7

