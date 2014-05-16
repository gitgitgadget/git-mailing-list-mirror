From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 19/31] Check that "guilt graph" works when working on a branch with a comma.
Date: Fri, 16 May 2014 16:46:06 +0200
Message-ID: <1400251578-17221-20-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJXR-00085F-JL
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbaEPOyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:54:53 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:50659 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbaEPOyw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:54:52 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so2028834lbg.18
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMnEognkABKJw4aGgoKA/0EYoyjV3hfcINmmHnJDH8w=;
        b=hP4qkNbfjosaeinBBNkS1HSIoZXWAP26nw0ghs+tuvCqWfjwb+e0C0e2Mm1EK/odSz
         /f1EZ1tlW+24PRMAH/k00xj7NZ2Fk1clzq1gNPmwSUB2jyipzCy2YoUlnIN6pr0XfR3K
         y3fe+oRHou8BOeCbGwQqn4HXyu7W94COV2sHJ6Q4PdnVWltV43jaliiEEfdEo+M+0YRc
         49Dk8xAgKkoZxW2X76Izv0s247AKWGDQJQtE7KIknv6Ifs/g1Gh38dWQD6CJeu1nkukk
         D0LH5CT5TZlA3ngYCqjeHkn4/1gol1w8d/KLPFpckvy8nF/bngkuoFbwCOjtRwq+Ac+5
         a+8w==
X-Gm-Message-State: ALoCoQl0pOwdfjUT1RXbsey4KPiXDqZd9aD7cQZ0fUDPrQL+/YZmf/I1M0WijhsuwzE1YPyJxamk
X-Received: by 10.112.164.148 with SMTP id yq20mr11922096lbb.22.1400252090930;
        Fri, 16 May 2014 07:54:50 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.54.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:54:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249329>

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
