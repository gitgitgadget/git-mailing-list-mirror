Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB27C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4E611AE
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbhDPR2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbhDPR2C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 13:28:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F0BC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 10:27:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bx20so32056698edb.12
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wnIfB9aO+e9JqBYf9lavHTKedibMp0hJv3O4KzfsPS4=;
        b=j+d9wJzys6gB2Pz67tokIb2dK+qHhLxxxCO+PGY180o7wIUTZ+zM3TwMLdPBPcV9o+
         PC6IQZXIfMzD5G4/hs60vWY3TfCtLpeA6bcBKHojBi3VUVT3OiEKi3ZQm2JRC5qoUA9y
         pMU6FNF4DaJP820SRCVrt7JTY4i0G9cTNtOkjyBOBpl9hPQE+vYHNca8y0XZN1R6e/TC
         EyTbPtRlwMLsN0a2orAMwDvWsm23q5pj6GW90e2Gy+ZSfaQ/xTHzAaKkPegYagrTnqed
         hFp96lYzhFm59/S2aIMODwblEHwXU7jAlAmLGDdrYQJ3wu4OOaxGnw2TKSbvl8dlWlsb
         2zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wnIfB9aO+e9JqBYf9lavHTKedibMp0hJv3O4KzfsPS4=;
        b=q/fTgmGHCKZV10LL/nlMf0z1O4lL/psJjbI1DNNdeCjgwpLMinVJ0jh37sdyvdtMo7
         V3t1WKgtV5JqeR0mOmm16iPx3O8sS4S2KwXMrS606xQ//w6shRt4FZrDswiAqRp8Q7Z7
         cp4kC0489d7lFnmYjuedRlGTWu0qwjA+VUueRC74tpgxwHB9oDUWy73OdFwB+ilkFWbA
         4vnRfL3BQpT2srs8kUcrBgr5GL8tyGlIdCukE8WKjwVazyhIewIK2LRK0iHZ0x30bn7a
         fsCCgVkqDBqslNa55sO/5Z8fyhpRKDL+Bn1cBqR3fUiU4A/enpRi62uVF6oCXV/tf+9I
         0S1A==
X-Gm-Message-State: AOAM533ogl1NlZ+hZRCNnGBtD6HWhI9jQo/pHM68kuh6rtDw/UxGZXtr
        iWGdlgXgzxL1pdTMsZdVAOqEAuyj1TY=
X-Google-Smtp-Source: ABdhPJyAPYEI39W4puHm8F2/+92j5L1fF+yLVxJVBaU8IhYTaJoZW6PSr1aSr4WA/NOlLrxI4WfPAw==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr11380100edb.306.1618594055680;
        Fri, 16 Apr 2021 10:27:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s3sm6008525edw.66.2021.04.16.10.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:27:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/15] builtin/hash-object: allow literally hashing with
 a given algorithm
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-3-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210410152140.3525040-3-sandals@crustytoothpaste.net>
Date:   Fri, 16 Apr 2021 19:27:33 +0200
Message-ID: <8735vq2l8a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, brian m. carlson wrote:

