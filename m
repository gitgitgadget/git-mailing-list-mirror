Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D8A20756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdAMR6J (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:58:09 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35815 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdAMR6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:58:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id l2so13412070wml.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HUtMvQcZBZxDD2vnqGu0i5R18o91ZOLR5jP7clYzvws=;
        b=iQQW7NVqmsh4Kt2NWnrIWlT5SDiphrjs/0nZhQbGelYt1Yb0rcgwIO+cVcFIwlqC5+
         v6C/cPKRIAsDN4lUiXiUECHv7zDV8AiDS4Dzv0qlt0ZABFigucqe1KuO4uwqK8vwwyVA
         sgAvw2wz9REPw30SE/txdN4+NbIy3AKiSh5kGoFdqd/YONh6zUs23dG8YfRJbEyS1qFT
         /WcKG7AXHTzmIOaxhB+bSNaXdl0rQ+KJ4w8gl4X0RX732b9s1XXqFhn+PQlcm3hGbxZu
         dFPYZRGZIGi6RnDEJ7SKVjM5j2WePp/Iuuf9CosP8Mpeo7Ms+Xl/CMVLPBwx5ihxPSk5
         lXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HUtMvQcZBZxDD2vnqGu0i5R18o91ZOLR5jP7clYzvws=;
        b=pNKPKVUB9QcRDXj7qiNyKDwsFczdPNoJUt2jRloaRmcaqU1lKLdN+ASZgRwqj8jDQe
         nTO7QphfVOT08Cro5j/wCZik3VMPgiuoKPAPhOq+ZQXROGp6B07SJdMZ++DOPiwpLaDG
         7H56HvF+zbUxA6nl24IkIuyDTIOCG9aFRKe7dCw75n6Pcpk7g3XZP8bM6xAU7tqRJh7+
         CK9OyyrK0RABWk1/iWFdaRr9EBaYavrbo6VARauNuKu/orme0ooRpfOn+WmcG0mfCvXc
         Wawt68A7pCGGyOhuns+Jg/x5s4Qae2teKQmZrV6koA5zFY4q65qQPh36qjIgsO+oxa6C
         AobA==
X-Gm-Message-State: AIkVDXJYV+vi52fhMJ0KMuFoNtj3lCCbKqSZYks0fcbVqqDs3MsoIqRZIYsYRbFr1QUBXQ==
X-Received: by 10.223.160.172 with SMTP id m41mr12640927wrm.116.1484330286418;
        Fri, 13 Jan 2017 09:58:06 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.94.233.52])
        by smtp.gmail.com with ESMTPSA id c81sm5717357wmf.22.2017.01.13.09.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 09:58:05 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3 2/2] builtin/commit.c: switch to xstrfmt(), instead of snprintf,
Date:   Fri, 13 Jan 2017 17:58:01 +0000
Message-Id: <20170113175801.39468-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.11.0.154.g5f5f154
In-Reply-To: <20170113175801.39468-1-gitter.spiros@gmail.com>
References: <20170113175801.39468-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this patch, instead of using xnprintf instead of snprintf, which asserts
that we don't truncate, we are switching to dynamic allocation with  xstrfmt(),
, so we can avoid dealing with magic numbers in the code and reduce the cognitive burden from
the programmers, because they no longer have to count bytes needed for static allocation.
As a side effect of this patch we have also reduced the snprintf() calls, that may silently truncate 
results if the programmer is not careful.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net> 
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the third  version of the patch.

Changes from the first version: I have split the original commit in two, as discussed here
http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.

Changes from the second version:
- Changed the commit message to clarify the purpose of the patch (
as suggested by Junio)
https://public-inbox.org/git/xmqqtw95mfo3.fsf@gitster.mtv.corp.google.com/T/#m2e6405a8a78a8ca1ed770614c91398290574c4a1



 builtin/commit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 09bcc0f13..37228330c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1526,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 static int run_rewrite_hook(const unsigned char *oldsha1,
 			    const unsigned char *newsha1)
 {
-	/* oldsha1 SP newsha1 LF NUL */
-	static char buf[2*40 + 3];
+	char *buf;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *argv[3];
 	int code;
-	size_t n;
 
 	argv[0] = find_hook("post-rewrite");
 	if (!argv[0])
@@ -1547,11 +1545,11 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	code = start_command(&proc);
 	if (code)
 		return code;
-	n = snprintf(buf, sizeof(buf), "%s %s\n",
-		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
 	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, buf, n);
+	write_in_full(proc.in, buf, strlen(buf));
 	close(proc.in);
+	free(buf);
 	sigchain_pop(SIGPIPE);
 	return finish_command(&proc);
 }
-- 
2.11.0.154.g5f5f154

