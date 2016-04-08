From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 09/18] Add testcase for --index-only merges with the ours strategy
Date: Thu,  7 Apr 2016 23:58:37 -0700
Message-ID: <1460098726-5958-10-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQO8-0002VL-PS
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbcDHG7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:16 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33978 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788AbcDHG7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:08 -0400
Received: by mail-pa0-f68.google.com with SMTP id hb4so8474617pac.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYsdfPgKRH3vrdMkQI/9GaAWpd46c3zHBO1MA0pN1FM=;
        b=pvqfo0ukd0yF1dTaXQOzcdXxmQMjGoEyb+fJsATtngn4LCmZ0KgoO+LW2Z6xuP4BiL
         WUM5K+cTIitbsWvpRSIeoHa6sBeaMKN2sHEHSbc1vEftyYI6it+T5m57x7DzSpHzhMBI
         IigtlrDIMKuuHSlrVg5AhQsNCzP+18K0/PMnc8ok87xEbBqOpWWFd2pmJK5wz3tswU2n
         LGh0GdoWvH/fCWG0QMeQ/r8d/EeK532D2K213LF3/koUjTiDiShbm8KhbH+LNU2Huqsc
         1WlHRXI96r16TWtRATG37I4mZnUR8Ff7nb0hpY4XaHBxrUCH2uvPAgCWyDedeSPSTqLC
         q9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYsdfPgKRH3vrdMkQI/9GaAWpd46c3zHBO1MA0pN1FM=;
        b=TTOgViNw8GkjKJFvn0VDrE0XjBMXAhGl9CJxWQIVarFqjcl/alAZF76eJQ4TDJXdgH
         dZFMHPWnCkiUaCeGkTrUngdTDPiv9twAGQQviu2FEKM6N34xcOBr3O6XnA1yt6IfE+OC
         aA0HIg79rYIYwn5DPMwWt06piQsZAR+V6xRweyvSJmaRUR6P6CyvrqhIeB1+SBsN13sU
         GwOh9oskc0IcKD8IiijQt5GtcsWqLxKF+ukWZ4pBstSCDq9Ed7cbPyFJlLQLy5JY17rM
         IV+CRlnZR0VonPMolhzqkYyDfhNf9O4fk/AsAt5cTEePgRnxie+h/wjp7NxvdsoT/46J
         n0Rw==
X-Gm-Message-State: AD7BkJL0qQUDKTSyHKK6zu6KbIaKEs8dr+I7WlZo55X5wwVtlqgq06yAF7ay35WIoGH7Yg==
X-Received: by 10.66.251.10 with SMTP id zg10mr10488649pac.1.1460098747672;
        Thu, 07 Apr 2016 23:59:07 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:07 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291006>

This is almost trivial to make work, because we already know that the
working tree will need no modifications, but lets test it for completeness
anyway.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-index-only.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index b01bf79..84c6640 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -374,4 +374,36 @@ test_expect_failure '--index-only octopus, bare' '
 	)
 '
 
+test_expect_failure '--index-only ours, non-bare' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git merge --index-only -s ours C^0 &&
+
+	test "$(git rev-list --count HEAD)" -eq 4 &&
+	test $(git rev-parse :a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	test_must_fail git rev-parse :c &&
+	test ! -f c
+'
+
+test_expect_failure '--index-only ours, bare' '
+	rm -rf bare.clone &&
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD B &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only -s ours C^0 &&
+
+	 test "$(git rev-list --count HEAD)" -eq 4 &&
+	 test $(git rev-parse :a) = $(git rev-parse B:a) &&
+	 test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	 test_must_fail git rev-parse :c &&
+	 test ! -f a &&
+	 test ! -f c
+	)
+'
+
 test_done
-- 
2.8.0.18.gc685494
