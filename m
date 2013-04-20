From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 5/8] t7201.24: Add refspec to keep --track working
Date: Sat, 20 Apr 2013 17:06:00 +0200
Message-ID: <1366470363-22309-6-git-send-email-johan@herland.net>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZNC-0000BZ-HW
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab3DTPGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:36 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:48830 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3DTPGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:36 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so4534694lbi.34
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2YcRQdJlDAfpms4Pj4gqHOzIK3BGrEtNKk+8IEfwfR4=;
        b=Wm8wW1Vl7uu4qEqMXy1yTt1hiOVIeYjFWywPm/0qEVjethj2rzgQ/jw6fU67cngjAp
         bo1jxa/i33ruHQh47gFUvyzx7PPSzz3ZYRv76i35HNgz+K8hBPYQ4OQpO0XQyYEIV32w
         nYpZgTUcXY8D9K9ZCYYfNU2uCSRbZYEjNgSaNdYBntBSBS7CUDXeKEfjZQEkmzFPgiUZ
         BlK3Zv62fhakh2bj5NAjtrMHwY6BhpnLHdnf3kt0u1kNFYSPSJAuoPKexSsMjoHngIKR
         Orfah6W1WZm/4Qe8EZYM/BfW5Tuu9baBQyOmmDQI8BSfJ8TFihZRllTgt0ydkP31lAz1
         I6iA==
X-Received: by 10.152.20.42 with SMTP id k10mr4000619lae.55.1366470394556;
        Sat, 20 Apr 2013 08:06:34 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.32
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366470363-22309-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221865>

We are formalizing a requirement that any remote-tracking branch to be used
as an upstream (i.e. as an argument to --track), _must_ "belong" to a
configured remote by being matched by the "dst" side of a fetch refspec.

Without this patch, this test would start failing when the new behavior is
introduced.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7201-co.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index be9672e..0c9ec0a 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -431,6 +431,7 @@ test_expect_success 'detach a symbolic link HEAD' '
 
 test_expect_success \
     'checkout with --track fakes a sensible -b <name>' '
+    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
     git update-ref refs/remotes/origin/koala/bear renamer &&
 
     git checkout --track origin/koala/bear &&
-- 
1.8.1.3.704.g33f7d4f
