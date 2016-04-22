From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 14/16] branch, tag: use porcelain output
Date: Sat, 23 Apr 2016 00:34:05 +0530
Message-ID: <1461351847-22903-15-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgOq-0000Sh-0j
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbcDVTF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:05:27 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32962 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbcDVTFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:05:23 -0400
Received: by mail-pa0-f68.google.com with SMTP id vv3so10611818pab.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t7bKTLljNmm6XldZDBkpfvWzYm2NOmVHgI4KwjBIaI=;
        b=KbFaVK38WLl55l4fgOoyptL6dYtjeWXGuzRry1bjX21dK0qVuKa3M3dfL9gkoZbOp5
         ctaMYyfgHNm6t0gI8CKA2oXpsStaNytEqB+4eLyDqb8ECesMh0d0P0YuNL9aEr0MPRCz
         qQkfTzaJ1/sFN2Px5G2OkewyVOBluHDP3Uv81P9EV6JutrHaHDP+8Fj3+7rcBD33ukIl
         i/Vq7opp42xlwoV4WqKRa3IB3DK5uOA0zDpg+ZgL5oNQeA3wcQf9XQZZtah6Vy/SGUbp
         EdeYIuBuYwfwHDOW7qjIYzNC2g9LId3sdx6JPdifDebZpKUhGPWv1DXgiTQ7nrTaM3jp
         jHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t7bKTLljNmm6XldZDBkpfvWzYm2NOmVHgI4KwjBIaI=;
        b=NQvOhRIyl75GlRUkKVyZXFiFP49eLX21VojmQZ4ttItKzSdVsNda/nBua5ChtyL5jJ
         XlPerPzaZ0x+pmw5a/3LZZzON/TI1UL/oLib9hJNdk3y7YuirEYNzYQPfcSNqexNVbAS
         BIdP4cEcySPwf/W06xctJVtROIi8XrcEE3uutS1YRV3D/dCiVCCPvOuO9BXdYYlG+w1h
         UIa8cv41oBSzqGRX/xZdI2IPDCn9YXYgci4eH1+B/Zgr4gySumNky9KvY5L6sWXlwH50
         VZ5jYzz8OyER1xS/PROAo/6C0U7Ydb6IAjLxGwm7pdxVlpAqNKXuVQO9ys024gK9mU9L
         x6Pg==
X-Gm-Message-State: AOPr4FWvIYlbx/K+mkVY3ua37ZyAnu5DW5wV2CecPgJAbrMfi8hozBCrEDGzNem6wieQxw==
X-Received: by 10.66.141.76 with SMTP id rm12mr31112787pab.30.1461351922369;
        Fri, 22 Apr 2016 12:05:22 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:05:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292260>

Call ref-filter's setup_ref_filter_porcelain_msg() to enable
translated messages for the %(upstream:tack) atom. Although branch.c
doesn't currently use ref-filter's printing API's, this will ensure
that when it does in the future patches, we do not need to worry about
translation.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 2 ++
 builtin/tag.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index d467840..ecd7ffc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -632,6 +632,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 528a1ba..3b51be1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -379,6 +379,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
-- 
2.8.0
