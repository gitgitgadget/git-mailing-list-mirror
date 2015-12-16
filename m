From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/7] sigchain: add command to pop all common signals
Date: Tue, 15 Dec 2015 16:04:09 -0800
Message-ID: <1450224252-16833-5-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8za3-0005ka-Io
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933803AbbLPAE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:28 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34749 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbbLPAEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:25 -0500
Received: by mail-pa0-f44.google.com with SMTP id wq6so13371019pac.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UjC/KLz2TAyaA4RMgzNQ3FMPYT4zbYmshniyT2Z8B4g=;
        b=WEKEPHV+1F9CCg/jfDom60pAXeoa64qA+fnj/c/htnxVX8SVzcPf961xJePrFrs17s
         C11XlSFTPJG8FrFRHNjo6GVbRjgt6JoOgti58Rz2xO/IzZ8WjCRJQG1K2xhD8I8mZa+8
         Y1xDZacF31sYk1y9/qVZ31gSXXq1jtyIglZE/ttDyPhMN3JTZLW3F1g5E6EaypL8DtnJ
         4zBgX3KxPms28Zp8ba9Fa1B9qP3z3dWWsgCDmKcCagIywVAWrJpFHcN+LEBKBAL6qllI
         j8t11XhL5lJFfyHpkAw4RmVgd/geU1AvB+aLxB/z22R1zraAdHop05hPzK471WEfSHzn
         QwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UjC/KLz2TAyaA4RMgzNQ3FMPYT4zbYmshniyT2Z8B4g=;
        b=KostoTJZ6+AhYO17UP0ElntnuMB8uFApa4zftJcglYANKo877fCALxPcoPZOLXzfnJ
         LaFhpfY1x9XwSc9SG5finRbCF99qSYYp87T6OuwwE7SvKabeVVXQyjBfx/BM1rNXMWjQ
         FEvOajy2KV5OaW3zHRx875L8vVOW6gt2Uv1heRHor1DPB4dnUNmPwtIHY1uFsHtJ6mJf
         jYvPcHCzNqv4PSVtgeesRu/C6GrlDufFfd5pmJvXJwMOUk7Nb+gAZYThRfaaZdF4cd7N
         OjrOvO/9Qz6vDm+MEM8fWX0F/lTfef+K61ADxnjXELJhgZl6FD2yYm95XV/L3awSmzjg
         GdUA==
X-Gm-Message-State: ALoCoQn4J2wPP4VsYEPhCmaZ0utJEHKiC3Cu9LdJ16CvnJPr+aaM0ZK0P5DzMFi8reNm6dIw/Szt1oCpvgHUx26CHR6OLQi8Pw==
X-Received: by 10.66.158.193 with SMTP id ww1mr29619778pab.21.1450224265046;
        Tue, 15 Dec 2015 16:04:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id z63sm399563pfi.69.2015.12.15.16.04.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:24 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282516>

The new method removes all common signal handlers that were installed
by sigchain_push.

CC: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sigchain.c | 9 +++++++++
 sigchain.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/sigchain.c b/sigchain.c
index faa375d..2ac43bb 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -50,3 +50,12 @@ void sigchain_push_common(sigchain_fun f)
 	sigchain_push(SIGQUIT, f);
 	sigchain_push(SIGPIPE, f);
 }
+
+void sigchain_pop_common(void)
+{
+	sigchain_pop(SIGPIPE);
+	sigchain_pop(SIGQUIT);
+	sigchain_pop(SIGTERM);
+	sigchain_pop(SIGHUP);
+	sigchain_pop(SIGINT);
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
2.6.4.443.ge094245.dirty
