From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 07/28] Added test cases for "guilt fold".
Date: Fri, 21 Mar 2014 08:31:45 +0100
Message-ID: <1395387126-13681-8-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxM-0002BU-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759621AbaCUHd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:27 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:38155 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbaCUHdL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:11 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so1399066lbj.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=poixmeiGcUGBbzI/VHKnQp3ENFdaTXs3eNO+Pgj47hM=;
        b=EndN7LCWb8HUuz4q8Sk+Rvy5b+XfKXPEbfItHRovSjd1DecfNnLTf3+INGBW9BBZKc
         2bFYHacpHmxdLeFl63CEmKG9ZsGcfZxpDlpOrcKcdagI7EkbiEbcUka5BM46sbVXQn9a
         2efbRG+PpGI87/eXNNhcdnaR7yfqdX+L1XRzM+YxUiy2UUKWud0PJoOXsIbOIM5kQ82V
         1myu9cvHYOBrKbuenprtVnOgbI3G75lszchitHV3wePBQ+6u6XLGpQo/oNjz7qGOVX0I
         SOIogHBVeSXH8OHR52mv+EjmDv0V7qqJpeoztRtfFZk7IHe8C8mImcIB+GV0rZi+KI6T
         CONw==
X-Gm-Message-State: ALoCoQn7i5BaBV1sqZ8D+6YKcbzzbkpAelkuEzqEBMtch6fxLC6583UKpqdjQZbpOUjhKsFu1wcv
X-Received: by 10.152.18.229 with SMTP id z5mr33024799lad.27.1395387189493;
        Fri, 21 Mar 2014 00:33:09 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244647>

