From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 81/94] run-command: make dup_devnull() non static
Date: Wed, 11 May 2016 15:17:32 +0200
Message-ID: <20160511131745.2914-82-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:22:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5Y-0005UD-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbcEKNVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33123 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370AbcEKNVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so9418670wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NgK5rRnj2w0z4Bqh+uLXvSeVTm6WgRB/bYqhQ7vD4WQ=;
        b=TFS7OCoF18NvXDGU8YITgNe34+Hdzb5zJ2F/bxQOpSbiCOJ5ytr92RI0EI2hNKkq0m
         THE/UvDcYFNsMUzaVwxFiiXyEOYA9ypgQcABLzr1YOkamgAljoC6IN1jI2sIpZQ0L9tN
         rzmT2gNunlb0agqw/u5wgt3zbTQNG+G3KkL0W7vLca8c41CSJJn+ddO61OhqoXyxQXcU
         SEAnksBUXEOrKYupXYTPcskF8Hp26l1DWqAwYOPSBjygk/x2Hdx8LGdm8EDO22WlHy2A
         eHGePlkgJPkMW9sKcFcNdVAoIQjZ3gnuOVxBL4jZwMbDRsKOZUHNKUTIv0cWexVoVxuf
         HCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NgK5rRnj2w0z4Bqh+uLXvSeVTm6WgRB/bYqhQ7vD4WQ=;
        b=d3rQ8QayySuWm2oumQlIcajAgvugXKZDuWRLgPwoxuaWrcv8ouNho5Wk42XSzXl0zy
         Qv4yY+m0PNFbcJo88CCopAANAU8yihprFCPNV4r+PCcQv7c3u4v7qG02b+Uyieue/UGp
         QXfXhhS969xh5miW+2JBNLDLS+LRNClLrKe33UZc8mF4+hoqwjNxC81eAyua/GLW1S49
         74eubsFiDoqU5dn0H4coExLMq/69aNljzlxyN8HNcYIODO5YnYI3yj4Dl0Yr1h6tdrWx
         PJx2sWLMRbTzsQzy5+nC10BoIj/lRbHXHhsE0yzFL8v6a73OzJMeTXTrkSf/vvLFBcRX
         orgA==
X-Gm-Message-State: AOPr4FWb+7lA+fJqYy/kJEy9jtHlQP6KVDQnCuLBP7UVBsdar6IRch1Belz3LJnCodNSvg==
X-Received: by 10.28.230.69 with SMTP id d66mr28660wmh.73.1462972874484;
        Wed, 11 May 2016 06:21:14 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:13 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294310>

We will need this function in a later commit to redirect stdout
and stderr to /dev/null.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 run-command.c | 2 +-
 run-command.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index e4593cd..5d1cedf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
 }
 
 #ifndef GIT_WINDOWS_NATIVE
-static inline void dup_devnull(int to)
+void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
 	if (fd < 0)
diff --git a/run-command.h b/run-command.h
index 11f76b0..e05ce7d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,4 +201,10 @@ int run_processes_parallel(int n,
 			   task_finished_fn,
 			   void *pp_cb);
 
+/**
+ * Misc helper functions
+ */
+
+void dup_devnull(int to);
+
 #endif
-- 
2.8.2.490.g3dabe57
