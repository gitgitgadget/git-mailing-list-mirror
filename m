Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A76FA3740
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 12:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiJYM3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiJYM3l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 08:29:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A500134DC0
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:29:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so20519940wrt.11
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDD0eqT/p7KZBlJWYwnAESOs888mnpU1yT/B6ypjIQo=;
        b=Smdwv5Q9r6D+rY4a32xOKqqDXD0pyNKreV8cBnex5/Q13CXWxoDwj/xSBOwTq15/JM
         ozXgEeDO6OW0pisNNomhOw0fW+lq5I3Uj5gwb6ROBF9NrWmLvud8fy73jI3u+MUq4a3Z
         QMdUU0NzoOWv0rldbg2u32AbhWZTjqkuHlKHcUtoY0092dNontD2CMAUM2i0WFpyJ4Z3
         1nDM9rANAeAgiRnUkXmaxGclZK/nZeh+ml3Lo/dVlyLphkGNaRFNap2BvWV5z7opWe/o
         vgpC+OZDx0moisqPLyKvaieg5elqaCALdKYn7Gxwi8aCEtt3Lr+H/P7nQ4IxMwChVP2X
         DqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDD0eqT/p7KZBlJWYwnAESOs888mnpU1yT/B6ypjIQo=;
        b=SUvTbJJIDvFsqDwZT8zl/69oGZyPVhsgxLvwKJcpxevGrvNxTPKgT2X4eRUAo2529e
         2jCOvDYI5nPRVinLnaCV3OBXHTOol6ZWTl9gqWaxqHXBdU17gd2HvjCcWOodVto3wZoK
         IeBI6MUvEoz8eCJ9YdEZAMhYa5uX4kuD8ADJHJPOIlHN5Cwl25FGwdITrha2NVeYx2g3
         ZlZhv4CI4stMjr1YbM9dk2Ud8muIOeJJo1m7pYmkb0nEhb1trwn2k+A/vsqmfkP69myW
         ZbwS+LoYUjeKbIoqfUlRBhpXEBvRqU3bpZSq1Rckww0ttUWK+tni+pImz2lKIIKGxWd4
         JWAA==
X-Gm-Message-State: ACrzQf2iX5N8RWhSud/zxqi97LNSg+wtkzYIuYlcbNUHRFcrYYz4RjDj
        66QxhD8iQPV4QXzVq37G14IDWEhnULI=
X-Google-Smtp-Source: AMsMyM4GkfvpmGBsmpL2Qqv6vy8hxFOAXu4KD3G0TdIzoVmwjWTHczGlFw9eNUxZRo3utfAN506BQw==
X-Received: by 2002:a7b:cb49:0:b0:3b4:b08a:89b with SMTP id v9-20020a7bcb49000000b003b4b08a089bmr25415425wmj.173.1666700977959;
        Tue, 25 Oct 2022 05:29:37 -0700 (PDT)
Received: from Precision-5550.lan (ber13-h01-176-133-175-75.dsl.sta.abo.bbox.fr. [176.133.175.75])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b00236860e7e9esm686975wrs.98.2022.10.25.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:29:37 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/2] repack: add --filter=<filter-spec> option
Date:   Tue, 25 Oct 2022 14:28:56 +0200
Message-Id: <20221025122856.20204-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.1.145.g80cce38e46.dirty
In-Reply-To: <20221025122856.20204-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20221025122856.20204-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <chriscool@tuxfamily.org>

After cloning with --filter=<filter-spec>, for example to avoid
getting unneeded large files on a user machine, it's possible
that some of these large files still get fetched for some reasons
(like checking out old branches) over time.

In this case the repo size could grow too much for no good reason
and `git repack --filter=<filter-spec>` would be useful to remove
the unneeded large files.

This command could be dangerous to use though, as it might remove
local objects that haven't been pushed which would lose data and
corrupt the repo. On a server, this command could also corrupt a
repo unless ALL the removed objects aren't already available in
another remote that clients can access.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt |  8 ++++++++
 builtin/repack.c             | 22 +++++++++++++++-------
 t/t7700-repack.sh            | 15 +++++++++++++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0bf13893d8..d28bb68cfc 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -137,6 +137,14 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Omits certain objects (usually blobs) from the resulting
+	packfile. WARNING: this could easily corrupt the current repo
+	and lose data if ANY of the omitted objects hasn't been already
+	pushed to a remote. Be very careful about objects that might
+	have been created locally! See linkgit:git-rev-list[1] for valid
+	`<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..d8b8a58f73 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -50,6 +50,7 @@ struct pack_objects_args {
 	const char *depth;
 	const char *threads;
 	const char *max_pack_size;
+	const char *filter;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -201,6 +202,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter)
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -268,6 +271,13 @@ static unsigned populate_pack_exts(char *name)
 	return ret;
 }
 
+static void write_promisor_file_1(char *p)
+{
+	char *promisor_name = mkpathdup("%s-%s.promisor", packtmp, p);
+	write_promisor_file(promisor_name, NULL, 0);
+	free(promisor_name);
+}
+
 static void repack_promisor_objects(const struct pack_objects_args *args,
 				    struct string_list *names)
 {
@@ -299,7 +309,6 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
-		char *promisor_name;
 
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
@@ -316,13 +325,8 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		 * concatenate the contents of all .promisor files instead of
 		 * just creating a new empty file.
 		 */
-		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
-					  line.buf);
-		write_promisor_file(promisor_name, NULL, 0);
-
+		write_promisor_file_1(line.buf);
 		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
-
-		free(promisor_name);
 	}
 	fclose(out);
 	if (finish_command(&cmd))
@@ -786,6 +790,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -955,6 +961,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		string_list_append(&names, line.buf);
+		if (po_args.filter)
+			write_promisor_file_1(line.buf);
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index ca45c4cd2c..363eaf8fea 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -237,6 +237,21 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'repacking with a filter works' '
+	test_when_finished "rm -rf server client" &&
+	test_create_repo server &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true &&
+	test_commit -C server 1 &&
+	git clone --bare --no-local server client &&
+	git -C client config remote.origin.promisor true &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep "^?" objects | wc -l) = 0 &&
+	git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep "^?" objects | wc -l) = 1
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.38.1.145.g80cce38e46.dirty

