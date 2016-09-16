Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9570F2070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757372AbcIPAMl (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:41 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33041 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756935AbcIPAM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id n66so4509965qkf.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=JpplnE1Ge9/fgjXPbodSetO0pc2Yqe3HQL3ol0qF6zE=;
        b=XDqSg7bL1rnErlgzo2J76Fmydg2KdFFckURcxaEARY+OrW98SWJrtrkjUfVkVfwdO9
         B93ez7C8ltup9vAsXXSgJb8bVlbvYeFovVk+lx8Vx71Z84sTWfuslGeOBycLNoL41OYT
         AIZ9NNn7736NnKUdxX5ese2G23FNVWp+ghvS1uBjGndig/GY09l16BQpYeKHWrP+0SHs
         LyP+VFZPBeX6wDGmpHcW5VMgVbJNoIL2825Q4A3K2pKm06D/4VwCX5Jsgo3kdmMBSo5d
         BeRLbryu/7ymY27xxlvackzHscXXCZ+/2bZbUI783RBk55WzXyDRmmw497iGOEW4NLIn
         uUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=JpplnE1Ge9/fgjXPbodSetO0pc2Yqe3HQL3ol0qF6zE=;
        b=b8TMeeaZ6+qlfne5x8XMqQClSaOgTQDZ0GtLcQVG2S9lzlQhnHIJrP9yAuHGIxpmPN
         ACyEapgzsXK0qP4v8XuqpdBl+Z9oXUqadq9qQjVLwS524PsdmOt4GFTRA43zjYcwr0xE
         s6AqdzklygrzXycd9olFsOgUnoO68MdvsDo4ird6HenMEekQKWDZUpb1jaOA0I/utX8L
         nAYM3HRb0eLYlYLklx5Si/L0pYupWL4QBu1jp69qJSnO4nNnyQMFG1nEkPjgTniUGGNg
         KcgEkdaaPXCze14wuVabvBjWXi0ebue3Ft+yalWslDy9GOT6nCrhNiMKwuqVDmKG1OeM
         KWYA==
X-Gm-Message-State: AE9vXwOzccnNavfk8nFM2pRqO1pS7zMabXtNFfnKV+9QHinuf8UBSY1ZC5zyrjlBFYKUFg==
X-Received: by 10.55.33.24 with SMTP id h24mr13408262qkh.230.1473984748206;
        Thu, 15 Sep 2016 17:12:28 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:27 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 05/11] Resumable clone: add output parsing to connect.c
Date:   Thu, 15 Sep 2016 20:12:16 -0400
Message-Id: <1473984742-12516-6-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add method for transport to call when parsing primeclone output from
stdin. Suppress stderr when using git_connect with ssh, unless output
is verbose.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 connect.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 connect.h | 10 ++++++----
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 0478631..284de53 100644
--- a/connect.c
+++ b/connect.c
@@ -804,6 +804,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 		}
 		argv_array_push(&conn->args, cmd.buf);
 
+		if (flags & CONNECT_SUPPRESS_ERRORS) {
+			conn->no_stderr = 1;
+		}
+
 		if (start_command(conn))
 			die("unable to fork");
 
@@ -831,3 +835,46 @@ int finish_connect(struct child_process *conn)
 	free(conn);
 	return code;
 }
+
+const struct alt_resource *const get_alt_res_connect(int fd, int flags)
+{
+	struct alt_resource *res = NULL;
+	const char *line;
+	char *url = NULL, *filetype = NULL;
+	char *error_string = NULL;
+
+	while (line = packet_read_line_gentle(fd, NULL)) {
+		const char *space = strchr(line, ' ');
+
+		// We will eventually support multiple resources, so always
+		// parse the whole message
+		if ((filetype && url) || error_string) {
+			continue;
+		}
+		if (skip_prefix(line, "ERR ", &line) || !space ||
+				strchr(space + 1, ' ')) {
+			error_string = xstrdup(line);
+			continue;
+		}
+		filetype = xstrndup(line, (space - line));
+		url = xstrdup(space + 1);
+	}
+
+	if (filetype && url && !error_string){
+		res = xcalloc(1, sizeof(*res));
+		res->filetype = filetype;
+		res->url = url;
+	}
+	else {
+		if (!(flags & CONNECT_SUPPRESS_ERRORS)) {
+			if (error_string)
+				fprintf(stderr, "prime clone protocol error: "
+					"got '%s'\n", error_string);
+			else
+				fprintf(stderr, "did not get required "
+					"components for alternate resource\n");
+		}
+	}
+
+	return res;
+}
diff --git a/connect.h b/connect.h
index 01f14cd..966c0eb 100644
--- a/connect.h
+++ b/connect.h
@@ -1,10 +1,11 @@
 #ifndef CONNECT_H
 #define CONNECT_H
 
-#define CONNECT_VERBOSE       (1u << 0)
-#define CONNECT_DIAG_URL      (1u << 1)
-#define CONNECT_IPV4          (1u << 2)
-#define CONNECT_IPV6          (1u << 3)
+#define CONNECT_VERBOSE         (1u << 0)
+#define CONNECT_DIAG_URL        (1u << 1)
+#define CONNECT_IPV4            (1u << 2)
+#define CONNECT_IPV6            (1u << 3)
+#define CONNECT_SUPPRESS_ERRORS (1u << 4)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
@@ -12,5 +13,6 @@ extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
 extern int url_is_local_not_ssh(const char *url);
+const struct alt_resource *const get_alt_res_connect(int fd, int flags);
 
 #endif
-- 
2.7.4

