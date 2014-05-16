From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 07/31] Added test cases for "guilt fold".
Date: Fri, 16 May 2014 16:45:54 +0200
Message-ID: <1400251578-17221-8-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJRW-000188-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbaEPOs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:48:59 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:37594 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756403AbaEPOs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:48:58 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so2022775lbd.14
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tSOwepvutkXtbx/oWAxoNL/R5vieo8MYC5U5ReETQa4=;
        b=VMWCwIbeG+1EFJsDtUPVnrMq1+72spngXpTvZJcSoLa3lzyPiTcbOQFhLH6l18P7i3
         Mf7CL483cw6G4ept4PGkAE9FthuyDDzyJFqHuPElFj5y5SzrTu6Wd/UNb55nipFatXu7
         Q9bf215yMig7CLs5dN4Tn9Aj4K4MobXsDNplumc9XK6SHQGcpzmhihxio0C1RkrV7D6Z
         +QXFsMdErY0qngJ/XtkZ9Qo95iEvL+n2GfDkOXFTbkHOHf7cr0+NuR4nNlhLOPqHMfB8
         qUIggxoDpiFNS9r58YUY6/G+qxGyjx7l1WyiYac/d3BRVproLDriK4Ah3VHQXS3O0X2F
         uhYA==
X-Gm-Message-State: ALoCoQn3v2bli6z/2wzwNe7zQIrejB6u3XYAkpIJyL6g3cEDbkxEdZIF769znHOvYF3pNyXNnhlE
X-Received: by 10.152.10.168 with SMTP id j8mr12327270lab.37.1400251736410;
        Fri, 16 May 2014 07:48:56 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.48.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:48:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249315>

