Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEABC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B3FE207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+3Po0ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgE2Waq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgE2Wan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AEFC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r18so4729331ybg.10
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cUKHyxmV7H1d49kXyReIwwb/hcHEYYYeMJPZ+erbffA=;
        b=K+3Po0EDGYFg08SSewSEkljUrPDszpOsqhySC9UhDahfZSDnXnah3HW3wNOj8x41Mb
         L/U4D8bqHgqrjkCw1W+pkSZ2cPrpqLDeUx4zKWt3fyk3qagZko6zzEc+nKqIkw/y31/E
         YOzs5eywnS7g/HG18NPOS7Ednl+ujfumiOqMi/5ORpO5aeuNDw09f3aEa8YYOdiULoXQ
         msvPFP6i2YNg61VIsCLNEiOvxzpIBm/Vj0Vt92gZ3GP47YWo7t9kfPvBtUIm8h29w/qK
         6jowps0GjLnc6uzTFbpMOb/3Apt7mhUg/qpJRS8ovCZskSYAvxievjTbEZ8lLjyC8+XF
         ngWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cUKHyxmV7H1d49kXyReIwwb/hcHEYYYeMJPZ+erbffA=;
        b=hULSzBcdV1bDd4jTakZvugb/+VXMhxd47/ZtCZDs39YfdekyphcsrDw0V7O+UR95L5
         5FmNWbs8xRJGmfSIjP/HWEXtNlYDVm0pm5Ti+xrbIwR1e4tEpBoKh8sNMUcN4V1PxTWr
         Yt54y8JFjnE08Lw4adziYfkeKAUUTlR/Po6AEO7Or6S5R5TPYdesN2dVaU9s60T382pt
         dW+gpLy6lx3CoJosAdMhb+ca1c5QGVjMspkp+OrRwLT2thXPN6ZtxistuYovgUoI/rCH
         LewLL4WutfXc7lXlaBTZPcsu4Q6kcpWI5vs5pK6ZTIpynvecGYlmZzQK3jhPJ3Kz/Acq
         U/tg==
X-Gm-Message-State: AOAM530lcf/0GDtTGRM4ycZ9uzlB9crygANbi1AKoJHBiX7iQhVuYLXl
        aOiFp8Mi9lNbTzVNgByiJW7dLV34QS9SNAd8B1bJ1URH6zQf/jnCye0b7e8CmD4eRWtzQ2aUlvC
        1ZaO9CXW1B8GCjwwROcWq5AjLFciVoIZz/M+g1oIKC7lh5gOtBw0U9tDECvltovvjDnkY/Sry0l
        PN
X-Google-Smtp-Source: ABdhPJw5Rqdq83Ha++oHInk7v4aGO4e+CpHbNmQNBEXuxmQe6Zt0Lo2MZtEy5UCBwcDejJxNZi3u3pvEyRK02BGOt1k9
X-Received: by 2002:a25:ac8:: with SMTP id 191mr16767243ybk.390.1590791442431;
 Fri, 29 May 2020 15:30:42 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:20 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <2cfee363873736d9ff73cd38d96f3533bb49c904.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 8/8] upload-pack: send part of packfile response as uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach upload-pack to send part of its packfile response as URIs.

An administrator may configure a repository with one or more
"uploadpack.blobpackfileuri" lines, each line containing an OID, a pack
hash, and a URI. A client may configure fetch.uriprotocols to be a
comma-separated list of protocols that it is willing to use to fetch
additional packfiles - this list will be sent to the server. Whenever an
object with one of those OIDs would appear in the packfile transmitted
by upload-pack, the server may exclude that object, and instead send the
URI. The client will then download the packs referred to by those URIs
before performing the connectivity check.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c |  76 ++++++++++++++++++++++++++++
 fetch-pack.c           | 110 +++++++++++++++++++++++++++++++++++++++--
 t/t5702-protocol-v2.sh |  88 +++++++++++++++++++++++++++++++++
 upload-pack.c          |  80 +++++++++++++++++++++++++++---
 4 files changed, 344 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c5b433a23f..7016b28485 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -117,6 +117,8 @@ static unsigned long window_memory_limit = 0;
 
 static struct list_objects_filter_options filter_options;
 