> Add an --object-format argument to git hash-object that allows hashing
> an object with a given algorithm. Currently this options is limited to
> use with --literally, since the index_* functions do not yet handle
> multiple hash algorithms.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/hash-object.c  | 47 ++++++++++++++++++++++++++++++------------
>  t/t1007-hash-object.sh | 10 +++++++++
>  2 files changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 640ef4ded5..0203cfbe9a 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -17,7 +17,8 @@
>   * needs to bypass the data conversion performed by, and the type
>   * limitation imposed by, index_fd() and its callees.
>   */
> -static int hash_literally(struct object_id *oid, int fd, const char *type, unsigned flags)
> +static int hash_literally(struct object_id *oid, int fd, const char *type,
> +			  unsigned flags, const struct git_hash_algo *algo)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	int ret;
> @@ -25,42 +26,46 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
>  	if (strbuf_read(&buf, fd, 4096) < 0)
>  		ret = -1;
>  	else
> -		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
> -						 flags);
> +		ret = hash_object_file_literally_algop(buf.buf, buf.len, type, oid,
> +						       flags, algo);
>  	strbuf_release(&buf);
>  	return ret;
>  }
>  
>  static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
> -		    int literally)
> +		    int literally, const struct git_hash_algo *algo)
>  {
>  	struct stat st;
>  	struct object_id oid;
>  
> +	if (!literally && algo != the_hash_algo)
> +		die(_("Can't use hash algo %s except literally yet"), algo->name);
> +
>  	if (fstat(fd, &st) < 0 ||
>  	    (literally
> -	     ? hash_literally(&oid, fd, type, flags)
> +	     ? hash_literally(&oid, fd, type, flags, algo)
>  	     : index_fd(the_repository->index, &oid, fd, &st,
>  			type_from_string(type), path, flags)))
>  		die((flags & HASH_WRITE_OBJECT)
>  		    ? "Unable to add %s to database"
>  		    : "Unable to hash %s", path);
> -	printf("%s\n", oid_to_hex(&oid));
> +	printf("%s\n", hash_to_hex_algop(oid.hash, algo));
>  	maybe_flush_or_die(stdout, "hash to stdout");
>  }
>  
>  static void hash_object(const char *path, const char *type, const char *vpath,
> -			unsigned flags, int literally)
> +			unsigned flags, int literally,
> +			const struct git_hash_algo *algo)
>  {
>  	int fd;
>  	fd = open(path, O_RDONLY);
>  	if (fd < 0)
>  		die_errno("Cannot open '%s'", path);
> -	hash_fd(fd, type, vpath, flags, literally);
> +	hash_fd(fd, type, vpath, flags, literally, algo);
>  }
>  
>  static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
> -			     int literally)
> +			     int literally, const struct git_hash_algo *algo)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf unquoted = STRBUF_INIT;
> @@ -73,7 +78,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
>  			strbuf_swap(&buf, &unquoted);
>  		}
>  		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
> -			    literally);
> +			    literally, algo);
>  	}
>  	strbuf_release(&buf);
>  	strbuf_release(&unquoted);
> @@ -94,6 +99,8 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  	int nongit = 0;
>  	unsigned flags = HASH_FORMAT_CHECK;
>  	const char *vpath = NULL;
> +	const char *object_format = NULL;
> +	const struct git_hash_algo *algo;
>  	const struct option hash_object_options[] = {
>  		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
>  		OPT_BIT('w', NULL, &flags, N_("write the object into the object database"),
> @@ -103,6 +110,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
>  		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
>  		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
> +		OPT_STRING( 0 , "object-format", &object_format, N_("object-format"), N_("Use this hash algorithm")),
>  		OPT_END()
>  	};
>  	int i;
> @@ -121,6 +129,19 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  
> +	algo = the_hash_algo;
> +	if (object_format) {
> +		if (flags & HASH_WRITE_OBJECT)
> +			errstr = "Can't use -w with --object-format";
> +		else {
> +			int id = hash_algo_by_name(object_format);
> +			if (id == GIT_HASH_UNKNOWN)
> +				errstr = "Unknown object format";
> +			else
> +				algo = &hash_algos[id];
> +		}
> +	}
> +
>  	if (stdin_paths) {
>  		if (hashstdin)
>  			errstr = "Can't use --stdin-paths with --stdin";
> @@ -142,7 +163,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (hashstdin)
> -		hash_fd(0, type, vpath, flags, literally);
> +		hash_fd(0, type, vpath, flags, literally, algo);
>  
>  	for (i = 0 ; i < argc; i++) {
>  		const char *arg = argv[i];
> @@ -151,12 +172,12 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  		if (prefix)
>  			arg = to_free = prefix_filename(prefix, arg);
>  		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
> -			    flags, literally);
> +			    flags, literally, algo);
>  		free(to_free);
>  	}
>  
>  	if (stdin_paths)
> -		hash_stdin_paths(type, no_filters, flags, literally);
> +		hash_stdin_paths(type, no_filters, flags, literally, algo);
>  
>  	return 0;
>  }
> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 64b340f227..ea4b3d2bda 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -83,6 +83,11 @@ test_expect_success 'hash a file' '
>  	test "$(test_oid hello)" = $(git hash-object hello)
>  '
>  
> +test_expect_failure 'hash a file with a given algorithm' '
> +	test "$(test_oid --hash=sha1 hello)" = $(git hash-object --object-format=sha1 hello) &&
> +	test "$(test_oid --hash=sha256 hello)" = $(git hash-object --object-format=sha256 hello)
> +'
> +
>  test_blob_does_not_exist "$(test_oid hello)"
>  
>  test_expect_success 'hash from stdin' '
> @@ -248,4 +253,9 @@ test_expect_success '--literally with extra-long type' '
>  	echo example | git hash-object -t $t --literally --stdin
>  '
>  
> +test_expect_success '--literally with --object-format' '
> +	test $(test_oid --hash=sha1 hello) = $(git hash-object -t blob --literally --object-format=sha1 hello) &&
> +	test $(test_oid --hash=sha256 hello) = $(git hash-object -t blob --literally --object-format=sha256 hello)
> +'
> +
>  test_done

