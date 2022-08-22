Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D1C32772
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiHVPTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiHVPS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:18:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165D474C6
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n7so13614605wrv.4
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Jkq6eDc+Te2e/roIjoOrp6lP8qYnEDriqAN3FZDewMk=;
        b=PVF73aWmFKB8bHwYV3Z5O/exKs9+8o3nf8oxo3ckFm5gy122uNDvB46PMuT6VYEUaF
         FX9lByhC0AmODH0bWZ1fH23uaAFROa9mgy0F3AAvwRWQ70DHl307HHbdKzGyh4Mj/O0C
         rp6P3G/QTW++S0RQaZD3sBTqx6JCvsXvbM7SMfKpcb1513RyM7DQBcXgoQjev8nymtmz
         o39oiRtsUGzPSb2HCAB1OLJ7+VrKVB56cod9oVi6Kd+nGHhMCjeziTYn5H74mpRGC6sp
         qiihveq2cXMsMGrYnLtz/Wmiw3GlVTWXPYcOZh1jKw/bDxCbd51AoIxWbb/Bt9/s1cYS
         9rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Jkq6eDc+Te2e/roIjoOrp6lP8qYnEDriqAN3FZDewMk=;
        b=JqRIoJx9dNjGbeuUeyc1LihVlQM3oPa8QfZm+YyPiO+AYCMOz6sksuV90HbF4hSeIZ
         8a1ETbyT+iAo9YTkpw4z24+/wI236muHaqgjyODVDUEiGQJnDWntHG17ZAMmUeX7pohT
         hlC20inJgJuGvXe9JBIpeOMPhRpICbeD3E22mw8T2SVaeD3PxJC60tjyPtJ+OogdXXVY
         eSjBXLBPbJvqQuQCoQc6VGcQA8G3GGculAZOHi+2b3pSErdmBmh8djg87BSx3MFs3dg4
         6j5iiMNaFmZxjGCDmLhtEgNtoG2Rwe7Ytw2isxAOY0H2RffNd9BLpX3NEG1PBsFRp5Yv
         PGRg==
X-Gm-Message-State: ACgBeo1otC+QXi9zPVRNunMcasP0BREboFv2iUPKCFBjAsguKjWsMmVb
        J9uJiSXDKDOwJG9vD68YOP4uDhITA/U=
X-Google-Smtp-Source: AA6agR4iVbnYr4ioHBkL28E861ohddCtRvntVPwTp7LHsXT+/6xgFDg7QO+2eK0T2qlfMniuRx/ZyA==
X-Received: by 2002:a05:6000:a05:b0:225:6149:20cc with SMTP id co5-20020a0560000a0500b00225614920ccmr1438389wrb.681.1661181177871;
        Mon, 22 Aug 2022 08:12:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj5-20020a0560001e0500b002206203ed3dsm12498505wrb.29.2022.08.22.08.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:12:57 -0700 (PDT)
Message-Id: <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:49 +0000
Subject: [PATCH 2/7] bundle-uri: create base key-value pair parsing
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

There will be two primary ways to advertise a bundle list: as a list of
packet lines in Git's protocol v2 and as a config file served from a
bundle URI. Both of these fundamentally use a list of key-value pairs.
We will use the same set of key-value pairs across these formats.

Create a new bundle_list_update() method that is currently unusued, but
will be used in the next change. It inspects each key to see if it is
understood and then applies it to the given bundle_list. Here are the
keys that we teach Git to understand:

* bundle.version: This value should be an integer. Git currently
  understands only version 1 and will ignore the list if the version is
  any other value. This version can be increased in the future if we
  need to add new keys that Git should not ignore. We can add new
  "heuristic" keys without incrementing the version.

* bundle.mode: This value should be one of "all" or "any". If this
  mode is not understood, then Git will ignore the list. This mode
  indicates whether Git needs all of the bundle list items to make a
  complete view of the content or if any single item is sufficient.

The rest of the keys use a bundle identifier "<id>" as part of the key
name. Keys using the same "<id>" describe a single bundle list item.

