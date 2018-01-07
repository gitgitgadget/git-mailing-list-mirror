Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0501F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754436AbeAGSPT (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:19 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36359 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754403AbeAGSPR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:17 -0500
Received: by mail-qk0-f195.google.com with SMTP id d21so737067qkj.3
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7v5J4yB7Oxc81+MQcku08Koan3wGgP9uoQkq1jkxiGk=;
        b=aRnEW48GcrCYV3iBg1ke/9iy/HZ7ln0HQUiESw1etZ/T0QyIZJA4Cl2M4k6pkKe107
         ofcCKsegzZkRak7lfm8xMdSsbCoW6WmdgY8wYqttbO0vKHhefHgfqaKP/rOfuBhW6zG1
         mcY1MDah7Je+/Zsx20SyibgKX4w98caH6AtMyX9zg0woEvFv8iL3THfhy7uguzk7vwm1
         sgUu4AwR8W15uVvgKYpOAtANmUeBHBG7+whi5f3AeQUUCvSQ+h7aFkTa2L+ABo8hbSx4
         xr0DSq0hOBHTJRUJTkDdITWun3kp0lFm1+5niwTff4JbInd21oA5CoXhMXUCR5UNZxht
         Csuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7v5J4yB7Oxc81+MQcku08Koan3wGgP9uoQkq1jkxiGk=;
        b=UNcrLjpaeNbstvRBea+NS/DQgiQWm7m41awLzhAWb0MP4k6cFFhsffPp7N7bL+pmgs
         cNUzCv63voCMpqauCxofQvq173JvQIHnMWE9Y/Q/QlcDFLUzCD26/2tOkZ+fhjB6yS5w
         sT6WlrNobhsZ0sGUKg2rqWkaVtpGU0K92+Fl+bukRpVI9wd3wa466Lob0H4UvoyR2tPi
         GLd3gto55bhyb5PU9+cGGZSpg6LoBYioYKiET0aP/kWWXynCFLPGT3857XsYtyxnvB7A
         3oQ+le82IvpRSsaWB4Gl4QvqPCN5m/QGp2/ZTghHQU7aP81EJunXRQ1avQWcOFM1GfDj
         0zHg==
X-Gm-Message-State: AKwxytevnktEQr60gXTslA/JBIxAuj3xo2E9upsxsdpqx8H/hXTj2P3P
        YB3yWWPg7RQVGGAEGakQhXA7hs1bWGQ=
X-Google-Smtp-Source: ACJfBougLoCXVa1X5QKx4FoeKEoqupIjHBTbtsd5as0cNn6A7W6t5XHHz7e7UVs0X9h0cC+TZJZsZA==
X-Received: by 10.55.53.205 with SMTP id c196mr1951115qka.311.1515348916072;
        Sun, 07 Jan 2018 10:15:16 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:15 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 08/18] midx: teach git-midx to read midx file details
Date:   Sun,  7 Jan 2018 13:14:49 -0500
Message-Id: <20180107181459.222909-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commentary: I included the pack directory of the MIDX file as a FLEX_ARRAY
at the end of the midxed_git struct, similar to how the pack name appears
at the end of the packed_git struct. A colleague mentioned this pattern is
confusing and possibly dangerous so I should consider changing it. If there
is no strong reason for this, then I will modify the struct before the v1
patch to use a char*.

-- >8 --

Add a "--read" subcommand to the midx builtin to report summary information
on the head MIDX file or a MIDX file specified by the supplied "--midx-id"
parameter.

This subcommand is used by t5318-midx.sh to verify the indexed objects are
as expected.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-midx.txt |  23 +++++++-
 builtin/midx.c             |  59 ++++++++++++++++++++
 midx.c                     | 132 +++++++++++++++++++++++++++++++++++++++++++++
 midx.h                     |  58 ++++++++++++++++++++
 t/t5318-midx.sh            |  79 +++++++++++++++++++--------
 5 files changed, 328 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
index 01f79cbba5..3eeed1d969 100644
--- a/Documentation/git-midx.txt
+++ b/Documentation/git-midx.txt
@@ -9,7 +9,7 @@ git-midx - Write and verify multi-pack-indexes (MIDX files).
 SYNOPSIS
 --------
 [verse]
-'git midx' --write <options> [--pack-dir <pack_dir>]
+'git midx' [--write|--read] <options> [--pack-dir <pack_dir>]
 
 DESCRIPTION
 -----------