First, the "errstr" handling here is arguably buggy, or at least hard to
read. Before this change we never clobber it if we find an issue, but
after we do. In the end it doesn't really matter, we error on one usage
error or the other, but it does make fore more confusing reading.

The patch-on-top mentioned below turns that into a "goto error".

Secondly, sorry about the semantic merge conflict, but while trying to
fix that issue today I started reviwing this in more depth, and wanted
to ask some questions first:

I don't get why we need to pass the algop around here at all. Why not
handle this like your previous change to e.g. show-index.c where we set
it globally?

Just doing it like that would make your TODO test pass, and we're a
one-shot command here, I see no reason not do do that.

I have a hacky WIP series on top of this which implements that mid-way,
the diff is also at the end of this E-Mail.

For my own re-rolling of my object.c changes I settled on passing a
"type_len" down to hash_literally() et al for reasons I won't go into
here. That would conflict with your in-flight changes (in a way that's
not hard to resolve), but not conflicting at all because we just used a
global repo_set_hash_algo() would be even better.

So here's the messy patches on top:

https://github.com/avar/git/compare/3e8b16d2e70...avar-bc/hash-transition-interop-part-1

The other part of that is to just support "git --object-format=sha256"
instead of needing every command to slowly aquire an --object-format
argument.

That's currently broken in that series for a reason I wanted to ask you
about. I know *why*, but I wonder what the best solution is.

Part how that's dealt with, i.e. if you think this direction of making
"git" take that argument directly, has to do with data in your wetware,
not something in-tree :) I.e. what the future direction is.

I.e. it's broken because we end up calling repo_set_hash_algo() in
several places, first via common-main.c, then with my patch below in
git.c's argument handling, and then via parse_options() and in setup.c,
e.g. hash-object.c's explicit setup_git_directory() call.

As you'll see from the setup_git_directory_gently() call below I had an
attempt to monkeypatch around that by detecting zero'd out structs in
setup_git_directory_gently().

But e.g. ./t5318-commit-graph.sh is still broken because we no longer
pay attention to "git init --object-format=*" since
check_repository_format() and validate_hash_algorithm() end up not only
validating config, but also (re-)setting it.

It seems to me that we need a separation of concerns there, to have the
default in one place, and validation in another. But maybe there's some
more subtle reason for why we're (re-)setting it in that manner, and I
ran out of hacking time today and figured I'd send this E-Mail off at
the end of the day :)


diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 0203cfbe9a4..0ecf24b4793 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -17,8 +17,7 @@
  * needs to bypass the data conversion performed by, and the type
  * limitation imposed by, index_fd() and its callees.
  */
-static int hash_literally(struct object_id *oid, int fd, const char *type,
-			  unsigned flags, const struct git_hash_algo *algo)
+static int hash_literally(struct object_id *oid, int fd, const char *type, unsigned flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -26,46 +25,42 @@ static int hash_literally(struct object_id *oid, int fd, const char *type,
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_object_file_literally_algop(buf.buf, buf.len, type, oid,
-						       flags, algo);
+		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
+						 flags);
 	strbuf_release(&buf);
 	return ret;
 }
 
 static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
