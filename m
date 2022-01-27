Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2EBC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 01:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiA0Bt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiA0Btw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 20:49:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F3C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:49:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so1993789wrb.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fsHtmRDEMo4Nqxfc2mRJtxYwizndRayI+FyW7SvQAlw=;
        b=hm40zSsflmnbW0PkCnwWjwLSDcGJ2q30EshP9sX+4whVit9WRxhvI6eHbzb6DDi3UK
         sTXIBqNr3mA5Sw5MtB21Oc1rh5ZCqaGvrwo78ElJ1v2nFkTjYdU8pbFv+3UlR/E8BVo4
         3lrKzEG1ePnLWISQolukTNd9qnJ9/RxpK8KYtivW6qxiVXKyrFj+MI2su/8BxN6YGiMv
         oq8P8I+XHUZyH+3rS52YTy6QGerFY+bSLp/y5cW6bcwLq8pHrszNYGcuqj55SchEq63O
         NXcewlUWkofGfNpbrKzIVRhLK+BCQK1G0+h7z4QSLT3g4MD/TcWrHZ5ghlfzFUVYC1Is
         eKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fsHtmRDEMo4Nqxfc2mRJtxYwizndRayI+FyW7SvQAlw=;
        b=BZeWD6l0/1cxqwSonk3NRafQ/FX/G7jgjU4SKSwxXys4ByN86GvekP0R2XFspvaGr0
         vNJfxbMd8EdiIIjktuwuEIF8peRDfNw0VIvQGwJcBKvj8bZocUh1XSnZmxIgslBlsDWZ
         cUobbuO+QasB9ExW9Pj97YETo3qjGiPbZGx8ayI4p0/totEGrGvBOlk59lVdX2+GkHAz
         XI1oh34w3pP/KyyJDIU6UGKvDkKEDt4iVN6r9ESRqJP9Ev3iYuZZEqMY1SwEcZJPPP3I
         h7QIODadevD9TS8czthY6UXTi9yF6LuXIQnZdGJWpA+FOknPHiUdAqCZA4IHnKPV/GOL
         phDg==
X-Gm-Message-State: AOAM530WzS8JZ3jlIT/2K/htLWIaP/Vk9+tt2uqTfKeHdjQiP179psV2
        0zsQOklNm037yqgdNmekQOXHUAxvcJY=
X-Google-Smtp-Source: ABdhPJyCxVTyxQHK1/x1Q2DOmprq70nPrjI8Iv9gcTykm80uw5ef6Mr4i1TDwF+9z98/5cFjKD9+OA==
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr1029323wry.320.1643248182942;
        Wed, 26 Jan 2022 17:49:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11sm4493574wmb.12.2022.01.26.17.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:49:42 -0800 (PST)
Message-Id: <a3166381572481f2ed159740eb8a1d88d4f9dc0f.1643248180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 01:49:40 +0000
Subject: [PATCH 2/2] repack: add --filter=<filter-spec> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Currently, repack does not work with partial clones. When repack is run
on a partially cloned repository, it grabs all missing objects from
promisor remotes. This also means that when gc is run for repository
maintenance on a partially cloned repository, it will end up getting
missing objects, which is not what we want.

In order to make repack work with partial clone, teach repack a new
option --filter, which takes a <filter-spec> argument. repack will skip
any objects that are matched by <filter-spec> similar to how the clone
command will skip fetching certain objects.

The final goal of this feature, is to be able to store objects on a
server other than the regular git server itself.

There are several scripts added so we can test the process of using a
remote helper to upload blobs to an http server:

- t/lib-httpd/list.sh lists blobs uploaded to the http server.
- t/lib-httpd/upload.sh uploads blobs to the http server.
- t/t0410/git-remote-testhttpgit a remote helper that can access blobs
  onto from an http server. Copied over from t/t5801/git-remote-testhttpgit
  and modified to upload blobs to an http server.