+static struct string_list uri_protocols = STRING_LIST_INIT_NODUP;
+
 enum missing_action {
 	MA_ERROR = 0,      /* fail if any missing objects are encountered */
 	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
@@ -125,6 +127,15 @@ enum missing_action {
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
 
+struct configured_exclusion {
+	struct oidmap_entry e;
+	char *pack_hash_hex;
+	char *uri;
+};
+static struct oidmap configured_exclusions;
+
+static struct oidset excluded_by_config;
+
 /*
  * stats
  */
@@ -969,6 +980,25 @@ static void write_reused_pack(struct hashfile *f)
 	unuse_pack(&w_curs);
 }
 
+static void write_excluded_by_configs(void)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+
+	oidset_iter_init(&excluded_by_config, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct configured_exclusion *ex =
+			oidmap_get(&configured_exclusions, oid);
+
+		if (!ex)
+			BUG("configured exclusion wasn't configured");
+		write_in_full(1, ex->pack_hash_hex, strlen(ex->pack_hash_hex));
+		write_in_full(1, " ", 1);
+		write_in_full(1, ex->uri, strlen(ex->uri));
+		write_in_full(1, "\n", 1);
+	}
+}
+
 static const char no_split_warning[] = N_(
 "disabling bitmap writing, packs are split due to pack.packSizeLimit"
 );
@@ -1266,6 +1296,25 @@ static int want_object_in_pack(const struct object_id *oid,
 		}
 	}
 
+	if (uri_protocols.nr) {
+		struct configured_exclusion *ex =
+			oidmap_get(&configured_exclusions, oid);
+		int i;
+		const char *p;
+
+		if (ex) {
+			for (i = 0; i < uri_protocols.nr; i++) {
+				if (skip_prefix(ex->uri,
+						uri_protocols.items[i].string,
+						&p) &&
+				    *p == ':') {
+					oidset_insert(&excluded_by_config, oid);
+					return 0;
+				}
+			}
+		}
+	}
+
 	return 1;
 }
 