-		    int literally, const struct git_hash_algo *algo)
+		    int literally)
 {
 	struct stat st;
 	struct object_id oid;
 
-	if (!literally && algo != the_hash_algo)
-		die(_("Can't use hash algo %s except literally yet"), algo->name);
-
 	if (fstat(fd, &st) < 0 ||
 	    (literally
-	     ? hash_literally(&oid, fd, type, flags, algo)
+	     ? hash_literally(&oid, fd, type, flags)
 	     : index_fd(the_repository->index, &oid, fd, &st,
 			type_from_string(type), path, flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
-	printf("%s\n", hash_to_hex_algop(oid.hash, algo));
+	printf("%s\n", oid_to_hex(&oid));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
 static void hash_object(const char *path, const char *type, const char *vpath,
-			unsigned flags, int literally,
-			const struct git_hash_algo *algo)
+			unsigned flags, int literally)
 {
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die_errno("Cannot open '%s'", path);
-	hash_fd(fd, type, vpath, flags, literally, algo);
+	hash_fd(fd, type, vpath, flags, literally);
 }
 
 static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
-			     int literally, const struct git_hash_algo *algo)
+			     int literally)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -78,7 +73,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 			strbuf_swap(&buf, &unquoted);
 		}
 		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
-			    literally, algo);
+			    literally);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&unquoted);
@@ -100,7 +95,6 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	unsigned flags = HASH_FORMAT_CHECK;
 	const char *vpath = NULL;
 	const char *object_format = NULL;
-	const struct git_hash_algo *algo;
 	const struct option hash_object_options[] = {
 		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
 		OPT_BIT('w', NULL, &flags, N_("write the object into the object database"),
@@ -110,47 +104,38 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
 		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
-		OPT_STRING( 0 , "object-format", &object_format, N_("object-format"), N_("Use this hash algorithm")),
+		OPT_OBJECT_FORMAT(0, "object-format", &object_format),
 		OPT_END()
 	};
 	int i;
 	const char *errstr = NULL;
 
-	argc = parse_options(argc, argv, prefix, hash_object_options,
-			     hash_object_usage, 0);
-
+	/* might setup the hash algorithm */
 	if (flags & HASH_WRITE_OBJECT)
 		prefix = setup_git_directory();
 	else
 		prefix = setup_git_directory_gently(&nongit);
 
+	/* maybe override the already setup hash algorithm */
+	argc = parse_options(argc, argv, prefix, hash_object_options,
+			     hash_object_usage, 0);
+
 	if (vpath && prefix)
 		vpath = xstrdup(prefix_filename(prefix, vpath));
 
 	git_config(git_default_config, NULL);
 
-	algo = the_hash_algo;
-	if (object_format) {
-		if (flags & HASH_WRITE_OBJECT)
-			errstr = "Can't use -w with --object-format";
-		else {
-			int id = hash_algo_by_name(object_format);
-			if (id == GIT_HASH_UNKNOWN)
-				errstr = "Unknown object format";
-			else
-				algo = &hash_algos[id];
-		}
-	}
 
-	if (stdin_paths) {
+	if (object_format && flags & HASH_WRITE_OBJECT) {
+		errstr = "Can't use -w with --object-format";
+	} else if (stdin_paths) {
 		if (hashstdin)
 			errstr = "Can't use --stdin-paths with --stdin";
 		else if (argc)
 			errstr = "Can't specify files with --stdin-paths";
 		else if (vpath)
 			errstr = "Can't use --stdin-paths with --path";
-	}
-	else {
+	} else {
 		if (hashstdin > 1)
 			errstr = "Multiple --stdin arguments are not supported";
 		if (vpath && no_filters)
@@ -163,7 +148,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	}
 
 	if (hashstdin)
-		hash_fd(0, type, vpath, flags, literally, algo);
+		hash_fd(0, type, vpath, flags, literally);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
@@ -172,12 +157,12 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		if (prefix)
 			arg = to_free = prefix_filename(prefix, arg);
 		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
-			    flags, literally, algo);
+			    flags, literally);
 		free(to_free);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, no_filters, flags, literally, algo);
+		hash_stdin_paths(type, no_filters, flags, literally);
 
 	return 0;
 }
