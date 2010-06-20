From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] t2018-checkout-branch.sh: show that checkout -f -b doesn't DWIM
Date: Mon, 21 Jun 2010 00:33:11 +0800
Message-ID: <1277051592-4552-3-git-send-email-rctay89@gmail.com>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 20 18:33:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQNSy-0006zp-2X
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab0FTQdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 12:33:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38256 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab0FTQdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 12:33:32 -0400
Received: by pwj8 with SMTP id 8so11517pwj.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qLF/RofqoJ78Z2AKF9xyTiX5qIva7mgkbZBTL7jSEGI=;
        b=GTK6pPDsqqd5QKDsvQv4HeE4uS3l0rFNyJ67d+e7W0jIe4KoyWbqloo669xGSNGEG6
         ZiF72ckInN0ujl1cbNmjn7c164CRTGrkKt5Zd9V1iq8EIXFzS/K+Ca1vqWiF5rbAPkjT
         DYxVJom+af/TaPgCGXQ0nSRerYHh0+NYH6N0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eRzs5uew9xFZctM6qEhtyZSTmvkVRehtxz0AN81CuzqCSToFi0V7zCE/dChySeTnqH
         quuUbj8aXgM7D3svSCJbG8RK8R75dMBpNQ5cBh+vPQjMHhW5/8ODDfdLYZ1zSQkO13FQ
         OZKnpQNprarjocDAYKnI2vhMySotkgSV0hj0A=
Received: by 10.142.247.7 with SMTP id u7mr2600548wfh.95.1277051610855;
        Sun, 20 Jun 2010 09:33:30 -0700 (PDT)
Received: from localhost.localdomain (cm123.zeta152.maxonline.com.sg [116.87.152.123])
        by mx.google.com with ESMTPS id n29sm9634993wae.16.2010.06.20.09.33.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 09:33:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277051592-4552-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149399>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t2018-checkout-branch.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 678a34f..e6c0f8c 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -63,4 +63,24 @@ test_expect_success 'checkout -b to an existing branch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
+test_expect_failure 'checkout -f -b to an existing branch resets branch' '
+	git checkout branch1 &&
+
+	do_checkout branch2 "" -f
+'
+
+test_expect_failure 'checkout -f -b to an existing branch resets branch (explicit ref)' '
+	git checkout branch1 &&
+
+	do_checkout branch2 $HEAD1 -f
+'
+
+test_expect_failure 'checkout -f -b to an existing branch resets branch (dirty) ' '
+	git checkout branch1 &&
+
+	setup_dirty &&
+	do_checkout branch2 $HEAD1 -f &&
+	test_must_fail test_dirty
+'
+
 test_done
-- 
1.7.1.513.g4f18
