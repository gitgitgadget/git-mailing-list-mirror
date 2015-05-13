From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 2/9] t5520: ensure origin refs are updated
Date: Wed, 13 May 2015 17:08:49 +0800
Message-ID: <1431508136-15313-3-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfa-0003HM-DT
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbEMJJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:31 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34671 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbbEMJJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:28 -0400
Received: by pacyx8 with SMTP id yx8so44495341pac.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YxqXeqK8+3ZrZyyv7iCraseLlI4H23hWZ+2C5X+2spY=;
        b=yToxW3wFLNSojb9GWL6yJHA6ensz6rXmf31CIwEs4pE5kzSO/LH/hnJq+AWCnoWWXv
         F0ZGJIQ6f5zc3uapemehKTtIEPHhMffQbQxX1CY1u3QVUkNDzDIIg4Qw0/T+VQGZfR5G
         GXu96np9aFPlZ2+SDOU9kErf3QFA2bfx5DGx3ndzUy005SeKxhh+IQXhOaLecDklPMJR
         HKnm9arhBUMTEbRPYjc8NeajDYUcMC3DXEOeH/+6UeeAlezCYEYCNz2T3Z4X3JTiJOt/
         rYjsc9Uy6EkOnlokZR0c33Kj6W8yMMCHu/RuBH2TbQ8wyxuoZNUOsGfYsomz8c9TAJRR
         29WQ==
X-Received: by 10.70.108.137 with SMTP id hk9mr35637772pdb.105.1431508167755;
        Wed, 13 May 2015 02:09:27 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268955>

Should all of the tests before "setup for avoiding reapplying old
patches" fail or be skipped, the repo "dst" will not have fetched the
updated refs from origin. To be resilient against such failures, run
"git fetch origin".

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
* Hmm, no reviews the last round?

 t/t5520-pull.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 20ad373..14a9280 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -339,6 +339,7 @@ test_expect_success 'git pull --rebase detects upstreamed changes' '
 test_expect_success 'setup for avoiding reapplying old patches' '
 	(cd dst &&
 	 test_might_fail git rebase --abort &&
+	 git fetch origin &&
 	 git reset --hard origin/master
 	) &&
 	git clone --bare src src-replace.git &&
-- 
2.1.4
