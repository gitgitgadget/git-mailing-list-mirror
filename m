From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 20/28] "guilt graph": Handle patch names containing quotes.
Date: Fri, 21 Mar 2014 08:31:58 +0100
Message-ID: <1395387126-13681-21-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxb-0002XC-UN
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759879AbaCUHdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:35 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:61962 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbaCUHdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:31 -0400
Received: by mail-la0-f46.google.com with SMTP id hr17so1380335lab.33
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJiqixPQtccdQS4/y5WknzNqxUStCrWxEVKiIFjvk+c=;
        b=M+2DaiXBgogFpzR6CX2uUP3ycQIHLnkkgl0YlyztLXe+v4VUDAGdDbpcmG9L1xMGUX
         Pgk+RS43rZq9Afd49jUKF/+1wKNaQl4Xf+C9w8vOWK+U1CFSJYv4Vvitump1/PhqsR0a
         6iEQmS5t9pRNv6rCGEsJL7uDmmW1EEuGPe74TmIKf9o/H1MYQgmhRe9TWhqwHw4Tv4eh
         Ibt793AykTBI0L5EAkHmBYkdr/RfI0ZCDsNBwYveOOqsMCg8LiEoB74a0LjFBDbKjs9k
         I2LQNMPqJCgfGtLsE7e2+e1lxWdx580U6Q/4orp1BBWbbtDFaonQtw2XCQfAvHKT5GMq
         VZhA==
X-Gm-Message-State: ALoCoQlyeWr2i2tXzfeT2RmNc+A/HgkmxIUfcy4tTxSmX2F5e8cWB7o632Xtrf9s0EZhO4eD/0H0
X-Received: by 10.112.137.5 with SMTP id qe5mr31380512lbb.16.1395387210049;
        Fri, 21 Mar 2014 00:33:30 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244652>

Quote quotes with a backslash in the "guitl graph" output.  Otherwise,
the "dot" file could contain syntax errors.

Added a test case.
---
 guilt-graph          |  2 ++
 regression/t-033.out | 22 ++++++++++++++++++++++
 regression/t-033.sh  |  9 +++++++++
 3 files changed, 33 insertions(+)

diff --git a/guilt-graph b/guilt-graph
index 575f03b..24ab83b 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -58,6 +58,8 @@ while [ "$current" != "$base" ]; do
 }"`
 	[ -z "$pname" ] && pname="?"
 
+	pname="`printf \"%s\" $pname|sed 's/\"/\\\\\"/g'`"
+
 	disp "# checking rev $current"
 	disp "	\"$current\" [label=\"$pname\"]"
 
diff --git a/regression/t-033.out b/regression/t-033.out
index e638d7b..1c28ea9 100644
--- a/regression/t-033.out
+++ b/regression/t-033.out
@@ -63,3 +63,25 @@ digraph G {
 	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
 	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
 }
+% guilt new a-"better&quicker'-patch.patch
+% git add file.txt
+% guilt refresh
+Patch a-"better&quicker'-patch.patch refreshed
+% guilt pop
+Now at c.patch.
+% guilt push
+Applying patch..a-"better&quicker'-patch.patch
+Patch applied.
+% guilt graph
+digraph G {
+# checking rev bc7df666a646739eaf559af23cab72f2bfd01f0e
+	"bc7df666a646739eaf559af23cab72f2bfd01f0e" [label="a-\"better&quicker'-patch.patch"]
+# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
+	"891bc14b5603474c9743fd04f3da888644413dc5" [label="c.patch"]
+	"bc7df666a646739eaf559af23cab72f2bfd01f0e" -> "891bc14b5603474c9743fd04f3da888644413dc5"; // ?
+# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
+	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
+# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
+	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
+	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
+}
diff --git a/regression/t-033.sh b/regression/t-033.sh
index 57dce78..968292c 100755
--- a/regression/t-033.sh
+++ b/regression/t-033.sh
@@ -46,3 +46,12 @@ cmd git add file.txt
 cmd guilt refresh
 fixup_time_info c.patch
 cmd guilt graph
+
+# A patch name that contains funky characters, including unbalanced
+# quotes.
+cmd guilt new "a-\"better&quicker'-patch.patch"
+cmd echo d >> file.txt
+cmd git add file.txt
+cmd guilt refresh
+fixup_time_info "a-\"better&quicker'-patch.patch"
+cmd guilt graph
-- 
1.8.3.1