Test that we can combine any combination of patches with empty and
non-empty messages, both with and without guilt.diffstat.  (All
patches are empty.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-035.out | 659 +++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-035.sh  |  88 +++++++
 2 files changed, 747 insertions(+)
 create mode 100644 regression/t-035.out
 create mode 100755 regression/t-035.sh

diff --git a/regression/t-035.out b/regression/t-035.out
new file mode 100644
index 0000000..04af146
--- /dev/null
+++ b/regression/t-035.out
@@ -0,0 +1,659 @@
+% setup_repo
+% git config guilt.diffstat true
+%% empty + empty (diffstat=true)
+% guilt new empty-1
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty-1
+Patch applied.
+% guilt new empty-2
+% guilt pop
+Now at empty-1.
+% guilt push
+Applying patch..empty-2
+Patch applied.
+% guilt pop
+Now at empty-1.
+% guilt fold empty-2
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty-1
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 4ea806e306f0228a8ef41f186035e7b04097f1f2  .git/patches/master/status
+f 7d261b8caad0f161c21daf5de65eeb521ff8c067  .git/patches/master/empty-1
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d28d87b88c1e24d637e390dc3603cfa7c1715711  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+r bde3d337af70f36836ad606c800d194006f883b3  .git/refs/patches/master/empty-1
+% git log -p
+commit bde3d337af70f36836ad606c800d194006f883b3
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch empty-1
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f empty-1
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% empty + non-empty (diffstat=true)
+% guilt new empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty
+Patch applied.
+% guilt new -f -s -m A commit message. non-empty
+% guilt pop
+Now at empty.
+% guilt push
+Applying patch..non-empty
+Patch applied.
+% guilt pop
+Now at empty.
+% guilt fold non-empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 15aab0fd8b937eb3bb01841693f35dcb75da2faf  .git/patches/master/status
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/empty~
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 683678040eef9334d6329e00d5b9babda3e65b57  .git/patches/master/empty
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f a26a22287b500a2a372e42c2bab03599bbe37cdf  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/empty
+% git log -p
+commit 4eedaa32894fc07af3298d8c1178052942a3ca6a
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    A commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f empty
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/empty~
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% non-empty + empty (diffstat=true)
+% guilt new -f -s -m A commit message. non-empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty
+Patch applied.
+% guilt new empty
+% guilt pop
+Now at non-empty.
+% guilt fold empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 3be33467b8bcaa0b423634f9fb0d56e7963b512c  .git/patches/master/status
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5b7e155be4d6d4ae570eb6a0ec3422bbe4089665  .git/patches/master/series
+f 683678040eef9334d6329e00d5b9babda3e65b57  .git/patches/master/non-empty
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/non-empty
+% git log -p
+commit 4eedaa32894fc07af3298d8c1178052942a3ca6a
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    A commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f non-empty
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% non-empty + non-empty (diffstat=true)
+% guilt new -f -s -m A commit message. non-empty-1
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty-1
+Patch applied.
+% guilt new -f -s -m Another commit message. non-empty-2
+% guilt pop
+Now at non-empty-1.
+% guilt push
+Applying patch..non-empty-2
+Patch applied.
+% guilt pop
+Now at non-empty-1.
+% guilt fold non-empty-2
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty-1
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 0c6b7357ea1ccc9cbf872bc3abf53cf059c55152  .git/patches/master/series
+f 2267d12f90557b360ac5a5ce8b39e17b4a2b91c3  .git/patches/master/status
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 8884157b59a3a1d90c0192dba642c9db047bb39d  .git/patches/master/non-empty-1
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r 871e6754840a705017381948d77225c8de7b24dd  .git/refs/patches/master/non-empty-1
+% git log -p
+commit 871e6754840a705017381948d77225c8de7b24dd
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    A commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+    
+    
+    Header from folded patch 'non-empty-2':
+    
+    Another commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f non-empty-1
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% git config guilt.diffstat false
+%% empty + empty (diffstat=false)
+% guilt new empty-1
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty-1
+Patch applied.
+% guilt new empty-2
+% guilt pop
+Now at empty-1.
+% guilt push
+Applying patch..empty-2
+Patch applied.
+% guilt pop
+Now at empty-1.
+% guilt fold empty-2
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty-1
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 4ea806e306f0228a8ef41f186035e7b04097f1f2  .git/patches/master/status
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d28d87b88c1e24d637e390dc3603cfa7c1715711  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r bde3d337af70f36836ad606c800d194006f883b3  .git/refs/patches/master/empty-1
+% git log -p
+commit bde3d337af70f36836ad606c800d194006f883b3
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch empty-1
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f empty-1
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% empty + non-empty (diffstat=false)
+% guilt new empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty
+Patch applied.
+% guilt new -f -s -m A commit message. non-empty
+% guilt pop
+Now at empty.
+% guilt push
+Applying patch..non-empty
+Patch applied.
+% guilt pop
+Now at empty.
+% guilt fold non-empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 15aab0fd8b937eb3bb01841693f35dcb75da2faf  .git/patches/master/status
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/empty
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/empty~
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f a26a22287b500a2a372e42c2bab03599bbe37cdf  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/empty
+% git log -p
+commit 4eedaa32894fc07af3298d8c1178052942a3ca6a
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    A commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f empty
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/empty~
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% non-empty + empty (diffstat=false)
+% guilt new -f -s -m A commit message. non-empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty
+Patch applied.
+% guilt new empty
+% guilt pop
+Now at non-empty.
+% guilt fold empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 3be33467b8bcaa0b423634f9fb0d56e7963b512c  .git/patches/master/status
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5b7e155be4d6d4ae570eb6a0ec3422bbe4089665  .git/patches/master/series
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/non-empty
+% git log -p
+commit 4eedaa32894fc07af3298d8c1178052942a3ca6a
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    A commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f non-empty
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% non-empty + non-empty (diffstat=false)
+% guilt new -f -s -m A commit message. non-empty-1
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty-1
+Patch applied.
+% guilt new -f -s -m Another commit message. non-empty-2
+% guilt pop
+Now at non-empty-1.
+% guilt push
+Applying patch..non-empty-2
+Patch applied.
+% guilt pop
+Now at non-empty-1.
+% guilt fold non-empty-2
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..non-empty-1
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 0c6b7357ea1ccc9cbf872bc3abf53cf059c55152  .git/patches/master/series
+f 2267d12f90557b360ac5a5ce8b39e17b4a2b91c3  .git/patches/master/status
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r 871e6754840a705017381948d77225c8de7b24dd  .git/refs/patches/master/non-empty-1
+% git log -p
+commit 871e6754840a705017381948d77225c8de7b24dd
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    A commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+    
+    
+    Header from folded patch 'non-empty-2':
+    
+    Another commit message.
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt pop
+All patches popped.
+% guilt delete -f non-empty-1
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/non-empty~
+f 5f0c43c5c062b1d9615fcd41a84ed6c1bc040e69  .git/patches/master/non-empty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/non-empty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
diff --git a/regression/t-035.sh b/regression/t-035.sh
new file mode 100755
index 0000000..aed3ef2
--- /dev/null
+++ b/regression/t-035.sh
@@ -0,0 +1,88 @@
+#!/bin/bash
+#
+# Test the fold code
+#
+
+source "$REG_DIR/scaffold"
+
+cmd setup_repo
+
+function fixup_time_info
+{
+	cmd guilt pop
+	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
+	cmd guilt push
+}
+
+function test_fold
+{
+    using_diffstat=$1
+
+    cmd git config guilt.diffstat $using_diffstat
+
+    # Empty message + empty message = empty message.
+    echo "%% empty + empty (diffstat=$using_diffstat)"
+    cmd guilt new empty-1
+    fixup_time_info empty-1
+    cmd guilt new empty-2
+    fixup_time_info empty-2
+    cmd guilt pop
+    cmd guilt fold empty-2
+    fixup_time_info empty-1
+    cmd list_files
+    cmd git log -p
+    cmd guilt pop
+    cmd guilt delete -f empty-1
+    cmd list_files
+
+    # Empty message + non-empty message
+    echo "%% empty + non-empty (diffstat=$using_diffstat)"
+    cmd guilt new empty
+    fixup_time_info empty
+    cmd echo test > a
+    cmd guilt new -f -s -m "A commit message." non-empty
+    fixup_time_info non-empty
+    cmd guilt pop
+    cmd guilt fold non-empty
+    fixup_time_info empty
+    cmd list_files
+    cmd git log -p
+    cmd guilt pop
+    cmd guilt delete -f empty
+    cmd list_files
+
+    # Non-empty message + empty message
+    echo "%% non-empty + empty (diffstat=$using_diffstat)"
+    cmd echo test > a
+    cmd guilt new -f -s -m "A commit message." non-empty
+    fixup_time_info non-empty
+    cmd guilt new empty
+    cmd guilt pop
+    cmd guilt fold empty
+    fixup_time_info non-empty
+    cmd list_files
+    cmd git log -p
+    cmd guilt pop
+    cmd guilt delete -f non-empty
+    cmd list_files
+
+    # Non-empty message + non-empty message
+    echo "%% non-empty + non-empty (diffstat=$using_diffstat)"
+    cmd echo test > a
+    cmd guilt new -f -s -m "A commit message." non-empty-1
+    fixup_time_info non-empty-1
+    cmd echo test > b
+    cmd guilt new -f -s -m "Another commit message." non-empty-2
+    fixup_time_info non-empty-2
+    cmd guilt pop
+    cmd guilt fold non-empty-2
+    fixup_time_info non-empty-1
+    cmd list_files
+    cmd git log -p
+    cmd guilt pop
+    cmd guilt delete -f non-empty-1
+    cmd list_files
+}
+
+test_fold true
+test_fold false
-- 
1.8.3.1