diff --git a/builtin/init-db.c b/builtin/init-db.c
index c19b35f1e69..7a7e63cf702 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -548,8 +548,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			   N_("separate git dir from working tree")),
 		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
 			   N_("override the name of the initial branch")),
-		OPT_STRING(0, "object-format", &object_format, N_("hash"),
-			   N_("specify the hash algorithm to use")),
+		OPT_OBJECT_FORMAT(0, "object-format", &object_format),
 		OPT_END()
 	};
 
@@ -607,11 +606,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		free(cwd);
 	}
 
-	if (object_format) {
+	if (object_format)
 		hash_algo = hash_algo_by_name(object_format);
-		if (hash_algo == GIT_HASH_UNKNOWN)
-			die(_("unknown hash algorithm '%s'"), object_format);
-	}
 
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0e0b9fb95bc..51352c2eaeb 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -15,23 +15,12 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 	unsigned int version;
 	static unsigned int top_index[256];
 	unsigned hashsz;
-	const char *hash_name = NULL;
-	int hash_algo;
 	const struct option show_index_options[] = {
-		OPT_STRING(0, "object-format", &hash_name, N_("hash-algorithm"),
-			   N_("specify the hash algorithm to use")),
+		OPT_OBJECT_FORMAT(0, "object-format", NULL),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, show_index_options, show_index_usage, 0);
-
-	if (hash_name) {
-		hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo == GIT_HASH_UNKNOWN)
-			die(_("Unknown hash algorithm"));
-		repo_set_hash_algo(the_repository, hash_algo);
-	}
-
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 05c52135946..6ce09d068e7 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -16,6 +16,8 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
 	int err;
 
+	if (hash_algo)
+		strvec_pushf(argv, "--object-format=%s", hash_algo);
 	strvec_push(argv, "index-pack");
 
 	if (stat_only)
@@ -25,9 +27,6 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 	else
 		strvec_push(argv, "--verify");
 
