Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF7C433E6
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BC164DB1
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhBVTZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhBVTUy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:20:54 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E0C061794
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:14 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t7so7815659pfq.6
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=4anif06XN1Y2NULTUcwd9CciRtPdaNZlPiouoa5xjB0=;
        b=XFpC15zxJH6LpWRpVTkH6HHnyATkjAJOoaIxmeGC61bVpnE9U1mBbY4p3lJpYjApY+
         fzOy+PAI/9gc+VBOGTeto74RyaAniXwZOgHPW94mT7WUZHTn5HC+1ErKV7QKsirfP+tS
         fAOFQXWc0yMWzAo8+/E8cPUm3sa64UaYdMioaA5DPnzYtTqsWlNEpP27pecJ3NrF/1BO
         a6xD9r9la97rodFMt0/Xx9bDfnjtcxZGOXBZM9t0CgCRK4JjfqH7ZYg3QDSsqGBny98R
         uLmIvxh1WA6LHdVqFiaYuzNlKmEamqVGGshkNVMtcGf5zcF/7mifUCyVxq0SctGtXmfS
         6X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4anif06XN1Y2NULTUcwd9CciRtPdaNZlPiouoa5xjB0=;
        b=doXkG2x4cYdNcEXNWZbZ/cpAOCeb4+eDhDU55ftNqZGGNpdzdpnqwkuzlucGJQI2W3
         1IqatNbvMeYekThms2VveZnUe365zx0PQdXKCLOJRfX1ImUjMojonxSFeQjRMl81Nz4J
         1RGwvnRz9i672ASxZjEZjZgz235d4bTj0+7KQrCwcglf+Y5XNKb0/Wt3sVqeXDn9Izw7
         iTUqOInRdt6QSOLl5IfUt3G3qoG3hVS4iVI0Gyl+2f8pkbao21Vx2PrKp2XjPGcMjNIM
         ycem2+wsHY9wQWypHO6/Pogx6PXk7PtlPvU1XlOqQ4Y8GfwIEaaDNxz7hjaTkM36GF1W
         1VNw==
X-Gm-Message-State: AOAM533e2B/ISFDFFWObHqkYIVOz7UBHEDPidQNSd+fSlPCWg20+46V3
        K/bIalsUcPplBd2snrpAvJ3W2uDsF4VuoOTipByqzYtkI+J5qfwqHIQUd7fjG6W7aNMg0HEX2fm
        MuW0ZU1OFV8icwOvbk0u55iIh6ZPbxdRndo9W6Sc6SOY2eKbcHH7B6NM8PF90qDiY7f7mkGA3Zp
        Im
X-Google-Smtp-Source: ABdhPJw1/JWlOZVj8qDHG0NNtWRWFhTJrdPz4RQrWEcBaoBiNEkh1afxJ3Z0oPp5FmJf7HE/x83VzbrzRfiUbFUl00ek
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:1524:: with SMTP id
 v36mr20723049pgl.221.1614021613238; Mon, 22 Feb 2021 11:20:13 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:20:05 -0800
In-Reply-To: <20210115234300.350442-1-jonathantanmy@google.com>
Message-Id: <cover.1614021092.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 0/4] Check .gitmodules when using packfile URIs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's v2. I think I've addressed all the review comments, including
passing the index-pack args as separate arguments (to avoid the
necessity to somehow encode in order to get rid of spaces), and by using
a custom error function instead of a specific option in fsck.

This applies on master. I mentioned earlier [1] that I was planning to
implement this on =C3=86var's fsck API improvements, but after looking at t=
he
latest v2, I see that it omits patch 11 from v1 (which is the one I
need), so what I've done is to use a string check in the meantime.

[1] https://lore.kernel.org/git/20210219004612.1181920-1-jonathantanmy@goog=
le.com/

