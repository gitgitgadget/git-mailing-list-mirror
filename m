From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] path.c: allocate enough memory for string
Date: Tue, 29 Mar 2016 17:38:48 -0700
Message-ID: <1459298333-21899-2-git-send-email-sbeller@google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 02:39:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4A4-00042K-IN
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcC3AjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:39:00 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36189 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbcC3AjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:39:00 -0400
Received: by mail-pf0-f180.google.com with SMTP id e128so6449114pfe.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePAHh4Sn+0RrBLBlM8BznD0G/itdDPw1gw5z3DMGgsY=;
        b=WeD5RkVjAM0Z5+u1wEQAESn5FdewJHdn3eqVbe9l0DP5fYu2ZcPQNmXpPjci2Ap69u
         i0I5740MHP+v+dSlCHFw8ZjnWj3j8iGHQ34vmbY0o5kXfaVFYleZyrkk/oy04hRsg2iQ
         cHbeDsflz8slGBV763RIr0ZhXkOtLuzzuYTcEzTj9fie1W3fYIonOLJpx9Ox6TRsKHH9
         0/Fe8piiJGi9tb1Z5GM26HHL5iKmGQZ2BTZVglihtsAXpo/GkS7/d6EJ9sP1C/5s0kHP
         V0ev3BvKoNLRy+jc5JJC/P9G6f2wYG8bq2yoYn/06z7Lxq6Xzz3ChHBjHjqPSeGqTaqK
         RyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePAHh4Sn+0RrBLBlM8BznD0G/itdDPw1gw5z3DMGgsY=;
        b=ZvQyTk59/GwiWFjhl26WtNdE7oxkODSqFP4mc+q8zzmVwQQyGxG+djVcWGsUpFMPXf
         Eh+2c5CkTJOtYIO7Sccj7nMdfZ3NHANRxyxpOPpFIFooPvkViMQW+qOtNR4GRMO5H9XJ
         3izDgM6EY3IujScz/8B4JcW7s4gOtUWjYiQvDzxaQQhLv/IxVDBMsccO8bLblFqNLINk
         XlzwgiTXQb2uBJ33hxaGf0s+qb0SAfXRM2g0aDaOjL+uOSzpJA/1pbrisVoevB2osPUc
         Q5wVrtfMbvX5H6tXltuwS37FDIXiLk03l1X6z9ElNb5ebpN+vrTdv3UOwz5HNs7NMW4w
         wBxg==
X-Gm-Message-State: AD7BkJJMpAHR1u5/JoR5ORVcCDbs1TY4KWfRZcBXEKlcqGY/loMfVgvB5/gFnuxFd0HtI1p+
X-Received: by 10.98.72.213 with SMTP id q82mr8159857pfi.164.1459298339167;
        Tue, 29 Mar 2016 17:38:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id kw10sm1039241pab.0.2016.03.29.17.38.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 17:38:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.8.g27a27a6.dirty
In-Reply-To: <1459298333-21899-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290233>

`strlen` returns the length of a string without the terminating null byte.
To make sure enough memory is allocated we need to pass `strlen(..) + 1`
to the allocation function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 969b494..0ae8af5 100644
--- a/path.c
+++ b/path.c
@@ -155,7 +155,7 @@ static struct trie *make_trie_node(const char *key, void *value)
 	struct trie *new_node = xcalloc(1, sizeof(*new_node));
 	new_node->len = strlen(key);
 	if (new_node->len) {
-		new_node->contents = xmalloc(new_node->len);
+		new_node->contents = xmalloc(new_node->len + 1);
 		memcpy(new_node->contents, key, new_node->len);
 	}
 	new_node->value = value;
-- 
2.8.0.8.g27a27a6.dirty
