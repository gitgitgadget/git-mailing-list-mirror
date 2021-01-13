Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D3C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 12:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53CF233F8
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 12:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbhAMMAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbhAMMAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 07:00:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E54C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 03:59:55 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m5so1039526pjv.5
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ImaNK14X16cNSHu9aDGosbqfKHNtTATpGg+wC4fB504=;
        b=Sp4Yyw65jR7TfLAoa6yp1e3qCc1HjUasQosgsiYYwRGfD2tsy1wV054qz/gyaNJmAi
         OukFYOaW+QN1QKelaIcFlftcVTFdd02jfiGJ5bHYIcIKwofKpgVuO2Tbb3Y/DtegBf60
         7Ruwg0ZFUI9yyfZmi8IQ2oEcHE415bFGfVXx2phYUyHztcaychJJ56YIniFabnm+ndkx
         x+LHzcbY2yB7c14boxFQ53mnD7yBlN0ZRoneV+nYmpzffNv8Geeko3AqBXuBEdUQTEaK
         83zBpjphuFufv9QfNbtChUB0YOVSAOIRNYs+Cuq5cvr9w7VIaDv1SdVH3PKXHzHOmJTl
         7wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ImaNK14X16cNSHu9aDGosbqfKHNtTATpGg+wC4fB504=;
        b=ns8OCsdlPaL2bhY4bmvY3Rl/G6ozZl1XfptQLqKpS7FZuojUoORxWCPcuKHlIDCCK0
         18nMpNqp1wnWdcRdNfv3I/qhyhE6zRX8dffCDPJ55y86LcsHLPELK3HiCVw5uvDnNnK8
         EyJdM1Yco9A3ORoHAZOs0JENqdp5LvsHJOxGF13hb0ZWXoifOqXVtApEjO/j6u2RUbMP
         DHuixvZ3q4JYxZqnVvQRVLfoPvXx0jutPm699MwePj2CwepRRCYaPPhBH1HtotNH2SCN
         Xsb6aCr9htTfAkgE/W2YuokZy6xQ2+tKZnGkEKzFN+YMUn0oHv8cKxml8+Q0qNMjXC2u
         R8jw==
X-Gm-Message-State: AOAM531ZVg3NhWBqWZ21e8no44XD6/pexz3IBQD1T+djwEog8J0brym9
        HSb6anvDYmb1uKepvuY2DNp8LFgWxZiTfg==
X-Google-Smtp-Source: ABdhPJwAehEuyFW/u5qNyUeeofAj73LsEWpn5BT2+v47eBCOMIPTsSuweWc2VgqARkapV7Py/4WrMQ==
X-Received: by 2002:a17:90a:6405:: with SMTP id g5mr2077109pjj.4.1610539194684;
        Wed, 13 Jan 2021 03:59:54 -0800 (PST)
Received: from localhost ([2402:800:63a8:f5bb:2516:717f:2f37:c4c0])
        by smtp.gmail.com with ESMTPSA id o14sm2577347pgr.44.2021.01.13.03.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:59:53 -0800 (PST)
Date:   Wed, 13 Jan 2021 18:59:52 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: test-tool: bloom: generate_filter for multiple string?
Message-ID: <X/7guF05a/Bb/VNp@danh.dev>
References: <20201231035438.22533-1-congdanhqx@gmail.com>
 <X/3+PG2hi71tj/UA@nand.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="whg8kvBV0NMCIgUU"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/3+PG2hi71tj/UA@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--whg8kvBV0NMCIgUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2021-01-12 14:53:32-0500, Taylor Blau <me@ttaylorr.com> wrote:
> On Thu, Dec 31, 2020 at 10:54:38AM +0700, Đoàn Trần Công Danh wrote:
> > I'm reading the code for Bloom Filter to see if arXiv:2012.00472
> > could be an improvement.
> 
> I'm late to the party, but I'm curious to hear which part of this
> article you think would help out the Bloom filter implementation.

Uhm, no. The article doesn't help the Bloom filter implementation.
The article was suggesting using Bloom filter to speed-up the
negotiation in fetch-pack and upload-pack. Which, in my own quick
experience, doesn't help much. Maybe it's me not understand the
article idea or I have made a naive implementation. However, I'm not
convinced to pursued further.

If you are curious, I'm attaching 2 quick-and-low-quality patches with
this email for your consideration.

-- 
Danh

--whg8kvBV0NMCIgUU
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-fetch-pack-implent-bloom-filter-in-client-side.patch"
Content-Transfer-Encoding: 8bit

From 287d1b94606bbc5475909e5298560cbd28ee998e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Thu, 31 Dec 2020 10:58:22 +0700
Subject: [PATCH 2/3] fetch-pack: implent bloom filter in client side
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 fetch-pack.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 876f90c759..f423ccd816 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,9 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "bloom.h"
+#include "list-objects.h"
+#include "revision.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1184,6 +1187,71 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return ret;
 }
 
