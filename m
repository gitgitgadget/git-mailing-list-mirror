From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] run-command: Improve readability of struct child_process
Date: Wed, 12 Aug 2015 14:50:26 -0700
Message-ID: <1439416226-20749-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 12 23:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPdur-0007PY-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbbHLVua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:50:30 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36377 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbHLVu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:50:29 -0400
Received: by pdco4 with SMTP id o4so11627304pdc.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sPzl1XpeuluLvnL2n4TXDW9MTpEucGAHq8kUfmgvPFg=;
        b=cmYDkx7TYo3BVTz9VznUpbGgXWCzH8PYSp5sgA78h5HasGSCP8Gd8kLwfOBeij1D11
         5Q1fG2pQsO+gdPnGquRDF/hi8EbICsz8v73DIyEJ9w09as9SCrmKaHuaK9asZELV6Wkm
         bnLyXHPIyc5pRtdMc7YyemB/5GKKhlyE9lOVZFiLvXrGg+nrJ8EUv1heF+OudP0QgWF0
         asnImSAGSKufBaTchWyhO5j8sLoOA31cYYqKs+LGcfq04obeqoSVTkzaiMQAWQB+zLX5
         kw8maWNo493t9+3URsl4Azs/YtN0aZOSLOC0XtbDQkXjh7LKadaeslTQ6WsoObpL0kWd
         RCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sPzl1XpeuluLvnL2n4TXDW9MTpEucGAHq8kUfmgvPFg=;
        b=enh5qWFIeqoTAvxA2UchoZNmYNZLxAmxL4dwjKBOVifuqrx+RErz2Xl8az24/y3eos
         qAF4rEdpwj/QBkXpf0NNfuvBSUTbQkxxr14+4OCqlXMAunh+DXXF52Ty4w9ZoX4Oxuqj
         X5fH2beYlnEn0Ue4eR7ZQWKP6OdCfnd0P+MoEHgV5ar+HJNEyfADk4yIdvmzN4BdIe5H
         /h5Cyg7GZa4dImHyPcHxVO8T1rV7+rAHIs26DXy2gLuGS2xil/hp8rQQQcsB4H1NSX0d
         sA0zJwNAC5Oh7kahTbgje7RWwWvNF2o47pEZ/vjiKlja1kAwTpwVdpYamvxEOKUwi9M5
         8+pA==
X-Gm-Message-State: ALoCoQnaIPmU1sG1xToSF+WiUBgH4ANmVXAqjSMUzOISDIe/fc1Q/ZWRNxXWRXAs6TEgUbtUcP7G
X-Received: by 10.70.118.163 with SMTP id kn3mr66929750pdb.115.1439416228758;
        Wed, 12 Aug 2015 14:50:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:d1d0:bd1:5138:d709])
        by smtp.gmail.com with ESMTPSA id da6sm103126pdb.22.2015.08.12.14.50.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 14:50:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.234.gefc8a62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275814>

Reordering the struct member env to be next to env_array
helps understanding the struct better.

This also adds comments to indicate that arg{s,v} and (env, env_array)
are used for the same purpose and only one must be used. Although
these comments are in the Documentation, I still think they are
a good idea in the code here as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/run-command.h b/run-command.h
index 1103805..e67395d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -8,8 +8,9 @@
 #include "argv-array.h"
 
 struct child_process {
-	const char **argv;
+	const char **argv; /* Use only one of arg{v,s} */
 	struct argv_array args;
+	const char *const *env; /* Use only one of (env, env_array) */
 	struct argv_array env_array;
 	pid_t pid;
 	/*
@@ -34,7 +35,6 @@ struct child_process {
 	int out;
 	int err;
 	const char *dir;
-	const char *const *env;
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
@@ -45,7 +45,7 @@ struct child_process {
 	unsigned clean_on_exit:1;
 };
 
-#define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
+#define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, NULL, ARGV_ARRAY_INIT }
 void child_process_init(struct child_process *);
 
 int start_command(struct child_process *);
-- 
2.5.0.234.gefc8a62
