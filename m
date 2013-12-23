From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: test 'shared_path' in a moved clone
Date: Mon, 23 Dec 2013 21:23:43 +0100
Message-ID: <1387830223-19780-1-git-send-email-apelisse@gmail.com>
References: <xmqqzjnzktdr.fsf@gitster.dls.corp.google.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 23 21:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvC47-0003Q2-32
	for gcvg-git-2@plane.gmane.org; Mon, 23 Dec 2013 21:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624Ab3LWUY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Dec 2013 15:24:57 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57076 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab3LWUY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Dec 2013 15:24:56 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so5214384wgh.23
        for <git@vger.kernel.org>; Mon, 23 Dec 2013 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hlnQvswnWLfWSpGqUE1k+VWCVEWQCTdeRTKxH9PJcLI=;
        b=e61zgmqQGdjp+n2XUoUnkx1QVOcjSPc6BFtGOzAICyA6d6v2vIM9XKhy7gRsrAtjdJ
         WhWXjScIqynJ7N6dcLJtUBQsl6hNwE0QZqZjiNb075N62VtpMWj9pTRR0hZkquhnyxDq
         PMUSz3Nwuk46mh+o22Sf7d4fsoDf3f6cRRj7jE62RiR0foG/wEDYRHR1CXQIGUU9eyUj
         kuz1QcTWVKOswq1anq2j60QbbybuMgI2StS3SuXq9Ke1P2erdaB+s2JyWxhcRPQ6Qf9c
         D+Z9pb8jLoEJdyO/fBmRo1xhMj6JSZBcHZu6byrRJsixVtou8vdXHumtX5k30ZhSiiGS
         dFmg==
X-Received: by 10.180.14.10 with SMTP id l10mr19803210wic.6.1387830295098;
        Mon, 23 Dec 2013 12:24:55 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id cx3sm35492944wib.0.2013.12.23.12.24.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Dec 2013 12:24:53 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.97.g8d784da.dirty
In-Reply-To: <xmqqzjnzktdr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239655>

Since e71d1378 (remote-hg: fix 'shared path' path, 2013-12-07),
Mercurial 'shared_path' file is correctly updated whenever a clone is
moved. Make sure it keeps working, especially as this is depending on a
private Mercurial file.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 0b7df11..5d128a5 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -337,6 +337,17 @@ test_expect_success 'remote cloning' '
 	check gitrepo HEAD zero
 '
 
+test_expect_success 'moving remote clone' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	mv gitrepo gitrepo2 &&
+	cd gitrepo2 &&
+	git fetch
+	)
+'
+
 test_expect_success 'remote update bookmark' '
 	test_when_finished "rm -rf gitrepo*" &&
 
-- 
1.8.5.1.97.g8d784da.dirty
