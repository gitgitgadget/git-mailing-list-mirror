Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496CC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiC3WIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiC3WIY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:08:24 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374E3B3CF
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:06:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ke15so18153249qvb.11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bayoJxHxWIjyW3NrJF2pH6OkNgj2AVczLkmNfkS3rIA=;
        b=gkkDoiA2cgctxTD40KkLMGmgWdt3l6qJFcFftxNp0wi9RPGcU0DynMuiTN9IegyB/L
         6hFTR0poW4vB8ctTmWodbb93/Flx9yIDYHRpF2yGzUBzm/E72cMBJlswSX24MRveMWPY
         jn0uIeSv0qp6c+Vv9kvZZEruLEMTf3eGuCChuSGWB7Duh0IiFIJ8FXivED5+pHMrvl8s
         DHrfX9o1SpF1oJDvXuJ1T9vT1ZtRQsulO7G5OysreZESC4n5Vs7snOkDYo4Ixrt9LL0u
         7zUs2I1RwlgeicXlq8n3KYzFYhf5jO/rxJgWd8Sfz884DPTwdOORb+pZAnhP7wAofW4/
         5XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bayoJxHxWIjyW3NrJF2pH6OkNgj2AVczLkmNfkS3rIA=;
        b=lvguVWDX+BkdWvnL5tsbowdB64b04JgoGz2qQJd5DNa3FzSDn7rVojC5TRD537S4G1
         nScthpu3wGgZHUHj/CK6IRehMxHjhIlpFK7m+7+u3PGqgAKDR4cp68VGnF1ebj0jkAfU
         CKWSyw2EJA4zhMPKI8pvl4J73J7q0Ioq/Zdh+s5aeelhFX+4cP79RDwhte4Y5PvSY6ZK
         18tktNI9gTiaSEnEu9wlKqFKACIFM8J+8SFuKZi8lG1wnl4BqnGhJwRdz2AZVDHObCOS
         +H0uEt1kFZ6l0TP5sOLxTzJ1mGD8eRcTxUR+l6u65SZKSP00vWcyqzhOJtYH7oVGUaHa
         4Gzg==
X-Gm-Message-State: AOAM532QQghoUYnfJKEAeTNFWUERtAJUhmIbXdYeXuTevBBpzPC5ZKq5
        7x99tWt2eaV8oRkrN4L/bf4=
X-Google-Smtp-Source: ABdhPJzZVaQPB0eIUCIZuqHrzcyg0oYrTLQsjxbpUwwdxndqw/T6/kQltH2xaurGmcUNgVSi+VFufQ==
X-Received: by 2002:a05:6214:21e1:b0:440:fa7a:493e with SMTP id p1-20020a05621421e100b00440fa7a493emr1477132qvj.55.1648677996128;
        Wed, 30 Mar 2022 15:06:36 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id y66-20020a37af45000000b0067dc0fc539fsm11744791qke.86.2022.03.30.15.06.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Mar 2022 15:06:35 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
Date:   Wed, 30 Mar 2022 18:06:35 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <15354CB8-E1DD-476C-B6E0-52F9451108A6@gmail.com>
In-Reply-To: <20220328191112.3092139-4-calvinwan@google.com>
References: <20220208235631.732466-1-calvinwan@google.com>
 <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-4-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28 Mar 2022, at 15:11, Calvin Wan wrote:

> Sometimes it is useful to get information about an object without
> having to download it completely. The server logic has already been
> implemented as =E2=80=9Ca2ba162cda (object-info: support for retrieving=
 object
> info, 2021-04-20)=E2=80=9D. This patch implements the client option for=

> it. Currently, only 'size' is supported, however future patches can
> implement additional options.
>
> Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows=
 the client to
> make an object-info command request to a server that supports protocol
> v2. If the server is v2, but does not allow for the object-info
> command request, fetch the objects as if it were a standard fetch
> (however without changing any refs). Therefore, hook `fetch
> object-info` into transport_fetch_refs() to easily fallback if needed.
>
> A previous patch added the `transfer.advertiseObjectInfo` config
> option, of which this patch utilizes to test the fallback.
>
> ---
>  Documentation/fetch-options.txt |   5 ++
>  Documentation/git-fetch.txt     |   1 +
>  builtin/fetch.c                 |  36 ++++++++-
>  fetch-pack.c                    |  42 +++++++++-
>  fetch-pack.h                    |   9 +++
>  t/t5583-fetch-object-info.sh    | 138 ++++++++++++++++++++++++++++++++=

