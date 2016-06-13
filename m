From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 37/40] usage: add get_error_routine() and get_warn_routine()
Date: Mon, 13 Jun 2016 18:09:39 +0200
Message-ID: <20160613160942.1806-38-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSY-0004Qg-Kf
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424997AbcFMQLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32800 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424971AbcFMQLA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:11:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so16047134wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0ACcAcpNS4lJ7iPLLPL0jVGrmMLXIes+1mZU7IrN1Q=;
        b=MCECQZcucZlHjws11hjfSS8AFvO9Jg8ujKXVZ7p5M4GH/KdWLNO0GcCQJtWUmuhLsC
         9tO9fFAlHeK6rQHPzxEfrVWFnse6bhvmgcADI/oOomLwFIry9IaS6GvWnMVZLNo4+jfE
         Cjna0oiDUG0nBtxCotqtixZ1zqrGw1Y1VhEpb78rYqNbTj8rcTiPnibExklnljbglFQS
         0/Qb37iew2vuqcAA82o5JaskHXzmXctfgfqkaQc89pbG2Bj0Hnl5n6K9+B0UC4tWZzVU
         Mvg/pqNTycrPLOE+3aws6P8cjJJW/QkMKWDB09FICYZVNX7wKvekIWPVBdloZ6Z1uS4Q
         8Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0ACcAcpNS4lJ7iPLLPL0jVGrmMLXIes+1mZU7IrN1Q=;
        b=Co4AotTYRu8+5cB4XEv1oMruhhWzAQMhc+d6zrnWxh3PUVmJXmx14GA0qfE7CdReDr
         irlHsmAL+eBdxMhbcGDeeDwO/MeQyYou/8WpAKLv9ASUixxFBGPQVGYNFwvgetq9RxWX
         DP0TTKZwhYsarp1kYkuDYTcI7t6KJvxV6EixaYtr3jsLbFqOuk29NtIEDzEF9orrM1tJ
         JnPcb3+Q3B9UF7xWikOelw3Z5JOhUnyTxXzjTNtb4Vj1LGhyN9X7bUZ4IvpF5nh+x+SA
         RGoKOB5iuQlQjmS2L+HIFwMMrOOZG6KbbB2vdebsC68TsRqZnZFbR/VfVEV25/fCRNcM
         EHjw==
X-Gm-Message-State: ALyK8tINwEe66RfODRcY6e65wCitThxfSeOlF5dSi4GmF+i5f5rx+YhjmnZq/xSdEX5xrA==
X-Received: by 10.28.131.80 with SMTP id f77mr2024161wmd.80.1465834258345;
        Mon, 13 Jun 2016 09:10:58 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:57 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297218>

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
index f78706a..92af27d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,7 +440,9 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void (*get_error_routine(void))(const char *err, va_list params);
 extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
+extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 67e5526..2fd3045 100644
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
2.9.0.rc2.411.g3e2ca28