Test that we can combine any combination of patches with empty and
non-empty messages, both with and without guilt.diffstat.  (All
patches are empty.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/t-035.out | 467 +++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-035.sh  |  61 +++++++
 2 files changed, 528 insertions(+)
 create mode 100644 regression/t-035.out
 create mode 100755 regression/t-035.sh

diff --git a/regression/t-035.out b/regression/t-035.out
new file mode 100644
index 0000000..cc16fb4
--- /dev/null
+++ b/regression/t-035.out
@@ -0,0 +1,467 @@
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
+%% empty + nonempty (diffstat=true)
+% guilt new empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty
+Patch applied.
+% guilt new -f -s -m A commit message. nonempty
+% guilt pop
+Now at empty.
+% guilt push
+Applying patch..nonempty
+Patch applied.
+% guilt pop
+Now at empty.
+% guilt fold nonempty
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
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 683678040eef9334d6329e00d5b9babda3e65b57  .git/patches/master/empty
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f a26a22287b500a2a372e42c2bab03599bbe37cdf  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/empty
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
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% nonempty + empty (diffstat=true)
+% guilt new -f -s -m A commit message. nonempty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty
+Patch applied.
+% guilt new empty
+% guilt pop
+Now at nonempty.
+% guilt push
+Applying patch..empty
+Patch applied.
+% guilt pop
+Now at nonempty.
+% guilt fold empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 683678040eef9334d6329e00d5b9babda3e65b57  .git/patches/master/nonempty
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f c47ddc01337e3bb67a9968a8823a5ba12be67f77  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f f7f068d44bf796d0f7cd14d27d1f48d6e659816a  .git/patches/master/status
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/nonempty
+% guilt pop
+All patches popped.
+% guilt delete -f nonempty
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% nonempty + nonempty (diffstat=true)
+% guilt new -f -s -m A commit message. nonempty-1
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty-1
+Patch applied.
+% guilt new -f -s -m Another commit message. nonempty-2
+% guilt pop
+Now at nonempty-1.
+% guilt push
+Applying patch..nonempty-2
+Patch applied.
+% guilt pop
+Now at nonempty-1.
+% guilt fold nonempty-2
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty-1
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 3b526c794741fb2d6b463f3245ab2f260fa74b7b  .git/patches/master/status
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 669c9685ce791098bb3573f80af6d720a3689f80  .git/patches/master/nonempty-1
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f a88f2625f128cfa307a52c8c2e84ed6c32a78d2b  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r 895dfbc21bde85fcc666a353a6bd32eaec939082  .git/refs/patches/master/nonempty-1
+% guilt pop
+All patches popped.
+% guilt delete -f nonempty-1
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
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
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d28d87b88c1e24d637e390dc3603cfa7c1715711  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r bde3d337af70f36836ad606c800d194006f883b3  .git/refs/patches/master/empty-1
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
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% empty + nonempty (diffstat=false)
+% guilt new empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty
+Patch applied.
+% guilt new -f -s -m A commit message. nonempty
+% guilt pop
+Now at empty.
+% guilt push
+Applying patch..nonempty
+Patch applied.
+% guilt pop
+Now at empty.
+% guilt fold nonempty
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
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f a26a22287b500a2a372e42c2bab03599bbe37cdf  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/empty
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
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% nonempty + empty (diffstat=false)
+% guilt new -f -s -m A commit message. nonempty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty
+Patch applied.
+% guilt new empty
+% guilt pop
+Now at nonempty.
+% guilt push
+Applying patch..empty
+Patch applied.
+% guilt pop
+Now at nonempty.
+% guilt fold empty
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f c47ddc01337e3bb67a9968a8823a5ba12be67f77  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f f7f068d44bf796d0f7cd14d27d1f48d6e659816a  .git/patches/master/status
+r 4eedaa32894fc07af3298d8c1178052942a3ca6a  .git/refs/patches/master/nonempty
+% guilt pop
+All patches popped.
+% guilt delete -f nonempty
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+%% nonempty + nonempty (diffstat=false)
+% guilt new -f -s -m A commit message. nonempty-1
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty-1
+Patch applied.
+% guilt new -f -s -m Another commit message. nonempty-2
+% guilt pop
+Now at nonempty-1.
+% guilt push
+Applying patch..nonempty-2
+Patch applied.
+% guilt pop
+Now at nonempty-1.
+% guilt fold nonempty-2
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..nonempty-1
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 3b526c794741fb2d6b463f3245ab2f260fa74b7b  .git/patches/master/status
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f a88f2625f128cfa307a52c8c2e84ed6c32a78d2b  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+r 895dfbc21bde85fcc666a353a6bd32eaec939082  .git/refs/patches/master/nonempty-1
+% guilt pop
+All patches popped.
+% guilt delete -f nonempty-1
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 51fcfcf16db2903f19ab4a4a3caacd297ea9f6cd  .git/patches/master/nonempty~
+f 75c672c7dbec8e8275d26d720f499899d04912a4  .git/patches/master/nonempty-1~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bbdc17918ad7ba268ea90ebf0fb71e32e0f09a02  .git/patches/master/nonempty-2~
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-1~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty-2~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty~
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
diff --git a/regression/t-035.sh b/regression/t-035.sh
new file mode 100755
index 0000000..c347e47
--- /dev/null
+++ b/regression/t-035.sh
@@ -0,0 +1,61 @@
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
+function empty_patch
+{
+	cmd guilt new "empty$1"
+	fixup_time_info "empty$1"
+}
+
+function nonempty_patch
+{
+	if [ "$1" = -2 ]; then
+		msg="Another commit message."
+	else
+		msg="A commit message."
+	fi
+
+	cmd guilt new -f -s -m "$msg" "nonempty$1"
+	fixup_time_info "nonempty$1"
+}
+
+for using_diffstat in true false; do
+	cmd git config guilt.diffstat $using_diffstat
+	for patcha in empty nonempty; do
+		for patchb in empty nonempty; do
+
+			if [ $patcha = $patchb ]; then
+				suffixa=-1
+				suffixb=-2
+			else
+				suffixa=
+				suffixb=
+			fi
+
+			echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
+			${patcha}_patch $suffixa
+			${patchb}_patch $suffixb
+			cmd guilt pop
+			cmd guilt fold $patchb$suffixb
+			fixup_time_info $patcha$suffixa
+			cmd list_files
+			cmd guilt pop
+			cmd guilt delete -f $patcha$suffixa
+			cmd list_files
+
+		done
+	done
+done
-- 
1.8.3.1
