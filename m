From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 90/94] usage: add get_error_routine() and get_warn_routine()
Date: Wed, 11 May 2016 15:17:41 +0200
Message-ID: <20160511131745.2914-91-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:21:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U58-00052I-Qv
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbcEKNVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33348 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406AbcEKNVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so9420629wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+uzXY38osmlX4lvOzX0MKYMyAKwpk8IWUdg41FIg5g=;
        b=hVLtWXcQWYKuglOkTtRJMv7UpDq5ATIvmrxud/SauMe4Nrc4nikhkV5IUwxZrA+sUc
         +l1nZtdmTpeQOT5/nvS3oDHxe6G54Ak5LRDCBpE5FNSPORPO4XTYeS1p4qR7+djsSrbU
         CvK9ehWcGf/fDvoiluaCSXiQp+P+WjFzkk1TIK7ENJFWHPeGxs6+0xsq6Q4nuqI8nHz4
         cvoWBm1xT5KxL/L8HQywnL8Uj1ipKTsBlzKkSoUVwr3z19AIL4AnixmnNKpYeNUcH++Z
         6f43Hm31jBImaFIOoDx8cn4/kgHVdBxIrh++VqEwW66swpy80m2vSO9z62Yv/ZRxzZYX
         O0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V+uzXY38osmlX4lvOzX0MKYMyAKwpk8IWUdg41FIg5g=;
        b=UPp2BkGPT8by7PlqsfcmjVrNhsNTeVE9YKhLPYRm4yLh3Tz31e7KDwWwJ8+wYLFnri
         R0x4zPIU6XhmQmeb3Xf0AlqycqIs3TBnVJuZ+STF5XLhDqGqLu2KXQ4cB2RG5fCSn8Kz
         0FTMxAts/850ZuvRe8X4bwTxqdlh8h2MwnvViejFvzwRq2rv6Wj0yO8ge6EIusQSmpnX
         7R5gJvm+xD2V/J9YgrROWdxQkg8Bofpy5QfGnSQ5zi/2AmOuVkUKdjEtjxMjOMv6Dn+4
         nE1AtW7LxTquEh9VWXleljdb0AisIl7dw1dFRAFmMhBprl0YcwvyDipIZwAVDVeEIutA
         xNKQ==
X-Gm-Message-State: AOPr4FWiNSEvUH0ltUkHAB0IRzis7ZVyqzlvtUi32gYGcDbRMT6NvurQVt3Ea68obV/06w==
X-Received: by 10.28.149.205 with SMTP id x196mr35524wmd.67.1462972893506;
        Wed, 11 May 2016 06:21:33 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294299>

Let's make it possible to get the current error_routine and warn_routine,
so that we can store them before using set_error_routine() or
set_warn_routine() to use new ones.

This way we will be able put back the original routines, when we are done
with using new ones.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h |  2 ++
 usage.c           | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 987eb99..73446af 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -438,7 +438,9 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void (*get_error_routine(void))(const char *err, va_list params);
 extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
+extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 8fbedb3..825bd92 100644
--- a/usage.c
+++ b/usage.c
@@ -70,11 +70,21 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void (*get_error_routine(void))(const char *err, va_list params)
+{
+	return error_routine;
+}
+
 void set_warn_routine(void (*routine)(const char *warn, va_list params))
 {
 	warn_routine = routine;
 }
 
+void (*get_warn_routine(void))(const char *warn, va_list params)
+{
+	return warn_routine;
+}
+
 void set_die_is_recursing_routine(int (*routine)(void))
 {
 	die_is_recursing = routine;
-- 
2.8.2.490.g3dabe57
