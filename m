Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3096C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiHVPTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiHVPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:18:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90025EB1
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:12:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e20so13124101wri.13
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=u0Y8DjsXF55pkSXQYNbfM7bdS8cdkF52DVnNTamF++M=;
        b=AsEbnapN7FmYjyFGOFutPbFLsiLQIeQiDDklWImn2ulLVz0KdQmNpNzLa+kX9eXOb2
         sa5Ygf5fzXTfXF0b4F/PAm+Tvomz9D4WQCmpxrgesqJqut9pgHdqZcHVSaigikNKVrIr
         2+28uv20PAxAOw9lJwR120XMjV4k6bscfhLWujVwBZ9TMUEUsF3C4gEeJegD8Z/c/wxX
         zPu46RnokZJcoja0pb1S83dg0VKNTm+jhW3qziIiA5bezFNMRDfxnIr1EpNJYnNURATI
         qGOtYeH89fihRVFIiw52s48zVBTjMhwHqvcoc3ZaK4jC2wZxa7qUt8iNz3EVKStsXb9f
         qcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=u0Y8DjsXF55pkSXQYNbfM7bdS8cdkF52DVnNTamF++M=;
        b=iYDEZtMzILKk8YwyDhZldBTappKIo3iT3db0TbDxoOFv3W0PYR3DPmtb19Hu7wYOiZ
         TsetsCG7+R594CllbizzMSHxLhAeJlcKKm5HHDKh4TIr4doNtUsbsKhwvVm+MD7LiXwc
         5VYdSG8hwm93QXk+NaPT1pRB8QFCo6+PEFsXbNi0KJXM1owKgtQBjXOiRQdrZxlbpmAl
         d0odNZM9cJcxxQgwRFDeuwrXd6AVO/OLyEy3ESnvieeNhsnOOw3ETzmNiECrXgRtMu8q
         tVSyn5CML4beASbSerSrcp5q4sNOGSYF4tQ2qA+8aywhwgoYezkCCevIIkjhOEokyNSV
         dOlw==
X-Gm-Message-State: ACgBeo3LCwIYbdzJ6bSTLP/zSakwziZZS0uCj9Of4Y4Es8H/AW8I8Nk9
        rJGxnNhlH7IByQRKBItJNJKxS2pSP9U=
X-Google-Smtp-Source: AA6agR5tRZNjhaobV4EeFQ+dheVg6/0OCFnd7zoDv+SwZPSOCYwDXmF5GsRw2HuXjIgOyPOUgzoRNw==
X-Received: by 2002:adf:fc05:0:b0:225:272b:76b4 with SMTP id i5-20020adffc05000000b00225272b76b4mr10810379wrr.162.1661181176950;
        Mon, 22 Aug 2022 08:12:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c2ca300b003a5ea1cc63csm18652832wmc.39.2022.08.22.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:12:56 -0700 (PDT)
Message-Id: <c39438886586f30b020e8ac473c7facaa757f822.1661181174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:48 +0000
Subject: [PATCH 1/7] bundle-uri: create bundle_list struct and helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It will likely be rare where a user uses a single bundle URI and expects
that URI to point to a bundle. Instead, that URI will likely be a list
of bundles provided in some format. Alternatively, the Git server could
advertise a list of bundles.

In anticipation of these two ways of advertising multiple bundles,
create a data structure that represents such a list. This will be
populated using a common API, but for now focus on what data can be
represented.

Each list contains a number of remote_bundle_info structs. These contain
an 'id' that is used to uniquely identify them in the list, and also a
'uri' that contains the location of its data. Finally, there is a strbuf
containing the filename used when Git downloads the contents to disk.

The list itself stores these remote_bundle_info structs in a hashtable
using 'id' as the key. The order of the structs in the input is
considered unimportant, but future modifications to the format and these
data structures will place ordering possibilities on the set. The list
also has a few "global" properties, including the version (used when
parsing the list) and the mode. The mode is one of these two options:

1. BUNDLE_MODE_ALL: all listed URIs are intended to be combined
   together. The client should download all of the advertised data to
   have a complete copy of the data.

2. BUNDLE_MODE_ANY: any one listed item is sufficient to have a complete
   copy of the data. The client can choose arbitrarily from these
   options. In the future, the client may use pings to find the closest
   URI among geodistributed replicas, or use some other heuristic
   information added to the format.