+static int rev_info_insert_ref_oid(const char *refname,
+				   const struct object_id *oid,
+				   int flag, void *cbdata)
+{
+	struct rev_info *rev_info = cbdata;
+	add_pending_oid(rev_info, refname, oid, 0);
+	return 1;
+}
+
+static void rev_info_insert_to_oidset(struct commit *commit, void *cbdata)
+{
+	struct oidset *set = cbdata;
+	oidset_insert(set, &commit->object.oid);
+}
+
+static void add_bloom(struct strbuf *req_buf, struct oidset *common)
+{
+	struct oidset_iter iter;
+	struct oidset haves = OIDSET_INIT;
+	struct rev_info rev_info;
+	struct bloom_filter filter;
+	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	struct strbuf buf;
+	const struct object_id *oid;
+	int i;
+
+	if (oidset_size(common) == 0)
+		return;
+	
+	repo_init_revisions(the_repository, &rev_info, NULL);
+
+	oidset_iter_init(common, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		add_pending_oid(&rev_info, oid_to_hex(oid), oid,
+			       UNINTERESTING | BOTTOM);
+	}
+
+	for_each_rawref(rev_info_insert_ref_oid, &rev_info);
+	if (prepare_revision_walk(&rev_info)) {
+		warning("couldn't prepare revision walk for fetch");
+		return;
+	}
+	traverse_commit_list(&rev_info, rev_info_insert_to_oidset, NULL, &haves);
+	if (oidset_size(&haves) == 0)
+		return;
+	filter.len = (oidset_size(&haves) * settings.bits_per_entry + BITS_PER_WORD - 1)
+		/ BITS_PER_WORD;
+	free(filter.data);
+	filter.data = xcalloc(filter.len, sizeof(unsigned char));
+	oidset_iter_init(&haves, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct bloom_key key;
+		fill_bloom_key((const char *)oid->hash, the_hash_algo->rawsz,
+			       &key, &settings);
+		add_key_to_filter(&key, &filter, &settings);
+	}
+
+	strbuf_init(&buf, filter.len * 2 + strlen("bloom \n"));
+	strbuf_addstr(&buf, "bloom ");
+	for (i = 0; i < filter.len; i++)
+		strbuf_addf(&buf, "%02x", filter.data[i]);
+	strbuf_addch(&buf, '\n');
+	packet_buf_write_len(req_buf, buf.buf, buf.len);
+}
+
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
@@ -1191,6 +1259,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      int sideband_all, int seen_ack)
 {
 	int ret = 0;
+	int transferbloom = 0;
 	const char *hash_name;
 	struct strbuf req_buf = STRBUF_INIT;
 
@@ -1278,6 +1347,11 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	ret = add_haves(negotiator, seen_ack, &req_buf,
 			haves_to_send, in_vain);
 
+	/* Add bloom filter represent commits we have from known common */
+	git_config_get_maybe_bool("transfer.bloom", &transferbloom);
+	if (transferbloom && server_supports_v2("bloom", 0))
+		add_bloom(&req_buf, common);
+
 	/* Send request */
 	packet_buf_flush(&req_buf);
 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
@@ -1352,11 +1426,14 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
 			struct object_id oid;
 			received_ack = 1;
 			if (!get_oid_hex(arg, &oid)) {
+				struct object *obj;
 				struct commit *commit;
-				oidset_insert(common, &oid);
-				commit = lookup_commit(the_repository, &oid);
-				if (negotiator)
-					negotiator->ack(negotiator, commit);
+				obj = lookup_object(the_repository, &oid);
+				if (obj && (commit = object_as_type(obj, OBJ_COMMIT, 0))) {
+					oidset_insert(common, &oid);
+					if (negotiator)
+						negotiator->ack(negotiator, commit);
+				}
 			}
 			continue;
 		}
-- 
2.30.0.4.gbe3229325d


--whg8kvBV0NMCIgUU
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0003-upload-pack-support-bloom-filter.patch"
Content-Transfer-Encoding: 8bit

From 2c93a1a6c37d40ba37eb083a139b6f1312a547e6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Mon, 4 Jan 2021 20:23:29 +0700
Subject: [PATCH 3/3] upload-pack: support bloom filter
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 serve.c              |  1 +
 t/t5701-git-serve.sh |  1 +
 upload-pack.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/serve.c b/serve.c
