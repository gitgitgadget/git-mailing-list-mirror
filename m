From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 08/12] t5520: ensure origin refs are updated
Date: Thu,  7 May 2015 16:44:04 +0800
Message-ID: <1430988248-18285-9-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQI-0005dY-M3
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbbEGIor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:47 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35432 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbEGIom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:42 -0400
Received: by pabtp1 with SMTP id tp1so34375545pab.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d4appReD6CWB0Q9QysXRuCMqU70ALhZ17aTLipOM3l0=;
        b=r2eY+2HZR+Q0dgaay8ucn0qnKSFk3K65CiEQdf5N4XCs5jHw9clem6xw9vmcj1tD9L
         kvhuJxcaApl1YLuDh6s/Li9lcp0PZ8qnTL0lwdwsYb5dj7zIdvSNmBOLm8YHfvWw3qkT
         IfAtSaWeTuK+sjPFSbmx1w9mP+7pmcOuh+kvBzyrWvnVd5OPWCwlpRn1jp51FQ8tWPfP
         yf0dsHHIWb5wVyWi/tnhmp8gwqjwtvIiRiA1go0S6V6zhZE92FzlQgGOOTOB8m9FvMoN
         rs06zuBc3Fc6IV1Hv+YueYWJO6xTsPpVhfyGw6vgYgikqH331oesna6GB0l1VjoDXKDP
         H0+g==
X-Received: by 10.68.246.1 with SMTP id xs1mr4996675pbc.53.1430988282469;
        Thu, 07 May 2015 01:44:42 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:41 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268516>

Should all of the tests before "setup for avoiding reapplying old
patches" fail or be skipped, the repo "dst" will not have fetched the
updated refs from origin. To be resilient against such failures, run
"git fetch origin".

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * This is a new patch in the patch series.

 t/t5520-pull.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9107991..d97a575 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -461,6 +461,7 @@ test_expect_success 'git pull --rebase detects upstreamed changes' '
 test_expect_success 'setup for avoiding reapplying old patches' '
 	(cd dst &&
 	 test_might_fail git rebase --abort &&
+	 git fetch origin &&
 	 git reset --hard origin/master
 	) &&
 	git clone --bare src src-replace.git &&
-- 
2.1.4