This API is currently unused, but will soon be expanded with parsing
logic and then be consumed by the bundle URI download logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 bundle-uri.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4a8cc74ed05..ceeef0b6641 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -4,6 +4,67 @@
 #include "object-store.h"
 #include "refs.h"
 #include "run-command.h"
+#include "hashmap.h"
+#include "pkt-line.h"
+
+static int compare_bundles(const void *hashmap_cmp_fn_data,
+			   const struct hashmap_entry *he1,
+			   const struct hashmap_entry *he2,
+			   const void *id)
+{
+	const struct remote_bundle_info *e1 =
+		container_of(he1, const struct remote_bundle_info, ent);
+	const struct remote_bundle_info *e2 =
+		container_of(he2, const struct remote_bundle_info, ent);
+
+	return strcmp(e1->id, id ? (const char *)id : e2->id);
+}
+
+void init_bundle_list(struct bundle_list *list)
+{
+	memset(list, 0, sizeof(*list));
+
+	/* Implied defaults. */
+	list->mode = BUNDLE_MODE_ALL;
+	list->version = 1;
+
+	hashmap_init(&list->bundles, compare_bundles, NULL, 0);
+}
+
+static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
+				    void *data)
+{
+	free(bundle->id);
+	free(bundle->uri);
+	strbuf_release(&bundle->file);
+	return 0;
+}
+
+void clear_bundle_list(struct bundle_list *list)
+{
+	if (!list)
+		return;
+
+	for_all_bundles_in_list(list, clear_remote_bundle_info, NULL);
+	hashmap_clear_and_free(&list->bundles, struct remote_bundle_info, ent);
+}
+
+int for_all_bundles_in_list(struct bundle_list *list,
+			    bundle_iterator iter,
+			    void *data)
+{
+	struct remote_bundle_info *info;
+	struct hashmap_iter i;
+
+	hashmap_for_each_entry(&list->bundles, &i, info, ent) {
+		int result = iter(info, data);
+
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
 
 static int find_temp_filename(struct strbuf *name)
 {
diff --git a/bundle-uri.h b/bundle-uri.h
index 8a152f1ef14..6692aa4b170 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -1,7 +1,72 @@
 #ifndef BUNDLE_URI_H
 #define BUNDLE_URI_H
 
+#include "hashmap.h"
+#include "strbuf.h"
+
 struct repository;
+struct string_list;
+
+/**
+ * The remote_bundle_info struct contains information for a single bundle
+ * URI. This may be initialized simply by a given URI or might have
+ * additional metadata associated with it if the bundle was advertised by
+ * a bundle list.
+ */
+struct remote_bundle_info {
+	struct hashmap_entry ent;
+
+	/**
+	 * The 'id' is a name given to the bundle for reference
+	 * by other bundle infos.
+	 */
+	char *id;
+
+	/**
+	 * The 'uri' is the location of the remote bundle so
+	 * it can be downloaded on-demand. This will be NULL
+	 * if there was no table of contents.
+	 */
+	char *uri;
+
+	/**
+	 * If the bundle has been downloaded, then 'file' is a
+	 * filename storing its contents. Otherwise, 'file' is
+	 * an empty string.
+	 */
+	struct strbuf file;
+};
+
+#define REMOTE_BUNDLE_INFO_INIT { \
+	.file = STRBUF_INIT, \
+}
+
+enum bundle_list_mode {
+	BUNDLE_MODE_NONE = 0,
+	BUNDLE_MODE_ALL,
+	BUNDLE_MODE_ANY
+};
+
+/**
+ * A bundle_list contains an unordered set of remote_bundle_info structs,
+ * as well as information about the bundle listing, such as version and
+ * mode.
+ */
+struct bundle_list {
+	int version;
+	enum bundle_list_mode mode;
+	struct hashmap bundles;
+};
+
+void init_bundle_list(struct bundle_list *list);
+void clear_bundle_list(struct bundle_list *list);
+
+typedef int (*bundle_iterator)(struct remote_bundle_info *bundle,
+			       void *data);
+
+int for_all_bundles_in_list(struct bundle_list *list,
+			    bundle_iterator iter,
+			    void *data);
 
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
-- 
gitgitgadget

