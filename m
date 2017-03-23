Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F7920958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756315AbdCWWei (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:34:38 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38182 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbdCWWeh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:34:37 -0400
Received: by mail-it0-f53.google.com with SMTP id y18so287383itc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRJM2s2j+xDXFzST1hfDCWYd3oceA2m2QJUPlouZEmQ=;
        b=u72bXBD1C9ql83yEPLOfUbOTHeTKJz4bqG29de0Z8f8fI+30iWJ+0y6PWgZBf4Y8w9
         WSGQ6asoY4Gn0Vqy6gn1i55cnxwhbI8pjY4z1WQFZKWxyzL4ztvDcYTJJ3wZPq7gFIve
         V32Skgbt5nyaLWyGUopkU3CFNopq45FxjJcffR57WoZJlC0Uhe+6/sHqJWXrJtq7J5Vn
         ks/RlgLmCe1o6MGicTX6W+NiZHW6DiXq0LjAyDoNEFEaPTJMTAg9xUzKigcbmJOM0/hU
         r6ramA0ghLVq3EwpjRu48SFsCLQediVdY1FksWlGYUyfPxav5KPIuoK7Wjlegl4WlNsi
         yh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRJM2s2j+xDXFzST1hfDCWYd3oceA2m2QJUPlouZEmQ=;
        b=TX8wxVoBHkeFr/klcqg+QZt4SCN+ZFQ18qTGW40/tXV72U5i8D7yq0QeyNcB1ffvJ8
         uv5Icc6OGOqtT7vEPCGGmw/kYu1DRLQPun867FbpCBO4L3o/dq+KSJM0r5Jq7kdiV9vA
         v+Oo1ig0LIJn6xhQuj9EcWM2gG4+6mDcQq9GAShJh5BVKcX/lCnyqYNFxGcREAZ6gw4D
         WRUTLSXaLAyD6xy+QuRR3HZP6s9vGRD7UJL6OJSJ03uHsbxTz84Ya2Y90Tj9OdISE/12
         W74JJz0ZueWoz4z+dHjDiToz5eAOFy3ZqCr2D8H0oUlpNNjwrmTF+D8sxgVg5WwKuqlM
         XiLQ==
X-Gm-Message-State: AFeK/H2M4r7BcUwrcx87AzFWSH+NhOlhOB4Zr5T1Q7zfxqQP2/sI/St7ovH6Fw+DtDQG0h4j
X-Received: by 10.36.50.82 with SMTP id j79mr111949ita.118.1490308455689;
        Thu, 23 Mar 2017 15:34:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id u191sm19962ita.15.2017.03.23.15.34.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:34:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] submodule.c: port is_submodule_modified to use porcelain 2
Date:   Thu, 23 Mar 2017 15:33:34 -0700
Message-Id: <20170323223338.32274-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323223338.32274-1-sbeller@google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'is_submodule_modified' to the new porcelain format of
git-status. This conversion attempts to convert faithfully, i.e.
the behavior ought to be exactly the same.

As the output in the parsing only distinguishes between untracked files
and the rest, this is easy to port to the new format, as we only
need to identify untracked files and the rest is handled in the "else"
case.

untracked files are indicated by only a single question mark instead of
two question marks, so the conversion is easy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index c1b7b78260..da1db90dda 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1058,7 +1058,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);
 
-	argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
+	argv_array_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
 		argv_array_push(&cp.args, "-uno");
 
@@ -1068,10 +1068,11 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain' in submodule %s", path);
+		die("Could not run 'git status --porcelain=2' in submodule %s", path);
 
 	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
-		if ((buf.buf[0] == '?') && (buf.buf[1] == '?')) {
+		/* regular untracked files */
+		if (buf.buf[0] == '?') {
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
 				break;
@@ -1085,7 +1086,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain' failed in submodule %s", path);
+		die("'git status --porcelain=2' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.12.1.438.gb674c4c09c

