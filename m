Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC1FC54FCB
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E33221F7
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl7TozUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgDRQDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgDRQDt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 12:03:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9DC061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so2458520pjb.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWOsfHnnPS30XKZweFXCjZnsqDvLA8QOHlTiKP0Yt9Y=;
        b=bl7TozUYObKvvJNunO0BGLaRHrIuJFxF0Krfq3zOKE+TJm3svAseiV3TGCK9EYah8O
         gPjPTVmZDmKqpHLFM8JWs0Td58jtsQm/Wdgvd5VAdURYxNhcre6LsqmGE+ukW10n2nua
         5VqNnSI9YV3G7gTd+nX25jkyv4TTdTY9ckyB453ufideDRRtf4fCL6d7mSDmzsLUQrsq
         CYlb3jLjJHHMd3ReWjMU+Do2pqPqSYSeGBcRVK8HAoXFxXb/qaNuHklZBmXAkfqVFi/d
         kXwa1EPZMTc5f82zmukorPBpbty8qEGJmPsMIV7FT2Wyy02dzhyPpnO6gXVEucCgg2na
         zhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWOsfHnnPS30XKZweFXCjZnsqDvLA8QOHlTiKP0Yt9Y=;
        b=iI5mGxd63aTvpZxshJi6fZj3OvnPZAmWPKcty0NBrbt8bmXcw3XN6kutWu8T8W2yQH
         JKUX9ByYEGEUYuAiV1lHOVPGSVhUFT7Vy/CZHX+ne5Ll9ZX8OIjmoxX/tf/rdrKz8JKm
         gYbA08Y8s3XDCNBalSk8tCWhdbq9CUEzkangOgAhGlxYmCBdYo/mmcmLSLDPZz29/jda
         mIHQTYApeHCUlB1wi3GoaGjKgYKILbc4hL1g07JUB/HosGBuoFJdyRKSJev/GU20BNe9
         klHEJ0RI+dWyBy5g4JTkdUqdCzPDEjioCs2pdSS2Y2RNfAz/3i4B4aBlPy1Hj4Pw3XuT
         GOfw==
X-Gm-Message-State: AGi0PubglMTVQ0ansvflfW0bw9npCJRJwp6OpsxxPEatAMX/TIskPgHV
        GgA3L3yKQKfN7ioLv7Ms8Fk=
X-Google-Smtp-Source: APiQypKMlWCKA2XNszZ3THGuwsGi7QSzEPGXrXz0S8H30zwdwPUOVM3zTb1kQFIqclwF5a+m1Yb2mg==
X-Received: by 2002:a17:90a:e7cf:: with SMTP id kb15mr11183707pjb.146.1587225828233;
        Sat, 18 Apr 2020 09:03:48 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i187sm22461649pfg.33.2020.04.18.09.03.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:03:47 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 0/8] New proc-receive hook for centralized workflow
Date:   Sat, 18 Apr 2020 12:03:26 -0400
Message-Id: <20200418160334.15631-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200414123257.27449-1-worldhello.net@gmail.com>
References: <20200414123257.27449-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Note: This patches series is based on topic branch `jx/atomic-push`,
      for there are overlap changes between these two topics.

## Changes since v12

1. test: Remove t5412, and move HTTP test cases into t5411.

2. test: Split test cases into multiple files as `t/t5411/test-*.sh`.

3. test: Add test cases for porcelain `git-push` output for
   `pro-receive` hook.  See files 't/t5411/test-*--porcelain.sh'.

4. New patch 5/8 to feed proper commands to `post-receive` hook.

5. Use flag `PACKET_READ_GENTLE_ON_EOF` instead of
   `PACKET_READ_DIE_ON_ERR_PACKET` for `packet_reader_init()`
   when reading result from the 'proc-receive' hook.
   So 'receive-pack' won't die with the `proc-receive` hook.

6.  Add two new options (`--die-version` and `--die-readline`) for
   't/helper/test-proc-receive.c', so we can test unexpected crash of
   'proc-receive' hook.

7. Apply the "SQUASH???" commit.

## Range-diff v12...v13