-	if (hash_algo)
-		strvec_pushf(argv, "--object-format=%s", hash_algo);
-
 	/*
 	 * In addition to "foo.pack" we accept "foo.idx" and "foo";
 	 * normalize these forms to "foo.pack" for "index-pack --verify".
@@ -71,8 +70,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 			VERIFY_PACK_VERBOSE),
 		OPT_BIT('s', "stat-only", &flags, N_("show statistics only"),
 			VERIFY_PACK_STAT_ONLY),
-		OPT_STRING(0, "object-format", &object_format, N_("hash"),
-			   N_("specify the hash algorithm to use")),
+		OPT_OBJECT_FORMAT(0, "object-format", &object_format),
 		OPT_END()
 	};
 
diff --git a/git.c b/git.c
index 9bc077a025c..824a9ef6cd2 100644
--- a/git.c
+++ b/git.c
@@ -160,6 +160,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				trace2_cmd_name("_query_");
 				exit(0);
 			}
+		} else if (skip_prefix(cmd, "--object-format=", &cmd)) {
+			repo_set_hash_algo_arg(the_repository, cmd);
 		} else if (!strcmp(cmd, "--html-path")) {
 			puts(system_path(GIT_HTML_PATH));
 			trace2_cmd_name("_query_");
diff --git a/object-file.c b/object-file.c
index 0401d7ca4fb..c53fc14718f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2001,15 +2001,6 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags)
-{
-	return hash_object_file_literally_algop(buf, len, type, oid, flags,
-						the_hash_algo);
-}
-
-int hash_object_file_literally_algop(const void *buf, unsigned long len,
-				     const char *type, struct object_id *oid,
-				     unsigned flags,
-				     const struct git_hash_algo *algo)
 {
 	char *header;
 	int hdrlen, status = 0;
@@ -2017,14 +2008,11 @@ int hash_object_file_literally_algop(const void *buf, unsigned long len,
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
 	header = xmalloc(hdrlen);
-	write_object_file_prepare(algo, buf, len, type, oid, header, &hdrlen);
+	write_object_file_prepare(the_hash_algo, buf, len, type, oid, header,
+				  &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
-	if (algo->format_id != the_hash_algo->format_id) {
-		status = -1;
-		goto cleanup;
-	}
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
 	status = write_loose_object(oid, header, hdrlen, buf, len, 0);
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 3c811e1e4a7..6308bed9675 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -293,3 +293,17 @@ int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset
 
 	return 0;
 }
+
+int parse_opt_object_format_cb(const struct option *opt, const char *arg, int unset)
+{
+	const char **value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (arg)
+		repo_set_hash_algo_arg(the_repository, arg);
+	if (value)
+		*value = arg;
+
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index a845a9d9527..086dab755ca 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -201,6 +201,10 @@ struct option {
 #define OPT_ALIAS(s, l, source_long_name) \
 	{ OPTION_ALIAS, (s), (l), (source_long_name) }
 
+#define OPT_OBJECT_FORMAT(s, l, v) \
+	{ OPTION_CALLBACK, (s), (l), (v), N_("hash"),N_("hash algorithm"), \
+	  PARSE_OPT_NONEG, parse_opt_object_format_cb }
+
 /*
  * parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. argv0 is assumed program name and
@@ -303,6 +307,7 @@ enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
+int parse_opt_object_format_cb(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
diff --git a/repository.c b/repository.c
index 87b355e7a65..1a7aca657db 100644
--- a/repository.c
+++ b/repository.c
@@ -91,6 +91,15 @@ void repo_set_hash_algo(struct repository *repo, int hash_algo)
 	repo->hash_algo = &hash_algos[hash_algo];
 }
 
+void repo_set_hash_algo_arg(struct repository *repo, const char *algo)
+{
+	int algo_id = hash_algo_by_name(algo);
+	if (algo_id == GIT_HASH_UNKNOWN)
+		die(_("unknown hash algorithm '%s'"), algo);
+	fprintf(stderr, "now setting %s=%d\n", algo, algo_id);
+	repo_set_hash_algo(the_repository, algo_id);
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
diff --git a/repository.h b/repository.h
index b385ca3c94b..56482f89f64 100644
--- a/repository.h
+++ b/repository.h
@@ -160,6 +160,7 @@ void repo_set_gitdir(struct repository *repo, const char *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
+void repo_set_hash_algo_arg(struct repository *repo, const char *algo);
 void initialize_the_repository(void);
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
 
diff --git a/setup.c b/setup.c
index c04cd25a30d..7ad8f685b9b 100644
--- a/setup.c
+++ b/setup.c
@@ -1308,7 +1308,15 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository &&
+		    /*
+		     * If we have called initialize_the_repository()
+		     * via common-main.c let's not set things up from
+		     * the REPOSITORY_FORMAT_INIT defaults again,
+		     * otherwise we'll clobber e.g. a invocations of
+		     * "git --object-format=<HASH> some-cmd".
+		     */
+		    !the_repository->hash_algo)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index ea4b3d2bda4..37bfb40c506 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -83,7 +83,7 @@ test_expect_success 'hash a file' '
 	test "$(test_oid hello)" = $(git hash-object hello)
 '
 
-test_expect_failure 'hash a file with a given algorithm' '
+test_expect_success 'hash a file with a given algorithm' '
 	test "$(test_oid --hash=sha1 hello)" = $(git hash-object --object-format=sha1 hello) &&
 	test "$(test_oid --hash=sha256 hello)" = $(git hash-object --object-format=sha256 hello)
 '
@@ -255,7 +255,9 @@ test_expect_success '--literally with extra-long type' '
 
 test_expect_success '--literally with --object-format' '
 	test $(test_oid --hash=sha1 hello) = $(git hash-object -t blob --literally --object-format=sha1 hello) &&
-	test $(test_oid --hash=sha256 hello) = $(git hash-object -t blob --literally --object-format=sha256 hello)
+	test $(test_oid --hash=sha256 hello) = $(git hash-object -t blob --literally --object-format=sha256 hello) &&
+	test $(test_oid --hash=sha256 hello) = $(git --object-format=sha256 hash-object -t blob --literally hello) &&
+	test $(test_oid --hash=sha256 hello) = $(git --object-format=sha1 hash-object -t blob --object-format=sha256 --literally hello)
 '
 
 test_done
