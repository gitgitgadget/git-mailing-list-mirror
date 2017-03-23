Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F17020958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933031AbdCWWeP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:34:15 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:36505 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932811AbdCWWeN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:34:13 -0400
Received: by mail-it0-f48.google.com with SMTP id w124so270586itb.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CFalfXT58zPCcP5RqDh3mKhHDTwTewn+bE2TpJDwafA=;
        b=IdJoBPbsFdBxmI+vQxD67GhHFeBzoidDqkT036wugAracQp1/QsF54Y122FQmjZ9Lc
         acK9s8g3nlPkD5mHNdm6uf7oTmYL9wXVHS7R0+6g5fyS+v+vQ88756XFat3kFLPGh0pb
         pKeeCfkFkEMRBmD8nQo2OsC5XD2er/mg+6kZ1N3NNgRX5cXXsuD6WWfZDzkO9UZNwnMX
         AqmtwFf2NAf4SqyLQ5id/9B8iJXQWQg3KS8Ktq/0lin9/Nz0W47aSJJ3OKIkU8jJBEtF
         zLZEU/IVXRXvX44ftQk+UbswTXjABdaAas5a9XXDODcmjBIr01UxkGKVgFO3clfrjFUn
         wHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CFalfXT58zPCcP5RqDh3mKhHDTwTewn+bE2TpJDwafA=;
        b=qxhsfUUVAOsT5D4mbkk9M7U8wdwCcYX4B8OfVfNmVt4B8nSpzlzoRdBIKEymp1179K
         YSKE9GYnXAc22oXkUEnPRD+CvZQD+Isotey8zL/5ff8pQWtLYjeUvl6cQNKTNHzRhywi
         YHRNvgV/Dlvq0Y0OX8FO7hWJPWTJzRXYaUU00N/aMv8pzgKWhhZ1ZpQLl27Q5l8nirQM
         sS33MCn0JA8WeqtPyDTyzv0/8B5hh+UdtFSBfB9Qe9WJfjryYhTlSvU8gdxWIG8R1aGE
         s8dqDKTRkhA8bXZl6d/fBimQjjWXy3RYwmNEyWnVELiOnAq+2au+i6jP+H7GNBwMyFdB
         0HmA==
X-Gm-Message-State: AFeK/H0PF5vj3t0yfcwqHgW40sJtVaQNryWya9UdiQxXqbvnfcA9Bhydfs0d4EVL5LC4jQpC
X-Received: by 10.36.173.33 with SMTP id c33mr85828itf.47.1490308452213;
        Thu, 23 Mar 2017 15:34:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id j85sm274800iod.27.2017.03.23.15.34.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:34:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] submodule.c: use argv_array in is_submodule_modified
Date:   Thu, 23 Mar 2017 15:33:32 -0700
Message-Id: <20170323223338.32274-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323223338.32274-1-sbeller@google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct argv_array is easier to use and maintain

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3200b7bb2b..2c667ac95a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1043,12 +1043,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"status",
-		"--porcelain",
-		NULL,
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
 	const char *line, *next_line;
@@ -1066,10 +1060,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);
 
+	argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
 	if (ignore_untracked)
-		argv[2] = "-uno";
+		argv_array_push(&cp.args, "-uno");
 
-	cp.argv = argv;
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-- 
2.12.1.438.gb674c4c09c

