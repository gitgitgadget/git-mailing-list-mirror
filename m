From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 31/44] run-command: make dup_devnull() non static
Date: Fri, 10 Jun 2016 22:11:05 +0200
Message-ID: <20160610201118.13813-32-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnO-0003kw-M7
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbcFJUMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33657 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbcFJUMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so1070771wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KuvDPX07L3KKWxWpM6EEa3SUR2ugI2CeKUEmoJxdZ/0=;
        b=Wx5MqvvG9yxCVvBxjfBqffLl6QFYGQL9AoFmrNjy/GeN9NofxPaxGd16rmptqqnhSX
         jqwn8wlI9FO1pQL67pl3bYKnZpuAf6u60ujnfFTzmkjxH+Ic75eMHws2B87ZyQfyhAAb
         roMkJCotwqquY666TxMmla5HCtLJuM1jNYJWVpJg43lrppyAzz6liXLl2SdmTM8nLrde
         a0Yc4q7ojwNEbRUigGWtraqAGGCACM3Z8IvyFJLWzTXlM120oQ4FfumC80bx0skoeM7P
         0HxSeTNzB7FTWATeKK4TpnOp7Mf1CysUTj4679WH9l3EQGTCmiFkSUWKsxtQHRUn4sJu
         Pm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KuvDPX07L3KKWxWpM6EEa3SUR2ugI2CeKUEmoJxdZ/0=;
        b=hFL3RxHTnAnl5ns811Ck3IdarXwk/QDivH7orJbswbUQztUqPgWTLsqFRUCkfCw5bA
         6/Qd/fk1x5dYtsvzi9xXQID9po4YsRoM8gJ+wStgvhEWprVpApsa7egpTswOR0cPYVWk
         0pPSxE9VK67kmT8CPIEalC2eYlvbhy2irRRmr0wjx1s4hpKvSXllrmuPvFd0ydWhVaiI
         8LF3Eic9YrztbKPKq8iEus25Qzy5UJmQ30CIrIRtICBEFNkB3FLZq+V1KfBuNtiu8n0H
         0yOavMZl8hn6nKp+MdWNFS7bd+7WSSYSMUMv3YUU6hFhBZ7lCw88m8Ec4ViKfiuoAeMG
         LoEw==
X-Gm-Message-State: ALyK8tKVNOsES/XcD0/1LxZxfSm6lhpZusA8bwiqcVZ9HThaDMwMxN7wllrbnZShD4MxFw==
X-Received: by 10.194.206.39 with SMTP id ll7mr3636800wjc.179.1465589553404;
        Fri, 10 Jun 2016 13:12:33 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297042>

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
index af0c8a1..d8ed88c 100644
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
2.9.0.rc2.362.g3cd93d0