* bundle.<id>.uri: This stores the URI of the bundle item. This
  currently is expected to be an absolute URI, but will be relaxed to be
  a relative URI in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config.txt        |  2 +
 Documentation/config/bundle.txt | 22 ++++++++++
 bundle-uri.c                    | 74 +++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 Documentation/config/bundle.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e376d547ce0..4280af6992e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -387,6 +387,8 @@ include::config/branch.txt[]
 
 include::config/browser.txt[]
 
+include::config/bundle.txt[]
+
 include::config/checkout.txt[]
 
 include::config/clean.txt[]
diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.txt
new file mode 100644
index 00000000000..3515bfe38d1
--- /dev/null
+++ b/Documentation/config/bundle.txt
@@ -0,0 +1,22 @@
+bundle.*::
+	The `bundle.*` keys are used when communicating a list of bundle URIs
+	See link:technical/bundle-uri.html[the bundle URI design document] for
+	more details.
+
+bundle.version::
+	This integer value advertises the version of the bundle list format
+	used by the bundle list. Currently, the only accepted value is `1`.
+
+bundle.mode::
+	This string value should be either `all` or `any`. This value describes
+	whether all of the advertised bundles are required to unbundle a
+	complete understanding of the bundled information (`all`) or if any one
+	of the listed bundle URIs is sufficient (`any`).
+
+bundle.<id>.*::
+	The `bundle.<id>.*` keys are used to describe a single item in the
+	bundle list, grouped under `<id>` for identification purposes.
+
+bundle.<id>.uri::
+	This string value defines the URI by which Git can reach the contents
+	of this `<id>`. This URI may be a bundle file or another bundle list.
diff --git a/bundle-uri.c b/bundle-uri.c
index ceeef0b6641..ade7eccce39 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -66,6 +66,80 @@ int for_all_bundles_in_list(struct bundle_list *list,
 	return 0;
 }
 
+/**
+ * Given a key-value pair, update the state of the given bundle list.
+ * Returns 0 if the key-value pair is understood. Returns 1 if the key
+ * is not understood or the value is malformed.
+ */
+MAYBE_UNUSED
+static int bundle_list_update(const char *key, const char *value,
+			      struct bundle_list *list)
+{
+	const char *pkey, *dot;
+	struct strbuf id = STRBUF_INIT;
+	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
+	struct remote_bundle_info *bundle;
+
+	if (!skip_prefix(key, "bundle.", &pkey))
+		return 1;
+
+	dot = strchr(pkey, '.');
+	if (!dot) {
+		if (!strcmp(pkey, "version")) {
+			int version = atoi(value);
+			if (version != 1)
+				return 1;
+
+			list->version = version;
+			return 0;
+		}
+
+		if (!strcmp(pkey, "mode")) {
+			if (!strcmp(value, "all"))
+				list->mode = BUNDLE_MODE_ALL;
+			else if (!strcmp(value, "any"))
+				list->mode = BUNDLE_MODE_ANY;
+			else
+				return 1;
+			return 0;
+		}
+
+		/* Ignore other unknown global keys. */
+		return 0;
+	}
+
+	strbuf_add(&id, pkey, dot - pkey);
+	dot++;
+
+	/*
+	 * Check for an existing bundle with this <id>, or create one
+	 * if necessary.
+	 */
+	lookup.id = id.buf;
+	hashmap_entry_init(&lookup.ent, strhash(lookup.id));
+	if (!(bundle = hashmap_get_entry(&list->bundles, &lookup, ent, NULL))) {
+		CALLOC_ARRAY(bundle, 1);
+		bundle->id = strbuf_detach(&id, NULL);
+		strbuf_init(&bundle->file, 0);
+		hashmap_entry_init(&bundle->ent, strhash(bundle->id));
+		hashmap_add(&list->bundles, &bundle->ent);
+	}
+	strbuf_release(&id);
+
+	if (!strcmp(dot, "uri")) {
+		free(bundle->uri);
+		bundle->uri = xstrdup(value);
+		return 0;
+	}
+
+	/*
+	 * At this point, we ignore any information that we don't
+	 * understand, assuming it to be hints for a heuristic the client
+	 * does not currently understand.
+	 */
+	return 0;
+}
+
 static int find_temp_filename(struct strbuf *name)
 {
 	int fd;
-- 
gitgitgadget

