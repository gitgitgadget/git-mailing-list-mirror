From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 19/28] Check that "guilt graph" works when working on a branch with a comma.
Date: Fri, 21 Mar 2014 08:31:57 +0100
Message-ID: <1395387126-13681-20-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyG-0003Wa-K5
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbaCUHeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:34:19 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45923 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbaCUHd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:29 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so1383043lbj.17
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GU6zGLtRLzCq9iihSNjyxvJHFX2iE+mJDRGV6zumYg=;
        b=Y5daOlH3+xTcu9n/dgBvHb2vV8j0CYYMfPIbiaJbNTLDyuG8S3QmNS4IbWHjjLjofU
         RTgaqt3HPgBiWEeR8J3JIAJPuaq06cxIoDTa6Is9/jbyaOrDY6G1CF8G/JUh3IyMoYaP
         idmi+3AdGdF3uO96Xp3EydHoFm30gN5SjNfbFCifd8HWGdaRiAylehI3UziZKiy2Nu9q
         qW35BwJyWWAU4MS8B2GKW2oHkjaLA+4Rp0cAZjPAlqgHNdY8/TisPq485+kyJ0fylHJw
         palQmOJCiIsmH2b7NQESSEzaXafchA/EgOti419UfoNws7vqz4k2MGfGOwPRV9rY0sRb
         a3dQ==
X-Gm-Message-State: ALoCoQlAUAk+amXhreZ9VHNxdXv4cnZDTacn4DpmgFd1Pn04+wOIyeMCZ3FKv9GffCu3idn1rbGy
X-Received: by 10.112.140.202 with SMTP id ri10mr31400381lbb.9.1395387208406;
        Fri, 21 Mar 2014 00:33:28 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244664>

git branch names can contain commas.  Check that "guilt graph" works
even in that case.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-033.out | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-033.sh  | 37 +++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/regression/t-033.out b/regression/t-033.out
index 76613f9..e638d7b 100644
--- a/regression/t-033.out
+++ b/regression/t-033.out
@@ -1,3 +1,65 @@
 % setup_repo
 % guilt graph
 No patch applied.
+% git checkout -b a,graph master
+Switched to a new branch 'a,graph'
+% guilt init
+% guilt new a.patch
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..a.patch
+Patch applied.
+% guilt graph
+digraph G {
+# checking rev 95275d7c05c6a6176d3941374115b91272877f6c
+	"95275d7c05c6a6176d3941374115b91272877f6c" [label="a.patch"]
+}
+% git add file.txt
+% guilt refresh
+Patch a.patch refreshed
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..a.patch
+Patch applied.
+% guilt graph
+digraph G {
+# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
+	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
+}
+% guilt new b.patch
+% git add file2.txt
+% guilt refresh
+Patch b.patch refreshed
+% guilt pop
+Now at a.patch.
+% guilt push
+Applying patch..b.patch
+Patch applied.
+% guilt graph
+digraph G {
+# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
+	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
+# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
+	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
+}
+% guilt new c.patch
+% git add file.txt
+% guilt refresh
+Patch c.patch refreshed
+% guilt pop
+Now at b.patch.
+% guilt push
+Applying patch..c.patch
+Patch applied.
+% guilt graph
+digraph G {
+# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
+	"891bc14b5603474c9743fd04f3da888644413dc5" [label="c.patch"]
+# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
+	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
+# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
+	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
+	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
+}
diff --git a/regression/t-033.sh b/regression/t-033.sh
index ae40577..57dce78 100755
--- a/regression/t-033.sh
+++ b/regression/t-033.sh
@@ -3,9 +3,46 @@
 # Test the graph code
 #
 
+function fixup_time_info
+{
+	cmd guilt pop
+	touch -a -m -t "$TOUCH_DATE" ".git/patches/a,graph/$1"
+	cmd guilt push
+}
+
 source "$REG_DIR/scaffold"
 
 cmd setup_repo
 
 shouldfail guilt graph
 
+cmd git checkout -b a,graph master
+
+cmd guilt init
+
+cmd guilt new a.patch
+
+fixup_time_info a.patch
+cmd guilt graph
+
+cmd echo a >> file.txt
+cmd git add file.txt
+cmd guilt refresh
+fixup_time_info a.patch
+cmd guilt graph
+
+# An unrelated file. No deps.
+cmd guilt new b.patch
+cmd echo b >> file2.txt
+cmd git add file2.txt
+cmd guilt refresh
+fixup_time_info b.patch
+cmd guilt graph
+
+# An change to an old file. Should add a dependency.
+cmd guilt new c.patch
+cmd echo c >> file.txt
+cmd git add file.txt
+cmd guilt refresh
+fixup_time_info c.patch
+cmd guilt graph
-- 
1.8.3.1
