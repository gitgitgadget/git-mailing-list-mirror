From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t3200: fix failure on case-insensitive filesystems
Date: Sat, 14 Sep 2013 03:36:24 -0400
Message-ID: <1379144184-17568-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 09:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKkPb-0008EE-F8
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 09:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab3INHgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 03:36:54 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:52367 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab3INHgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 03:36:54 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so1905919obc.38
        for <git@vger.kernel.org>; Sat, 14 Sep 2013 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=UsbDuplX5MxHPIuMj/WVQrSadXKGYUbf7wQ3AIyyd7w=;
        b=KF/cqJrEdVkwmEqBGilni4UlQqv9zjPnm0TLYZyCSIwphbvT6g8lKdOipc9zwynVYf
         sSUzw5DLkWxqzgjdrgkWCAqp+bt347I5Yrwkk7XRSH4P1UI/C/+CR6Gz9RP/oH2J0uM8
         jFMyoLAvoxBHp5xthXRZkEpFdl30m7fLfkTb7HrFFIbIjvX+VMUgEjyY6WqDAKiqAiLj
         LrQlWPj1o/hQX1dBqliWX4jF0eADI5H2A2lpcX2CUaJE+JcMAdzLmLKOjUF9wuz2eaUy
         hpyIX9MalA1mF4Sw7eSp8vYhADyA3iHbBHvL1Gghhub2yrWM6huwGEdP4wmGlWGurOeV
         wzJQ==
X-Received: by 10.182.106.4 with SMTP id gq4mr16182728obb.4.1379144213615;
        Sat, 14 Sep 2013 00:36:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id d3sm21331213oek.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 14 Sep 2013 00:36:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234803>

62d94a3a (t3200: Add test demonstrating minor regression in 41c21f2;
2013-09-08) introduced a test which creates a directory named 'a',
however, on case-insensitive filesystems, this action fails with a
"fatal: cannot mkdir a: File exists" error due to a file named 'A' left
over from earlier tests. Resolve this problem.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This applies against 'next'.

There are many ways to resolve this failure.  I chose one in which the
test arranges a clean slate for itself before performing the important
operations.

 t/t3200-branch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 84fcbf4..0fe7647 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -873,6 +873,7 @@ test_expect_success '--merged catches invalid object names' '
 '
 
 test_expect_success 'tracking with unexpected .fetch refspec' '
+	rm -rf a b c d &&
 	git init a &&
 	(
 		cd a &&
-- 
1.8.4.535.g7b94f8e