- t/t0410/lib-http-promisor.sh convenience functions for uploading
  blobs

Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-repack.txt   |   5 +
 builtin/repack.c               |  10 ++
 t/lib-httpd.sh                 |   2 +
 t/lib-httpd/apache.conf        |   8 ++
 t/lib-httpd/list.sh            |  43 +++++++++
 t/lib-httpd/upload.sh          |  46 +++++++++
 t/t0410-partial-clone.sh       |  52 ++++++++++
 t/t0410/git-remote-testhttpgit | 170 +++++++++++++++++++++++++++++++++
 t/t7700-repack.sh              |  20 ++++
 9 files changed, 356 insertions(+)
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0410/git-remote-testhttpgit

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ee30edc178a..e394ec52ab1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -126,6 +126,11 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Omits certain objects (usually blobs) from the resulting
+	packfile. See linkgit:git-rev-list[1] for valid
+	`<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index da1e364a756..9c2e5bcfe3b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -152,6 +152,7 @@ struct pack_objects_args {
 	const char *depth;
 	const char *threads;
 	const char *max_pack_size;
+	const char *filter;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -172,6 +173,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter)
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -660,6 +663,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -819,6 +824,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		string_list_append(&names, line.buf);
+		if (po_args.filter) {
+			char *promisor_name = mkpathdup("%s-%s.promisor", packtmp,
+							line.buf);
+			write_promisor_file(promisor_name, NULL, 0);
+		}
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 782891908d7..fc6587c6d39 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -136,6 +136,8 @@ prepare_httpd() {
 	install_script error-smart-http.sh
 	install_script error.sh
 	install_script apply-one-time-perl.sh
+	install_script upload.sh
+	install_script list.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 497b9b9d927..1ea382750f0 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -129,6 +129,8 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
 ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
+ScriptAlias /upload/ upload.sh/
+ScriptAlias /list/ list.sh/
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
@@ -156,6 +158,12 @@ ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
 <Files ${GIT_EXEC_PATH}/git-http-backend>
 	Options ExecCGI
 </Files>
+<Files upload.sh>
+  Options ExecCGI
+</Files>
+<Files list.sh>
+  Options ExecCGI
+</Files>
 
 RewriteEngine on
 RewriteRule ^/dumb-redir/(.*)$ /dumb/$1 [R=301]
diff --git a/t/lib-httpd/list.sh b/t/lib-httpd/list.sh
new file mode 100644
index 00000000000..e63406be3b2
--- /dev/null
+++ b/t/lib-httpd/list.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+# Used in the httpd test server to be called by a remote helper to list objects.
+
+FILES_DIR="www/files"
+
+OLDIFS="$IFS"
+IFS='&'
+set -- $QUERY_STRING
+IFS="$OLDIFS"
+
+while test $# -gt 0
+do
+	key=${1%%=*}
+	val=${1#*=}
+
+	case "$key" in
+	"sha1") sha1="$val" ;;
+	*) echo >&2 "unknown key '$key'" ;;
+	esac
+
+	shift
+done
+
+if test -d "$FILES_DIR"
+then
+	if test -z "$sha1"
+	then
+		echo 'Status: 200 OK'
+		echo
+		ls "$FILES_DIR" | tr '-' ' '
+	else
+		if test -f "$FILES_DIR/$sha1"-*
+		then
+			echo 'Status: 200 OK'
+			echo
+			cat "$FILES_DIR/$sha1"-*
+		else
+			echo 'Status: 404 Not Found'
+			echo
+		fi
+	fi
+fi
diff --git a/t/lib-httpd/upload.sh b/t/lib-httpd/upload.sh
new file mode 100644
index 00000000000..202de63b2dc
--- /dev/null
+++ b/t/lib-httpd/upload.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+# In part from http://codereview.stackexchange.com/questions/79549/bash-cgi-upload-file
+# Used in the httpd test server to for a remote helper to call to upload blobs.
+
+FILES_DIR="www/files"
+
+OLDIFS="$IFS"
+IFS='&'
+set -- $QUERY_STRING
+IFS="$OLDIFS"
+
+while test $# -gt 0
+do
+	key=${1%%=*}
+	val=${1#*=}
+
+	case "$key" in
+	"sha1") sha1="$val" ;;
+	"type") type="$val" ;;
+	"size") size="$val" ;;
+	"delete") delete=1 ;;
+	*) echo >&2 "unknown key '$key'" ;;
+	esac
+
+	shift
+done
+
+case "$REQUEST_METHOD" in
+POST)
+	if test "$delete" = "1"
+	then
+		rm -f "$FILES_DIR/$sha1-$size-$type"
+	else
+		mkdir -p "$FILES_DIR"
+		cat >"$FILES_DIR/$sha1-$size-$type"
+	fi
+
+	echo 'Status: 204 No Content'
+	echo
+	;;
+
+*)
+	echo 'Status: 405 Method Not Allowed'
+	echo
+esac
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index f17abd298c8..731f6bebc64 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -30,6 +30,31 @@ promise_and_delete () {
 	delete_object repo "$HASH"
 }
 
+upload_blob() {
+	SERVER_REPO="$1"
+	HASH="$2"
+
+	test -n "$HASH" || die "Invalid argument '$HASH'"
+	HASH_SIZE=$(git -C "$SERVER_REPO" cat-file -s "$HASH") || {
+		echo >&2 "Cannot get blob size of '$HASH'"
+		return 1
+	}
+
+	UPLOAD_URL="http://127.0.0.1:$LIB_HTTPD_PORT/upload/?sha1=$HASH&size=$HASH_SIZE&type=blob"
+
+	git -C "$SERVER_REPO" cat-file blob "$HASH" >object &&
+	curl --data-binary @object --include "$UPLOAD_URL"
+}
+
+upload_blobs_from_stdin() {
+	SERVER_REPO="$1"
+	while read -r blob
+	do
+		echo "uploading $blob"
+		upload_blob "$SERVER_REPO" "$blob" || return
+	done
+}
+
 test_expect_success 'extensions.partialclone without filter' '
 	test_create_repo server &&
 	git clone --filter="blob:none" "file://$(pwd)/server" client &&
@@ -668,6 +693,33 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	grep "$HASH" out
 '
 
+PATH="$TEST_DIRECTORY/t0410:$PATH"
+
+test_expect_success 'fetch of missing objects through remote helper' '
+	rm -rf origin server &&
+	test_create_repo origin &&
+	dd if=/dev/zero of=origin/file1 bs=801k count=1 &&
+	git -C origin add file1 &&
+	git -C origin commit -m "large blob" &&
+	sha="$(git -C origin rev-parse :file1)" &&
+	expected="?$(git -C origin rev-parse :file1)" &&
+	git clone --bare --no-local origin server &&
+	git -C server remote add httpremote "testhttpgit::${PWD}/server" &&
+	git -C server config remote.httpremote.promisor true &&
+	git -C server config --remove-section remote.origin &&
+	git -C server rev-list --all --objects --filter-print-omitted \
+		--filter=blob:limit=800k | perl -ne "print if s/^[~]//" \
+		>large_blobs.txt &&
+	upload_blobs_from_stdin server <large_blobs.txt &&
+	git -C server -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=800k &&
+	git -C server rev-list --objects --all --missing=print >objects &&
+	grep "$expected" objects &&
+	HTTPD_URL=$HTTPD_URL git -C server show $sha &&
+	git -C server rev-list --objects --all --missing=print >objects &&
+	grep "$sha" objects
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
diff --git a/t/t0410/git-remote-testhttpgit b/t/t0410/git-remote-testhttpgit
new file mode 100755
index 00000000000..e5e187243ed
--- /dev/null
+++ b/t/t0410/git-remote-testhttpgit
@@ -0,0 +1,170 @@
+#!/bin/sh
+# Copyright (c) 2012 Felipe Contreras
+# Copyright (c) 2020 Christian Couder
+
+# This is a git remote helper that can be used to store blobs on an http server
+
+# The first argument can be a url when the fetch/push command was a url
+# instead of a configured remote. In this case, use a generic alias.
+if test "$1" = "testhttpgit::$2"; then
+	alias=_
+else
+	alias=$1
+fi
+url=$2
+
+unset GIT_DIR
+
+h_refspec="refs/heads/*:refs/testhttpgit/$alias/heads/*"
+t_refspec="refs/tags/*:refs/testhttpgit/$alias/tags/*"
+
+if test -n "$GIT_REMOTE_TESTHTTPGIT_NOREFSPEC"
+then
+	h_refspec=""
+	t_refspec=""
+fi
+
+die () {
+	echo >&2 "fatal: $*"
+	echo "fatal: $*" >>/tmp/t0430.txt
+	echo >>/tmp/t0430.txt
+	exit 1
+}
+
+force=
+
+mark_count_tmp=$(mktemp -t git-remote-http-mark-count_XXXXXX) || die "Failed to create temp file"
+echo "1" >"$mark_count_tmp"
+
+get_mark_count() {
+	mark=$(cat "$mark_count_tmp")
+	echo "$mark"
+	mark=$((mark+1))
+	echo "$mark" >"$mark_count_tmp"	
+}
+
+export_blob_from_file() {
+	file="$1"
+	echo "blob"
+	echo "mark :$(get_mark_count)"
+	size=$(wc -c <"$file") || return
+	echo "data $size"
+	cat "$file" || return
+	echo
+}
+
+while read line
+do
+	case $line in
+	capabilities)
+		echo 'import'
+		echo 'export'
+		test -n "$h_refspec" && echo "refspec $h_refspec"
+		test -n "$t_refspec" && echo "refspec $t_refspec"
+		test -n "$GIT_REMOTE_TESTHTTPGIT_SIGNED_TAGS" && echo "signed-tags"
+		test -n "$GIT_REMOTE_TESTHTTPGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
+		echo 'option'
+		echo
+		;;
+	list)
+		git -C "$url" for-each-ref --format='? %(refname)' 'refs/heads/' 'refs/tags/'
+		head=$(git -C "$url" symbolic-ref HEAD)
+		echo "@$head HEAD"
+		echo
+		;;
+	import*)
+		# read all import lines
+		while true
+		do
+			ref="${line#* }"
+			refs="$refs $ref"
+			read line
+			test "${line%% *}" != "import" && break
+		done
+
+		echo "refs: $refs" >>/tmp/t0430.txt
+
+		if test -n "$GIT_REMOTE_TESTHTTPGIT_FAILURE"
+		then
+			echo "feature done"
+			exit 1
+		fi
+
+		echo "feature done"
+
+		tmpdir=$(mktemp -d -t git-remote-http-import_XXXXXX) || die "Failed to create temp directory"
+
+		for ref in $refs
+		do
+			get_url="$HTTPD_URL/list/?sha1=$ref"
+			echo "curl url: $get_url" >>/tmp/t0430.txt
+			echo "curl output: $tmpdir/$ref" >>/tmp/t0430.txt
+			curl -s -o "$tmpdir/$ref" "$get_url" ||
+				die "curl '$get_url' failed"
+			echo "exporting from: $tmpdir/$ref" >>/tmp/t0430.txt
+			export_blob_from_file "$tmpdir/$ref" ||
+				die "failed to export blob from '$tmpdir/$ref'"
+			echo "done exporting" >>/tmp/t0430.txt
+		done
+
+		echo "done"
+		;;
+	export)
+		if test -n "$GIT_REMOTE_TESTHTTPGIT_FAILURE"
+		then
+			# consume input so fast-export doesn't get SIGPIPE;
+			# git would also notice that case, but we want
+			# to make sure we are exercising the later
+			# error checks
+			while read line; do
+				test "done" = "$line" && break
+			done
+			exit 1
+		fi
+
+		before=$(git -C "$url" for-each-ref --format=' %(refname) %(objectname) ')
+
+		git -C "$url" fast-import \
+			${force:+--force} \
+			${testhttpgitmarks:+"--import-marks=$testhttpgitmarks"} \
+			${testhttpgitmarks:+"--export-marks=$testhttpgitmarks"} \
+			--quiet
+
+		# figure out which refs were updated
+		git -C "$url" for-each-ref --format='%(refname) %(objectname)' |
+		while read ref a
+		do
+			case "$before" in
+			*" $ref $a "*)
+				continue ;;	# unchanged
+			esac
+			if test -z "$GIT_REMOTE_TESTHTTPGIT_PUSH_ERROR"
+			then
+				echo "ok $ref"
+			else
+				echo "error $ref $GIT_REMOTE_TESTHTTPGIT_PUSH_ERROR"
+			fi
+		done
+
+		echo
+		;;
+	option\ *)
+		read cmd opt val <<-EOF
+		$line
+		EOF
+		case $opt in
+		force)
+			test $val = "true" && force="true" || force=
+			echo "ok"
+			;;
+		*)
+			echo "unsupported"
+			;;
+		esac
+		;;
+	'')
+		exit
+		;;
+	esac
+done
+
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index e489869dd94..78cc1858cb6 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -237,6 +237,26 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'repack with filter does not fetch from remote' '
+	rm -rf server client &&
+	test_create_repo server &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true &&
+	echo content1 >server/file1 &&
+	git -C server add file1 &&
+	git -C server commit -m initial_commit &&
+	expected="?$(git -C server rev-parse :file1)" &&
+	git clone --bare --no-local server client &&
+	git -C client config remote.origin.promisor true &&
+	git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	grep "$expected" objects &&
+	git -C client repack -a -d &&
+	expected="$(git -C server rev-parse :file1)" &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	grep "$expected" objects
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
gitgitgadget