>  transport-helper.c              |   8 +-
>  transport-internal.h            |   1 +
>  transport.c                     |  75 ++++++++++++++++-
>  transport.h                     |   9 +++
>  10 files changed, 315 insertions(+), 9 deletions(-)
>  create mode 100755 t/t5583-fetch-object-info.sh
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
> index f903683189..f1ca95c32d 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -299,3 +299,8 @@ endif::git-pull[]
>  -6::
>  --ipv6::
>  	Use IPv6 addresses only, ignoring IPv4 addresses.
> +
> +--object-info=3D[<arguments>]::
> +	Fetches only the relevant information passed in arguments from a
> +	specific remote and set of object ids. Object 'size' is currently
> +	the only supported argument.
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 550c16ca61..a13d2ba7ad 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  'git fetch' [<options>] <group>
>  'git fetch' --multiple [<options>] [(<repository> | <group>)...]
>  'git fetch' --all [<options>]
> +'git fetch' --object-info=3D[<arguments>] <remote> [<object-ids>]
>
>
>  DESCRIPTION
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 4d12c2fd4d..0b21bebfca 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -29,6 +29,9 @@
>  #include "commit-graph.h"
>  #include "shallow.h"
>  #include "worktree.h"
> +#include "protocol.h"
> +#include "pkt-line.h"
> +#include "connect.h"
>
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>
> @@ -37,6 +40,7 @@ static const char * const builtin_fetch_usage[] =3D {=

>  	N_("git fetch [<options>] <group>"),
>  	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),=