Jonathan Tan (4):
  http: allow custom index-pack args
  http-fetch: allow custom index-pack args
  fetch-pack: with packfile URIs, use index-pack arg
  fetch-pack: print and use dangling .gitmodules

 Documentation/git-http-fetch.txt |  10 ++-
 Documentation/git-index-pack.txt |   7 ++-
 builtin/index-pack.c             |  25 +++++++-
 builtin/receive-pack.c           |   2 +-
 fetch-pack.c                     | 103 ++++++++++++++++++++++++++-----
 fsck.c                           |   5 ++
 fsck.h                           |   2 +
 http-fetch.c                     |  20 +++++-
 http.c                           |  15 ++---
 http.h                           |  10 +--
 pack-write.c                     |   8 ++-
 pack.h                           |   2 +-
 t/t5550-http-fetch-dumb.sh       |   5 +-
 t/t5702-protocol-v2.sh           |  58 +++++++++++++++--
 14 files changed, 227 insertions(+), 45 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  b7e376be16 http: allow custom index-pack args
1:  9fba6c9bcc ! 2:  57220ceb84 http-fetch: allow custom index-pack args
    @@ Documentation/git-http-fetch.txt: commit-id::
     =20
      --packfile=3D<hash>::
     -	Instead of a commit id on the command line (which is not expected in
    -+	For internal use only. Instead of a commit id on the command line (w=
hich is not expected in
    ++	For internal use only. Instead of a commit id on the command
    ++	line (which is not expected in
      	this case), 'git http-fetch' fetches the packfile directly at the gi=
ven
      	URL and uses index-pack to generate corresponding .idx and .keep fil=
es.
      	The hash is used to determine the name of the temporary file and is
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_=
args *args,
      		strvec_pushf(&cmd.args, "--packfile=3D%.*s",
      			     (int) the_hash_algo->hexsz,
      			     packfile_uris.items[i].string);
    -+		strvec_push(&cmd.args, "--index-pack-args=3Dindex-pack --stdin --ke=
ep");
    ++		strvec_push(&cmd.args, "--index-pack-arg=3Dindex-pack");
    ++		strvec_push(&cmd.args, "--index-pack-arg=3D--stdin");
    ++		strvec_push(&cmd.args, "--index-pack-arg=3D--keep");
      		strvec_push(&cmd.args, uri);
      		cmd.git_cmd =3D 1;
      		cmd.no_stdin =3D 1;
    @@ http-fetch.c: int cmd_main(int argc, const char **argv)
      	int packfile =3D 0;
      	int nongit;
      	struct object_id packfile_hash;
    -+	const char *index_pack_args =3D NULL;
    ++	struct strvec index_pack_args =3D STRVEC_INIT;
     =20
      	setup_git_directory_gently(&nongit);
     =20
    @@ http-fetch.c: int cmd_main(int argc, const char **argv)
      			packfile =3D 1;
      			if (parse_oid_hex(p, &packfile_hash, &end) || *end)
      				die(_("argument to --packfile must be a valid hash (got '%s')"), =
p);
    -+		} else if (skip_prefix(argv[arg], "--index-pack-args=3D", &p)) {
    -+			index_pack_args =3D p;
    ++		} else if (skip_prefix(argv[arg], "--index-pack-arg=3D", &p)) {
    ++			strvec_push(&index_pack_args, p);
      		}
      		arg++;
      	}
    @@ http-fetch.c: int cmd_main(int argc, const char **argv)
     =20
      	if (packfile) {
     -		fetch_single_packfile(&packfile_hash, argv[arg]);
    -+		struct strvec encoded =3D STRVEC_INIT;
    -+		char **raw;
    -+		int i;
    -+
    -+		if (!index_pack_args)
    ++		if (!index_pack_args.nr)
     +			die(_("--packfile requires --index-pack-args"));
     +
    -+		strvec_split(&encoded, index_pack_args);
    -+
    -+		CALLOC_ARRAY(raw, encoded.nr + 1);
    -+		for (i =3D 0; i < encoded.nr; i++)
    -+			raw[i] =3D url_percent_decode(encoded.v[i]);
    -+
     +		fetch_single_packfile(&packfile_hash, argv[arg],
    -+				      (const char **) raw);
    -+
    -+		for (i =3D 0; i < encoded.nr; i++)
    -+			free(raw[i]);
    -+		free(raw);
    -+		strvec_clear(&encoded);
    ++				      index_pack_args.v);
     +
      		return 0;
      	}
     =20
    -+	if (index_pack_args)
    ++	if (index_pack_args.nr)
     +		die(_("--index-pack-args can only be used with --packfile"));
     +
      	if (commits_on_stdin) {
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfi=
le' '
      	p=3D$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pac=
k/pack-*.pack) &&
     -	git -C packfileclient http-fetch --packfile=3D$ARBITRARY "$HTTPD_URL=
