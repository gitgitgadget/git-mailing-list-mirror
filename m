From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 19/33] Check that "guilt graph" works when working on a branch with a comma.
Date: Sun, 18 May 2014 23:59:55 +0200
Message-ID: <1400450409-30998-20-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:08:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9GL-00014d-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbaERWIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:08:54 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:57738 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbaERWIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:08:53 -0400
Received: by mail-la0-f53.google.com with SMTP id ec20so3486261lab.12
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMnEognkABKJw4aGgoKA/0EYoyjV3hfcINmmHnJDH8w=;
        b=ASyyx60gIUX2fq3VFsmIPsgzuhqH0shTdPq8v00MESSc/tEWMq6Mow5EAHpTncULhf
         xsfMDlt13yxC1sFldZlTpmQuVLTNAZQhgjC3A2H+4X7sxA1njwQ3tqrCrPPhTF+GY8/t
         op52CjYPepzYQOvqVxKLgVPnEw4YbwrkD3N1kAMjMJgg+bOohL/QbffxkpFG1SXdeq0E
         fIxZRtKkK45skh39fDEHOcpGDzgumGvl8UXB+vfNm6/CsFgZDNjebKHcgJEzNFH23AIr
         7llFmyTfb7A6a5bqCs20CPUgAjOPeuJRu7w6xyYFbW8Jkgnq8ZdcdM+hcsGFIYvGuUeQ
         HYjg==
X-Gm-Message-State: ALoCoQktjwt4RdIvvFhKLceeIxscu7wSTQfClErFTu9hVpSY4eB9DpLWnXQqZGMvSmOQHu2um47k
X-Received: by 10.112.149.36 with SMTP id tx4mr3031733lbb.59.1400450932573;
        Sun, 18 May 2014 15:08:52 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.08.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:08:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249534>

git branch names can contain commas.  Check that "guilt graph" works
even in that case.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/t-033.out | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-033.sh  | 39 +++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/regression/t-033.out b/regression/t-033.out
index 76613f9..3d1c61f 100644
--- a/regression/t-033.out
+++ b/regression/t-033.out
@@ -1,3 +1,68 @@
 % setup_repo
 % guilt graph
 No patch applied.
+%% Testing branch a,graph
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
+%% Adding an unrelated file in a new patch. No deps.
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
+%% Changing a file already changed in the first patch adds a dependency.
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
index a3a8981..fac081e 100755
--- a/regression/t-033.sh
+++ b/regression/t-033.sh
@@ -3,6 +3,13 @@
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
@@ -11,3 +18,35 @@ cmd setup_repo
 # message when no patches are applied.  (An older version of guilt
 # used to enter an endless loop in this situation.)
 shouldfail guilt graph
+
+echo "%% Testing branch a,graph"
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
+echo "%% Adding an unrelated file in a new patch. No deps."
+cmd guilt new b.patch
+cmd echo b >> file2.txt
+cmd git add file2.txt
+cmd guilt refresh
+fixup_time_info b.patch
+cmd guilt graph
+
+echo "%% Changing a file already changed in the first patch adds a dependency."
+cmd guilt new c.patch
+cmd echo c >> file.txt
+cmd git add file.txt
+cmd guilt refresh
+fixup_time_info c.patch
+cmd guilt graph
-- 
1.8.3.1
