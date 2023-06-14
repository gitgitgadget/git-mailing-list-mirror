Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A2BEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjFNT0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjFNT0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCEC1FDD
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so9284874e87.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770763; x=1689362763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZw3Wr9b6l0Xaz14oHZo1mGFe1ZhH3aMinlQKqEZmnU=;
        b=lSTvc+9FnjCRXFhTD8tWTZPoU/S5iAzbWYVPvjuJ15aVs39iT6b40ngvactOPypbQF
         GfvLGoP2EkIimJwASnifaGZWFMVUfVRPWx56+NOz4toMzeuUxjES9ISa2LicPg9PiOL4
         ZuJCPG5TUJ55+WNRcBpHTiH4Q08tj/CRoMSlgXBIDzV5+4LR5ThohajOuytM8/uVvMYS
         1kL0fcdWtezfbE7id5Qw/46Ytn0qLvKBKm2rzhRJDp5c8hIAis/ORpE/pAn5p/gxBsns
         HFPIjw07fbIRbcQhv7GlFUAFo9cb3v4CPF7YcXcec/MRFqLI/YyT+5bl5wGOvG4z2ddN
         LQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770763; x=1689362763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZw3Wr9b6l0Xaz14oHZo1mGFe1ZhH3aMinlQKqEZmnU=;
        b=O3IS2Rb2itNzPKTkFbSjYDGIWzRt6932l7tQbhIApY0LvVEgcZEa/ULLrs7Zhrl9tg
         1vHtdpTEOWE3JkJtnHHaVj0vsOB5P8YXaLkOraaIbdBocEP/jMzTjgdDQaSCh9w063Hr
         s1DqpApEh/uHzjr+CCRFval/akVvQsw6Ssrk6tYQ1TyGPi8FFtIzb63myDhs0aJ6bSn0
         sjoGnqetIq78nVxYuAOyCYmQSmci463LDyYSjB8epcNWW3ygFjdXTaq0hQJ4WwSCwaEz
         lskVB4e0dSCjyqHT9SvNf4qbn0mGMOahG3eNhqLbJDe0/1XFRpyCpKj6Bl/4YRJF1ggE
         agRg==
X-Gm-Message-State: AC+VfDxIog95PiKlqI98C2cpfqB6ivg5SxKNw2/rQUdp+XFIuCtWv8mB
        mXQwltNJ1isd2YHPMWfcuak7GbMwmDU=
X-Google-Smtp-Source: ACHHUZ71jve/7wMTaIWRmzYXPcVRi1ECkSqidybo7m6cxXNEI4wuabxEB/I4p3z6JxZ3zcvOdeENpQ==
X-Received: by 2002:a19:920a:0:b0:4f4:b806:4b5f with SMTP id u10-20020a19920a000000b004f4b8064b5fmr8202251lfd.57.1686770763195;
        Wed, 14 Jun 2023 12:26:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/9] pack-objects: add `--print-filtered` to print omitted objects
Date:   Wed, 14 Jun 2023 21:25:34 +0200
Message-ID: <20230614192541.1599256-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the `--filter=<filter-spec>` option, `git pack-objects` will
omit some objects from the resulting packfile(s) it produces. It could
be useful to know about these omitted objects though.

For example, we might want to write these objects into a separate
packfile by piping them into another `git pack-object` process.
Or we might want to check if these objects are available from a
promisor remote.

Anyway, this patch implements a simple way to let us know about these
objects by simply printing their oid, one per line, on stdout when the
new `--print-filtered` flag is passed.

As `--print-filtered` doesn't make sense without `--filter`, it is
disallowed to use the former without the latter.

Using `--stdout` is likely to make the `--print-filtered` output
difficult to find or parse, so we also disallow using these two options
together.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-pack-objects.txt     | 10 ++++++
 builtin/pack-objects.c                 | 47 ++++++++++++++++++++++++--
 t/t5317-pack-objects-filter-objects.sh | 27 +++++++++++++++
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 583270a85f..6469080029 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -305,6 +305,16 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 --no-filter::
 	Turns off any previous `--filter=` argument.
 