"/dumb/repo_pack.git/$p >out &&
     +	git -C packfileclient http-fetch --packfile=3D$ARBITRARY \
    -+		--index-pack-args=3D"index-pack --stdin --keep" "$HTTPD_URL"/dumb/r=
epo_pack.git/$p >out &&
    ++		--index-pack-arg=3Dindex-pack --index-pack-arg=3D--stdin \
    ++		--index-pack-arg=3D--keep \
    ++		"$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
     =20
      	grep "^keep.[0-9a-f]\{16,\}$" out &&
      	cut -c6- out >packhash &&
2:  7c3244e79f ! 3:  aa87335464 fetch-pack: with packfile URIs, use index-p=
ack arg
    @@ fetch-pack.c: static void write_promisor_file(const char *keep_name,
     - * Pass 1 as "only_packfile" if the pack received is the only pack in=
 this
     - * fetch request (that is, if there were no packfile URIs provided).
     + * If packfile URIs were provided, pass a non-NULL pointer to index_p=
ack_args.
    -+ * The string to pass as the --index-pack-args argument to http-fetch=
 will be
    ++ * The strings to pass as the --index-pack-arg arguments to http-fetc=
h will be
     + * stored there. (It must be freed by the caller.)
       */
      static int get_pack(struct fetch_pack_args *args,
      		    int xd[2], struct string_list *pack_lockfiles,
     -		    int only_packfile,
    -+		    char **index_pack_args,
    ++		    struct strvec *index_pack_args,
      		    struct ref **sought, int nr_sought)
      {
      	struct async demux;
    @@ fetch-pack.c: static int get_pack(struct fetch_pack_args *args,
      	}
     =20
     +	if (index_pack_args) {
    -+		struct strbuf joined =3D STRBUF_INIT;
     +		int i;
     +
    -+		for (i =3D 0; i < cmd.args.nr; i++) {
    -+			if (i)
    -+				strbuf_addch(&joined, ' ');
    -+			strbuf_addstr_urlencode(&joined, cmd.args.v[i],
    -+						is_rfc3986_unreserved);
    -+		}
    -+		*index_pack_args =3D strbuf_detach(&joined, NULL);
    ++		for (i =3D 0; i < cmd.args.nr; i++)
    ++			strvec_push(index_pack_args, cmd.args.v[i]);
     +	}
     +
      	cmd.in =3D demux.out;
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_=
args *args,
      	int seen_ack =3D 0;
      	struct string_list packfile_uris =3D STRING_LIST_INIT_DUP;
      	int i;
    -+	char *index_pack_args =3D NULL;
    ++	struct strvec index_pack_args =3D STRVEC_INIT;
     =20
      	negotiator =3D &negotiator_alloc;
      	fetch_negotiator_init(r, negotiator);
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_=
args *args,
      				die(_("git fetch-pack: fetch failed."));
      			do_check_stateless_delimiter(args, &reader);
     =20
    +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack=
_args *args,
    + 	}
    +=20
    + 	for (i =3D 0; i < packfile_uris.nr; i++) {
    ++		int j;
    + 		struct child_process cmd =3D CHILD_PROCESS_INIT;
    + 		char packname[GIT_MAX_HEXSZ + 1];
    + 		const char *uri =3D packfile_uris.items[i].string +
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack=
_args *args,
      		strvec_pushf(&cmd.args, "--packfile=3D%.*s",
      			     (int) the_hash_algo->hexsz,
      			     packfile_uris.items[i].string);
    --		strvec_push(&cmd.args, "--index-pack-args=3Dindex-pack --stdin --ke=
ep");
    -+		strvec_pushf(&cmd.args, "--index-pack-args=3D%s", index_pack_args);
    +-		strvec_push(&cmd.args, "--index-pack-arg=3Dindex-pack");
    +-		strvec_push(&cmd.args, "--index-pack-arg=3D--stdin");
    +-		strvec_push(&cmd.args, "--index-pack-arg=3D--keep");
    ++		for (j =3D 0; j < index_pack_args.nr; j++)
    ++			strvec_pushf(&cmd.args, "--index-pack-arg=3D%s",
    ++				     index_pack_args.v[j]);
      		strvec_push(&cmd.args, uri);
      		cmd.git_cmd =3D 1;
      		cmd.no_stdin =3D 1;
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_=
args *args,
      						 packname));
      	}
      	string_list_clear(&packfile_uris, 0);
    -+	FREE_AND_NULL(index_pack_args);
    ++	strvec_clear(&index_pack_args);
     =20
      	if (negotiator)
      		negotiator->release(negotiator);
