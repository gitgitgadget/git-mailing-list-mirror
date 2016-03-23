From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v3/GSoC 5/5] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Wed, 23 Mar 2016 18:13:25 +0800
Message-ID: <1458728005-22555-5-git-send-email-huiyiqun@gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Cc: peff@peff.net, pickfire@riseup.net, Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifnW-000210-LE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbcCWKNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:13:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34288 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbcCWKNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:13:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id n5so2391109pfn.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OhrLu2otmCiAG47P4BTviWF+mon6v2sWA136UjD/6Y=;
        b=xfLzz1DyfoS8JDsAV0KmGDcO8LVUXs46EOpC7X0rxZZxphsoyt+KLnq2A7JPPn0+uo
         nCyDvppH77XOIvIjOBVIzIRUo0Da1k/IIhwBSCkDDuRNPl8qp/OxG4kI2nkJ7iaN4Kla
         MC0P9PYvdXmBH1FbEAbV1KSzJ69rf3JRW6FyYMC3XUBhZZKgn0qB1La2tVMbCup1S+W5
         Lr6y9M/eupXMmEg/4//ohCmROWufYHhgE9pqTLDpMgia834Hwa3Nd9p+3eZGBbzKzyTE
         WD5cLRAVj91xyqnn5l0lTTZ3LJ6Lm0Yhi+Kyif6bnFo+2Zrk63uSZ5vCbgz9yDw/MU77
         +qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OhrLu2otmCiAG47P4BTviWF+mon6v2sWA136UjD/6Y=;
        b=XObehouCZ2lMWjhuKrctcvIH3ZS3HyXTbb0bMPgBlSGq8YakoOhazflZfFKSnvA6VC
         3nT1qL0cPtNYoVb29hhiqRce6HvgQ6P2HhGg5mX6iXzfuW6wHrftBW5XN8mo7EN68cAS
         vyLBfA4w5sOffYIoL/OrREwcVOMnYtjJ0CEA5iVgMm2o/LkNyoESNqblrAPrg0EOhQGs
         KASLGN1JEyGziJktSyEbWZ9zCPJLWBbKHQlZcrqCDVsQEKlZBcS/kwkeq7IAoPD2PMIP
         HzbBs332ARirHFuQcugAJyaKT5rgxqmdqQxjxMHbe4GIkcsp8theqh8lXNCj7Mb3a1m9
         Afww==
X-Gm-Message-State: AD7BkJIuolRHytiJnTxUQ+iDvYd+p4L/KNOgBkFOFBlzlNC5/OdxB6xmC6GWU1i+Wein/A==
X-Received: by 10.98.14.147 with SMTP id 19mr2826335pfo.79.1458728021087;
        Wed, 23 Mar 2016 03:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:ae9e:17ff:fe87:5adb])
        by smtp.gmail.com with ESMTPSA id x18sm3232325pfi.42.2016.03.23.03.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:13:40 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289634>

t0301 now tests git-credential-cache support for XDG user-specific
runtime path. Specifically:

* if $XDG_RUNTIME_DIR exists, use socket at
  `$XDG_RUNTIME_DIR/git/credential-cache.sock`.

* otherwise, `/tmp/git-$uid/credential-cache.sock` is taken.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 t/t0301-credential-cache.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 82c8411..264c394 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -12,7 +12,36 @@ test -z "$NO_UNIX_SOCKETS" || {
 # don't leave a stale daemon running
 trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
 
+test_expect_success 'set $XDG_RUNTIME_DIR' '
+	XDG_RUNTIME_DIR=$HOME/xdg_runtime/ &&
+	export XDG_RUNTIME_DIR
+'
+
+helper_test cache
+
+test_expect_success 'when $XDG_RUNTIME_DIR is set, `$XDG_RUNTIME_DIR/git` are used' '
+	test_path_is_missing "/tmp/git-$(id -u)/credential-cache.sock" &&
+	test -S "$HOME/xdg_runtime/git/credential-cache.sock"
+'
+
+test_expect_success 'force git-credential-cache to exit so that socket disappear' '
+	git credential-cache exit &&
+	test_path_is_missing "$HOME/xdg_runtime/git/credential-cache.sock" &&
+	unset XDG_RUNTIME_DIR
+'
+
 helper_test cache
+
+test_expect_success 'when $XDG_RUNTIME_DIR is not set, `/tmp/git-$(id -u) is used' '
+	test_path_is_missing "$HOME/xdg_runtime/git/credential-cache.sock" &&
+	test -S "/tmp/git-$(id -u)/credential-cache.sock"
+'
+
+# TODO: if $XDG_RUNTIME_DIR/git/ exists, but has wrong permission and ownership,
+# `helper_test cache` must fail.
+
+# TODO: check whether `--socket` works
+
 helper_test_timeout cache --timeout=1
 
 # we can't rely on our "trap" above working after test_done,
-- 
2.7.4