+--print-filtered::
+	Requires `--filter=`. Prints on stdout, one per line, the
+	object IDs of the objects that are filtered out from the
+	resulting packfile by the filter. This is incompatible with
+	`--stdout`. As <SHA-1> hashes are already written to stdout
+	based on the resulting pack contents (see the `base-name`
+	argument), a line containing only six `-` characters is
+	written after those <SHA-1> hashes, before the filtered object
+	IDs.
+
 --missing=<missing-action>::
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index af007868c1..c8e2b6b859 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,6 +266,12 @@ static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
 
+/*
+ * Objects omitted by filter
+ */
+static int print_filtered_out;
+static struct oidset *omitted_by_filter;
+
 /*
  * stats
  */
@@ -4065,11 +4071,18 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 		die(_("revision walk setup failed"));
 	mark_edges_uninteresting(revs, show_edge, sparse);
 
+	if (print_filtered_out) {
+		omitted_by_filter = xmalloc(sizeof(*omitted_by_filter));
+		oidset_init(omitted_by_filter, 0);
+	}
+
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list(revs,
-			     show_commit, fn_show_object,
-			     NULL);
+	traverse_commit_list_filtered(revs,
+				      show_commit,
+				      fn_show_object,
+				      NULL,
+				      omitted_by_filter);
 
 	if (unpack_unreachable_expiration) {
 		revs->ignore_missing_links = 1;
@@ -4165,6 +4178,23 @@ static int option_parse_cruft_expiration(const struct option *opt,
 	return 0;
 }
 
+static void print_omitted_by_filter(void)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+
+	fprintf_ln(stdout, "%s", "------");
+	fprintf_ln(stderr, "%s", _("Printing objects omitted by filter"));
+
+	oidset_iter_init(omitted_by_filter, &iter);
+
+	while ((oid = oidset_iter_next(&iter)))
+		fprintf_ln(stdout, "%s", oid_to_hex(oid));
+
+	oidset_clear(omitted_by_filter);
+	FREE_AND_NULL(omitted_by_filter);
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -4278,6 +4308,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
 				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+		OPT_BOOL(0, "print-filtered", &print_filtered_out,
+			 N_("print filtered out objects to stdout")),
 		OPT_END(),
 	};
 
@@ -4394,6 +4426,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
 
+	if (print_filtered_out && !filter_options.choice)
+		die(_("cannot use --print-filtered without --filter"));
+
+	if (print_filtered_out && pack_to_stdout)
+		die(_("cannot use --print-filtered with --stdout"));
+
 	if (cruft) {
 		if (use_internal_rev_list)
 			die(_("cannot use internal rev list with --cruft"));
@@ -4509,6 +4547,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			   written, written_delta, reused, reused_delta,
 			   reuse_packfile_objects);
 
+	if (omitted_by_filter)
+		print_omitted_by_filter();
+
 cleanup:
 	list_objects_filter_release(&filter_options);
 	strvec_clear(&rp);
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index b26d476c64..ec3a03d90a 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -438,6 +438,33 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 	test_cmp expected observed
 '
 
+# Test pack-objects with --print-filtered option
+
+test_expect_success 'pack-objects fails w/ both --print-filtered and --stdout' '
+	test_must_fail git -C r1 pack-objects --revs --stdout \
+		--filter=blob:none --print-filtered >filter.out <<-EOF
+	HEAD
+	EOF
+'
+
+test_expect_success 'pack-objects w/ --print-filtered and a pack name' '
+	git -C r1 pack-objects --revs --filter=blob:none \
+		--print-filtered filtered-pack >filter.out <<-EOF &&
+	HEAD
+	EOF
+
+	# Check that the second line contains "------"
+	head -n 2 filter.out | tail -n 1 >actual &&
+	echo "------" >expected &&
+	test_cmp expected actual &&
+
+	# Remove the first two lines and check there are all the blobs
+	tail -n +3 filter.out | sort >actual &&
+	git -C r1 cat-file --batch-check --batch-all-objects | grep blob |
+		sed -e "s/ blob.*//" | sort >expected &&
+	test_cmp expected actual
+'
+
 # Delete some loose objects and use pack-objects, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.41.0.37.gae45d9845e