@@ -2864,6 +2913,29 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
+	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
+		const char *oid_end, *pack_end;
+		/*
+		 * Stores the pack hash. This is not a true object ID, but is
+		 * of the same form.
+		 */
+		struct object_id pack_hash;
+
+		if (parse_oid_hex(v, &ex->e.oid, &oid_end) ||
+		    *oid_end != ' ' ||
+		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
+		    *pack_end != ' ')
+			die(_("value of uploadpack.blobpackfileuri must be "
+			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
+		if (oidmap_get(&configured_exclusions, &ex->e.oid))
+			die(_("object already configured in another "
+			      "uploadpack.blobpackfileuri (got '%s')"), v);
+		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
+		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
+		ex->uri = xstrdup(pack_end + 1);
+		oidmap_put(&configured_exclusions, ex);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -3462,6 +3534,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
+		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
+				N_("protocol"),
+				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
 		OPT_END(),
 	};
 
@@ -3650,6 +3725,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	trace2_region_enter("pack-objects", "write-pack-file", the_repository);
+	write_excluded_by_configs();
 	write_pack_file();
 	trace2_region_leave("pack-objects", "write-pack-file", the_repository);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 0a9a82bc46..9668c0b66e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,6 +38,7 @@ static int server_supports_filtering;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
+static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -795,6 +796,7 @@ static void write_promisor_file(const char *keep_name,
 
 static int get_pack(struct fetch_pack_args *args,
 		    int xd[2], struct string_list *pack_lockfiles,
+		    int only_packfile,
 		    struct ref **sought, int nr_sought)
 {
 	struct async demux;
@@ -855,8 +857,15 @@ static int get_pack(struct fetch_pack_args *args,
 					"--keep=fetch-pack %"PRIuMAX " on %s",
 					(uintmax_t)getpid(), hostname);
 		}
-		if (args->check_self_contained_and_connected)
+		if (only_packfile && args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
+		else
+			/*
+			 * We cannot perform any connectivity checks because
+			 * not all packs have been downloaded; let the caller
+			 * have this responsibility.
+			 */
+			args->check_self_contained_and_connected = 0;
 		/*
 		 * If we're obtaining the filename of a lockfile, we'll use
 		 * that filename to write a .promisor file with more
@@ -1068,7 +1077,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfiles, sought, nr_sought))
+	if (get_pack(args, fd, pack_lockfiles, 1, sought, nr_sought))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1222,6 +1231,26 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		warning("filtering not recognized by server, ignoring");
 	}
 
+	if (server_supports_feature("fetch", "packfile-uris", 0)) {
+		int i;
+		struct strbuf to_send = STRBUF_INIT;
+
+		for (i = 0; i < uri_protocols.nr; i++) {
+			const char *s = uri_protocols.items[i].string;
+
+			if (!strcmp(s, "https") || !strcmp(s, "http")) {
+				if (to_send.len)
+					strbuf_addch(&to_send, ',');
+				strbuf_addstr(&to_send, s);
+			}
+		}
+		if (to_send.len) {
+			packet_buf_write(&req_buf, "packfile-uris %s",
+					 to_send.buf);
+			strbuf_release(&to_send);
+		}
+	}
+
 	/* add wants */
 	add_wants(args->no_dependents, wants, &req_buf);
 
@@ -1444,6 +1473,21 @@ static void receive_wanted_refs(struct packet_reader *reader,
 		die(_("error processing wanted refs: %d"), reader->status);
 }
 
+static void receive_packfile_uris(struct packet_reader *reader,
+				  struct string_list *uris)
+{
+	process_section_header(reader, "packfile-uris", 0);
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		if (reader->pktlen < the_hash_algo->hexsz ||
+		    reader->line[the_hash_algo->hexsz] != ' ')
+			die("expected '<hash> <uri>', got: %s\n", reader->line);
+
+		string_list_append(uris, reader->line);
+	}
+	if (reader->status != PACKET_READ_DELIM)
+		die("expected DELIM");
+}
+
 enum fetch_state {
 	FETCH_CHECK_LOCAL = 0,
 	FETCH_SEND_REQUEST,
@@ -1477,6 +1521,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 	int seen_ack = 0;
+	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
+	int i;
 
 	if (args->no_dependents) {
 		negotiator = NULL;
@@ -1570,9 +1616,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (process_section_header(&reader, "wanted-refs", 1))
 				receive_wanted_refs(&reader, sought, nr_sought);
 
-			/* get the pack */
+			/* get the pack(s) */
+			if (process_section_header(&reader, "packfile-uris", 1))
+				receive_packfile_uris(&reader, &packfile_uris);
 			process_section_header(&reader, "packfile", 0);
-			if (get_pack(args, fd, pack_lockfiles, sought, nr_sought))
+			if (get_pack(args, fd, pack_lockfiles,
+				     !packfile_uris.nr, sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args, &reader);
 
@@ -1583,8 +1632,53 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	for (i = 0; i < packfile_uris.nr; i++) {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+		char packname[GIT_MAX_HEXSZ + 1];
+		const char *uri = packfile_uris.items[i].string +
+			the_hash_algo->hexsz + 1;
+
+		argv_array_push(&cmd.args, "http-fetch");
+		argv_array_push(&cmd.args, "--packfile");
+		argv_array_push(&cmd.args, uri);
+		cmd.git_cmd = 1;
+		cmd.no_stdin = 1;
+		cmd.out = -1;
+		if (start_command(&cmd))
+			die("fetch-pack: unable to spawn http-fetch");
+
+		if (read_in_full(cmd.out, packname, 5) < 0 ||
+		    memcmp(packname, "keep\t", 5))
+			die("fetch-pack: expected keep then TAB at start of http-fetch output");
+
+		if (read_in_full(cmd.out, packname,
+				 the_hash_algo->hexsz + 1) < 0 ||
+		    packname[the_hash_algo->hexsz] != '\n')
+			die("fetch-pack: expected hash then LF at end of http-fetch output");
+
+		packname[the_hash_algo->hexsz] = '\0';
+
+		close(cmd.out);
+
+		if (finish_command(&cmd))
+			die("fetch-pack: unable to finish http-fetch");
+
+		if (memcmp(packfile_uris.items[i].string, packname,
+			   the_hash_algo->hexsz))
+			die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
+			    uri, (int) the_hash_algo->hexsz,
+			    packfile_uris.items[i].string);
+
+		string_list_append_nodup(pack_lockfiles,
+					 xstrfmt("%s/pack/pack-%s.keep",
+						 get_object_directory(),
+						 packname));
+	}
+	string_list_clear(&packfile_uris, 0);
+
 	if (negotiator)
 		negotiator->release(negotiator);
+
 	oidset_clear(&common);
 	return ref;
 }
@@ -1621,6 +1715,14 @@ static void fetch_pack_config(void)
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
+	if (!uri_protocols.nr) {
+		char *str;
+
+		if (!git_config_get_string("fetch.uriprotocols", &str) && str) {
+			string_list_split(&uri_protocols, str, ',', -1);
+			free(str);
+		}
+	}
 
 	git_config(fetch_pack_config_cb, NULL);
 }
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 8da65e60de..3ea9345e6f 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -795,6 +795,94 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
+configure_exclusion () {
+	git -C "$1" hash-object "$2" >objh &&
+	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	git -C "$1" config --add \
+		"uploadpack.blobpackfileuri" \
+		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+	cat objh
+}
+
+test_expect_success 'part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	echo other-blob >"$P/other-blob" &&
+	git -C "$P" add other-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion "$P" other-blob >h2 &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	# Ensure that my-blob and other-blob are in separate packfiles.
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 1 out.objectlist
+		then
+			if grep $(cat h) out
+			then
+				>hfound
+			fi &&
+			if grep $(cat h2) out
+			then
+				>h2found
+			fi
+		fi
+	done &&
+	test -f hfound &&
+	test -f h2found &&
+
+	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
+	ls http_child/.git/objects/pack/* >filelist &&
+	test_line_count = 6 filelist
+'
+
+test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	echo other-blob >"$P/other-blob" &&
+	git -C "$P" add other-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+	# Configure a URL for other-blob. Just reuse the hash of the object as
+	# the hash of the packfile, since the hash does not matter for this
+	# test as long as it is not the hash of the pack, and it is of the
+	# expected length.
+	git -C "$P" hash-object other-blob >objh &&
+	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	git -C "$P" config --add \
+		"uploadpack.blobpackfileuri" \
+		"$(cat objh) $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+
+	GIT_TEST_SIDEBAND_ALL=1 \
+	test_must_fail git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child 2>err &&
+	test_i18ngrep "pack downloaded from.*does not match expected hash" err
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
diff --git a/upload-pack.c b/upload-pack.c
index 13f6152560..d928d1c0a8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -105,9 +105,12 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 struct output_state {
 	char buffer[8193];
 	int used;
+	unsigned packfile_uris_started : 1;
+	unsigned packfile_started : 1;
 };
 
-static int relay_pack_data(int pack_objects_out, struct output_state *os)
+static int relay_pack_data(int pack_objects_out, struct output_state *os,
+			   int write_packfile_line)
 {
 	/*
 	 * We keep the last byte to ourselves
@@ -128,6 +131,37 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os)
 	}
 	os->used += readsz;
 
+	while (!os->packfile_started) {
+		char *p;
+		if (os->used >= 4 && !memcmp(os->buffer, "PACK", 4)) {
+			os->packfile_started = 1;
+			if (write_packfile_line) {
+				if (os->packfile_uris_started)
+					packet_delim(1);
+				packet_write_fmt(1, "\1packfile\n");
+			}
+			break;
+		}
+		if ((p = memchr(os->buffer, '\n', os->used))) {
+			if (!os->packfile_uris_started) {
+				os->packfile_uris_started = 1;
+				if (!write_packfile_line)
+					BUG("packfile_uris requires sideband-all");
+				packet_write_fmt(1, "\1packfile-uris\n");
+			}
+			*p = '\0';
+			packet_write_fmt(1, "\1%s\n", os->buffer);
+
+			os->used -= p - os->buffer + 1;
+			memmove(os->buffer, p + 1, os->used);
+		} else {
+			/*
+			 * Incomplete line.
+			 */
+			return readsz;
+		}
+	}
+
 	if (os->used > 1) {
 		send_client_data(1, os->buffer, os->used - 1);
 		os->buffer[0] = os->buffer[os->used - 1];
@@ -142,7 +176,8 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os)
 
 static void create_pack_file(const struct object_array *have_obj,
 			     const struct object_array *want_obj,
-			     struct list_objects_filter_options *filter_options)
+			     struct list_objects_filter_options *filter_options,
+			     const struct string_list *uri_protocols)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	struct output_state output_state = { { 0 } };
@@ -192,6 +227,11 @@ static void create_pack_file(const struct object_array *have_obj,
 					 spec);
 		}
 	}
