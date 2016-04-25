From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 15/17] branch, tag: use porcelain output
Date: Mon, 25 Apr 2016 20:47:56 +0530
Message-ID: <1461597478-31855-15-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHm-0005yC-5M
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbcDYPSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:48 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36161 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbcDYPSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:46 -0400
Received: by mail-pa0-f47.google.com with SMTP id bt5so12187326pac.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t7bKTLljNmm6XldZDBkpfvWzYm2NOmVHgI4KwjBIaI=;
        b=viZhZnjb/kYpqMiQrzAVYdNLF1LElHS/dLKHyFSWkz/rPCFcLf6ZkYTYqyaivHH9B2
         4tYB9IbsmP0JUdbQzGFoKi++jWDklAdfnS3cWNDrt0ZFuIJ8B7aVMJv7yUjuJ0SkUzSO
         ci0y0Sajqbhfxc/CAVwTcaMYCd3OPamRJagGqZ1luPCtVilx/28obisxJDMtPXBcBo+T
         Fo0QoX683T9QluCyLxHRX9esFqgcRRCvgPJZhZJSGYprlqn0dcNjeKLHYuEPrKS0u3Ji
         +1L4CYJC7fGMYMpZQ+lnr0D00YKRKgH4x4Nh4cU9nG9mM4H3WT/bQgD6r+jlIM6owPuL
         /qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t7bKTLljNmm6XldZDBkpfvWzYm2NOmVHgI4KwjBIaI=;
        b=U5f2DDRK8+hkiC/TXQhDG+5E7rz+cJr+Jd4gl/9ombSl/M7b0+wDYjNrDoJxSd0qtB
         DSRIt9bLpYHBtMtjctjx1DgYqsgfNJGxyDnbjaSCscelmW/sCILUPurBd2Ay+0rupxYC
         2WwF4S8P0QRgguTK99KAeA6J74gIsFOwdxQnAcgkdGzSgr31lsTphFlxvo07KQWGIbMn
         NlQJlnXoXZX4SxhVvrrrXOXJ4PpQ+ww03u91ybF7B2JDszh2O7YcS2HNsyPAExscsWqc
         OYf+bHWZIZgKfAFx93jZ1sVjvuIeQXqofXxJrGyl4iignC7x9abdiw3GYkXoiHGV1TVS
         bmhQ==
X-Gm-Message-State: AOPr4FVTbmg/+bjSHor/WtJciLwHg1voqWDVViGNL6cyyoq78ZaugGWQ3UTKqOqzN5q1JA==
X-Received: by 10.66.160.73 with SMTP id xi9mr49175187pab.73.1461597525918;
        Mon, 25 Apr 2016 08:18:45 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:45 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292499>

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
