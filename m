From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Wed, 16 Mar 2016 18:07:45 +0800
Message-ID: <1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 11:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag8Nb-0007IT-GH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 11:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965929AbcCPKIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 06:08:34 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33317 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935041AbcCPKIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 06:08:30 -0400
Received: by mail-pf0-f181.google.com with SMTP id 124so69532444pfg.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=khJM+mg8g2VERfG66YZCblkeixO0biLZnDf8hml8guk=;
        b=qyP5llXGMw3jo9FqawzvQ6Vjh5xj/uZUCM/GujLsrdywP9v8WtfwfS099543H7P7li
         WaRktvcw7YSOZXeZg9jikCVnt5WfR0tanETsFU6g3trADycaXpA+HW6q5AP4Y/jBgIXq
         h/DkHSykUonptJnxvoXhziKKiWFwLdjBxtXNJcuZddAmV+r8gkFIc9d74bfQfVwxuw6O
         1RdWLGb36eqlFnuG8nvda7sbf6fqqL3PL0m/cR5BhnHdEfFcDeSNAi0IoZkJeZMJNBCy
         tuEKcwIAdwQM3u83MslxSVFsWdbrWEgYgTg0hAvjRsuS4TrGMmd80LTROjHn8AErM2jw
         NxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=khJM+mg8g2VERfG66YZCblkeixO0biLZnDf8hml8guk=;
        b=nFfsTLigSEd0/+pXVbR1nZVfEXfF0WXNVcX22iJowvxkzfU/VL5zZrfmLAM+eimCDD
         gk/6VWAIqGLYC0GhtVRf4W3zEa1QEjcNWeNyibuE8WXaxi4uI9nJOwFEjwjMtBnV2bQv
         eAWll1dc4ZkTuwdZIJ0KRUF9wjYI2f6oqTUeXBinKJg4DucX7z8VSkMhwS59lBzRt2ww
         WXVKKW/SxIDfXpnr6+aSfyNOxvoKIAvsJeordEWdZcGzHXnN5LaP/jhImEJ/5Vy2yogB
         XwoMK495PWYFB/5VikWdt7x6d/xaFXbOWs7RvYgyTK51LmLN79Hs3gphuPEBzks9G9ES
         vQRw==
X-Gm-Message-State: AD7BkJIkFsX3iPTq+18AzMqqbiatisfYHlk2OTKuIKSZ50CNuVRMVksHVIX7BLKb3CPCBw==
X-Received: by 10.98.65.215 with SMTP id g84mr4526796pfd.94.1458122909699;
        Wed, 16 Mar 2016 03:08:29 -0700 (PDT)
Received: from Saturn.localdomain ([128.199.68.97])
        by smtp.gmail.com with ESMTPSA id n68sm4275755pfj.46.2016.03.16.03.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 03:08:29 -0700 (PDT)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288954>

t0301 now tests git-credential-cache support for XDG user-specific
runtime file $XDG_RUNTIME_DIR/git/credential.sock. Specifically:

* if $XDG_RUNTIME_DIR exists, use socket at
  `$XDG_RUNTIME_DIR/git/credential-cache.sock`.

* otherwise, `/tmp/git-$uid/credential-cache.sock` is taken.

Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 t/t0301-credential-cache.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 82c8411..0718bb0 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -12,7 +12,32 @@ test -z "$NO_UNIX_SOCKETS" || {
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
+	test -S "$XDG_RUNTIME_DIR/git/credential-cache.sock"
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
 helper_test_timeout cache --timeout=1
 
 # we can't rely on our "trap" above working after test_done,
-- 
2.7.2