1:  77a731c151 < -:  ---------- transport: not report a non-head push as a branch
-:  ---------- > 1:  312ee17e84 transport: not report a non-head push as a branch
2:  4c4f7cffff = 2:  e86a3c5a4e connect: export parse_feature_value()
3:  b76900cb0f ! 3:  5adc60e9d1 receive-pack: add new proc-receive hook
    @@ Makefile: TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
      TEST_BUILTINS_OBJS += test-read-cache.o
     
      ## builtin/receive-pack.c ##
    -@@
    - #include "remote.h"
    - #include "connect.h"
    - #include "string-list.h"
    -+#include "string.h"
    - #include "sha1-array.h"
    - #include "connected.h"
    - #include "argv-array.h"
     @@ builtin/receive-pack.c: static void write_head_info(void)
      	packet_flush(1);
      }
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +	for (;;) {
     +		struct object_id old_oid, new_oid;
    -+		char *status;
    ++		const char *status;
     +		char *refname;
     +		char *remains = NULL;
     +
     +		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     +			break;
    -+		status = (char *)reader->line;
    ++		status = reader->line;
     +		refname = strchr(status, ' ');
     +		if (refname) {
     +			*refname++ = '\0';
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
     +			hint->run_proc_receive = 0;
     +		} else if (!strcmp("alt", status)) {
    -+			char *alt_ref;
    ++			char *alt_ref = NULL;
    ++			char *p1, *p2;
     +
    -+			alt_ref = remains;
    -+			remains = strchr(alt_ref, ' ');
    -+			if (remains)
    -+				*remains++ = '\0';
    ++			if (!remains) {
    ++				strbuf_addf(errmsg, "proc-receive expected 'alt <ref> <alt-ref> ...', got 'alt %s'\n",
    ++					    refname);
    ++				continue;
    ++			}
    ++			p1 = strchr(remains, '=');
    ++			p2 = strchr(remains, ' ');
    ++			if (!p1) {
    ++				/*
    ++				 * "alt <ref> <alt-ref>", or
    ++				 * "alt <ref> <alt-ref> forced-update"
    ++				 */
    ++				alt_ref = remains;
    ++				remains = p2;
    ++				if (remains)
    ++					*remains++ = '\0';
    ++			} else if (!p2) {
    ++				/* "alt <ref> old-oid=<oid>" */
    ++				alt_ref = NULL;
    ++			} else if (p1 > p2) {
    ++				/* "alt <ref> <alt-ref> old-oid=<oid>" */
    ++				alt_ref = remains;
    ++				remains = p2;
    ++				if (remains)
    ++					*remains++ = '\0';
    ++			} else {
    ++				/* "alt <ref> old-oid=<oid1> new-oid=<oid2>" */
    ++				alt_ref = NULL;
    ++			}
     +
     +			if (hint->extended_status)
     +				strbuf_addstr(&extended_status, hint->extended_status);
     +
    -+			strbuf_addf(&extended_status, "%sref=%s",
    -+				    extended_status.len > 0 ? " ": "",
    -+				    alt_ref);
    ++			/*
    ++			 * Already received an "ok <ref>" response, add an
    ++			 * additional "ref=<ref>" field.
    ++			 */
    ++			if (extended_status.len == 0 &&
    ++			    hint->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)
    ++				strbuf_addf(&extended_status, "ref=%s", refname);
    ++
    ++			if (alt_ref)
    ++				strbuf_addf(&extended_status, "%sref=%s",
    ++					    extended_status.len > 0 ? " ": "",
    ++					    alt_ref);
    ++			else if (extended_status.len > 0)
    ++				/*
    ++				 * Start new extended status for refname, if it
    ++				 * is not the first report for this reference.
    ++				 */
    ++				strbuf_addf(&extended_status, " ref=%s", refname);
     +
     +			if (remains) {
     +				const char *val;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	/* Version negotiaton */
     +	packet_reader_init(&reader, proc.out, NULL, 0,
     +			   PACKET_READ_CHOMP_NEWLINE |
    -+			   PACKET_READ_DIE_ON_ERR_PACKET);
    ++			   PACKET_READ_GENTLE_ON_EOF);
     +	if (use_atomic)
     +		strbuf_addstr(&cap, " atomic");
     +	if (use_push_options)
    @@ t/helper/test-proc-receive.c (new)
     +	NULL
     +};
     +
    -+static int version = 1;
    -+static int verbose = 0;
    ++static int die_version = 0;
    ++static int die_readline = 0;
     +static int no_push_options = 0;
     +static int use_atomic = 0;
     +static int use_push_options = 0;
    ++static int verbose = 0;
    ++static int version = 1;
     +static struct string_list returns = STRING_LIST_INIT_NODUP;
     +
     +struct command {
    @@ t/helper/test-proc-receive.c (new)
     +		}
     +	}
     +
    -+	if (server_version != 1)
    ++	if (server_version != 1 || die_version)
     +		die("bad protocol version: %d", server_version);
     +
     +	packet_write_fmt(1, "version=%d%c%s\n",
    @@ t/helper/test-proc-receive.c (new)
     +		if (parse_oid_hex(reader->line, &old_oid, &p) ||
     +		    *p++ != ' ' ||
     +		    parse_oid_hex(p, &new_oid, &p) ||
    -+		    *p++ != ' ')
    ++		    *p++ != ' ' ||
    ++		    die_readline)
     +			die("protocol error: expected 'old new ref', got '%s'",
     +			    reader->line);
     +		refname = p;
    @@ t/helper/test-proc-receive.c (new)
     +	struct option options[] = {
     +		OPT_BOOL(0, "no-push-options", &no_push_options,
     +			 "disable push options"),
    ++		OPT_BOOL(0, "die-version", &die_version,
    ++			 "die during version negotiation"),
    ++		OPT_BOOL(0, "die-readline", &die_readline,
    ++			 "die when readline"),
     +		OPT_STRING_LIST('r', "return", &returns, "old/new/ref/status/msg",
     +				"return of results"),
     +		OPT__VERBOSE(&verbose, "be verbose"),
    @@ t/helper/test-proc-receive.c (new)
     +	}
     +
     +	if (returns.nr)
    -+		for_each_string_list_item(item, &returns) {
    -+			char *p;
    -+
    -+			p = strstr(item->string, "\\0");
    -+			if (p) {
    -+				*p = '\0';
    -+				p += 2;
    -+				packet_write_fmt(1, "%s%c%s\n", item->string, '\0', p);
    -+			} else {
    -+				packet_write_fmt(1, "%s\n", item->string);
    -+			}
    -+		}
    ++		for_each_string_list_item(item, &returns)
    ++			packet_write_fmt(1, "%s\n", item->string);
     +	packet_flush(1);
     +	sigchain_pop(SIGPIPE);
     +
    @@ t/helper/test-tool.h: int cmd__parse_pathspec_file(int argc, const char** argv);
      int cmd__reach(int argc, const char **argv);
      int cmd__read_cache(int argc, const char **argv);
     
    - ## t/t5411/common-functions.sh ##
    -@@ t/t5411/common-functions.sh: create_commits_in () {
    - # Format the output of git-push, git-show-ref and other commands to make a
    - # user-friendly and stable text.  We can easily prepare the expect text
    - # without having to worry about future changes of the commit ID and spaces
    --# of the output.  We also replce single quotes with double quotes, because
    --# it is boring to prepare unquoted single quotes in expect text.
    -+# of the output.  Single quotes are replaced with double quotes, because
    -+# it is boring to prepare unquoted single quotes in expect text.  We also
    -+# remove some locale error messages, which break test if we turn on
    -+# `GIT_TEST_GETTEXT_POISON=true` in order to test unintentional translations
    -+# on plumbing commands.
    - make_user_friendly_and_stable_output_common () {
    - 	sed \
    - 		-e "s/  *\$//" \
    -@@ t/t5411/common-functions.sh: make_user_friendly_and_stable_output_common () {
    - 		-e "s/$TAG/<TAG-v123>/g" \
    - 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
    - 		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
    --		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g"
    -+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
    -+		-e "/^error: / d"
    - }
    -
    - ## t/t5411/common-test-cases.sh ##
    -@@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
    - 	EOF
    - 	test_cmp expect actual
    - '
    -+
    -+# Refs of upstream : master(A)  tags/v123  refs/review/master/topic(A)  a/b/c(A)
    -+# Refs of workbench: master(A)  tags/v123
    -+test_expect_success "cleanup" '
    -+	(
    -+		cd "$upstream" &&
    -+		git update-ref -d refs/review/master/topic &&
    -+		git update-ref -d refs/tags/v123 &&
    -+		git update-ref -d refs/heads/a/b/c
    -+	)
    -+'
    -+
    + ## t/t5411/test-0011-no-hook-error.sh (new) ##
    +@@
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       next(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: no hook, fail to push special ref" '
    ++test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:next \
     +		HEAD:refs/for/master/topic \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +
     +# Refs of upstream : master(A)             next(A)
     +# Refs of workbench: master(A)  tags/v123
    -+test_expect_success "cleanup" '
    ++test_expect_success "cleanup ($PROTOCOL)" '
     +	git -C "$upstream" update-ref -d refs/heads/next
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: no hook, fail all for atomic push" '
    ++test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCOL)" '
     +	test_must_fail git -C workbench push --atomic origin \
     +		$B:master \
     +		HEAD:next \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0012-no-hook-error--porcelain.sh (new) ##
    +@@
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       next(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: no hook, fail to push special ref (--porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		HEAD:next \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: error: cannot find hook "proc-receive"
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/heads/next    [new branch]
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	<COMMIT-A> refs/heads/next
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref -d refs/heads/next
     +'
     +
    -+test_expect_success "setup proc-receive hook (unknown version)" '
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: no hook, all failed for atomic push (--porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain --atomic origin \
    ++		$B:master \
    ++		HEAD:next \
    ++		HEAD:refs/for/master/topic >out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: error: cannot find hook "proc-receive"
    ++	To <URL/of/upstream.git>
    ++	!    <COMMIT-B>:refs/heads/master    [remote rejected] (fail to run proc-receive hook)
    ++	!    HEAD:refs/heads/next    [remote rejected] (fail to run proc-receive hook)
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0013-bad-protocol.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v --version 2
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: bad protocol (unknown version)" '
    ++test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +
     +	# Check status report for git-push
     +	sed -n \
    -+		-e "/^To / { s/   */ /g; p; }" \
    -+		-e "/^ / { s/   */ /g; p; }" \
    ++		-e "/^To / { p; n; p; }" \
     +		<actual >actual-report &&
     +	cat >expect <<-EOF &&
     +	To <URL/of/upstream.git>
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	# Check error message from "receive-pack", but ignore unstable fatal error
     +	# message ("remote: fatal: the remote end hung up unexpectedly") which
     +	# is different from the remote HTTP server with different locale settings.
    -+	sed -n -e "/^remote: error:/ { s/   */ /g; p; }" \
    -+		<actual >actual-error &&
    ++	grep "^remote: error:" <actual >actual-error &&
     +	cat >expect <<-EOF &&
     +	remote: error: proc-receive version "2" is not supported
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (no report)" '
    ++test_expect_success "setup proc-receive hook (hook --die-version, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v --die-version
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: fatal: bad protocol version: 1
    ++	remote: error: proc-receive version "0" is not supported
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (hook --die-readline, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v --die-readline
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: fatal: protocol error: expected "old new ref", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       next(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: bad protocol (no report)" '
    ++test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/heads/next \
     +		HEAD:refs/for/master/topic >out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +
     +# Refs of upstream : master(A)             next(A)
     +# Refs of workbench: master(A)  tags/v123
    -+test_expect_success "cleanup" '
    ++test_expect_success "cleanup ($PROTOCOL)" '
     +	git -C "$upstream" update-ref -d refs/heads/next
     +
     +'
     +
    -+test_expect_success "setup proc-receive hook (no ref)" '
    ++test_expect_success "setup proc-receive hook (no ref, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: bad protocol (no ref)" '
    ++test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic\
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (unknown status)" '
    ++test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: bad protocol (unknown status)" '
    ++test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
     +	test_must_fail git -C workbench push origin \
     +			HEAD:refs/for/master/topic \
     +			>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	EOF
     +	test_cmp expect actual
     +'
    -+
    -+test_expect_success "setup proc-receive hook (ng)" '
    +
    + ## t/t5411/test-0014-bad-protocol--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+	test-tool proc-receive -v \
    -+		-r "ng refs/for/master/topic"
    ++	test-tool proc-receive -v --version 2
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: fail to update (ng)" '
    -+	test_must_fail git -C workbench push origin \
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: bad protocol (unknown version, --porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
    ++
    ++	# Check status report for git-push
    ++	sed -n \
    ++		-e "/^To / { p; n; p; n; p; }" \
    ++		<actual >actual-report &&
     +	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> ng refs/for/master/topic
     +	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (failed)
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
    ++	Done
     +	EOF
    -+	test_cmp expect actual &&
    ++	test_cmp expect actual-report &&
    ++
    ++	# Check error message from "receive-pack", but ignore unstable fatal error
    ++	# message ("remote: fatal: the remote end hung up unexpectedly") which
    ++	# is different from the remote HTTP server with different locale settings.
    ++	grep "^remote: error:" <actual >actual-error &&
    ++	cat >expect <<-EOF &&
    ++	remote: error: proc-receive version "2" is not supported
    ++	EOF
    ++	test_cmp expect actual-error &&
    ++
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (ng message)" '
    ++test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+	test-tool proc-receive -v \
    -+		-r "ng refs/for/master/topic error msg"
    ++	test-tool proc-receive -v
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: fail to update (ng message)" '
    -+	test_must_fail git -C workbench push origin \
    -+		HEAD:refs/for/master/topic \
    -+		>out 2>&1 &&
    ++# git push         :                       next(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: bad protocol (no report, --porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		HEAD:refs/heads/next \
    ++		HEAD:refs/for/master/topic >out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> ng refs/for/master/topic error msg
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (error msg)
    ++	*    HEAD:refs/heads/next    [new branch]
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
    ++	Done
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    ++	<COMMIT-A> refs/heads/next
     +	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (unexpected ref)" '
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref -d refs/heads/next
    ++
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (no ref, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ok refs/heads/master"
    ++		-r "ok"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push         : (B)                   refs/for/master/topic
    -+test_expect_success "proc-receive: report on unexpected ref" '
    -+	test_must_fail git -C workbench push origin \
    -+		$B:refs/heads/master \
    -+		HEAD:refs/for/master/topic \
    ++# git push         :                       refs/for/master/topic
    ++test_expect_success "proc-receive: bad protocol (no ref, --porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic\
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    -+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> ok refs/heads/master
    -+	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
    -+	remote: # post-receive hook
    -+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: proc-receive> ok
    ++	remote: error: proc-receive expected "<status> <ref> ...", got "ok"
     +	To <URL/of/upstream.git>
    -+	 <OID-A>..<OID-B> <COMMIT-B> -> master
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
    ++	Done
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	<COMMIT-B> refs/heads/master
    ++	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
     +'
     +
    -+# Refs of upstream : master(B)
    -+# Refs of workbench: master(A)  tags/v123
    -+test_expect_success "cleanup" '
    -+	git -C "$upstream" update-ref refs/heads/master $A
    -+'
    -+
    -+test_expect_success "setup proc-receive hook (ok)" '
    ++test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ok refs/for/master/topic"
    ++		-r "xx refs/for/master/topic"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: ok" '
    -+	git -C workbench push origin \
    -+		HEAD:refs/for/master/topic \
    -+		>out 2>&1 &&
    ++test_expect_success "proc-receive: bad protocol (unknown status, --porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++			HEAD:refs/for/master/topic \
    ++			>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> ok refs/for/master/topic
    -+	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> xx refs/for/master/topic
    ++	remote: error: proc-receive reported bad status "xx" on ref "refs/for/master/topic"
     +	To <URL/of/upstream.git>
    -+	 * [new reference] HEAD -> refs/for/master/topic
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
    ++	Done
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0020-report-ng.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ng refs/for/master/topic"
    ++	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/a/b/c/my/topic
    -+test_expect_success "proc-receive: failed to report status" '
    ++# git push         :                       refs/for/master/topic
    ++test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
     +	test_must_fail git -C workbench push origin \
    -+		HEAD:refs/for/a/b/c/my/topic \
    ++		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
    -+	remote: proc-receive> ok refs/for/master/topic
    -+	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ng refs/for/master/topic
     +	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (failed)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+# Refs of upstream : master(A)
    -+# Refs of workbench: master(A)  tags/v123
    -+# git push -o ...  :                       refs/for/master/topic
    -+test_expect_success "proc-receive: not support push options" '
    -+	test_must_fail git -C workbench push \
    ++test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ng refs/for/master/topic error msg"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
    ++test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ng refs/for/master/topic error msg
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (error msg)
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0021-report-ng--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ng refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
    ++test_expect_success "proc-receive: fail to update (ng, no message, --porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ng refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (failed)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ng refs/for/master/topic error msg"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
    ++test_expect_success "proc-receive: fail to update (ng, with message, --porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ng refs/for/master/topic error msg
    ++	To <URL/of/upstream.git>
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (error msg)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0022-report-unexpect-ref.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/heads/master"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         : (B)                   refs/for/master/topic
    ++test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
    ++	test_must_fail git -C workbench push origin \
    ++		$B:refs/heads/master \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/heads/master
    ++	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
    ++	remote: # post-receive hook
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	To <URL/of/upstream.git>
    ++	 <OID-A>..<OID-B> <COMMIT-B> -> master
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-B> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(B)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref refs/heads/master $A
    ++'
    +
    + ## t/t5411/test-0023-report-unexpect-ref--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/heads/master"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         : (B)                   refs/for/master/topic
    ++test_expect_success "proc-receive: report unexpected ref (--porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		$B:refs/heads/master \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/heads/master
    ++	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
    ++	remote: # post-receive hook
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	To <URL/of/upstream.git>
    ++	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-B> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(B)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref refs/heads/master $A
    ++'
    +
    + ## t/t5411/test-0024-report-unknown-ref.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/a/b/c/my/topic
    ++test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/a/b/c/my/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0025-report-unknown-ref--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/a/b/c/my/topic
    ++test_expect_success "proc-receive: report unknown reference (--porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/a/b/c/my/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	!    HEAD:refs/for/a/b/c/my/topic    [remote rejected] (proc-receive failed to report status)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0026-push-options.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL)" '
    ++	git -C "$upstream" config receive.advertisePushOptions false &&
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push -o ...  :                       refs/for/master/topic
    ++test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
    ++	test_must_fail git -C workbench push \
     +		-o issue=123 \
     +		-o reviewer=user1 \
     +		origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
    -+	test_i18ngrep "fatal: the receiving end does not support push options" \
    -+		actual &&
    ++	test_i18ngrep "fatal: the receiving end does not support push options" \
    ++		actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "enable push options ($PROTOCOL)" '
    ++	git -C "$upstream" config receive.advertisePushOptions true
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push -o ...  :                       next(A)  refs/for/master/topic
    ++test_expect_success "proc-receive: push with options ($PROTOCOL)" '
    ++	git -C workbench push \
    ++		--atomic \
    ++		-o issue=123 \
    ++		-o reviewer=user1 \
    ++		origin \
    ++		HEAD:refs/heads/next \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive: atomic push_options
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive< issue=123
    ++	remote: proc-receive< reviewer=user1
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new branch] HEAD -> next
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	<COMMIT-A> refs/heads/next
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref -d refs/heads/next
    ++'
    +
    + ## t/t5411/test-0027-push-options--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL)" '
    ++	git -C "$upstream" config receive.advertisePushOptions false &&
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push -o ...  :                       refs/for/master/topic
    ++test_expect_success "proc-receive: not support push options (--porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push \
    ++		--porcelain \
    ++		-o issue=123 \
    ++		-o reviewer=user1 \
    ++		origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	test_i18ngrep "fatal: the receiving end does not support push options" \
    ++		actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "enable push options ($PROTOCOL)" '
    ++	git -C "$upstream" config receive.advertisePushOptions true
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push -o ...  :                       next(A)  refs/for/master/topic
    ++test_expect_success "proc-receive: push with options (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push \
    ++		--porcelain \
    ++		--atomic \
    ++		-o issue=123 \
    ++		-o reviewer=user1 \
    ++		origin \
    ++		HEAD:refs/heads/next \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive: atomic push_options
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive< issue=123
    ++	remote: proc-receive< reviewer=user1
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/heads/next    [new branch]
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	<COMMIT-A> refs/heads/next
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref -d refs/heads/next
    ++'
    +
    + ## t/t5411/test-0030-report-ok.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (ok, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
    ++test_expect_success "proc-receive: ok ($PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0031-report-ok--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (ok, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
    ++test_expect_success "proc-receive: ok (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0032-report-alt.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (alt <ref>, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref>, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic
    ++	remote: error: proc-receive expected "alt <ref> <alt-ref> ...", got "alt refs/for/master/topic"
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> <alt-ref>, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/pull/123/head"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, $PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> forced-update, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/pull/123/head forced-update"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update, $PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> old-oid=X, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, $PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> old-oid=X, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic old-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, $PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> old-oid=X new-oid=Y, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic old-oid=$A new-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, $PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (with multiple alt reports, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/a/b/c/topic" \
    ++		-r "alt refs/for/next/topic refs/pull/123/head" \
    ++		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: with multiple alt reports ($PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/next/topic \
    ++		HEAD:refs/for/a/b/c/topic \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/a/b/c/topic
    ++	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/next/topic
    ++	 * [new reference] HEAD -> refs/for/a/b/c/topic
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0033-report-alt--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (alt <ref>, --porcelain, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref>, --porcelain, $PROTOCOL)" '
    ++	test_must_fail git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic
    ++	remote: error: proc-receive expected "alt <ref> <alt-ref> ...", got "alt refs/for/master/topic"
    ++	To <URL/of/upstream.git>
    ++	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> <alt-ref>, --porcelain, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/pull/123/head"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, --porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> forced-update, --porcelain, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/pull/123/head forced-update"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update, --porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic old-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (alt <ref> old-oid=X new-oid=Y, --porcelain, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic old-oid=$A new-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, --porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (with multiple alt reports, --porcelain, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/a/b/c/topic" \
    ++		-r "alt refs/for/next/topic refs/pull/123/head" \
    ++		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: with multiple alt reports (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/next/topic \
    ++		HEAD:refs/for/a/b/c/topic \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/a/b/c/topic
    ++	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/next/topic    [new reference]
    ++	*    HEAD:refs/for/a/b/c/topic    [new reference]
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0034-report-ft.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ft refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(B)
    ++test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		$B:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: proc-receive> ft refs/for/master/topic
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] <COMMIT-B> -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-B> refs/for/master/topic
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(A)             refs/for/master/topic(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref -d refs/for/master/topic
    ++'
    +
    + ## t/t5411/test-0035-report-ft--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ft refs/for/master/topic"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(B)
    ++test_expect_success "proc-receive: fall throught, let receive-pack to execute (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		$B:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: proc-receive> ft refs/for/master/topic
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    <COMMIT-B>:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-B> refs/for/master/topic
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(A)             refs/for/master/topic(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref -d refs/for/master/topic
    ++'
    +
    + ## t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 1st resp, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    ++		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    ++		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$A new-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st resp ($PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "enable push options" '
    -+	git -C "$upstream" config receive.advertisePushOptions true
    ++test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 2nd resp, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    ++		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    ++		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$B new-oid=$A forced-update"
    ++	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push -o ...  :                       next(A)  refs/for/master/topic
    -+test_expect_success "proc-receive: push with options" '
    -+	git -C workbench push \
    -+		--atomic \
    -+		-o issue=123 \
    -+		-o reviewer=user1 \
    -+		origin \
    -+		HEAD:refs/heads/next \
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd resp ($PROTOCOL)" '
    ++	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
    -+	remote: proc-receive: atomic push_options
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive< issue=123
    -+	remote: proc-receive< reviewer=user1
    -+	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
     +	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    -+	 * [new branch] HEAD -> next
     +	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    -+	<COMMIT-A> refs/heads/next
     +	EOF
     +	test_cmp expect actual
     +'
     +
    -+# Refs of upstream : master(A)             next(A)
    ++test_expect_success "setup proc-receive hook (ok and alt for the same ref, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "alt refs/for/master/topic refs/changes/24/124/1 new-oid=$B old-oid=$A"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+test_expect_success "cleanup" '
    -+	git -C "$upstream" update-ref -d refs/heads/next
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report ok and alt for the same ref ($PROTOCOL)" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (ft)" '
    ++test_expect_success "setup proc-receive hook (multiple responses, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ft refs/for/master/topic"
    ++		-r "alt refs/for/master/topic refs/changes/23/123/1" \
    ++		-r "alt refs/for/master/topic refs/changes/24/124/2 old-oid=$A new-oid=$B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/master/topic(B)
    -+test_expect_success "proc-receive: fall throught, let receive-pack to execute" '
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report multiple response ($PROTOCOL)" '
     +	git -C workbench push origin \
    -+		$B:refs/for/master/topic \
    ++		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    -+	remote: proc-receive> ft refs/for/master/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
     +	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    -+	 * [new reference] <COMMIT-B> -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	<COMMIT-B> refs/for/master/topic
     +	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
    ++'
    +
    + ## t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 1st resp, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    ++		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    ++		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$A new-oid=$B"
    ++	EOF
     +'
     +
    -+# Refs of upstream : master(A)             refs/for/master/topic(A)
    ++# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+test_expect_success "cleanup" '
    -+	git -C "$upstream" update-ref -d refs/for/master/topic
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st resp (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (with extended status)" '
    ++test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 2nd resp, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ok refs/for/a/b/c/topic" \
    -+		-r "alt refs/for/next/topic refs/pull/123/head" \
    -+		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
    ++		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    ++		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    ++		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$B new-oid=$A forced-update"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report with extended status" '
    -+	git -C workbench push origin \
    -+		HEAD:refs/for/next/topic \
    -+		HEAD:refs/for/a/b/c/topic \
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd resp (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> ok refs/for/a/b/c/topic
    -+	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    ++	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
     +	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    -+	 * [new reference] HEAD -> refs/for/next/topic
    -+	 * [new reference] HEAD -> refs/for/a/b/c/topic
    -+	 * [new reference] HEAD -> refs/for/master/topic
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (ok and alt for the same ref, $PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "alt refs/for/master/topic refs/changes/24/124/1 new-oid=$B old-oid=$A"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report ok and alt for the same ref (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (multiple responses)" '
    ++test_expect_success "setup proc-receive hook (multiple responses, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report multiple response" '
    -+	git -C workbench push origin \
    ++test_expect_success "proc-receive: report multiple response (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    -+	 * [new reference] HEAD -> refs/for/master/topic
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	EOF
     +	test_cmp expect actual
     +'
    -+
    -+test_expect_success "setup proc-receive hook" '
    +
    + ## t/t5411/test-0038-report-mixed-refs.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook ($PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report update of mixed refs" '
    ++test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/heads/bar \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	(
    ++		cd "$upstream" &&
    ++		git update-ref refs/heads/master $A &&
    ++		git update-ref -d refs/heads/foo &&
    ++		git update-ref -d refs/heads/bar &&
    ++		git update-ref -d refs/heads/baz
    ++	)
    ++
    ++'
    +
    + ## t/t5411/test-0039-report-mixed-refs--porcelain.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook ($PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/next/topic" \
    ++		-r "alt refs/for/master/topic refs/for/master/topic old-oid=$A new-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report update of mixed refs (--porcelain, $PROTOCOL)" '
    ++	git -C workbench push --porcelain origin \
    ++		$B:refs/heads/master \
    ++		HEAD:refs/heads/bar \
    ++		HEAD:refs/heads/baz \
    ++		HEAD:refs/for/next/topic \
    ++		HEAD:refs/heads/foo \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
    ++	*    HEAD:refs/heads/bar    [new branch]
    ++	*    HEAD:refs/heads/baz    [new branch]
    ++	*    HEAD:refs/for/next/topic    [new reference]
    ++	*    HEAD:refs/heads/foo    [new branch]
    ++	*    HEAD:refs/for/master/topic    [new reference]
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/bar
    ++	<COMMIT-A> refs/heads/baz
    ++	<COMMIT-A> refs/heads/foo
    ++	<COMMIT-B> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	(
    ++		cd "$upstream" &&
    ++		git update-ref refs/heads/master $A &&
    ++		git update-ref -d refs/heads/foo &&
    ++		git update-ref -d refs/heads/bar &&
    ++		git update-ref -d refs/heads/baz
    ++	)
    ++
    ++'
4:  d20702291b ! 4:  f03038c82f send-pack: extension for client-side status report
    @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
     +void update_ref_from_remote_status(struct ref *ref)
     +{
     +	char *val;
    -+	char c;
     +	int len;
     +
     +	if (!ref->remote_status)
     +		return;
     +
     +	val = (char *)parse_feature_value(ref->remote_status, "old-oid", &len);
    -+	if (val && len) {
    -+		c = *(val+len);
    -+		*(val+len) = '\0';
    ++	if (val && len)
     +		get_oid_hex(val, &ref->old_oid);
    -+		*(val+len) = c;
    -+	}
    ++
     +	val = (char *)parse_feature_value(ref->remote_status, "new-oid", &len);
    -+	if (val && len) {
    -+		c = *(val+len);
    -+		*(val+len) = '\0';
    ++	if (val && len)
     +		get_oid_hex(val, &ref->new_oid);
    -+		*(val+len) = c;
    -+	}
    ++
     +	if (parse_feature_request(ref->remote_status, "forced-update"))
     +		ref->forced_update = 1;
     +}
    @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref
      		/* first try searching at our hint, falling back to all refs */
      		if (hint)
     @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref *refs)
    + 			hint->status = REF_STATUS_OK;
    + 		else
      			hint->status = REF_STATUS_REMOTE_REJECT;
    - 			ret = -1;
    - 		}
     -		hint->remote_status = xstrdup_or_null(msg);
     +		if (msg)
     +			hint->remote_status = xstrdup(msg);
     +		else if (extended_status)
    -+			hint->remote_status = xstrdup(extended_status);
    ++			hint->remote_status = xstrdup_or_null(extended_status);
      		/* start our next search from the next ref */
      		hint = hint->next;
      	}
     
    - ## t/t5411/common-test-cases.sh ##
    -@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report with extended status" '
    + ## t/t5411/test-0032-report-alt.sh ##
    +@@ t/t5411/test-0032-report-alt.sh: test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, $PROTOCOL)"
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/pull/123/head
    + 	EOF
    + 	test_cmp expect actual
    + '
    +@@ t/t5411/test-0032-report-alt.sh: test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/pull/123/head
    + 	EOF
    + 	test_cmp expect actual
    + '
    +@@ t/t5411/test-0032-report-alt.sh: test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, $P
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 <OID-B>..<OID-A> HEAD -> refs/pull/123/head
    + 	EOF
    + 	test_cmp expect actual
    + '
    +@@ t/t5411/test-0032-report-alt.sh: test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, $PROTOCOL)"
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 <OID-B>..<OID-A> HEAD -> refs/for/master/topic
    + 	EOF
    + 	test_cmp expect actual
    + '
    +@@ t/t5411/test-0032-report-alt.sh: test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, $P
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
    + 	EOF
    + 	test_cmp expect actual
    + '
    +@@ t/t5411/test-0032-report-alt.sh: test_expect_success "proc-receive: with multiple alt reports ($PROTOCOL)" '
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
      	To <URL/of/upstream.git>
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report with ext
     +	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
      	EOF
      	test_cmp expect actual &&
    + 
    +
    + ## t/t5411/test-0033-report-alt--porcelain.sh ##
    +@@ t/t5411/test-0033-report-alt--porcelain.sh: test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, --porcelain,
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	*    HEAD:refs/pull/123/head    [new reference]
    + 	Done
    + 	EOF
    + 	test_cmp expect actual
    +@@ t/t5411/test-0033-report-alt--porcelain.sh: test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	*    HEAD:refs/pull/123/head    [new reference]
    + 	Done
    + 	EOF
    + 	test_cmp expect actual
    +@@ t/t5411/test-0033-report-alt--porcelain.sh: test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, --
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	     HEAD:refs/pull/123/head    <OID-B>..<OID-A>
    + 	Done
    + 	EOF
    + 	test_cmp expect actual
    +@@ t/t5411/test-0033-report-alt--porcelain.sh: test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, --porcelain,
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	     HEAD:refs/for/master/topic    <OID-B>..<OID-A>
    + 	Done
    + 	EOF
    + 	test_cmp expect actual
    +@@ t/t5411/test-0033-report-alt--porcelain.sh: test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, --
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
    + 	Done
    + 	EOF
    + 	test_cmp expect actual
    +@@ t/t5411/test-0033-report-alt--porcelain.sh: test_expect_success "proc-receive: with multiple alt reports (--porcelain, $PROT
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/next/topic    [new reference]
    ++	*    HEAD:refs/pull/123/head    [new reference]
    + 	*    HEAD:refs/for/a/b/c/topic    [new reference]
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
    + 	Done
    + 	EOF
    + 	test_cmp expect actual &&
    +
    + ## t/t5411/test-0036-report-multi-alt-for-one-ref.sh ##
    +@@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh: test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st r
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/changes/24/124/1
    ++	 <OID-A>..<OID-B> HEAD -> refs/changes/25/125/1
    + 	EOF
    + 	test_cmp expect actual &&
      	git -C "$upstream" show-ref >out &&
    -@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report multiple response" '
    +@@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh: test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd r
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/changes/24/124/1
    ++	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
    ++	 + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
    + 	EOF
    + 	test_cmp expect actual &&
    + 	git -C "$upstream" show-ref >out &&
    +@@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh: test_expect_success "proc-receive: report ok and alt for the same ref ($PROTOCOL
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    + 	 * [new reference] HEAD -> refs/for/master/topic
    ++	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/1
    + 	EOF
    + 	test_cmp expect actual &&
    + 	git -C "$upstream" show-ref >out &&
    +@@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh: test_expect_success "proc-receive: report multiple response ($PROTOCOL)" '
      	remote: # post-receive hook
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
      	To <URL/of/upstream.git>
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report multiple
      	EOF
      	test_cmp expect actual &&
      	git -C "$upstream" show-ref >out &&
    -@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update of mixed refs" '
    +
    + ## t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh ##
    +@@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh: test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st r
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
    ++	*    HEAD:refs/changes/24/124/1    [new reference]
    ++	     HEAD:refs/changes/25/125/1    <OID-A>..<OID-B>
    + 	Done
    + 	EOF
    + 	test_cmp expect actual &&
    +@@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh: test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd r
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	*    HEAD:refs/changes/24/124/1    [new reference]
    ++	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
    ++	+    HEAD:refs/changes/25/125/1    <OID-B>...<OID-A> (forced update)
    + 	Done
    + 	EOF
    + 	test_cmp expect actual &&
    +@@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh: test_expect_success "proc-receive: report ok and alt for the same ref (--porcela
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    + 	*    HEAD:refs/for/master/topic    [new reference]
    ++	     HEAD:refs/changes/24/124/1    <OID-A>..<OID-B>
    + 	Done
    + 	EOF
    + 	test_cmp expect actual &&
    +@@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh: test_expect_success "proc-receive: report multiple response (--porcelain, $PROTO
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	*    HEAD:refs/changes/23/123/1    [new reference]
    ++	     HEAD:refs/changes/24/124/2    <OID-A>..<OID-B>
    + 	Done
    + 	EOF
    + 	test_cmp expect actual &&
    +
    + ## t/t5411/test-0038-report-mixed-refs.sh ##
    +@@ t/t5411/test-0038-report-mixed-refs.sh: test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
      	 * [new branch] HEAD -> baz
      	 * [new reference] HEAD -> refs/for/next/topic
      	 * [new branch] HEAD -> foo
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update o
      	test_cmp expect actual &&
      	git -C "$upstream" show-ref >out &&
     
    + ## t/t5411/test-0039-report-mixed-refs--porcelain.sh ##
    +@@ t/t5411/test-0039-report-mixed-refs--porcelain.sh: test_expect_success "proc-receive: report update of mixed refs (--porcelain, $PR
    + 	*    HEAD:refs/heads/baz    [new branch]
    + 	*    HEAD:refs/for/next/topic    [new reference]
    + 	*    HEAD:refs/heads/foo    [new branch]
    +-	*    HEAD:refs/for/master/topic    [new reference]
    ++	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
    + 	Done
    + 	EOF
    + 	test_cmp expect actual &&
    +
      ## transport-helper.c ##
     @@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
      			msg = xstrdup(msg);
    @@ transport.c: static void print_ref_status(char flag, const char *summary,
     +	if (to && to->remote_status) {
     +		val = parse_feature_value(to->remote_status, "ref", &len);
     +		if (val && len)
    -+		to_name = xmemdupz(val, len);
    ++			to_name = xmemdupz(val, len);
     +	}
     +
      	if (porcelain) {
    @@ transport.c: static int print_one_push_status(struct ref *ref, const char *dest,
     +					      porcelain, summary_width);
     +
     +	head = ref->remote_status;
    -+	begin = strstr(head, "ref=");
    -+	if (!begin)
    -+		begin = ref->remote_status;
    ++	begin = head;
     +	for (;;) {
     +		char *end;
     +		struct object_id old_oid;
-:  ---------- > 5:  c3ad1ab5a4 receive-pack: feed extended_status to post-receive
5:  a8860faa17 = 6:  d9226a4898 refs.c: refactor to reuse ref_is_hidden()
6:  46a839ddf6 ! 7:  7143e2c501 receive-pack: new config receive.procReceiveRefs
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +	if (proc_receive_refs.nr > 0) {
     +		struct strbuf refname_full = STRBUF_INIT;
     +		size_t prefix_len;
    -+
    -+		strbuf_addstr(&refname_full, get_git_namespace());
    -+		prefix_len = refname_full.len;
      
     -		/* TODO: replace the fixed prefix by looking up git config variables. */
     -		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
     -			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
     -			run_proc_receive = 1;
    ++		strbuf_addstr(&refname_full, get_git_namespace());
    ++		prefix_len = refname_full.len;
    ++
     +		for (cmd = commands; cmd; cmd = cmd->next) {
     +			if (!should_process_cmd(cmd))
     +				continue;
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const
      	return 0;
      }
     
    - ## t/t5411/common-test-cases.sh ##
    -@@ t/t5411/common-test-cases.sh: test_expect_success "cleanup" '
    - 	)
    - '
    - 
    + ## t/t5411/test-0010-proc-receive-settings.sh (new) ##
    +@@
     +test_expect_success "add two receive.procReceiveRefs settings" '
     +	(
     +		cd "$upstream" &&
     +		git config --add receive.procReceiveRefs refs/for &&
     +		git config --add receive.procReceiveRefs refs/review/
     +	)
    ++'
    +
    + ## t/t5411/test-0040-process-all-refs.sh (new) ##
    +@@
    ++test_expect_success "config receive.procReceiveRefs = refs ($PROTOCOL)" '
    ++	git -C "$upstream" config --unset-all receive.procReceiveRefs &&
    ++	git -C "$upstream" config --add receive.procReceiveRefs refs
     +'
     +
    - # Refs of upstream : master(A)
    - # Refs of workbench: master(A)  tags/v123
    - # git push         :                       next(A)  refs/for/master/topic(A)
    -@@ t/t5411/common-test-cases.sh: test_expect_success "setup proc-receive hook (with extended status)" '
    - 	write_script "$upstream/hooks/proc-receive" <<-EOF
    - 	printf >&2 "# proc-receive hook\n"
    - 	test-tool proc-receive -v \
    --		-r "ok refs/for/a/b/c/topic" \
    -+		-r "ok refs/review/a/b/c/topic" \
    - 		-r "alt refs/for/next/topic refs/pull/123/head" \
    - 		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
    - 	EOF
    -@@ t/t5411/common-test-cases.sh: test_expect_success "setup proc-receive hook (with extended status)" '
    - 
    - # Refs of upstream : master(A)
    - # Refs of workbench: master(A)  tags/v123
    --# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+# git push         :                       refs/for/next/topic(A)  refs/review/a/b/c/topic(A)  refs/for/master/topic(A)
    - test_expect_success "proc-receive: report with extended status" '
    - 	git -C workbench push origin \
    - 		HEAD:refs/for/next/topic \
    --		HEAD:refs/for/a/b/c/topic \
    -+		HEAD:refs/review/a/b/c/topic \
    - 		HEAD:refs/for/master/topic \
    - 		>out 2>&1 &&
    - 	make_user_friendly_and_stable_output <out >actual &&
    - 	cat >expect <<-EOF &&
    - 	remote: # pre-receive hook
    - 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    --	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    - 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    - 	remote: # proc-receive hook
    - 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    --	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    - 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    --	remote: proc-receive> ok refs/for/a/b/c/topic
    -+	remote: proc-receive> ok refs/review/a/b/c/topic
    - 	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    - 	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
    - 	remote: # post-receive hook
    - 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    --	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    - 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    - 	To <URL/of/upstream.git>
    - 	 * [new reference] HEAD -> refs/pull/123/head
    --	 * [new reference] HEAD -> refs/for/a/b/c/topic
    -+	 * [new reference] HEAD -> refs/review/a/b/c/topic
    - 	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
    - 	EOF
    - 	test_cmp expect actual &&
    -@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update of mixed refs" '
    - 	EOF
    - 	test_cmp expect actual
    - '
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "setup upstream branches ($PROTOCOL)" '
    ++	(
    ++		cd "$upstream" &&
    ++		git update-ref refs/heads/master $B &&
    ++		git update-ref refs/heads/foo $A &&
    ++		git update-ref refs/heads/bar $A &&
    ++		git update-ref refs/heads/baz $A
    ++	)
     +
    -+test_expect_success "config add receive.procReceiveRefs = refs" '
    -+	git -C "$upstream" config --add receive.procReceiveRefs refs
     +'
     +
    -+test_expect_success "setup proc-receive hook" '
    ++test_expect_success "setup proc-receive hook ($PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update o
     +# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
    -+test_expect_success "proc-receive: process all refs" '
    ++test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
     +	git -C workbench push -f origin \
     +		HEAD:refs/heads/master \
     +		:refs/heads/foo \
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update o
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
     +	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
     +	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
    ++	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
     +	To <URL/of/upstream.git>
     +	 <OID-A>..<OID-B> <COMMIT-B> -> bar
     +	 - [deleted] foo
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update o
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++# Refs of upstream : master(A)             bar(A)  baz(B)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	(
    ++		cd "$upstream" &&
    ++		git update-ref -d refs/heads/bar &&
    ++		git update-ref -d refs/heads/baz
    ++	)
    ++'
    +
    + ## t/t5411/test-0041-process-all-refs--porcelain.sh (new) ##
    +@@
    ++test_expect_success "config receive.procReceiveRefs = refs ($PROTOCOL)" '
    ++	git -C "$upstream" config --unset-all receive.procReceiveRefs &&
    ++	git -C "$upstream" config --add receive.procReceiveRefs refs
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "setup upstream branches ($PROTOCOL)" '
    ++	(
    ++		cd "$upstream" &&
    ++		git update-ref refs/heads/master $B &&
    ++		git update-ref refs/heads/foo $A &&
    ++		git update-ref refs/heads/bar $A &&
    ++		git update-ref refs/heads/baz $A
    ++	)
    ++
    ++'
    ++
    ++test_expect_success "setup proc-receive hook ($PROTOCOL)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ft refs/heads/master" \
    ++		-r "ft refs/heads/foo" \
    ++		-r "ft refs/heads/bar" \
    ++		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$A new-oid=$B " \
    ++		-r "alt refs/for/next/topic refs/pull/124/head old-oid=$B new-oid=$A forced-update"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
    ++test_expect_success "proc-receive: process all refs (--porcelain) ($PROTOCOL)" '
    ++	git -C workbench push --porcelain -f origin \
    ++		HEAD:refs/heads/master \
    ++		:refs/heads/foo \
    ++		$B:refs/heads/bar \
    ++		HEAD:refs/for/master/topic \
    ++		HEAD:refs/for/next/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
    ++	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
    ++	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
    ++	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
    ++	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive> ft refs/heads/master
    ++	remote: proc-receive> ft refs/heads/foo
    ++	remote: proc-receive> ft refs/heads/bar
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> alt refs/for/next/topic refs/pull/124/head old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
    ++	remote: # post-receive hook
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
    ++	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
    ++	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
    ++	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
    ++	To <URL/of/upstream.git>
    ++	     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
    ++	-    :refs/heads/foo    [deleted]
    ++	+    HEAD:refs/heads/master    <OID-B>...<OID-A> (forced update)
    ++	     HEAD:refs/pull/123/head    <OID-A>..<OID-B>
    ++	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
    ++	Done
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-B> refs/heads/bar
    ++	<COMMIT-A> refs/heads/baz
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(A)             bar(A)  baz(B)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup ($PROTOCOL)" '
    ++	(
    ++		cd "$upstream" &&
    ++		git update-ref -d refs/heads/bar &&
    ++		git update-ref -d refs/heads/baz
    ++	)
    ++'
7:  a357234e97 = 8:  98702cf3e9 doc: add documentation for the proc-receive hook

---

Jiang Xin (8):
  transport: not report a non-head push as a branch
  connect: export parse_feature_value()
  receive-pack: add new proc-receive hook
  send-pack: extension for client-side status report
  receive-pack: feed extended_status to post-receive
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt              |  14 +
 Documentation/githooks.txt                    |  58 +++
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 442 +++++++++++++++++-
 connect.c                                     |   3 +-
 connect.h                                     |   1 +
 refs.c                                        |  13 +-
 refs.h                                        |   1 +
 remote.c                                      |  21 +
 remote.h                                      |   3 +
 send-pack.c                                   |  11 +-
 t/helper/test-proc-receive.c                  | 175 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411-proc-receive-hook.sh                  | 105 +++++
 t/t5411/common-functions.sh                   |  56 +++
 t/t5411/test-0000-standard-git-push.sh        |  84 ++++
 .../test-0001-standard-git-push--porcelain.sh |  87 ++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0011-no-hook-error.sh            |  64 +++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 +++
 t/t5411/test-0013-bad-protocol.sh             | 225 +++++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 160 +++++++
 t/t5411/test-0020-report-ng.sh                |  67 +++
 t/t5411/test-0021-report-ng--porcelain.sh     |  69 +++
 t/t5411/test-0022-report-unexpect-ref.sh      |  45 ++
 ...est-0023-report-unexpect-ref--porcelain.sh |  46 ++
 t/t5411/test-0024-report-unknown-ref.sh       |  34 ++
 ...test-0025-report-unknown-ref--porcelain.sh |  35 ++
 t/t5411/test-0026-push-options.sh             |  79 ++++
 t/t5411/test-0027-push-options--porcelain.sh  |  82 ++++
 t/t5411/test-0030-report-ok.sh                |  35 ++
 t/t5411/test-0031-report-ok--porcelain.sh     |  36 ++
 t/t5411/test-0032-report-alt.sh               | 229 +++++++++
 t/t5411/test-0033-report-alt--porcelain.sh    | 236 ++++++++++
 t/t5411/test-0034-report-ft.sh                |  42 ++
 t/t5411/test-0035-report-ft--porcelain.sh     |  43 ++
 .../test-0036-report-multi-alt-for-one-ref.sh | 167 +++++++
 ...report-multi-alt-for-one-ref--porcelain.sh | 171 +++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  74 +++
 .../test-0039-report-mixed-refs--porcelain.sh |  75 +++
 t/t5411/test-0040-process-all-refs.sh         |  93 ++++
 .../test-0041-process-all-refs--porcelain.sh  |  94 ++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport-helper.c                            |  64 +--
 transport.c                                   |  83 +++-
 48 files changed, 3506 insertions(+), 61 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/test-0000-standard-git-push.sh
 create mode 100644 t/t5411/test-0001-standard-git-push--porcelain.sh
 create mode 100644 t/t5411/test-0002-pre-receive-declined.sh
 create mode 100644 t/t5411/test-0003-pre-receive-declined--porcelain.sh
 create mode 100644 t/t5411/test-0010-proc-receive-settings.sh
 create mode 100644 t/t5411/test-0011-no-hook-error.sh
 create mode 100644 t/t5411/test-0012-no-hook-error--porcelain.sh
 create mode 100644 t/t5411/test-0013-bad-protocol.sh
 create mode 100644 t/t5411/test-0014-bad-protocol--porcelain.sh
 create mode 100644 t/t5411/test-0020-report-ng.sh
 create mode 100644 t/t5411/test-0021-report-ng--porcelain.sh
 create mode 100644 t/t5411/test-0022-report-unexpect-ref.sh
 create mode 100644 t/t5411/test-0023-report-unexpect-ref--porcelain.sh
 create mode 100644 t/t5411/test-0024-report-unknown-ref.sh
 create mode 100644 t/t5411/test-0025-report-unknown-ref--porcelain.sh
 create mode 100644 t/t5411/test-0026-push-options.sh
 create mode 100644 t/t5411/test-0027-push-options--porcelain.sh
 create mode 100644 t/t5411/test-0030-report-ok.sh
 create mode 100644 t/t5411/test-0031-report-ok--porcelain.sh
 create mode 100644 t/t5411/test-0032-report-alt.sh
 create mode 100644 t/t5411/test-0033-report-alt--porcelain.sh
 create mode 100644 t/t5411/test-0034-report-ft.sh
 create mode 100644 t/t5411/test-0035-report-ft--porcelain.sh
 create mode 100644 t/t5411/test-0036-report-multi-alt-for-one-ref.sh
 create mode 100644 t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh
 create mode 100644 t/t5411/test-0038-report-mixed-refs.sh
 create mode 100644 t/t5411/test-0039-report-mixed-refs--porcelain.sh
 create mode 100644 t/t5411/test-0040-process-all-refs.sh
 create mode 100644 t/t5411/test-0041-process-all-refs--porcelain.sh

-- 

