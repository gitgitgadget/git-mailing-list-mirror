From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 39/44] usage: add get_error_routine() and get_warn_routine()
Date: Fri, 10 Jun 2016 22:11:13 +0200
Message-ID: <20160610201118.13813-40-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnk-00042I-IS
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbcFJUMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34608 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbcFJUMp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id n184so1058352wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qqmLfCD/rM7cGcandiqhYOVtMgxuAopdzDputNbUnVw=;
        b=axSWz30yjauuicp7b0h2gh1ntSPzbyDI9hQdH/4FbYLfT52MMXO6R85j2YRhlN+5l1
         UKklSaw72lUGnkSF0vFupGFbvD6KA/hGyhXOEzOccMUgytisDMXxfMd4Vswa6LCD3T3E
         P6kseh5Zh7SJB9C3+WQ89Er8OeMhNJacQDwc8l7ZvgwywmTpU3E+A5ebpsAj4zpwZ8pp
         0iqqfU6CkxIS4EQrDf64OvbSnsM0ENUIYsU87TxK0mglilyTZL4P8Bq1osNSyyFZerVj
         ULxKvKPxXmQ0+69niY4voojfUylrvdHFrcnR9tcX106ldJiodIRH2/Gq2x/bzBbV/YiD
         uJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qqmLfCD/rM7cGcandiqhYOVtMgxuAopdzDputNbUnVw=;
        b=T1RSngOc4lHvXwzOW1ssC4XZyVF9Tz6QjfcO37Sq4CAyCMR9YjWz0dD1t6J82Pv4aj
         cHRmpvashyQ4dWVS34+5CUBQkedu3i+oNwYmZME5Kj5iHekW6MRPdBnqKAV6l40VCSId
         jRnnOWkUr5ISnqhKWENl4JPUij4M/6EieiJ/YmVqanMXzaTWHBtpHG2+pxyMikpSeZdt
         xUi+w7dguSZ0Cn/+Nyzp3fFvIky/W55y+y0jIX8LBEdGU1WErwliKKwKXF/WgxH9RegR
         CbFU7JTIt4dNKB/Cahgzo+wHaEAGoZMdJYb/iMi5xBVDgFXVoyZ/HNRFY0Lsep84tFeQ
         8jRQ==
X-Gm-Message-State: ALyK8tJprWtJkd0ntLzXdQYFdMXxRUA4Bcjf+eJKlwVGuAYdaj6Em2BcNdSOZrhG9CoawA==
X-Received: by 10.28.27.81 with SMTP id b78mr635949wmb.19.1465589564133;
        Fri, 10 Jun 2016 13:12:44 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:43 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297049>

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
2.9.0.rc2.362.g3cd93d0
