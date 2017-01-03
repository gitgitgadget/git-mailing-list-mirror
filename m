Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE928209B9
	for <e@80x24.org>; Tue,  3 Jan 2017 19:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934096AbdACTKH (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:10:07 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35843 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757817AbdACTKC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:10:02 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so217555782pgc.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i09lRAPbhG4JF6LI3ooI+tp6rEafjOQ7GaWkCpXnxfU=;
        b=fj2JSxUOeafTUsrdwirNxJy5xxpptyHjFQj86FUVDVGw7CXwoNiUk+KluT4CJTkdPa
         4s5Mt4j/rI5HiSZquFGmXK+4cHTL1eluI9c4j7qQiSn2REost0BDD/9dsdDJgUdJrIdV
         BxL1kXoGZWAamm0x9JacDgMS6iRJTy19vENFf2nBA0weOGpH52OmGcNMHVbklEW7LB0N
         OHCtGq2136xs38yVMGxloeACYG3Q26IFL6HYrL6viAh1fP21nKwc+uLcchJmRKb2jIyL
         BHjd+39cZNvgTEKOlWTtB36Kg2EeNRPvWieQH3BkKi115UUGgrBQFs/8hAthQsVU88eO
         BBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i09lRAPbhG4JF6LI3ooI+tp6rEafjOQ7GaWkCpXnxfU=;
        b=gFPbmHE4dSr1IJPw5kx0T8ogFGn8tw3cqhkw9oyGmK+7gCphasQk1uzJ6NSGKGrEDK
         8uAdX7scq/+gbcXlpn9Y1IIOsOF4Fx33Cd6Q7mGQ/05XL9iK4WVFt2Q5YzNJxLky83lS
         2hwjCE5bdkS/BfAi8Vdx2bbRVbVRbhSwm5c7HjLq9uVCxI2lD6YfQF84U7sIdNio7tN/
         7MAS1dpdvNwWPOib/G0RydiPS2iwHjcQe9h7g6ECz3YoJOBHldFpjTcn+rWIV7hzB2ty
         lUUdGzIpVB+6D9y+mzcYeGqHAv74nN1CrsXfiPkw2b4vD2nJ5ogqjRrebBJgIP2/cUBw
         FA0w==
X-Gm-Message-State: AIkVDXKVTbAdEj059OCLRv1xNTLu8n0fivEM9cIx10CJFq0mu537y68SvK6eKfdhdJM6+MG6
X-Received: by 10.99.123.3 with SMTP id w3mr111255245pgc.155.1483470601735;
        Tue, 03 Jan 2017 11:10:01 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q5sm66947112pgf.45.2017.01.03.11.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 11:10:00 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 3/5] real_path: create real_pathdup
Date:   Tue,  3 Jan 2017 11:09:21 -0800
Message-Id: <20170103190923.11882-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103190923.11882-1-bmwill@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create real_pathdup which returns a caller owned string of the resolved
realpath based on the provide path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 13 +++++++++++++
 cache.h   |  1 +
 2 files changed, 14 insertions(+)

diff --git a/abspath.c b/abspath.c
index c3a6acd4d..f4283f465 100644
--- a/abspath.c
+++ b/abspath.c
@@ -205,6 +205,19 @@ const char *real_path_if_valid(const char *path)
 	return strbuf_realpath(&realpath, path, 0);
 }
 
+char *real_pathdup(const char *path)
+{
+	struct strbuf realpath = STRBUF_INIT;
+	char *retval = NULL;
+
+	if (strbuf_realpath(&realpath, path, 0))
+		retval = strbuf_detach(&realpath, NULL);
+
+	strbuf_release(&realpath);
+
+	return retval;
+}
+
 /*
  * Use this to get an absolute path from a relative one. If you want
  * to resolve links, you should use real_path.
diff --git a/cache.h b/cache.h
index 7a8129403..e12a5d912 100644
--- a/cache.h
+++ b/cache.h
@@ -1068,6 +1068,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
+char *real_pathdup(const char *path);
 const char *absolute_path(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
-- 
2.11.0.390.gc69c2f50cf-goog

