From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] sigchain: add command to pop all common signals
Date: Mon, 28 Sep 2015 16:14:03 -0700
Message-ID: <1443482046-25569-6-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghd3-0007Kf-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbbI1XOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:31 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36469 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbbI1XO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:28 -0400
Received: by pablk4 with SMTP id lk4so89755933pab.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hllV8k029YiRo9oY3F13tFNK0jQSOToDoPnZ4Ha0z80=;
        b=FG9DSDpH6pk44fIZcbOkQ5IpYSw+RaW3AxeXE3E6UdWUlqJRyxQ0RYhhQg0mJsV764
         I6b2bMQdwVnEhrqlEbhiASCaEPu6lnJpglygt+BChH63b6IGRznxH/UchIL2OsOkgcB1
         UZTe3pO+5H6dEgrgeLNQXxjffdBpFI+2J5sx3ExnmNO80qem2K445SP7IneuORE0csie
         dpZGqzTT4kL29QBVAaGIPJmEZnDcsqahPvZf4yoiHG2JtjycqJlZzE8YjUdbg8RpYSzl
         CKL65na1Z1iLWcvylVx7N/wQNWjVUqWQnQO1fjmCdRtomdylKy7cR/LqM3KPEW1GHggS
         731A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hllV8k029YiRo9oY3F13tFNK0jQSOToDoPnZ4Ha0z80=;
        b=KpvyD6syyAX1yTJkS6d96WHe/ZnU9emP80T1qkUMBS+qtpEUfb8IhNXfz7xBnapvq3
         oAQc8ZGQ77mOfiM0ulZNmIfVKwaYblpSlkW1c4LOPk2OIKm9s8awkhzW4VfnWUennoCt
         5ba4mpZOmA8vawkBx8+Zeo/f3prJOb6S1mF/Lz9EiX/DQnlYaCPM7aFqBJFPv2xn/X7j
         12Cts8zBn/wmsm/2g/uX+vUC1KrRWpJ+IeFI0CAtYjOmOgKGLwrhVlDMFW4vOrLg3yKX
         Bw9Y22QsptvtNa3VNDlK7dj9m7cyA36/QaZHy7goEfy1ZCQTF0ngtaHivCvcqdBLiVdm
         lscQ==
X-Gm-Message-State: ALoCoQkgioTN7ox9PYQJ0R58CDtjPjcZBPvH/3vmRZCWrnjE8RKJAbowavfBdCvyjJjArmEYyAFc
X-Received: by 10.67.15.66 with SMTP id fm2mr29358488pad.82.1443482067216;
        Mon, 28 Sep 2015 16:14:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id w5sm21479675pbs.31.2015.09.28.16.14.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278804>

The new method removes all common signal handlers that were installed
by sigchain_push.

CC: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sigchain.c | 9 +++++++++
 sigchain.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/sigchain.c b/sigchain.c
index faa375d..9262307 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -50,3 +50,12 @@ void sigchain_push_common(sigchain_fun f)
 	sigchain_push(SIGQUIT, f);
 	sigchain_push(SIGPIPE, f);
 }
+
+void sigchain_pop_common(void)
+{
+	sigchain_pop(SIGINT);
+	sigchain_pop(SIGHUP);
+	sigchain_pop(SIGTERM);
+	sigchain_pop(SIGQUIT);
+	sigchain_pop(SIGPIPE);
+}
diff --git a/sigchain.h b/sigchain.h
index 618083b..138b20f 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -7,5 +7,6 @@ int sigchain_push(int sig, sigchain_fun f);
 int sigchain_pop(int sig);
 
 void sigchain_push_common(sigchain_fun f);
+void sigchain_pop_common(void);
 
 #endif /* SIGCHAIN_H */
-- 
2.5.0.273.g6fa2560.dirty