index eec2fe6f29..daea53bfb7 100644
--- a/serve.c
+++ b/serve.c
@@ -78,6 +78,7 @@ static struct protocol_capability capabilities[] = {
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
 	{ "session-id", session_id_advertise, NULL },
+	{ "bloom", always_advertise, NULL },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index a1f5fdc9fd..9fabdba6b1 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -16,6 +16,7 @@ test_expect_success 'test capability advertisement' '
 	fetch=shallow
 	server-option
 	object-format=$(test_oid algo)
+	bloom
 	0000
 	EOF
 
diff --git a/upload-pack.c b/upload-pack.c
index 3b66bf92ba..0eff165865 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -27,6 +27,7 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "bloom.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -62,6 +63,8 @@ struct upload_pack_data {
 	struct object_array have_obj;
 	struct oid_array haves;					/* v2 only */
 	struct string_list wanted_refs;				/* v2 only */
+	struct bloom_filter bloom_filter;			/* v2 only */
+	struct bloom_filter_settings bloom_filter_settings;
 
 	struct object_array shallows;
 	struct string_list deepen_not;
@@ -113,6 +116,13 @@ struct upload_pack_data {
 	unsigned advertise_sid : 1;
 };
 
+struct upload_pack_bloom_args
+{
+	struct bloom_filter *bloom_filter;
+	struct bloom_filter_settings *bloom_filter_settings;
+	struct oid_array *acks;
+};
+
 static void upload_pack_data_init(struct upload_pack_data *data)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
@@ -125,6 +135,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
 	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
+	struct bloom_filter_settings bloom_filter_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	memset(data, 0, sizeof(*data));
 	data->symref = symref;
@@ -132,6 +143,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->want_obj = want_obj;
 	data->have_obj = have_obj;
 	data->haves = haves;
+	data->bloom_filter_settings = bloom_filter_settings;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
 	data->uri_protocols = uri_protocols;
@@ -1464,6 +1476,34 @@ static int parse_have(const char *line, struct oid_array *haves)
 	return 0;
 }
 
+static int parse_bloom(const char *line, struct bloom_filter *filter,
+		       struct bloom_filter_settings *settings)
+{
+	const char *arg;
+	unsigned char *p;
+	size_t len;
+	if (!skip_prefix(line, "bloom ", &arg))
+		return 0;
+
+	len = strlen(arg);
+	if (len % 2)
+		die("git upload-pack: corrupted bloom data with len: %zu", len);
+	filter->len = len / 2;
+	filter->data = p = xmalloc(filter->len);
+	while (*arg) {
+		int val = hex2chr(arg);
+		if (val < 0)
+			goto errout;
+		*p++ = val;
+		arg += 2;
+	}
+	return 1;
+errout:
+	filter->len = 0;
+	FREE_AND_NULL(filter->data);
+	return 0;
+}
+
 static void process_args(struct packet_reader *request,
 			 struct upload_pack_data *data)
 {
@@ -1482,6 +1522,9 @@ static void process_args(struct packet_reader *request,
 		if (parse_have(arg, &data->haves))
 			continue;
 
+		if (parse_bloom(arg, &data->bloom_filter, &data->bloom_filter_settings))
+			continue;
+
 		/* process args like thin-pack */
 		if (!strcmp(arg, "thin-pack")) {
 			data->use_thin_pack = 1;
@@ -1570,6 +1613,48 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 	return 0;
 }
 
+static void rev_info_bloom_ack(struct commit *commit, void *cbdata)
+{
+	struct upload_pack_bloom_args *args = cbdata;
+	struct bloom_key key;
+	struct object_id *oid = &commit->object.oid;
+	fill_bloom_key((const char *)oid->hash, the_hash_algo->rawsz,
+		       &key, args->bloom_filter_settings);
+	if (bloom_filter_contains(args->bloom_filter, &key,
+				  args->bloom_filter_settings))
+		oid_array_append(args->acks, oid);
+}
+
+/* Walking from wanted_obj until haves, add all MAYBE objects to acks */
+static int process_bloom(struct upload_pack_data *data, struct oid_array *acks)
+{
+	struct upload_pack_bloom_args args;
+	struct rev_info rev_info;
+	const struct object_id *oid;
+	int i;
+
+	/* unknown bloom data and/or no known common objects */
+	if (!data->bloom_filter.len || !acks->nr)
+		return 0;
+	repo_init_revisions(the_repository, &rev_info, NULL);
+	for (i = 0; i < acks->nr; i++) {
+		oid = &acks->oid[i];
+		add_pending_oid(&rev_info, oid_to_hex(oid), oid,
+				UNINTERESTING | BOTTOM);
+	}
+	for (i = 0; i < data->want_obj.nr; i++) {
+		oid = &data->want_obj.objects[i].item->oid;
+		add_pending_oid(&rev_info, oid_to_hex(oid), oid, 0);
+	}
+	if (prepare_revision_walk(&rev_info))
+		return 0;
+	args.bloom_filter = &data->bloom_filter;
+	args.bloom_filter_settings = &data->bloom_filter_settings;
+	args.acks = acks;
+	traverse_commit_list(&rev_info, rev_info_bloom_ack, NULL, &args);
+	return 0;
+}
+
 static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 {
 	int i;
@@ -1600,6 +1685,7 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 	int ret = 0;
 
 	process_haves(data, &common);
+	process_bloom(data, &common);
 	if (data->done) {
 		ret = 1;
 	} else if (send_acks(data, &common)) {
-- 
2.30.0.4.gbe3229325d


--whg8kvBV0NMCIgUU--