>  	N_("git fetch --all [<options>]"),
> +	N_("git fetch --object-info=3D[<arguments>] <remote> [<object-ids>]")=
,
>  	NULL
>  };
>
> @@ -86,6 +90,7 @@ static struct string_list negotiation_tip =3D STRING_=
LIST_INIT_NODUP;
>  static int fetch_write_commit_graph =3D -1;
>  static int stdin_refspecs =3D 0;
>  static int negotiate_only;
> +static struct string_list object_info_options =3D STRING_LIST_INIT_NOD=
UP;
>
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
> @@ -221,6 +226,8 @@ static struct option builtin_fetch_options[] =3D {
>  		 N_("write the commit-graph after fetching")),
>  	OPT_BOOL(0, "stdin", &stdin_refspecs,
>  		 N_("accept refspecs from stdin")),
> +	OPT_STRING_LIST(0, "object-info", &object_info_options, N_("option"),=

> +		 N_("command request arguments")),
>  	OPT_END()
>  };
>
> @@ -2087,6 +2094,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
>  	struct remote *remote =3D NULL;
>  	int result =3D 0;
>  	int prune_tags_ok =3D 1;
> +	struct oid_array object_info_oids =3D OID_ARRAY_INIT;
>
>  	packet_trace_identity("fetch");
>
> @@ -2168,7 +2176,19 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
>  	if (dry_run)
>  		write_fetch_head =3D 0;
>
> -	if (all) {
> +	if (object_info_options.nr > 0) {
> +		if (argc =3D=3D 0 || argc =3D=3D 1) {
> +			die(_("must supply remote and object ids when using --object-info")=
);
> +		} else {
> +			struct object_id oid;
> +			remote =3D remote_get(argv[0]);
> +			for (i =3D 1; i < argc; i++) {
> +				if (get_oid(argv[i], &oid))
> +					return error(_("malformed object id '%s'"), argv[i]);
> +				oid_array_append(&object_info_oids, &oid);
> +			}
> +		}
> +	} else if (all) {
>  		if (argc =3D=3D 1)
>  			die(_("fetch --all does not take a repository argument"));
>  		else if (argc > 1)
> @@ -2199,7 +2219,19 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
>  		}
>  	}
>
> -	if (negotiate_only) {
> +	if (object_info_options.nr > 0) {
> +		if (!remote)
> +			die(_("must supply remote when using --object-info"));
> +		gtransport =3D prepare_transport(remote, 1);
> +		if (gtransport->smart_options) {
> +			gtransport->smart_options->object_info =3D 1;
> +			gtransport->smart_options->object_info_oids =3D &object_info_oids;
> +			gtransport->smart_options->object_info_options =3D &object_info_opt=
ions;
> +		}
> +		if (server_options.nr)
> +			gtransport->server_options =3D &server_options;
> +		result =3D transport_fetch_refs(gtransport, NULL);
> +	} else if (negotiate_only) {
>  		struct oidset acked_commits =3D OIDSET_INIT;
>  		struct oidset_iter iter;
>  		const struct object_id *oid;
> diff --git a/fetch-pack.c b/fetch-pack.c
> index b709a61baf..36e3d1c5d0 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1269,6 +1269,27 @@ static void write_command_and_capabilities(struc=
t strbuf *req_buf,
>  	packet_buf_delim(req_buf);
>  }
>
> +void send_object_info_request(int fd_out, struct object_info_args *arg=
s)
> +{
> +	struct strbuf req_buf =3D STRBUF_INIT;
> +	int i;
> +
> +	write_command_and_capabilities(&req_buf, args->server_options, "objec=
t-info");
> +
> +	if (string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");
> +
> +	for (i =3D 0; i < args->oids->nr; i++) {
> +		packet_buf_write(&req_buf, "oid %s\n", oid_to_hex(&args->oids->oid[i=
]));
> +	}
> +
> +	packet_buf_flush(&req_buf);
> +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +		die_errno(_("unable to write request to remote"));
> +
> +	strbuf_release(&req_buf);
> +}
> +
>  static int send_fetch_request(struct fetch_negotiator *negotiator, int=
 fd_out,
>  			      struct fetch_pack_args *args,
>  			      const struct ref *wants, struct oidset *common,
> @@ -1604,6 +1625,10 @@ static struct ref *do_fetch_pack_v2(struct fetch=
_pack_args *args,
>  	if (args->depth > 0 || args->deepen_since || args->deepen_not)
>  		args->deepen =3D 1;
>
> +	if (args->object_info) {
> +		state =3D FETCH_SEND_REQUEST;
> +	}
> +
>  	while (state !=3D FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
> @@ -1613,7 +1638,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_=
pack_args *args,
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			mark_complete_and_common_ref(negotiator, args, &ref);
>  			filter_refs(args, &ref, sought, nr_sought);
> -			if (everything_local(args, &ref))
> +			if (!args->object_info && everything_local(args, &ref))
>  				state =3D FETCH_DONE;
>  			else
>  				state =3D FETCH_SEND_REQUEST;
> @@ -1999,8 +2024,19 @@ struct ref *fetch_pack(struct fetch_pack_args *a=
rgs,
>  		}
>  		args->connectivity_checked =3D 1;
>  	}
> -
> -	update_shallow(args, sought, nr_sought, &si);
> +	=

> +	if (args->object_info) {
> +		struct ref *ref_cpy_reader =3D ref_cpy;
> +		unsigned long size =3D 0;
> +		while (ref_cpy_reader) {
> +			oid_object_info(the_repository, &(ref_cpy_reader->old_oid), &size);=

> +			printf("%s %li\n", oid_to_hex(&(ref_cpy_reader->old_oid)), size);
> +			ref_cpy_reader =3D ref_cpy_reader->next;
> +		}
> +	}
> +	else {
> +		update_shallow(args, sought, nr_sought, &si);
> +	}
>  cleanup:
>  	clear_shallow_info(&si);
>  	oid_array_clear(&shallows_scratch);
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 7f94a2a583..23e69bb218 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -42,6 +42,7 @@ struct fetch_pack_args {
>  	unsigned update_shallow:1;
>  	unsigned reject_shallow_remote:1;
>  	unsigned deepen:1;
> +	unsigned object_info:1;
>
>  	/*
>  	 * Indicate that the remote of this request is a promisor remote. The=

> @@ -68,6 +69,12 @@ struct fetch_pack_args {
>  	unsigned connectivity_checked:1;
>  };
>
> +struct object_info_args {
> +	const struct string_list *object_info_options;
> +	const struct string_list *server_options;
> +	const struct oid_array *oids;
> +};
> +
>  /*
>   * sought represents remote references that should be updated from.
>   * On return, the names that were found on the remote will have been
> @@ -101,4 +108,6 @@ void negotiate_using_fetch(const struct oid_array *=
negotiation_tips,
>   */
>  int report_unmatched_refs(struct ref **sought, int nr_sought);
>
> +void send_object_info_request(int fd_out, struct object_info_args *arg=
s);
> +
>  #endif
> diff --git a/t/t5583-fetch-object-info.sh b/t/t5583-fetch-object-info.s=
h
> new file mode 100755
> index 0000000000..e5db6d953c
> --- /dev/null
> +++ b/t/t5583-fetch-object-info.sh
> @@ -0,0 +1,138 @@
> +#!/bin/sh
> +
> +test_description=3D'test git fetch object-info version 2'
> +
> +TEST_NO_CREATE_REPO=3D1
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +# Test fetch object-info with 'git://' transport
> +
> +. "$TEST_DIRECTORY"/lib-git-daemon.sh
> +start_git_daemon --export-all --enable=3Dreceive-pack
> +daemon_parent=3D$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
> +
> +
> +test_expect_success 'create repo to be served by git-daemon' '
> +	git init "$daemon_parent" &&
> +	test_commit -C "$daemon_parent" message1 a.txt
> +'
> +
> +test_expect_success 'fetch object-info with git:// using protocol v2' =
'
> +	(
> +		cd "$daemon_parent" &&
> +		object_id=3D$(git rev-parse message1:a.txt) &&
> +		length=3D$(wc -c <a.txt) &&
> +
> +		printf "%s %d\n" "$object_id" "$length" >expect &&
> +		git -c protocol.version=3D2 fetch --object-info=3Dsize "$GIT_DAEMON_=
URL/parent" "$object_id" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +stop_git_daemon
> +
> +# Test protocol v2 with 'http://' transport
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +test_expect_success 'create repo to be served by http:// transport' '
> +	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepac=
k true &&
> +	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" message1 a.txt=
 &&
> +	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" message2 b.txt=

> +'
> +
> +test_expect_success 'fetch object-info with http:// using protocol v2'=
 '
> +	(
> +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +		object_id=3D$(git rev-parse message1:a.txt) &&
> +		length=3D$(wc -c <a.txt) &&
> +
> +		printf "%s %d\n" "$object_id" "$length" >expect &&
> +		git -c protocol.version=3D2 fetch --object-info=3Dsize "$HTTPD_URL/s=
mart/http_parent" "$object_id" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'fetch object-info for multiple objects' '
> +	(
> +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +		object_id1=3D$(git rev-parse message1:a.txt) &&
> +		object_id2=3D$(git rev-parse message2:b.txt) &&
> +		length1=3D$(wc -c <a.txt) &&
> +		length2=3D$(wc -c <b.txt) &&
> +
> +		printf "%s %d\n" "$object_id1" "$length1" >expect &&
> +		printf "%s %d\n" "$object_id2" "$length2" >>expect &&
> +		git -c protocol.version=3D2 fetch --object-info=3Dsize "$HTTPD_URL/s=
mart/http_parent" "$object_id1" "$object_id2" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'fetch object-info fallbacks to standard fetch if =
object-info is not supported by the server' '
> +	(
> +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +		object_id=3D$(git rev-parse message1:a.txt) &&
> +		length=3D$(wc -c <a.txt) &&
> +
> +		printf "%s %d\n" "$object_id" "$length" >expect &&
> +		git config objectinfo.advertise false &&
> +		git -c protocol.version=3D2 fetch --object-info=3Dsize "$HTTPD_URL/s=
mart/http_parent" "$object_id" >actual &&
> +		test_cmp expect actual
> +	)

I noticed this test doesn't confirm that standard fetch was actually used=
=2E Would
it be useful to check for the existence of the object to prove it got fet=
ched?

Also, is seems the way this test is set up, it's fetching from itself.
This is logically fine in most cases that client =3D=3D server, but it wa=
s a little
confusing at first because it looked like the invocation of git config wa=
s on
the client rather than the server, until I realized they are the same.

Since the server is being used as the client, we wouldn't be able to conf=
irm that
the object got fetched. I realize for most of these tests, it doesn't rea=
lly matter
to conflate client with server. I think this is the one exception.

But, as a larger question for the list, I'm wondering if it's best practi=
ce to separate client from
server in tests, or if it's an accepted style to just use one repository =
in cases
when it doesn't really matter?

Thanks
John

> +'
> +
> +test_expect_success 'fetch object-info fails on server with legacy pro=
tocol' '
> +	(
> +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +		object_id=3D$(git rev-parse message1:a.txt) &&
> +		test_must_fail git -c protocol.version=3D0 fetch --object-info=3Dsiz=
e "$HTTPD_URL/smart/http_parent" "$object_id" 2>err &&
> +		test_i18ngrep "object-info requires protocol v2" err
> +	)
> +'
> +
> +test_expect_success 'fetch object-info fails on malformed OID' '
> +	(
> +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +		malformed_object_id=3D"this_id_is_not_valid" &&
> +		test_must_fail git -c protocol.version=3D2 fetch --object-info=3Dsiz=
e "$HTTPD_URL/smart/http_parent" "$malformed_object_id" 2>err &&
> +		test_i18ngrep "malformed object id '$malformed_object_id'" err
> +	)
> +'
> +
> +test_expect_success 'fetch object-info fails on missing OID' '
> +	git clone "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" missing_oid_repo &&=

> +	test_commit -C missing_oid_repo message3 c.txt &&
> +	(
> +		cd missing_oid_repo &&
> +		object_id=3D$(git rev-parse message3:c.txt) &&
> +		test_must_fail env GIT_TRACE_PACKET=3D1 git -c protocol.version=3D2 =
fetch --object-info=3Dsize "$HTTPD_URL/smart/http_parent" "$object_id" 2>=
err &&
> +		test_i18ngrep "fatal: remote error: upload-pack: not our ref $object=
_id" err
> +	)
> +'
> +
> +# Test fetch object-info with 'file://' transport
> +
> +test_expect_success 'create repo to be served by file:// transport' '
> +	git init server &&
> +	test_commit -C server message1 a.txt &&
> +	git -C server config protocol.version 2
> +'
> +
> +test_expect_success 'fetch object-info with file:// using protocol v2'=
 '
> +	(
> +		cd server &&
> +		object_id=3D$(git rev-parse message1:a.txt) &&
> +		length=3D$(wc -c <a.txt) &&
> +
> +		printf "%s %d\n" "$object_id" "$length" >expect &&
> +		git -c protocol.version=3D2 fetch --object-info=3Dsize "file://$(pwd=
)" "$object_id" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index a0297b0986..64c175e904 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -686,13 +686,17 @@ static int fetch_refs(struct transport *transport=
,
>
>  	/*
>  	 * If we reach here, then the server, the client, and/or the transpor=
t
> -	 * helper does not support protocol v2. --negotiate-only requires
> -	 * protocol v2.
> +	 * helper does not support protocol v2. --negotiate-only and --object=
-info
> +	 * require protocol v2.
>  	 */
>  	if (data->transport_options.acked_commits) {
>  		warning(_("--negotiate-only requires protocol v2"));
>  		return -1;
>  	}
> +	if (transport->smart_options->object_info) {
> +		warning(_("--object-info requires protocol v2"));
> +		return -1;
> +	}
>
>  	if (!data->get_refs_list_called)
>  		get_refs_list_using_list(transport, 0);
> diff --git a/transport-internal.h b/transport-internal.h
> index c4ca0b733a..04fa015011 100644
> --- a/transport-internal.h
> +++ b/transport-internal.h
> @@ -59,6 +59,7 @@ struct transport_vtable {
>  	 * use. disconnect() releases these resources.
>  	 **/
>  	int (*disconnect)(struct transport *connection);
> +	int (*fetch_object_info)(struct transport *transport, struct oid_arra=
y *oids);
>  };
>
>  #endif
> diff --git a/transport.c b/transport.c
> index 70e9840a90..65a1b1fdb3 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -350,6 +350,67 @@ static struct ref *handshake(struct transport *tra=
nsport, int for_push,
>  	return refs;
>  }
>
> +/*
> + * Fetches object info if server supports object-info command
> + * Make sure to fallback to normal fetch if this fails
> + */
> +static int fetch_object_info(struct transport *transport)
> +{
> +	struct git_transport_data *data =3D transport->data;
> +	struct object_info_args args;
> +	struct packet_reader reader;
> +
> +	memset(&args, 0, sizeof(args));
> +	args.server_options =3D transport->server_options;
> +	args.object_info_options =3D transport->smart_options->object_info_op=
tions;
> +	args.oids =3D transport->smart_options->object_info_oids;
> +
> +	connect_setup(transport, 0);
> +	packet_reader_init(&reader, data->fd[0], NULL, 0,
> +			PACKET_READ_CHOMP_NEWLINE |
> +			PACKET_READ_DIE_ON_ERR_PACKET);
> +	data->version =3D discover_version(&reader);
> +
> +	transport->hash_algo =3D reader.hash_algo;
> +
> +	switch (data->version) {
> +	case protocol_v2:
> +		if (!server_supports_v2("object-info", 0))
> +			return 0;
> +		send_object_info_request(data->fd[1], &args);
> +		break;
> +	case protocol_v1:
> +	case protocol_v0:
> +		die(_("wrong protocol version. expected v2"));
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
> +
> +	if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) {
> +		die(_("error reading object info header"));
> +	}
> +	if (strcmp(reader.line, "size")) {
> +		die(_("expected 'size', received '%s'"), reader.line);
> +	}
> +	while (packet_reader_read(&reader) =3D=3D PACKET_READ_NORMAL) {
> +		printf("%s\n", reader.line);
> +	}
> +	check_stateless_delimiter(transport->stateless_rpc, &reader, "statele=
ss delimiter expected");
> +
> +	return 1;
> +}
> +
> +static int append_oid_to_ref(const struct object_id *oid, void *data)
> +{
> +	struct ref *ref =3D data;
> +	struct ref *temp_ref =3D xcalloc(1, sizeof (struct ref));
> +	temp_ref->old_oid =3D *oid;
> +	temp_ref->exact_oid =3D 1;
> +	ref->next =3D temp_ref;
> +	ref =3D ref->next;
> +	return 0;
> +}
> +
>  static struct ref *get_refs_via_connect(struct transport *transport, i=
nt for_push,
>  					struct transport_ls_refs_options *options)
>  {
> @@ -364,6 +425,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>  	struct ref *refs =3D NULL;
>  	struct fetch_pack_args args;
>  	struct ref *refs_tmp =3D NULL;
> +	struct ref *wanted_refs =3D xcalloc(1, sizeof (struct ref));
>
>  	memset(&args, 0, sizeof(args));
>  	args.uploadpack =3D data->options.uploadpack;
> @@ -388,8 +450,17 @@ static int fetch_refs_via_pack(struct transport *t=
ransport,
>  	args.server_options =3D transport->server_options;
>  	args.negotiation_tips =3D data->options.negotiation_tips;
>  	args.reject_shallow_remote =3D transport->smart_options->reject_shall=
ow;
> +	args.object_info =3D transport->smart_options->object_info;
>
> -	if (!data->got_remote_heads) {
> +	if (transport->smart_options && transport->smart_options->object_info=
) {
> +		struct ref *temp_ref =3D wanted_refs;
> +		if (fetch_object_info(transport)) {
> +			goto cleanup;
> +		}
> +		oid_array_for_each(transport->smart_options->object_info_oids, appen=
d_oid_to_ref, temp_ref);
> +		wanted_refs =3D wanted_refs->next;
> +		transport->remote_refs =3D wanted_refs;
> +	} else if (!data->got_remote_heads) {
>  		int i;
>  		int must_list_refs =3D 0;
>  		for (i =3D 0; i < nr_heads; i++) {
> @@ -406,7 +477,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>  	else if (data->version <=3D protocol_v1)
>  		die_if_server_options(transport);
>
> -	if (data->options.acked_commits) {
> +	if (data->options.acked_commits && !transport->smart_options->object_=
info) {
>  		if (data->version < protocol_v2) {
>  			warning(_("--negotiate-only requires protocol v2"));
>  			ret =3D -1;
> diff --git a/transport.h b/transport.h
> index a0bc6a1e9e..3bba16f86e 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -30,6 +30,12 @@ struct git_transport_options {
>  	 */
>  	unsigned connectivity_checked:1;
>
> +	/*
> +	 * Transport will attempt to pull only object-info. Fallbacks
> +	 * to pulling entire object if object-info is not supported
> +	 */
> +	unsigned object_info : 1;
> +
>  	int depth;
>  	const char *deepen_since;
>  	const struct string_list *deepen_not;
> @@ -53,6 +59,9 @@ struct git_transport_options {
>  	 * common commits to this oidset instead of fetching any packfiles.
>  	 */
>  	struct oidset *acked_commits;
> +
> +	struct oid_array *object_info_oids;
> +	struct string_list *object_info_options;
>  };
>
>  enum transport_family {
> -- =

> 2.33.0.664.g0785eb7698