@@ -22,9 +22,18 @@ OPTIONS
 	Use given directory for the location of packfiles, pack-indexes,
 	and MIDX files.
 
+--read::
+	If specified, read a midx file specified by the midx-head file
+	and output basic details about the midx file. (Cannot be combined
+	with --write.)
+
+--midx-id <oid>::
+	If specified with --read, use the given oid to read midx-[oid].midx
+	instead of using midx-head.
 --write::
 	If specified, write a new midx file to the pack directory using
 	the packfiles present. Outputs the hash of the result midx file.
+	(Cannot be combined with --read.)
 
 --update-head::
 	If specified with --write, update the midx-head file to point to
@@ -58,6 +67,18 @@ $ git midx --write --update-head
 $ git midx --write --pack-dir ../../alt/pack/
 ---------------------------------------------------------
 
+* Read the current midx-head.
++
+-----------------------------------------------
+$ git midx --read
+-----------------------------------------------
+
+* Read a specific MIDX file in the local .git folder.
++
+--------------------------------------------------------------------
+$ git midx --read --midx-id 3e50d982a2257168c7fd0ff12ffe5cf6af38c74e
+--------------------------------------------------------------------
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/midx.c b/builtin/midx.c
index 84ce6588a2..ee9234583d 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -16,12 +16,60 @@ static char const * const builtin_midx_usage[] = {
 
 static struct opts_midx {
 	const char *pack_dir;
+	int read;
+	const char *midx_id;
 	int write;
 	int update_head;
 	int has_existing;
 	struct object_id old_midx_oid;
 } opts;
 
+static int midx_read(void)
+{
+	struct object_id midx_oid;
+	struct midxed_git *midx;
+	uint32_t i;
+
+	if (opts.midx_id && strlen(opts.midx_id) == GIT_MAX_HEXSZ)
+		get_oid_hex(opts.midx_id, &midx_oid);
+	else if (!get_midx_head_oid(opts.pack_dir, &midx_oid))
+		die("No midx-head exists.");
+
+	midx = get_midxed_git(opts.pack_dir, &midx_oid);
+
+	printf("header: %08x %x %d %d %d %d %d\n",
+		ntohl(midx->hdr->midx_signature),
+		ntohl(midx->hdr->midx_version),
+		midx->hdr->hash_version,
+		midx->hdr->hash_len,
+		midx->hdr->num_base_midx,
+		midx->hdr->num_chunks,
+		ntohl(midx->hdr->num_packs));
+	printf("num_objects: %d\n", midx->num_objects);
+	printf("chunks:");
+
+	if (midx->chunk_pack_lookup)
+		printf(" pack_lookup");
+	if (midx->chunk_pack_names)
+		printf(" pack_names");
+	if (midx->chunk_oid_fanout)
+		printf(" oid_fanout");
+	if (midx->chunk_oid_lookup)
+		printf(" oid_lookup");
+	if (midx->chunk_object_offsets)
+		printf(" object_offsets");
+	if (midx->chunk_large_offsets)
+		printf(" large_offsets");
+	printf("\n");
+
+	printf("pack_names:\n");
+	for (i = 0; i < midx->num_packs; i++)
+		printf("%s\n", midx->pack_names[i]);
+
+	printf("pack_dir: %s\n", midx->pack_dir);
+	return 0;
+}
+
 static int build_midx_from_packs(
 	const char *pack_dir,
 	const char **pack_names, uint32_t nr_packs,
@@ -187,6 +235,12 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory containing set of packfile and pack-index pairs.") },
+		OPT_BOOL('r', "read", &opts.read,
+			N_("read midx file")),
+		{ OPTION_STRING, 'M', "midx-id", &opts.midx_id,
+			N_("oid"),
+			N_("An OID for a specific midx file in the pack-dir."),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_BOOL('w', "write", &opts.write,
 			N_("write midx file")),
 		OPT_BOOL('u', "update-head", &opts.update_head,
@@ -205,6 +259,9 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 			     builtin_midx_options,
 			     builtin_midx_usage, 0);
 
+	if (opts.write + opts.read > 1)
+		usage_with_options(builtin_midx_usage, builtin_midx_options);
+
 	if (!opts.pack_dir) {
 		struct strbuf path = STRBUF_INIT;
 		strbuf_addstr(&path, get_object_directory());
@@ -214,6 +271,8 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 
 	opts.has_existing = !!get_midx_head_oid(opts.pack_dir, &opts.old_midx_oid);
 
+	if (opts.read)
+		return midx_read();
 	if (opts.write)
 		return midx_write();
 
diff --git a/midx.c b/midx.c
index f4178c1b81..c631be451f 100644
--- a/midx.c
+++ b/midx.c
@@ -65,6 +65,138 @@ struct object_id *get_midx_head_oid(const char *pack_dir,
 	return oid;
 }
 
+static struct midxed_git *alloc_midxed_git(int extra)
+{
+	struct midxed_git *m = xmalloc(st_add(sizeof(*m), extra));
+	memset(m, 0, sizeof(*m));
+	m->midx_fd = -1;
+
+	return m;
+}
+
+static struct midxed_git *load_midxed_git_one(const char *midx_file, const char *pack_dir)
+{
+	void *midx_map;
+	const unsigned char *data;
+	struct pack_midx_header *hdr;
+	size_t midx_size, packs_len;
+	struct stat st;
+	uint32_t i;
+	struct midxed_git *midx;
+	int fd = git_open(midx_file);
+
+	if (fd < 0)
+		return 0;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return 0;
+	}
+	midx_size = xsize_t(st.st_size);
+
+	if (midx_size < 16 + 8 * 5 + 4 * 256 + GIT_MAX_RAWSZ) {
+		close(fd);
+		die("midx file %s is too small", midx_file);
+	}
+	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	data = (const unsigned char *)midx_map;
+
+	hdr = midx_map;
+	if (ntohl(hdr->midx_signature) != MIDX_SIGNATURE) {
+		munmap(midx_map, midx_size);
+		close(fd);
+		die("MIDX signature %X does not match signature %X",
+		    ntohl(hdr->midx_signature), MIDX_SIGNATURE);
+	}
+
+	if (ntohl(hdr->midx_version) != MIDX_VERSION) {
+		munmap(midx_map, midx_size);
+		die("MIDX version %X does not match version %X",
+		    ntohl(hdr->midx_version), MIDX_VERSION);
+	}
+
+	midx = alloc_midxed_git(strlen(pack_dir) + 1);
+
+	midx->hdr = hdr;
+	midx->midx_fd = fd;
+	midx->data = midx_map;
+	midx->data_len = midx_size;
+
+	for (i = 0; i <= hdr->num_chunks; i++) {
+		uint32_t chunk_id = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i));
+		uint64_t chunk_offset1 = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i + 4));
+		uint32_t chunk_offset2 = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i + 8));
+		uint64_t chunk_offset = (chunk_offset1 << 32) | chunk_offset2;
+
+		if (sizeof(data) == 4 && chunk_offset >> 32) {
+			munmap(midx_map, midx_size);
+			close(fd);
+			die(_("unable to memory-map in 32-bit address space"));
+		}
+
+		switch (chunk_id) {
+			case MIDX_CHUNKID_PACKLOOKUP:
+				midx->chunk_pack_lookup = data + chunk_offset;
+				break;
+
+			case MIDX_CHUNKID_PACKNAMES:
+				midx->chunk_pack_names = data + chunk_offset;
+				break;
+
+			case MIDX_CHUNKID_OIDFANOUT:
+				midx->chunk_oid_fanout = data + chunk_offset;
+				break;
+
+			case MIDX_CHUNKID_OIDLOOKUP:
+				midx->chunk_oid_lookup = data + chunk_offset;
+				break;
+
+			case MIDX_CHUNKID_OBJECTOFFSETS:
+				midx->chunk_object_offsets = data + chunk_offset;
+				break;
+
+			case MIDX_CHUNKID_LARGEOFFSETS:
+				midx->chunk_large_offsets = data + chunk_offset;
+				break;
+
+			case 0:
+				break;
+
+			default:
+				munmap(midx_map, midx_size);
+				close(fd);
+				die("unrecognized MIDX chunk id: %08x", chunk_id);
+		}
+	}
+
+	midx->num_objects = ntohl(*((uint32_t*)(midx->chunk_oid_fanout + 255 * 4)));
+	midx->num_packs = ntohl(midx->hdr->num_packs);
+
+	packs_len = st_mult(sizeof(struct packed_git*), midx->num_packs);
+
+	if (packs_len) {
+		ALLOC_ARRAY(midx->packs, midx->num_packs);
+		ALLOC_ARRAY(midx->pack_names, midx->num_packs);
+		memset(midx->packs, 0, packs_len);
+
+		for (i = 0; i < midx->num_packs; i++) {
+			uint32_t name_offset = ntohl(*(uint32_t*)(midx->chunk_pack_lookup + 4 * i));
+			midx->pack_names[i] = (const char*)(midx->chunk_pack_names + name_offset);
+		}
+	}
+
+	strcpy(midx->pack_dir, pack_dir);
+	return midx;
+}
+
+struct midxed_git *get_midxed_git(const char *pack_dir, struct object_id *oid)
+{
+	struct midxed_git *m;
+	char *fname = get_midx_filename_oid(pack_dir, oid);
+	m = load_midxed_git_one(fname, pack_dir);
+	free(fname);
+	return m;
+}
+
 struct pack_midx_details_internal {
 	uint32_t pack_int_id;
 	uint32_t internal_offset;
diff --git a/midx.h b/midx.h
index 9d9ab85261..92b74e49db 100644
--- a/midx.h
+++ b/midx.h
@@ -27,6 +27,64 @@ struct pack_midx_header {
 	uint32_t num_packs;
 };
 
+struct midxed_git {
+	struct midxed_git *next;
+
+	int midx_fd;
+
+	/* the mmap'd data for the midx file */
+	const unsigned char *data;
+	size_t data_len;
+
+	/* points into the mmap'd data */
+	struct pack_midx_header *hdr;
+
+	/* can construct filename from obj_dir + "/packs/midx-" + oid + ".midx" */
+	struct object_id oid;
+
+	/* derived from the fanout chunk */
+	uint32_t num_objects;
+
+	/* converted number of packs */
+	uint32_t num_packs;
+
+	/* hdr->num_packs * 4 bytes */
+	const unsigned char *chunk_pack_lookup;
+	const unsigned char *chunk_pack_names;
+
+	/* 256 * 4 bytes */
+	const unsigned char *chunk_oid_fanout;
+
+	/* num_objects * hdr->hash_len bytes */
+	const unsigned char *chunk_oid_lookup;
+
+	/* num_objects * 8 bytes */
+	const unsigned char *chunk_object_offsets;
+
+	/*
+	 * 8 bytes per large offset.
+	 * (Optional: may be null.)
+	 */
+	const unsigned char *chunk_large_offsets;
+
+	/*
+	 * Points into mmap'd data storing the pack filenames.
+	 */
+	const char **pack_names;
+
+	/*
+	 * Store an array of pack-pointers. If NULL, then the
+	 * pack has not been loaded yet. The array indices
+	 * correspond to the pack_int_ids from the midx storage.
+	 */
+	struct packed_git **packs;
+
+	/* something like ".git/objects/pack" */
+	char pack_dir[FLEX_ARRAY]; /* more */
+};
+
+extern struct midxed_git *get_midxed_git(const char *pack_dir, struct object_id *oid);
+
 /*
  * Write a single MIDX file storing the given entries for the
  * given list of packfiles. If midx_name is null, then a temp
diff --git a/t/t5318-midx.sh b/t/t5318-midx.sh
index b66efcdce9..2e52389442 100755
--- a/t/t5318-midx.sh
+++ b/t/t5318-midx.sh
@@ -26,11 +26,27 @@ test_expect_success 'create objects' \
      git commit -m "test data 1" &&
      git branch commit1 HEAD'
 
+_midx_read_expect() {
+	cat >expect <<- EOF
+	header: 4d494458 1 1 20 0 5 $1
+	num_objects: $2
+	chunks: pack_lookup pack_names oid_fanout oid_lookup object_offsets
+	pack_names:
+	$(ls $3 | grep pack | grep -v idx | sort)
+	pack_dir: $3
+	EOF
+}
+
 test_expect_success 'write-midx from index version 1' \
     'pack1=$(git rev-list --all --objects | git pack-objects --index-version=1 ${packdir}/test-1) &&
      midx1=$(git midx --write) &&
      test_path_is_file ${packdir}/midx-${midx1}.midx &&
-     test_path_is_missing ${packdir}/midx-head'
+     test_path_is_missing ${packdir}/midx-head &&
+     _midx_read_expect \
+         "1" "102" \
+         "${packdir}" &&
+     git midx --read --midx-id=${midx1} >output &&
+     cmp output expect'
 
 test_expect_success 'write-midx from index version 2' \
     'rm "${packdir}/test-1-${pack1}.pack" &&
@@ -38,12 +54,17 @@ test_expect_success 'write-midx from index version 2' \
      midx2=$(git midx --write --update-head) &&
      test_path_is_file ${packdir}/midx-${midx2}.midx &&
      test_path_is_file ${packdir}/midx-head &&
-     test $(cat ${packdir}/midx-head) = "$midx2"'
+     test $(cat ${packdir}/midx-head) = "$midx2" &&
+     _midx_read_expect \
+         "1" "102" \
+         "${packdir}" &&
+     git midx --read> output &&
+     cmp output expect'
 
 test_expect_success 'Create more objects' \
     'for i in $(test_seq 100)
      do
-         echo $i >file-2-$i
+         echo extra-$i >file-2-$i
      done &&
      git add file-* &&
      test_tick &&
@@ -55,28 +76,32 @@ test_expect_success 'write-midx with two packs' \
      midx3=$(git midx --write --update-head) &&
      test_path_is_file ${packdir}/midx-${midx3}.midx &&
      test_path_is_file ${packdir}/midx-head &&
-     test $(cat ${packdir}/midx-head) = "$midx3"'
+     test $(cat ${packdir}/midx-head) = "$midx3" &&
+     _midx_read_expect \
+         "2" "204" \
+	 "${packdir}" &&
+     git midx --read >output &&
+     cmp output expect'
 
 test_expect_success 'Add more packs' \
-    'for j in $(test_seq 10)
+    'for i in $(test_seq 10)
      do
-         jjj=$(printf '%03i' $j)
-         test-genrandom "bar" 200 > wide_delta_$jjj &&
-         test-genrandom "baz $jjj" 50 >> wide_delta_$jjj &&
-         test-genrandom "foo"$j 100 > deep_delta_$jjj &&
-         test-genrandom "foo"$(expr $j + 1) 100 >> deep_delta_$jjj &&
-         test-genrandom "foo"$(expr $j + 2) 100 >> deep_delta_$jjj &&
-         echo $jjj >file_$jjj &&
-         test-genrandom "$jjj" 8192 >>file_$jjj &&
-         git update-index --add file_$jjj deep_delta_$jjj wide_delta_$jjj &&
+         iii=$(printf '%03i' $i)
+         test-genrandom "bar" 200 > wide_delta_$iii &&
+         test-genrandom "baz $iii" 50 >> wide_delta_$iii &&
+         test-genrandom "foo"$i 100 > deep_delta_$iii &&
+         test-genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+         test-genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
+         echo $iii >file_$iii &&
+         test-genrandom "$iii" 8192 >>file_$iii &&
+         git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
          { echo 101 && test-genrandom 100 8192; } >file_101 &&
          git update-index --add file_101 &&
-         commit=$(git commit-tree $EMPTY_TREE -p HEAD</dev/null) && {
-         echo $EMPTY_TREE &&
-         git ls-tree $EMPTY_TREE | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+         tree=$(git write-tree) &&
+         commit=$(git commit-tree $tree -p HEAD</dev/null) && {
+         echo $tree &&
+         git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
          } >obj-list &&
-         echo commit_packs_$j = $commit &&
-	 git branch commit_packs_$j $commit &&
          git update-ref HEAD $commit &&
          git pack-objects --index-version=2 ${packdir}/test-pack <obj-list
      done'
@@ -85,7 +110,12 @@ test_expect_success 'write-midx with twelve packs' \
     'midx4=$(git midx --write --update-head) &&
      test_path_is_file ${packdir}/midx-${midx4}.midx &&
      test_path_is_file ${packdir}/midx-head &&
-     test $(cat ${packdir}/midx-head) = "$midx4"'
+     test $(cat ${packdir}/midx-head) = "$midx4" &&
+     _midx_read_expect \
+         "12" "245" \
+         "${packdir}" &&
+     git midx --read >output &&
+     cmp output expect'
 
 test_expect_success 'write-midx with no new packs' \
     'midx5=$(git midx --write --update-head) &&
@@ -100,12 +130,17 @@ test_expect_success 'create bare repo' \
      cd bare &&
      git config core.midx true &&
      git config pack.threads 1 &&
-     baredir=objects/pack'
+     baredir=./objects/pack'
 
 test_expect_success 'write-midx in bare repo' \
     'midxbare=$(git midx --write --update-head) &&
      test_path_is_file ${baredir}/midx-${midxbare}.midx  &&
      test_path_is_file ${baredir}/midx-head &&
-     test $(cat ${baredir}/midx-head) = "$midxbare"'
+     test $(cat ${baredir}/midx-head) = "$midxbare" &&
+     _midx_read_expect \
+         "12" "245" \
+         "${baredir}" &&
+     git midx --read >output &&
+     cmp output expect'
 
 test_done
-- 
2.15.0

