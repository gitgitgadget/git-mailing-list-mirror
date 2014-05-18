From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 32/33] Improved doc and tests for guilt header.
Date: Mon, 19 May 2014 00:00:08 +0200
Message-ID: <1400450409-30998-33-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:14:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9M4-0005Eo-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbaERWOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:14:49 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:59473 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbaERWOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:14:48 -0400
Received: by mail-la0-f46.google.com with SMTP id ec20so3470587lab.19
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nAKrZZtgv7h84siYTKTiuHr4HsFLQ3dy30YdhQQBFvg=;
        b=TVVDag5vOt9LAkI1pJY+vxXicN+JrOr/jd7QajjbSIPhMdxd3LmdLZXjksFsugtt5l
         j0wAYgtmGAUh+upNLByhWFO3GjKapiKt3ibZpEYF5OnziKpJZmsZ+gmkuC1xRNEFovu4
         /gf/gFkhFY2RKZwgdnQnkSpQMrvAmOCPyCyes0jAGJ0VHPfr69L1xxpa5kNGfpGfuAjD
         fDML/CnFkrgFhNhR+S5wndcgwwKVOhmWRgGZk08BxntkRS61S0JNXZlQ9eGcqPFHxI5r
         DF5942+h7kmp0zy5zSTG0VAV1+w4rSB25CgJdJPfi1j5hnRITvy3Xt2qNqljrXRkWy2R
         Ci0Q==
X-Gm-Message-State: ALoCoQnOe3uZJFjNpfFNQkJuASkLcKosDmauxqdBoSykO6xV/OxPvhJqds99GI6vGJujPrBv3eZC
X-Received: by 10.152.207.74 with SMTP id lu10mr23449473lac.28.1400451287230;
        Sun, 18 May 2014 15:14:47 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.14.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:14:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249547>

---
 Documentation/guilt-header.txt | 5 ++++-
 regression/t-028.out           | 9 +++++++++
 regression/t-028.sh            | 3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/guilt-header.txt b/Documentation/guilt-header.txt
index 870bfaf..71b2e66 100644
--- a/Documentation/guilt-header.txt
+++ b/Documentation/guilt-header.txt
@@ -18,7 +18,10 @@ Prints either the topmost patch's header or the header of a specified patch.
 -E::
 	Open the raw patch in an editor, instead of printing it.
 <patchname>::
-	Name of the patch.
+	Name of the patch. If a patch with exactly this name exists,
+	use it. Otherwise, treat the name as a regexp; if the regexp
+	matches a single patch, use it. Otherwise, list all matching
+	patch names to stderr and fail.
 
 Author
 ------
diff --git a/regression/t-028.out b/regression/t-028.out
index ea72a3a..39ac900 100644
--- a/regression/t-028.out
+++ b/regression/t-028.out
@@ -56,3 +56,12 @@ Patch non-existant is not in the series
   remove
   mode
   patch-with-some-desc
+% guilt header de
+de does not uniquely identify a patch. Did you mean any of these?
+  mode
+  patch-with-some-desc
+% guilt header des
+blah blah blah
+
+Signed-off-by: Commiter Name <commiter@email>
+
diff --git a/regression/t-028.sh b/regression/t-028.sh
index 2ce0378..cd3088c 100755
--- a/regression/t-028.sh
+++ b/regression/t-028.sh
@@ -35,4 +35,7 @@ shouldfail guilt header non-existant
 # patch name is a regexp that just happens to match an existing patch.
 shouldfail guilt header '.*'
 
+shouldfail guilt header de
+cmd guilt header des
+
 # FIXME: how do we check that -e works?
-- 
1.8.3.1
