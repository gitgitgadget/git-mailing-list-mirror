Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB7EC433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347150AbiDRR3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347091AbiDRR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86827340F5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c10so19325562wrb.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lW/xBHIRoqM3FIeh6KmZoqZfmfip3gF4Lmesi65LyjE=;
        b=A37a7SSHwxEC47y2FtyBFqjUx/kmy/ILHYLa0it8rZMartA9uyYlTQO+zC4FhddzsU
         kAcQZBJohrncHQnTbg7k0TuCljIPDCvK78ybUs4Ia/6jewq2w8iNcF7AE3Q/ohZS8qM9
         vkBnEl33GcZ7TCPlcogknm8p8xyeKV+7PsWRxkYeeewVkbVhjxOox+0LlZYKb8oU7I+u
         iMsU2BKrjgDNcpVG2h6vazp6+X1ri/5p7aaBSt4wfbZhpB/RLPysLHVKIdA+4qtkHUBw
         FiMQq8c8EFNlDrysiBl9Yr6ETLUHjkn0dbPFwxwDF6HeYf38bOaCruxvuWNwWDhEuknU
         XL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW/xBHIRoqM3FIeh6KmZoqZfmfip3gF4Lmesi65LyjE=;
        b=Z+CG1dQdq8tGjrNnZR2ieogfb6hiMKZfAL1NqT7DkM88jklYvhHZItqq0+2wV0rgXo
         M5UF/bwRz+viBnxz4loBypYsdOEfJ1Bcqorg0CmPfKzHXHTWzmnu0NH2GG5NskxLJUrz
         99L6mzsKVbuJip2nMmmweq9awdFUHUTqdtxEpF41HNxU1IAbp2OChDXcbIzEk/o8u8LZ
         UDfQ+I4sPKkfyctzlnP5CYo5fSyXi3ji/h7r2LBWvLI0sko9vIygzGmsnEqL/w5GT4Uq
         OU21oAI710NgBJg1viwk52f6TiNVRSO8pUOn4NCgh3OeX/USGT5Vu2qWt0PrcsNSM9Aw
         lsHA==
X-Gm-Message-State: AOAM530keboMcYv2fj16Jcej27Qn5j4Zj00nmKmVOtK+UgBEva1VWIB8
        A0HZeW8Ab8W8daZlnWbAFjpQKzPMholWkQ==
X-Google-Smtp-Source: ABdhPJzZw8Jo0B1hiMv06T55rgV7+P3T22Z0tq6mA6ug+ZVh8oVNy9zVkOPquJZxIAKpuUmFPGlJKg==
X-Received: by 2002:a05:6000:1acf:b0:20a:9c20:c769 with SMTP id i15-20020a0560001acf00b0020a9c20c769mr3160282wry.467.1650302671818;
        Mon, 18 Apr 2022 10:24:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 31/36] transport: add connections for 'features' capability
Date:   Mon, 18 Apr 2022 19:23:48 +0200
Message-Id: <RFC-patch-v2-31.36-6611dd08f93-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

To allow 'git clone' to check the 'features' capability, we need to fill
in some boilerplate methods that help detect if the capability exists
and then to execute the get_recommended_features() method with the
proper context. This involves jumping through some vtables.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 transport-helper.c   | 13 +++++++++++++
 transport-internal.h |  9 +++++++++
 transport.c          | 38 ++++++++++++++++++++++++++++++++++++++
 transport.h          |  5 +++++
 4 files changed, 65 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 398712c76f3..782aa1f43a2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1160,6 +1160,18 @@ static int push_refs(struct transport *transport,
 	return -1;
 }
 
+static int get_features(struct transport *transport,
+		      struct string_list *list)
+{
+	get_helper(transport);
+
+	if (process_connect(transport, 0)) {
+		do_take_over(transport);
+		return transport->vtable->get_features(transport, list);
+	}
+
+	return -1;
+}
 
 static int has_attribute(const char *attrs, const char *attr)
 {
@@ -1285,6 +1297,7 @@ static struct transport_vtable vtable = {
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs,
 	.push_refs	= push_refs,
+	.get_features	= get_features,
 	.connect	= connect_helper,
 	.disconnect	= release_helper
 };
diff --git a/transport-internal.h b/transport-internal.h
index 90ea749e5cf..969cb30f510 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -5,6 +5,7 @@ struct ref;
 struct transport;
 struct strvec;
 struct transport_ls_refs_options;
+struct string_list;
 
 struct transport_vtable {
 	/**
@@ -58,6 +59,14 @@ struct transport_vtable {
 	 * process involved generating new commits.
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
+
+	/**
+	 * get_features() requests a list of recommended features and
+	 * populates the given string_list with those 'key=value' pairs.
+	 */
+	int (*get_features)(struct transport *transport,
+			    struct string_list *list);
+
 	int (*connect)(struct transport *connection, const char *name,
 		       const char *executable, int fd[2]);
 
diff --git a/transport.c b/transport.c
index 7e5e1192f95..42a726dc066 100644
--- a/transport.c
+++ b/transport.c
@@ -205,6 +205,20 @@ struct git_transport_data {
 	struct oid_array shallow;
 };
 
+static int get_features(struct transport *transport,
+		      struct string_list *list)
+{
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	return get_recommended_features(data->fd[1], &reader, list,
+					transport->stateless_rpc);
+}
+
 static int set_git_option(struct git_transport_options *opts,
 			  const char *name, const char *value)
 {
@@ -948,6 +962,7 @@ static struct transport_vtable taken_over_vtable = {
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
+	.get_features	= get_features,
 	.disconnect	= disconnect_git
 };
 
@@ -1102,6 +1117,7 @@ static struct transport_vtable builtin_smart_vtable = {
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
+	.get_features	= get_features,
 	.connect	= connect_git,
 	.disconnect	= disconnect_git
 };
@@ -1606,6 +1622,28 @@ void transport_unlock_pack(struct transport *transport, unsigned int flags)
 		string_list_clear(&transport->pack_lockfiles, 0);
 }
 
+struct string_list *transport_remote_features(struct transport *transport)
+{
+	const struct transport_vtable *vtable = transport->vtable;
+	struct string_list *list = NULL;
+
+	if (!server_supports_v2("features", 0))
+		return NULL;
+
+	if (!vtable->get_features) {
+		warning(_("'features' not supported by this remote"));
+		return NULL;
+	}
+
+	CALLOC_ARRAY(list, 1);
+	string_list_init_dup(list);
+
+	if (vtable->get_features(transport, list))
+		warning(_("failed to get recommended features from remote"));
+
+	return list;
+}
+
 int transport_connect(struct transport *transport, const char *name,
 		      const char *exec, int fd[2])
 {
diff --git a/transport.h b/transport.h
index ed5ebcf1466..7afc02eb683 100644
--- a/transport.h
+++ b/transport.h
@@ -322,6 +322,11 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs);
  */
 void transport_unlock_pack(struct transport *transport, unsigned int flags);
 
+/**
+ * Get recommended config from remote.
+ */
+struct string_list *transport_remote_features(struct transport *transport);
+
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
-- 
2.36.0.rc2.902.g60576bbc845