3:  384c9d1c73 ! 4:  e8b18d02e6 fetch-pack: print and use dangling .gitmodu=
les
    @@ Documentation/git-index-pack.txt: OPTIONS
      	Specifies the number of threads to spawn when resolving
    =20
      ## builtin/index-pack.c ##
    +@@ builtin/index-pack.c: static void show_pack_info(int stat_only)
    + 	}
    + }
    +=20
    ++static int print_dangling_gitmodules(struct fsck_options *o,
    ++				     const struct object_id *oid,
    ++				     enum object_type object_type,
    ++				     int msg_type, const char *message)
    ++{
    ++	/*
    ++	 * NEEDSWORK: Plumb the MSG_ID (from fsck.c) here and use it
    ++	 * instead of relying on this string check.
    ++	 */
    ++	if (starts_with(message, "gitmodulesMissing")) {
    ++		printf("%s\n", oid_to_hex(oid));
    ++		return 0;
    ++	}
    ++	return fsck_error_function(o, oid, object_type, msg_type, message);
    ++}
    ++
    + int cmd_index_pack(int argc, const char **argv, const char *prefix)
    + {
    + 	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0;
     @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **arg=
v, const char *prefix)
      	else
      		close(input_fd);
    @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv=
, const char
     -	if (do_fsck_object && fsck_finish(&fsck_options))
     -		die(_("fsck error in pack objects"));
     +	if (do_fsck_object) {
    -+		struct fsck_options fo =3D FSCK_OPTIONS_STRICT;
    ++		struct fsck_options fo =3D fsck_options;
     +
    -+		fo.print_dangling_gitmodules =3D 1;
    ++		fo.error_func =3D print_dangling_gitmodules;
     +		if (fsck_finish(&fo))
     +			die(_("fsck error in pack objects"));
     +	}
    @@ fetch-pack.c: static void write_promisor_file(const char *keep_name,
     +
      /*
       * If packfile URIs were provided, pass a non-NULL pointer to index_p=
ack_args.
    -  * The string to pass as the --index-pack-args argument to http-fetch=
 will be
    +  * The strings to pass as the --index-pack-arg arguments to http-fetc=
h will be
     @@ fetch-pack.c: static void write_promisor_file(const char *keep_name=
,
      static int get_pack(struct fetch_pack_args *args,
      		    int xd[2], struct string_list *pack_lockfiles,
    - 		    char **index_pack_args,
    + 		    struct strvec *index_pack_args,
     -		    struct ref **sought, int nr_sought)
     +		    struct ref **sought, int nr_sought,
     +		    struct oidset *gitmodules_oids)
    @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_arg=
s *args,
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack=
_args *args,
      	struct string_list packfile_uris =3D STRING_LIST_INIT_DUP;
      	int i;
    - 	char *index_pack_args =3D NULL;
    + 	struct strvec index_pack_args =3D STRVEC_INIT;
     +	struct oidset gitmodules_oids =3D OIDSET_INIT;
     =20
      	negotiator =3D &negotiator_alloc;
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_=
args *args,
      		if (finish_command(&cmd))
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack=
_args *args,
      	string_list_clear(&packfile_uris, 0);
    - 	FREE_AND_NULL(index_pack_args);
    + 	strvec_clear(&index_pack_args);
     =20
     +	fsck_gitmodules_oids(&gitmodules_oids);
     +
    @@ fsck.c: int fsck_error_function(struct fsck_options *o,
      int fsck_finish(struct fsck_options *options)
      {
      	int ret =3D 0;
    -@@ fsck.c: int fsck_finish(struct fsck_options *options)
    - 		if (!buf) {
    - 			if (is_promisor_object(oid))
    - 				continue;
    --			ret |=3D report(options,
    --				      oid, OBJ_BLOB,
    --				      FSCK_MSG_GITMODULES_MISSING,
    --				      "unable to read .gitmodules blob");
    -+			if (options->print_dangling_gitmodules)
    -+				printf("%s\n", oid_to_hex(oid));
    -+			else
    -+				ret |=3D report(options,
    -+					      oid, OBJ_BLOB,
    -+					      FSCK_MSG_GITMODULES_MISSING,
    -+					      "unable to read .gitmodules blob");
    - 			continue;
    - 		}
    -=20
    =20
      ## fsck.h ##
    -@@ fsck.h: struct fsck_options {
    - 	int *msg_type;
    - 	struct oidset skiplist;
    - 	kh_oid_map_t *object_names;
    -+
    -+	/*
    -+	 * If 1, print the hashes of missing .gitmodules blobs instead of
    -+	 * considering them to be errors.
    -+	 */
    -+	unsigned print_dangling_gitmodules:1;
    - };
    -=20
    - #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OI=
