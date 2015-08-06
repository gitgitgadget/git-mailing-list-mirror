From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] argv_array: add argv_array_copy
Date: Thu,  6 Aug 2015 10:35:23 -0700
Message-ID: <1438882524-21215-4-git-send-email-sbeller@google.com>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, hvoigt@hvoigt.net, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNP5a-0002IQ-FR
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 19:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbbHFRfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 13:35:45 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34063 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbbHFRfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 13:35:37 -0400
Received: by pdber20 with SMTP id er20so34632761pdb.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K2haqGkSvYICpJKezB8gnDRI8mgikvcgzcwMLCpz7HY=;
        b=MQQ9jTxb0gfVXy7l3UplbmF9rp6brDfYm2YMfwc7jTLscERGSPOo1km27DQDygNnbq
         b83EuKOvT2r7B0p2nplIXNR7Dy3qzi7O1CpjuYZ4RbCzlmMe36OD00s5jEzBbDGvbbKr
         iT19Px0IrexD147dIv/8Th8lM5C25Bpy2jxt+HaJ0aCXte0NE2n9x66v6TyBFWkSxbh7
         3+KxN4m+ndcDuHIt1HD5RX8XRbvIEw1mfEg2i1uy9mlhyIVGvtjO1HwB3ErPz+syCgOC
         y0uZAFWOuANQmmB4kDusfyNL78EGwAyN2PR39rKt/cIzYzOXbCl9YAzxpPbg5bgenup7
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K2haqGkSvYICpJKezB8gnDRI8mgikvcgzcwMLCpz7HY=;
        b=XWMSLsR4QDt/zZMVvPAQ/oC6Ib0M9WI9sYPjp/P+g0sgGe//16Mjtlctoj9T9mpUTm
         4CO+NEpMkb9OC+e0tX/wNfVOUJJim/opMBVWMnVsberiE3ATmhoxR0SzzeLjAt6DqRsb
         uW3H7CFAwMYId0V3VP5BBrYsSgLCekI+86FMAslNJXnWrJjfg++CN7zlTc1wYrYFdT49
         PPPmPqUDmNnlBlK39kTtTfuj7pasuf8/ikQRY8VsuJicn/l/FobuLW91oijXN28lpeJq
         btwqq9Oh+CAqTqabRlDFRv++aB7uSQHreVG8PDutuXqQ5ZmL0dt/tX+VwxWeT/BHqfU6
         arGw==
X-Gm-Message-State: ALoCoQllaVBFdU5ri8KN5cRcfxzQWtUcYt5zdGtgLc8cjXTOIbOVVvwry0X7w9Hut6DdEhWmLtXw
X-Received: by 10.70.20.5 with SMTP id j5mr5614622pde.40.1438882536968;
        Thu, 06 Aug 2015 10:35:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id lk4sm7262315pab.23.2015.08.06.10.35.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 10:35:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
In-Reply-To: <1438882524-21215-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275427>

The copied argv array shall be an identical deep copy except for
the internal allocation value.

CC: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 argv-array.c | 13 +++++++++++++
 argv-array.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/argv-array.c b/argv-array.c
index 256741d..6d9c1dd 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -68,3 +68,16 @@ void argv_array_clear(struct argv_array *array)
 	}
 	argv_array_init(array);
 }
+
+void argv_array_copy(struct argv_array *src, struct argv_array *dst)
+{
+	int i;
+
+	dst->argv = xmalloc((src->argc + 1) * sizeof(*dst->argv));
+	dst->argc = src->argc;
+	dst->alloc = src->argc;
+	for (i = 0; i < dst->argc ; i++)
+		dst->argv[i] = xstrdup(src->argv[i]);
+	dst->argv[dst->argc] = NULL;
+}
+
diff --git a/argv-array.h b/argv-array.h
index c65e6e8..247627da 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -19,5 +19,6 @@ LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
+void argv_array_copy(struct argv_array *src, struct argv_array *dst);
 
 #endif /* ARGV_ARRAY_H */
-- 
2.5.0.239.g9728e1d.dirty