+	if (uri_protocols) {
+		for (i = 0; i < uri_protocols->nr; i++)
+			argv_array_pushf(&pack_objects.args, "--uri-protocol=%s",
+					 uri_protocols->items[0].string);
+	}
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -278,7 +318,8 @@ static void create_pack_file(const struct object_array *have_obj,
 		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			int result = relay_pack_data(pack_objects.out,
-						     &output_state);
+						     &output_state,
+						     !!uri_protocols);
 
 			if (result == 0) {
 				close(pack_objects.out);
@@ -1137,7 +1178,7 @@ void upload_pack(struct upload_pack_options *options)
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
 		get_common_commits(&reader, &have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj, &filter_options);
+		create_pack_file(&have_obj, &want_obj, &filter_options, 0);
 	}
 
 	list_objects_filter_release(&filter_options);
@@ -1154,6 +1195,7 @@ struct upload_pack_data {
 	timestamp_t deepen_since;
 	int deepen_rev_list;
 	int deepen_relative;
+	struct string_list uri_protocols;
 
 	struct list_objects_filter_options filter_options;
 
@@ -1175,6 +1217,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct oid_array haves = OID_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
 	data->wants = wants;
@@ -1182,6 +1225,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->haves = haves;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
+	data->uri_protocols = uri_protocols;
 	packet_writer_init(&data->writer, 1);
 }
 
