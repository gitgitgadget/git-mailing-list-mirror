From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 20/31] "guilt graph": Handle patch names containing quotes.
Date: Fri, 16 May 2014 16:46:07 +0200
Message-ID: <1400251578-17221-21-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:55:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJXQ-00085F-VZ
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbaEPOzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:55:01 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:61122 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbaEPOy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:54:59 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so2043345lbi.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m6GkOWoT1B8J26s4S5ylKc07a/FE3dEX6fCiWQVRmv4=;
        b=jxN4fwCw1SdJIQl8y9V/zMYyIHLIR7u1LFOerrllDJO8zt6UHGuIYgZnfM6IG7pj3M
         mXO1CLuLLt5fgbiD5r7qBGFuqBL30yfSEiBKN38L8zapbkduax/AIsNV+fuv748zrunf
         Pfr7zxLSHOFEHA7cIr5XNjDNqmAI6v7UOy8+13YsfqoWkiTZnBVlCs10XH0VTISrh4ie
         Zemx4D970Hnz9PhE2XhepM179mkC4ZtKRBfW38mBXQdANV2fFHe08PkfGgjQvlkGzJgq
         X4al6Br9FuHPkKOECdI4QwuFYCIfMuSP84hX4tpxv6paOzKw1RA1R/sUoMywmOGXUAwz
         zSdw==
X-Gm-Message-State: ALoCoQn0nvU2YvEJzfZa5YwRaxNL5REEkHw6AEv2bVppbwCrMqBVgka4CDfB6UA2r3WZeZUhjnIe
X-Received: by 10.112.150.103 with SMTP id uh7mr11615969lbb.30.1400252098352;
        Fri, 16 May 2014 07:54:58 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.54.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:54:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249328>

Quote quotes with a backslash in the "guilt graph" output.  Otherwise,
the "dot" file could contain syntax errors.

Added a test case.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-graph          |  2 ++
 regression/t-033.out | 22 ++++++++++++++++++++++
 regression/t-033.sh  |  9 +++++++++
 3 files changed, 33 insertions(+)

diff --git a/guilt-graph b/guilt-graph
index 924a63e..0857e0d 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -57,6 +57,8 @@ while [ "$current" != "$base" ]; do
 }"`
 	[ -z "$pname" ] && pname="?"
 
+	pname="`printf \"%s\" \"$pname\" | sed 's/\"/\\\\\"/g'`"
+
 	disp "# checking rev $current"
 	disp "	\"$current\" [label=\"$pname\"]"
 
diff --git a/regression/t-033.out b/regression/t-033.out
index 3d1c61f..c120d4f 100644
--- a/regression/t-033.out
+++ b/regression/t-033.out
@@ -66,3 +66,25 @@ digraph G {
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
index fac081e..9fe1827 100755
--- a/regression/t-033.sh
+++ b/regression/t-033.sh
@@ -50,3 +50,12 @@ cmd git add file.txt
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
