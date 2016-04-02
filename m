From: santiago@nyu.edu
Subject: [PATCH v3 2/4] t/t7030-verify-tag.sh: Adds validation for multiple tags
Date: Sat,  2 Apr 2016 19:16:13 -0400
Message-ID: <1459638975-17705-3-git-send-email-santiago@nyu.edu>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:17:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amUmx-0004ZP-Is
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbcDBXQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:16:57 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36283 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcDBXQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 19:16:55 -0400
Received: by mail-qk0-f196.google.com with SMTP id e124so6146803qkc.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 16:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WGGPzEs1qeOo7cWvKtEWI6um4EBw3TbdiiEy4gccSDE=;
        b=D5RNOMjYjDISiIiCyaRQuJtRf0Vd+sgqBj0s5Zeaky1FNGAylpAn3DS3NWceTOuh0Z
         Gr4aRUQI16ph7bHhOVeCqZB2xveMi54JPXpX6xl5s47rfxa+V0XUp6Xxvnc1Td9YIv1k
         khxn8zhxvsNcRkIqinKgacHEBSmN6fCnEOavxHsuk/vUO6rpwHi7ttLz/2Qie+3x0C/x
         BIfdlRj5RCOEPGi7AOhvhyKOCO6fR5rl9o91V0FjJ95dILRkIx2mDkPbB8twCovS1jle
         t1BuqieTXLIDjlkvGdqxn63XUbaqcsLUFh6nW8xCyzEP4cI/zOb9sy36YI+npZvCg5ug
         K8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WGGPzEs1qeOo7cWvKtEWI6um4EBw3TbdiiEy4gccSDE=;
        b=dyQDzOLvYdSo+EOIciEf3SWSjHunWXMhJHiaffGkbDWKnpSkQ8Kvyy1P2p1QqnV/EL
         ONBmcVQ7UHB5BfD65PGlX2KljLPEn8wLQRAbblho58VY4+5Gwf3DY2xiKga1aOYMLqs1
         1n4dleOP5AMNg8iGCL/2L1rCJyl2/cCLIjR2qvsf4quL98BshNc5iTy2Tt7BCpmsN1N6
         jLQnWfQy9DKK7+ExTQEdpJTqnD5A9i1WO1XJN1HgzSZJGmyv14HMqMKLEse4lm3EskAF
         oQz5Cqp0emINx3HKfiYcu0cF/rxe6MpEfb8nqugQXby8THtFNT9DH/+UM2GCsmfM6Siz
         gFyg==
X-Gm-Message-State: AD7BkJIZ3KYMnr4kn0yhJyhQXjcCFym4cYYe+im9Tcb+xIeRKaTKECGHV2UT3HWAdCkql9IJ
X-Received: by 10.55.22.103 with SMTP id g100mr26075814qkh.0.1459639014234;
        Sat, 02 Apr 2016 16:16:54 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id l33sm9199788qge.11.2016.04.02.16.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 16:16:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290611>

From: Santiago Torres <santiago@nyu.edu>

The verify-tag command supports mutliple tag names as an argument.
However, no previous tests try to verify multiple tags at once. This
test runs the verify-tag command against three trusted tags (created
previously), and ensures that:

	1) Three tags are verified appropriately (grep GOODSIG) and
	2) The three tags verified are indeed differently (uniq
		-u)

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/t7030-verify-tag.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 4608e71..5918f86 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -112,4 +112,12 @@ test_expect_success GPG 'verify signatures with --raw' '
 	)
 '
 
+test_expect_success GPG 'verify multiple tags' '
+	git verify-tag -v --raw fourth-signed sixth-signed seventh-signed 2>actual 1> tagnames &&
+		grep -c "GOODSIG" actual > count &&
+		! grep "BADSIG" actual &&
+		grep -E "tag\ .*" tagnames | uniq -u | wc - l | grep "3"
+'
+
+
 test_done
-- 
2.8.0