DSET_INIT }
     @@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_o=
ptions *options);
      int fsck_object(struct object *obj, void *data, unsigned long size,
      	struct fsck_options *options);
    @@ pack.h: int verify_pack_index(struct packed_git *);
       * The "hdr" output buffer should be at least this big, which will ha=
ndle sizes
    =20
      ## t/t5702-protocol-v2.sh ##
    +@@ t/t5702-protocol-v2.sh: test_expect_success 'part of packfile respo=
nse provided as URI' '
    + 	test -f hfound &&
    + 	test -f h2found &&
    +=20
    +-	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
    +-	ls http_child/.git/objects/pack/* >filelist &&
    ++	# Ensure that there are exactly 3 packfiles with associated .idx
    ++	ls http_child/.git/objects/pack/*.pack \
    ++	    http_child/.git/objects/pack/*.idx >filelist &&
    + 	test_line_count =3D 6 filelist
    + '
    +=20
    +@@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with tran=
sfer.fsckobjects' '
    + 		-c fetch.uriprotocols=3Dhttp,https \
    + 		clone "$HTTPD_URL/smart/http_parent" http_child &&
    +=20
    +-	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
    +-	ls http_child/.git/objects/pack/* >filelist &&
    ++	# Ensure that there are exactly 2 packfiles with associated .idx
    ++	ls http_child/.git/objects/pack/*.pack \
    ++	    http_child/.git/objects/pack/*.idx >filelist &&
    + 	test_line_count =3D 4 filelist
    + '
    +=20
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with tran=
sfer.fsckobjects fails on bad object'
      	test_i18ngrep "invalid author/committer line - missing email" error
      '
    @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with trans=
fer.fsckobje
     +		-c fetch.uriprotocols=3Dhttp,https \
     +		clone "$HTTPD_URL/smart/http_parent" http_child &&
     +
    -+	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
    -+	ls http_child/.git/objects/pack/* >filelist &&
    ++	# Ensure that there are exactly 2 packfiles with associated .idx
    ++	ls http_child/.git/objects/pack/*.pack \
    ++	    http_child/.git/objects/pack/*.idx >filelist &&
     +	test_line_count =3D 4 filelist
     +'
     +
4:  da0d7b38ae < -:  ---------- SQUASH??? test fix
--=20
2.30.0.617.g56c4b15f3c-goog

