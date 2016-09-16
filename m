Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66093207E6
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757407AbcIPAMt (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:49 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34388 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757069AbcIPAMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:31 -0400
Received: by mail-qk0-f195.google.com with SMTP id b204so4477878qkc.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=NZsn9nVoc99E/YMFlQepkPQERt8hIt0zGwXTmKFefek=;
        b=iLM/CyEHDUX8NWnL+T13c2eReGPxb9FzBCcus36q43O9MIdZTO6t8r6pb8sJ0yMuGi
         eNmnS9jopME548NM0+0twCoYzyMPwLEnSj7S7wpNu9x68xdvkvm8vDiXuxus4Cr4N/Uf
         r4B7WKd7g5eOAs5yn8JJZHeB/UFHWQe1omwImLeVUV1UMGHJoKy16eg7n3wBbiJrTKqA
         5kcthytU2Y74rx08WeyPUfhNq0J7E2vA39tKI8xZ1pjku9Vk0hM8IqTn7yQUkPl1+Hhv
         LKL1XKdwU1+lN6kVzjGJatbxk+Xj/vGEI+BsffxBOxljs6RFVI+N/OMBSMuMRIYr0ZP2
         91MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=NZsn9nVoc99E/YMFlQepkPQERt8hIt0zGwXTmKFefek=;
        b=K5/iZnvRV4+YHtbfi2s7nSSWqwDJvYbHn7+5sWQiHpK4pNTzgLZO4zntp9OgOuJnpy
         yeoezTFUbGKJTjs92qiBxwKl8PUIW97Xwt7bXthN+z6ZkWUZUc4n9Hui/GBKTZsukaiT
         ZMjR4oiXkP8X4ACEO+kDLtUC2lfO5m+I05DMpu9ZTBGWUs1DZsRtzUSLbVkp5yyj3jMW
         x3jc8cTMQNvcQTMOCRtxQjgCu7ZuRAZELjPJ1Y7fdXSPewYtggcgPsFuOEMtlnkPEyPF
         TopUGtVEebGU+STIZR54OvmkKmcVD5HtTS8K59F194e7RuI4bTVZMKSN3T94yHnUjjE5
         nC1g==
X-Gm-Message-State: AE9vXwNoc6b4B1DtOMYRby1HMU5YCONq1ZhyjaiFtg/9xhs08pFtEd5oUOxGTUk6OwUiRg==
X-Received: by 10.55.107.193 with SMTP id g184mr12943926qkc.145.1473984750590;
        Thu, 15 Sep 2016 17:12:30 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:30 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 08/11] Resumable clone: create transport_download_primer
Date:   Thu, 15 Sep 2016 20:12:19 -0400
Message-Id: <1473984742-12516-9-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create function transport_download_primer and components
to invoke and pass commands to remote-curl.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 transport-helper.c | 24 ++++++++++++++++++++++++
 transport.c        |  9 +++++++++
 transport.h        |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index eb185d5..2ff96ef 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -29,6 +29,7 @@ struct helper_data {
 		check_connectivity : 1,
 		no_disconnect_req : 1,
 		no_private_update : 1,
+		download_primer : 1,
 		prime_clone : 1;
 	char *export_marks;
 	char *import_marks;
@@ -183,6 +184,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->check_connectivity = 1;
 		else if (!strcmp(capname, "prime-clone"))
 			data->prime_clone = 1;
+		else if (!strcmp(capname, "download-primer"))
+			data->download_primer = 1;
 		else if (!data->refspecs && skip_prefix(capname, "refspec ", &arg)) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
@@ -1058,6 +1061,26 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	return ret;
 }
 
+static const char *download_primer(struct transport *transport,
+				   const struct alt_resource *res,
+				   const char *base_path)
+{
+	struct helper_data *data = transport->data;
+	struct child_process *helper;
+	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
+	char *ret = NULL;
+
+	helper = get_helper(transport);
+
+	strbuf_addf(&buf, "download-primer %s %s\n", res->url, base_path);
+	sendline(data, &buf);
+	recvline(data, &out);
+	strbuf_release(&buf);
+	if (out.len > 0)
+		ret = strbuf_detach(&out, NULL);
+	return ret;
+}
+
 static const struct alt_resource *const get_alt_res_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -1115,6 +1138,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->data = data;
 	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
+	transport->download_primer = download_primer;
 	transport->prime_clone = get_alt_res_helper;
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
diff --git a/transport.c b/transport.c
index dd0d839..3b33029 100644
--- a/transport.c
+++ b/transport.c
@@ -572,6 +572,15 @@ const struct alt_resource *const transport_prime_clone(struct transport *transpo
 	return transport->alt_res;
 }
 
+const char *transport_download_primer(struct transport *transport,
+				      const struct alt_resource *alt_res,
+				      const char *base_dir)
+{
+	if (transport->download_primer)
+		return transport->download_primer(transport, alt_res, base_dir);
+	return NULL;
+}
+
 static int connect_git(struct transport *transport, const char *name,
 		       const char *executable, int fd[2])
 {
diff --git a/transport.h b/transport.h
index 2bb6963..1484d6d 100644
--- a/transport.h
+++ b/transport.h
@@ -83,6 +83,10 @@ struct transport {
 	 **/
 	const struct alt_resource *const (*prime_clone)(struct transport *transport);
 
+	const char *(*download_primer)(struct transport *transport,
+			const struct alt_resource *alt_res,
+			const char *base_path);
+
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
@@ -228,6 +232,9 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 const struct alt_resource *const transport_prime_clone(struct transport *transport);
+const char *transport_download_primer(struct transport *transport,
+		const struct alt_resource *alt_res,
+		const char *base_path);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
-- 
2.7.4

