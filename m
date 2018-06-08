Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502A41F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeFHUdK (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:33:10 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33349 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbeFHUdB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:33:01 -0400
Received: by mail-wm0-f44.google.com with SMTP id z6-v6so8302413wma.0
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T+TikzJ/YyZ1e2YDG0hoBKGZlGITBMsyIXeR5hqhCB8=;
        b=VXBG372qbwPS0vl/PhcDhofIrFCkxCqY7Gyaey47GC+hEnEHzWlbdX06UQIGc4DGAw
         bKexv+J1D24+UszL8mTA1Ii9eXcqo6cXW2gs16mBsB5e8USulq7B6tWbfA+gbAzBfCvp
         7/bTK6JLyJgJI0mUrQ0c3WhXfuhPuk+33KXoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T+TikzJ/YyZ1e2YDG0hoBKGZlGITBMsyIXeR5hqhCB8=;
        b=XVeoY25Rdi5oImX5LTlPxRbCRaakzmWmPRkEps2PiZ7Wk5O1yW06e3PpviD3il+0lq
         kX0CAKzyWtg6uw5Bbt5qNgOWB5avnCOAuQ3ZfIr1oEb4E3b+GSz8Gwf66hnGANJO3BKY
         1vnmILIU83Pt+QftMNIBTU2erCjrkQNOMR1aMVov3mvNuyh/a5GA7zda9DFrgdXZ6KHr
         oFmGClGNGOslEoF1ihlOvstdEf4wE4GiBhCdoUMq3LwrNiCE9nIyYcocxb8Lu1DPj2UT
         YDMjZN78IO9gizjiEaP3RKAZ/Ll7EWHQSjehZ+a8ByZM5k5WpUb5rdRymbUBaYyVnMnk
         akug==
X-Gm-Message-State: APt69E1WiyQWZ62pW1iILZrJupYXddoSIvPEsq54U3qURK95bbZj3Bad
        M8koRQ8S0EO/bucB6QqAOZjaLWwd
X-Google-Smtp-Source: ADUXVKJGNtSEw6FkmtEDTLlEKqJBCiANufzTYtIK2BILhjCLFqcyaptk+FJycZaWzGDiYf0VR/pR/g==
X-Received: by 2002:a1c:6d85:: with SMTP id b5-v6mr2334865wmi.135.1528489979812;
        Fri, 08 Jun 2018 13:32:59 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id k82-v6sm240001wmg.10.2018.06.08.13.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:32:59 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Eric Scouten <eric@scouten.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, viniciusalexandre@gmail.com,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 4/6] git-p4: raise exceptions from p4CmdList based on error from p4 server
Date:   Fri,  8 Jun 2018 21:32:46 +0100
Message-Id: <20180608203248.16311-5-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180608203248.16311-4-luke@diamand.org>
References: <20180608203248.16311-1-luke@diamand.org>
 <20180608203248.16311-2-luke@diamand.org>
 <20180608203248.16311-3-luke@diamand.org>
 <20180608203248.16311-4-luke@diamand.org>
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

This makes the code that handles the errors a bit easier.

The default behavior is unchanged; the new code is enabled with a flag.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 3de12a4a0a..f4b5deeb83 100755
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
+class P4ServerException(P4Exception):
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

