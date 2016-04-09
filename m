From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 14/16] branch, tag: use porcelain output
Date: Sun, 10 Apr 2016 00:15:13 +0530
Message-ID: <1460227515-28437-15-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:46:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxtb-00040H-3V
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759248AbcDISp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35818 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759100AbcDISp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:56 -0400
Received: by mail-io0-f196.google.com with SMTP id q128so20553742iof.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cind8Vr6YUWp7K1GRLMwGyKGdWMjhCeKMvWstc5zKJk=;
        b=zwEerKm+hBWwJB53ho5jHV9GE7/N4y9jtMGulqKVQNInVCpiYYzyIOMn+NKfSF9s/d
         +2wNarN47SN9oodMX67Xh6r1+WWKVpAC8CMZR8DwfyjsvrwSzs1daiyNGafTAZaPvRdZ
         lpJt6KT+Yo7x+etPVrT27tgmdiKJWt4c9UHMbLVjrAIyWmVzyB92KRcNc81+Tp9iUZ2m
         m+PMthe9KvYAlnGevl2I4oVDmDkfdgt0Nkrx1otnGcPGCxfGFm1ozgLgNaLMP6jUpN20
         gzk4cWVbxcp4FMem/so1WJXKp3+7sqEjKhEGf6JA4t+GX0J6Wf0PjjGF018PJ+iwcfSo
         8Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cind8Vr6YUWp7K1GRLMwGyKGdWMjhCeKMvWstc5zKJk=;
        b=WkwvXIT8iUARrhpDtp7IHYH/AWGDVA2y5HJFjp+8gx7mcTxBh83BjVkiLNCG9oQszG
         L6JbK2aM2lFokbymEoUsdI+vaXA3vPPm8t78X8v51drogQMCiNPSkdmRfDLLqVehE7Tw
         JNug5bKEe+yLyC0lohm7Sz1Od+OTVPpz4iqz0521suXHHNdZNKDN+xbTa06Ugwe7ebCC
         cVj8lPX/sq2D6/EFo+pkaqdFJ9BK9vU4VyLIj+NFTFVkzoUJ1bMWvfLU/Y1uNGi1Vr9N
         pFUaOChZVMIbmDJkDyD8j+0cSJrwOX8M+qzrgj1FGjAXIm8vchuACTrX95+5EBOFj8X5
         gbqg==
X-Gm-Message-State: AD7BkJLVtEdCUBiFkn1gQ7HvjN96D6BI1opqiveH2yhKa/Ebdwwm5CJp8Lih2a2jUM3IXg==
X-Received: by 10.107.9.202 with SMTP id 71mr17782660ioj.52.1460227555858;
        Sat, 09 Apr 2016 11:45:55 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:55 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291122>

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
index 460f32f..8747d82 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -622,6 +622,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
