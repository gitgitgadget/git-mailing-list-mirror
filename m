Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EAFC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiBOP76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:59:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbiBOP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5720BDE4C
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h6so32894105wrb.9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WCRJGBzKu4QyjQLrcDwJxN00AqoRiU+DAZFB0l/UuiE=;
        b=AJK0Y3RAkaqr7U4LjaZFuqc0XmlDNZApJq6JlT3PCeYob53uE38SIQYSbc14qxY22d
         uagAo0W4Kox2s6V5uY6i2FOdtvwxGzypc3O4ZqA3+JlNHIY/2DVaxyGWd6hdxO8dNjgB
         OzzEst/IFr/OkZAOev7S4sdngHHVjUVS8KyLmFbYwQPhzpLplTCJaOP3k+aaXXc7GDKl
         zR+i7Cs3Xp/3GBCiC0YZrp06X65SclFdQGJKvO6UPqPAldHJRlt4InYukP6gKA+x289z
         WqI+wWBv+S6dA1lXlwXKDFMb0hqCTWAtVQdG0WPjMev/IzbZcgzLbgv3pOuiWjTqIfRK
         /Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WCRJGBzKu4QyjQLrcDwJxN00AqoRiU+DAZFB0l/UuiE=;
        b=YNMcIlBGBZYbvL8IDczrZF6gV1xDee45R0tSAPilom4a07cq6ecCpcwYkpaJhl1LCA
         4lBV7gcq5S+jCFo+5XnQW7v7FzqBWwMv9yLfFcxQWv+gm4YeZTUb6IfE8TwvrI0MLaL3
         g2TTXK1rWyGxtV5GW21f9DbIDe6XUIHaAIN1UwQ0SfUDdakQoSEI6/KAp/v+1a/Xl8oN
         lWdA6vYfMhnR+F7fiMc8Gg2SBcrn6F96UbcEA/uSbHY679l/0F5tySo85l/zZX5jmvj3
         YItkd6lRyZgux6IiK+biy2ceXHLbK5ZAGXSBoifg5OG9YL/Zy5LKsvEEhdLzy3K/ocX9
         NBMA==
X-Gm-Message-State: AOAM531wb3IyF18E0bvU3Qxwd41yDHBCBGmWpKlVVIOATEjpQRhe5x5R
        +d0FQAEwTHgc/vY2woV4TKtgT+bMJvI=
X-Google-Smtp-Source: ABdhPJxe5yC5R5mHlX+Q+uHYRkhZWMgqTtzrbE6Cwif1kJezhIOheIcuNMh+me6LarxjeSZNnYOzaw==
X-Received: by 2002:adf:eed0:: with SMTP id a16mr3710084wrp.163.1644940780014;
        Tue, 15 Feb 2022 07:59:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm9688160wms.4.2022.02.15.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:39 -0800 (PST)
Message-Id: <9efdbe28223e371dc22b4ba32fc791729af5577a.1644940773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:14 +0000
Subject: [PATCH 04/23] t/helper/fsmonitor-client: create stress test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a stress test to hammer on the fsmonitor daemon.
Create a client-side thread pool of n threads and have
each of them make m requests as fast as they can.

NEEDSWORK: This is just the client-side thread pool and
is useful for interactive testing and experimentation.
We need to add a script test to drive this.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-fsmonitor-client.c | 105 +++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index f7a5b3a32fa..9dd2f9af553 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -7,6 +7,8 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
+#include "thread-utils.h"
+#include "trace2.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
 int cmd__fsmonitor_client(int argc, const char **argv)
@@ -79,20 +81,120 @@ static int do_send_flush(void)
 	return 0;
 }
 
+struct hammer_thread_data
+{
+	pthread_t pthread_id;
+	int thread_nr;
+
+	int nr_requests;
+	const char *token;
+
+	int sum_successful;
+	int sum_errors;
+};
+
+static void *hammer_thread_proc(void *_hammer_thread_data)
+{
+	struct hammer_thread_data *data = _hammer_thread_data;
+	struct strbuf answer = STRBUF_INIT;
+	int k;
+	int ret;
+
+	trace2_thread_start("hammer");
+
+	for (k = 0; k < data->nr_requests; k++) {
+		strbuf_reset(&answer);
+
+		ret = fsmonitor_ipc__send_query(data->token, &answer);
+		if (ret < 0)
+			data->sum_errors++;
+		else
+			data->sum_successful++;
+	}
+
+	strbuf_release(&answer);
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Start a pool of client threads that will each send a series of
+ * commands to the daemon.
+ *
+ * The goal is to overload the daemon with a sustained series of
+ * concurrent requests.
+ */
+static int do_hammer(const char *token, int nr_threads, int nr_requests)
+{
+	struct hammer_thread_data *data = NULL;
+	int k;
+	int sum_join_errors = 0;
+	int sum_commands = 0;
+	int sum_errors = 0;
+
+	if (!token || !*token)
+		token = get_token_from_index();
+	if (nr_threads < 1)
+		nr_threads = 1;
+	if (nr_requests < 1)
+		nr_requests = 1;
+
+	CALLOC_ARRAY(data, nr_threads);
+
+	for (k = 0; k < nr_threads; k++) {
+		struct hammer_thread_data *p = &data[k];
+		p->thread_nr = k;
+		p->nr_requests = nr_requests;
+		p->token = token;
+
+		if (pthread_create(&p->pthread_id, NULL, hammer_thread_proc, p)) {
+			warning("failed to create thread[%d] skipping remainder", k);
+			nr_threads = k;
+			break;
+		}
+	}
+
+	for (k = 0; k < nr_threads; k++) {
+		struct hammer_thread_data *p = &data[k];
+
+		if (pthread_join(p->pthread_id, NULL))
+			sum_join_errors++;
+		sum_commands += p->sum_successful;
+		sum_errors += p->sum_errors;
+	}
+
+	fprintf(stderr, "HAMMER: [threads %d][requests %d] [ok %d][err %d][join %d]\n",
+		nr_threads, nr_requests, sum_commands, sum_errors, sum_join_errors);
+
+	free(data);
+
+	/*
+	 * TODO Decide if/when to return an error or call die().
+	 */
+	return 0;
+}
+
 int cmd__fsmonitor_client(int argc, const char **argv)
 {
 	const char *subcmd;
 	const char *token = NULL;
+	int nr_threads = 1;
+	int nr_requests = 1;
 
 	const char * const fsmonitor_client_usage[] = {
 		N_("test-helper fsmonitor-client query [<token>]"),
 		N_("test-helper fsmonitor-client flush"),
+		N_("test-helper fsmonitor-client hammer [<token>] [<threads>] [<requests>]"),
 		NULL,
 	};
 
 	struct option options[] = {
 		OPT_STRING(0, "token", &token, N_("token"),
 			   N_("command token to send to the server")),
+
+		OPT_INTEGER(0, "threads", &nr_threads, N_("number of client threads")),
+		OPT_INTEGER(0, "requests", &nr_requests, N_("number of requests per thread")),
+
 		OPT_END()
 	};
 
@@ -116,6 +218,9 @@ int cmd__fsmonitor_client(int argc, const char **argv)
 	if (!strcmp(subcmd, "flush"))
 		return !!do_send_flush();
 
+	if (!strcmp(subcmd, "hammer"))
+		return !!do_hammer(token, nr_threads, nr_requests);
+
 	die("Unhandled subcommand: '%s'", subcmd);
 }
 #endif
-- 
gitgitgadget

