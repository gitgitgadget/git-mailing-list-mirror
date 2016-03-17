From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v2/GSoC 4/4] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 00:48:46 +0800
Message-ID: <1458233326-7735-4-git-send-email-huiyiqun@gmail.com>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 17:49:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agb7D-00081F-NQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbcCQQtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:49:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34467 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965348AbcCQQte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:49:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id n5so11810614pfn.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0QnISeg6zYPvcgIZ3b1M2L8H9EAigANXkFxQwAtVhSU=;
        b=UOqpucVuVftugjDjvy+bPPG6RRNuhTYytqd2jPHo1t0H+lAXV3dzL0OEc1qUIY4HFH
         jJ2gGEblCb9qfkfwIjckfJASWgvlmfyfiKrydBm7bntuJcbXQPm01F3tXMz+SvU+DpMM
         IDNt+9CHQr/qTcRvG90boSaLxnqe6RIg2WLpOUF9Mtbgw756qFJ/fdZQIE7jcqnEHbYL
         tShrPUAxTSAUA/Kv+pWOVsJUug2NZVq8vwSF8wXRYPs/45drr8tdHjmXyNW2VyeVZrqS
         tvtVfiGt4UwTh2jW8qDfInAnRG0MWkpgvgymurdSIsPUOIAljLdC/0NM66QtPkjp1wjZ
         N1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0QnISeg6zYPvcgIZ3b1M2L8H9EAigANXkFxQwAtVhSU=;
        b=eLUqOPDUVoBCSIaFj9RKt6TqR1YeLtMwwPWN3k46CdC29cahqBPCdT1pEgGPUcnUTT
         femYiZmT2e2WSgFU9RcAexjwYsVM+oatCJ/YwXljw6ukR3hm+M8UrvxDEej0EwtFoQ8W
         4Y9okttaXXxWHx1ZHHdu8tFKutNE8w1h1Be6pOCRuKSgp6GYjm2eHwMwyhhjJ0JFiXQi
         JommbIJRFUnGv0m2RTz8MsYv0j8PpU1D1488Hjf7pvWmGQxNkoFwNY9ot19o4k1rIHbL
         JBi7DLjZMA9vcOfKscxtTHBV4AMEwdJOvOOlsY7rTBHcXOt+gvhpbNCD3ALviq9PwPWo
         OEMA==
X-Gm-Message-State: AD7BkJLrC/uz7+Qfk5e3fb2Kk+0xFSWeR/7DTP/Ln1Bf62Rp7FADmnLA+IZaXo1GeA+7Yg==
X-Received: by 10.66.226.135 with SMTP id rs7mr16677463pac.116.1458233374074;
        Thu, 17 Mar 2016 09:49:34 -0700 (PDT)
Received: from localhost.localdomain (hashi.inv.dotkrnl.com. [133.130.122.94])
        by smtp.gmail.com with ESMTPSA id kw10sm14643290pab.0.2016.03.17.09.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 09:49:33 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289126>

t0301 now tests git-credential-cache support for XDG user-specific
runtime file $XDG_RUNTIME_DIR/git/credential.sock. Specifically:

* if $XDG_RUNTIME_DIR exists, use socket at
  `$XDG_RUNTIME_DIR/git/credential-cache.sock`.

* otherwise, `/tmp/git-$uid/credential-cache.sock` is taken.

Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 t/t0301-credential-cache.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 82c8411..892d1ba 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -12,7 +12,34 @@ test -z "$NO_UNIX_SOCKETS" || {
 # don't leave a stale daemon running
 trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
 
+test_expect_success 'set $XDG_RUNTIME_DIR' '
+	XDG_RUNTIME_DIR=$HOME/xdg_runtime/
+'
+
+helper_test cache
+
+test_expect_success 'when $XDG_RUNTIME_DIR is set, `$XDG_RUNTIME_DIR/git` are used' '
+	test_path_is_missing "/tmp/git-$(id -u)/git/credential-cache.sock" &&
+	test -S "$HOME/xdg_runtime/git/credential-cache.sock"
+'
+
+test_expect_success 'force git-credential-cache to exit so that socket disappear' '
+	git credential-cache exit &&
+	test_path_is_missing "$XDG_RUNTIME_DIR/git/credential-cache.sock" &&
+	unset XDG_RUNTIME_DIR
+'
+
 helper_test cache
+
+test_expect_success 'when $XDG_RUNTIME_DIR is not set, `/tmp/git-$(id -u) is used' '
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
2.7.3
