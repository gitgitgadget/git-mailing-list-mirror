Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131B41F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJCEpp (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 00:45:45 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34465 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJCEpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 00:45:45 -0400
Received: by mail-qt1-f201.google.com with SMTP id e88-v6so3324411qtb.1
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tWxUnUYH1vf0kscHx889/2zPiN/bFbjwF6U1p6IRzFU=;
        b=SL7pl2cH0MloJAoGvfj+J/jFlTaHtIcCo1nFLXagzppscY43YIkxx964QxZD1HxvGf
         pxVGQmFMjk6EHM/Q4MyGBq9zi0Y6oWQ2XUPL+t5cVVM4Gs+qs6lhZmyb2VnJDos2xkzI
         dt53fHMoP97J3Zs0TqnbLa1lNzfLkZaHVyiSHTsV2dXHs/eLG4LBYrkOFMkyrzOmWxWZ
         yNhIMXFG/0WzmKoPfzJ+3P4WTpT+GJAV+6m6EK0mq18HvTqrSmViW3c7SvolFjfTSuMi
         /1SZXu8R/6WRPcAD9rmslGlDDILjaxIaUq32bruhm3knt+UlSkT0pw9U66h4mlfhEMcL
         rj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tWxUnUYH1vf0kscHx889/2zPiN/bFbjwF6U1p6IRzFU=;
        b=hnkHnVLiMCmM7uNEXLaVPqo0g51Foyg7BjFFK8GnGFxh36EEfOkVLg+abE2Z+D/jlP
         Bu3Md1BJz2g19Y/DXEOml0FYk9Tdel77rdW3ZBDV9uzMb383Aer7RLDF9xg7PCqQLhb2
         d93m+soAmLAWAfmA9dSecwSs2LkfkdKp6NYetmQPvpIGMmBbPVN+aso6TN1Asxm3W4vh
         R9tEarFABItLBN9AYQJGkY8qulYFYl7qLLpEQi+cB7M8cbRistFZdwLSZVQvx+e8DT/N
         ITL9IesWChz//CQbLsZZC30IIuEsxRwNeZGbIwGyCp9OSvGXThjrT3+IpkU85bFc7dkQ
         8x+Q==
X-Gm-Message-State: ABuFfoh6l7tp4VW9S6++YPAkMwtOoCgdRKUa0op7kyrxDhpyzLcPx7ej
        d0iuj8aksf4rdkoDFja+L2vNbkiJIpmdNRtk0Rd8hg+oc0+HQicWSUTIKgGXIzWyDzU1ZWXcPC7
        s7Ypi4Jlq0seJcKhHnbTBoUWIn42w/gLoQ2sC09l2HKddDJycmZcA0dRKSyYKRBg=
X-Google-Smtp-Source: ACcGV63SmVie55lES7CmqCwR+RvU/rU8JwApq4I+1MiJYKkiONZTgjlvhJRJ6hhXSd68gwh4jkpQ8MiRHOCAAg==
X-Received: by 2002:ac8:3839:: with SMTP id q54-v6mr13817919qtb.12.1538517615705;
 Tue, 02 Oct 2018 15:00:15 -0700 (PDT)
Date:   Tue,  2 Oct 2018 14:59:51 -0700
In-Reply-To: <cover.1538516853.git.steadmon@google.com>
Message-Id: <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 1/1] protocol: limit max protocol version per service
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For services other than git-receive-pack, clients currently advertise
that they support the version set in the protocol.version config,
regardless of whether or not there is actually an implementation of that
service for the given protocol version. This causes backwards-
compatibility problems when a new implementation for the given
protocol version is added.

This patch sets maximum allowed protocol versions for git-receive-pack,
git-upload-archive, and git-upload-pack.

Previously, git-receive-pack would downgrade from v2 to v0, but would
allow v1 if set in protocol.version. Now, it will downgrade from v2 to
v1.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 connect.c     | 11 ++++-------
 protocol.c    | 13 +++++++++++++
 protocol.h    |  7 +++++++
 remote-curl.c | 11 ++++-------
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/connect.c b/connect.c
index 94547e5056..4a8cd78239 100644
--- a/connect.c
+++ b/connect.c
@@ -1228,14 +1228,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 	struct child_process *conn;
 	enum protocol protocol;
 	enum protocol_version version = get_protocol_version_config();
+	enum protocol_version max_version;
 
-	/*
-	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
-	 * to perform a push, then fallback to v0 since the client doesn't know
-	 * how to push yet using v2.
-	 */
-	if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
-		version = protocol_v0;
+	max_version = determine_maximum_protocol_version(prog, version);
+	if (version > max_version)
+		version = max_version;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
diff --git a/protocol.c b/protocol.c
index 5e636785d1..1c553d8b99 100644
--- a/protocol.c
+++ b/protocol.c
@@ -79,3 +79,16 @@ enum protocol_version determine_protocol_version_client(const char *server_respo
 
 	return version;
 }
+
+enum protocol_version determine_maximum_protocol_version(
+		const char *service, enum protocol_version default_version)
+{
+	if (!strcmp(service, "git-receive-pack"))
+		return protocol_v1;
+	else if (!strcmp(service, "git-upload-archive"))
+		return protocol_v1;
+	else if (!strcmp(service, "git-upload-pack"))
+		return protocol_v2;
+
+	return default_version;
+}
diff --git a/protocol.h b/protocol.h
index 2ad35e433c..eabc0c5fab 100644
--- a/protocol.h
+++ b/protocol.h
@@ -31,4 +31,11 @@ extern enum protocol_version determine_protocol_version_server(void);
  */
 extern enum protocol_version determine_protocol_version_client(const char *server_response);
 
+/*
+ * Used by a client to determine the maximum protocol version to advertise for a
+ * particular service. If the service is unrecognized, return default_version.
+ */
+extern enum protocol_version determine_maximum_protocol_version(
+		const char *service, enum protocol_version default_version);
+
 #endif /* PROTOCOL_H */
diff --git a/remote-curl.c b/remote-curl.c
index fb28309e85..028adb76ae 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -344,6 +344,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	int http_ret, maybe_smart = 0;
 	struct http_get_options http_options;
 	enum protocol_version version = get_protocol_version_config();
+	enum protocol_version max_version;
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -360,13 +361,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
-	/*
-	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
-	 * to perform a push, then fallback to v0 since the client doesn't know
-	 * how to push yet using v2.
-	 */
-	if (version == protocol_v2 && !strcmp("git-receive-pack", service))
-		version = protocol_v0;
+	max_version = determine_maximum_protocol_version(service, version);
+	if (version > max_version)
+		version = max_version;
 
 	/* Add the extra Git-Protocol header */
 	if (get_protocol_http_header(version, &protocol_header))
-- 
2.19.0.605.g01d371f741-goog