@@ -1342,10 +1386,18 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
+		if (skip_prefix(arg, "packfile-uris ", &p)) {
+			string_list_split(&data->uri_protocols, p, ',', -1);
+			continue;
+		}
+
 		/* ignore unknown lines maybe? */
 		die("unexpected line: '%s'", arg);
 	}
 
+	if (data->uri_protocols.nr && !data->writer.use_sideband)
+		string_list_clear(&data->uri_protocols, 0);
+
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after fetch arguments"));
 }
@@ -1537,8 +1589,15 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data, &want_obj);
 
-			packet_writer_write(&data.writer, "packfile\n");
-			create_pack_file(&have_obj, &want_obj, &data.filter_options);
+			if (data.uri_protocols.nr) {
+				create_pack_file(&have_obj, &want_obj,
+						 &data.filter_options,
+						 &data.uri_protocols);
+			} else {
+				packet_writer_write(&data.writer, "packfile\n");
+				create_pack_file(&have_obj, &want_obj,
+						 &data.filter_options, NULL);
+			}
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
@@ -1559,6 +1618,7 @@ int upload_pack_advertise(struct repository *r,
 		int allow_filter_value;
 		int allow_ref_in_want;
 		int allow_sideband_all_value;
+		char *str = NULL;
 
 		strbuf_addstr(value, "shallow");
 
@@ -1580,6 +1640,14 @@ int upload_pack_advertise(struct repository *r,
 					   &allow_sideband_all_value) &&
 		     allow_sideband_all_value))
 			strbuf_addstr(value, " sideband-all");
+
+		if (!repo_config_get_string(the_repository,
+					    "uploadpack.blobpackfileuri",
+					    &str) &&
+		    str) {
+			strbuf_addstr(value, " packfile-uris");
+			free(str);
+		}
 	}
 
 	return 1;
-- 
2.27.0.rc0.183.gde8f92d652-goog

