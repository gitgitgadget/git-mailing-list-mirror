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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B261221
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhIOAVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 20:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhIOAVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 20:21:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B5C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:19:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g21so1507641edw.4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wqZczEoCrvDGDqNRrwG7zW31rKk1OGG0erwfOnDbFeo=;
        b=FK0YsZ7ffCEReDwy8hA6slkqjOsbmxa7yw0c0Md9nxuv13MwFHq5mpvNQsjMKuCnx8
         rT1UnAz3WRN30x3XK/lGot76grnbEQVdsMQFWwsb0nvmJkXcBlOPxGEf3hw66DD+EM6H
         Il7xjbfNY762D1xsQwBNR7bf6cg/50kMwROwqEf88mqBesTykUfydLDTeDf4yN6SWP4k
         jYB688XooKVwfis5ricMTteU+8WTZIsU2F4HMVvOJb3S9dRwJs+tpPBXDul1bhR/6TRY
         oMXa/xbabH5UBiFv8IPZjdSJb0FL3tXCiXCZ3bRfvgyopLJTn9xHWQSAfWaVwU1kStxF
         2dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wqZczEoCrvDGDqNRrwG7zW31rKk1OGG0erwfOnDbFeo=;
        b=VasGKhNycYPBDQpN+W7ggRJbOgBQ3s4GVYUy1aVf55HOIME5LnVYUoeVUtnJ1CQTTv
         ZYrZftfBfW7YiFXADbTDEo+v4ze8zI5Df/U2pf7qOgCWjoMohaJvQe6En0G6F8i7vb7k
         loSKagNCJUE4kB+rriWGjaks+bRe2dDLFh5TX5Q+wLjtfbghPAJbdASWiGO4jMJbBRqD
         H8EhKRjRF6lZIewS4A2plmQD96lFRxVQYJ2aB2mRNRaXuZxiGYsT45BmjTfZYEeD77z+
         WqdySOhKFr8wcF33RaqsGbqymNMDKOSEd5wFxqDr/ElU6dUnYisBhpdONtzE1WixQ/z6
         2A0w==
X-Gm-Message-State: AOAM531ZsmMWWsP++AHBaoCusvsa7ctWl71scI7ndIkd9yuuv1bpL/di
        Wl0kQhYmFuP11Cy8+MrheSo=
X-Google-Smtp-Source: ABdhPJxofXAv7t5xavEWrLVPEal6bOqBEvU0eKh8Zj6XRzbg4DJeZiufnqRuoo5LCbc/pnz/i1kDVw==
X-Received: by 2002:aa7:c38b:: with SMTP id k11mr16686493edq.175.1631665190805;
        Tue, 14 Sep 2021 17:19:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q11sm6186588edv.73.2021.09.14.17.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 17:19:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 11/11] ls-refs: reject unknown arguments
Date:   Wed, 15 Sep 2021 02:09:16 +0200
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE2J74PP8TGthOZ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUE2J74PP8TGthOZ@coredump.intra.peff.net>
Message-ID: <875yv2ofkq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Jeff King wrote:

> The v2 ls-refs command may receive extra arguments from the client, one
> per pkt-line. The spec is pretty clear that the arguments must come from
> a specified set, but we silently ignore any unknown entries. For a
> well-behaved client this doesn't matter, but it makes testing and
> debugging more confusing. Let's tighten this up to match the spec.
>
> In theory this liberal behavior _could_ be useful for extending the
> protocol. But:
>
>   - every other part of the protocol requires that the server first
>     indicate that it supports the argument; this includes the fetch and
>     object-info commands, plus the "unborn" capability added to ls-refs
>     itself
>
>   - it's not a very good extension mechanism anyway; without the server
>     advertising support, clients would have no idea if the argument was
>     silently ignored, or accepted and simply had no effect
>
> So we're not really losing anything by tightening this.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ls-refs.c            |  2 ++
>  t/t5701-git-serve.sh | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 18c4f41e87..460ac9b229 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -168,6 +168,8 @@ int ls_refs(struct repository *r, struct packet_reade=
r *request)
>  		}
>  		else if (!strcmp("unborn", arg))
>  			data.unborn =3D allow_unborn;
> +		else
> +			die(_("unexpected line: '%s'"), arg);
>  	}
>=20=20
>  	if (request->status !=3D PACKET_READ_FLUSH)
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index b027ba9b06..e4d60bc605 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -145,6 +145,19 @@ test_expect_success 'basics of ls-refs' '
>  	test_cmp expect actual
>  '
>=20=20
> +test_expect_success 'ls-refs complains about unknown options' '
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=3Dls-refs
> +	object-format=3D$(test_oid algo)
> +	0001
> +	no-such-arg
> +	0000
> +	EOF
> +
> +	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
> +	grep unexpected.line.*no-such-arg err
> +'
> +
>  test_expect_success 'basic ref-prefixes' '
>  	test-tool pkt-line pack >in <<-EOF &&
>  	command=3Dls-refs

Looks good. For what it's worth some of this series is stuff I've been
meaning to submit after my current in-flight series, so I guess we'll be
playing some rebase ping-pong in this area.

In my version of this I'd led with a change to do changes like these for
all the protocol verbs:
=09
	diff --git a/connect.c b/connect.c
	index 70b13389ba5..5e991a92279 100644
	--- a/connect.c
	+++ b/connect.c
	@@ -514,6 +514,8 @@ struct ref **get_remote_refs(int fd_out, struct packet=
_reader *reader,
	        packet_write_fmt(fd_out, "symrefs\n");
	        if (server_supports_feature("ls-refs", "unborn", 0))
	                packet_write_fmt(fd_out, "unborn\n");
	+       if (git_env_bool("GIT_TEST_PROTOCOL_BAD_LS_REFS", 0))
	+               packet_write_fmt(fd_out, "test-bad-client\n");
	        for (i =3D 0; ref_prefixes && i < ref_prefixes->nr; i++) {
	                packet_write_fmt(fd_out, "ref-prefix %s\n",
	                                 ref_prefixes->v[i]);

So the below patch isn't anywhere near applying, but you can see the
test coverage (those tests are new) & what changes if we instrument a
client to actually send this bad data.

That packet_client_error() function is new, part of what I'm doing there
is converting all of this error emitting from die() to properly sending
ERR packets.

I think a bug in your versio is that you're using _() here, if your
server program happens to be started in Chinese you probably still want
to emit errors to clients in LANG=3DC.

That's why I'm using N_() in my version, it knows to emit the die()
localized, but the ERR packet in LANG=3DC, no you'll get the i18n message
in the server terminal, but the client gets LANG=3DC.

Of course that actually working is subject to various races that I may
or may not be able to untangle...


-- >8 --
protocol v2: correct & adjust "ls-refs" ERR behavior

Change the protocol v2 "ls-refs" to error out on unknown arguments,
before this we'd silently ignore unknown arguments.

This brings us in line with the behavior we've had in
"fetch" (i.e. upload-pack.c) since 3145ea957d2 (upload-pack: introduce
fetch server command, 2018-03-15) (see the "/* ignore unknown lines
maybe? */" comment in "process_args()".

The looser behavior in "ls-refs" seems to have been unintentionally
added in 72d0ea0056b (ls-refs: introduce ls-refs server command,
2018-03-15).

I've also changed the wording of the "expected flush" message in
"ls-refs" to be consistent with "fetch" and "object-info".

In the changes leading up to this we had to grep out the racy "fatal:
the remote end hung up unexpectedly" messages. Now we need to guard
the full test_cmp with a test_expect_failure. I could also write a
looser test, but this makes subsequent changes smaller, and is more
accurate.

Most of the time the test_expect_failure() succeeds, but in some cases
the two messages will be out-of-order, or e.g. only the STDERR one
will make it, and not the ERR message, or the other way
around. I.e. now that we emit both an ERR line and die() on the
remote, we might see ERR before die(), or die() before ERR.

This race does not happen in the t5701-git-serve.sh and other
"test-tool pkt-line" tests, which only use one process.

Ideally we should only emit ERR and not also something on STDERR when
we die() on the server. Subsequent commits will address that, but for
now let's keep that behavior. I.e. we'll now emit two mostly duplicate
errors in some cases from the client, or one where we emitted none (or
one that made no sense) before.

The current client implementation doesn't expect the server to be this
overly helpful in giving us errors both via pkt-line and STDERR, so we
usually get two lines, and in some cases just one (but never
zero).

Subsequent commits will address this. I.e. we can assume that the
client can format the ERR lines, and that we can just exit(128) or
disconnect on the server, not die().

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 ls-refs.c                      |  6 +++++-
 t/t5703-protocol-v2-file.sh    | 24 +++++++++++++++++-------
 t/t5704-protocol-v2-git.sh     | 20 +++++++++++++-------
 t/t5705-protocol-v2-http.sh    | 25 +++++++++++++++++++------
 t/t5710-protocol-violations.sh |  2 +-
 5 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 1e50e785665..f9bd577dcd2 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -150,11 +150,15 @@ int ls_refs(struct repository *r, struct packet_reade=
r *request)
 			strvec_push(&data.prefixes, out);
 		else if (!strcmp("unborn", arg))
 			data.unborn =3D allow_unborn;
+		else
+			packet_client_error(&data.writer,
+					    N_("ls-refs: unexpected argument: '%s'"),
+					    request->line);
 	}
=20
 	if (request->status !=3D PACKET_READ_FLUSH)
 		packet_client_error(&data.writer,
-				    N_("expected flush after ls-refs arguments"));
+				    N_("ls-refs: expected flush after arguments"));
=20
 	send_possibly_unborn_head(&data);
 	if (!data.prefixes.nr)
diff --git a/t/t5703-protocol-v2-file.sh b/t/t5703-protocol-v2-file.sh
index e572767ee00..79457eaf101 100755
--- a/t/t5703-protocol-v2-file.sh
+++ b/t/t5703-protocol-v2-file.sh
@@ -32,18 +32,28 @@ test_expect_success 'list refs with file:// using proto=
col v2' '
 test_expect_success 'ls-remote handling a bad client using file:// protoco=
l v2' '
 	test_when_finished "rm -f log" &&
=20
-	cat >expect <<-EOF &&
-	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/m=
ain
+	cat >log.expect <<-\EOF &&
+	packet:  upload-pack> ERR ls-refs: unexpected argument: '"'"'test-bad-cli=
ent'"'"'
+	packet:          git< ERR ls-refs: unexpected argument: '"'"'test-bad-cli=
ent'"'"'
 	EOF
-	env \
+	cat >err.expect <<-\EOF &&
+	fatal: ls-refs: unexpected argument: '"'"'test-bad-client'"'"'
+	fatal: remote error: ls-refs: unexpected argument: '"'"'test-bad-client'"=
'"'
+	EOF
+	test_must_fail env \
 		GIT_TRACE_PACKET=3D"$(pwd)/log" \
 		GIT_TEST_PROTOCOL_BAD_LS_REFS=3Dtrue \
 		git -c protocol.version=3D2 \
-		ls-remote "file://$(pwd)/file_parent" main >actual 2>err &&
+		ls-remote "file://$(pwd)/file_parent" main >out 2>err.actual &&
=20
-	test_must_be_empty err &&
-	test_cmp expect actual &&
-	grep "git> test-bad-client$" log
+	grep "unexpected argument.*test-bad-client" err.actual &&
+	test_must_be_empty out &&
+	grep ERR log >log.actual &&
+	test_cmp log.expect log.actual
+'
+
+test_expect_failure 'ls-remote ERR and die() is racy under file:// protoco=
l v2' '
+	test_cmp err.expect err.actual
 '
=20
 test_expect_success 'ref advertisement is filtered with ls-remote using pr=
otocol v2' '
diff --git a/t/t5704-protocol-v2-git.sh b/t/t5704-protocol-v2-git.sh
index c9293bbaad2..123c3f56ef8 100755
--- a/t/t5704-protocol-v2-git.sh
+++ b/t/t5704-protocol-v2-git.sh
@@ -48,19 +48,25 @@ test_expect_success 'ref advertisement is filtered with=
 ls-remote using protocol
 	test_cmp expect actual
 '
=20
-test_expect_success 'ls-remote handling a bad client using git:// protocol=
 v2' '
+test_expect_success 'ls-remote handling a bad client using protocol v2' '
 	test_when_finished "rm -f log" &&
=20
-	git ls-remote "$daemon_parent" >expect &&
-	env \
+	cat >err.expect <<-EOF &&
+	fatal: remote error: ls-refs: unexpected argument: '"'"'test-bad-client'"=
'"'
+	EOF
+	test_must_fail env \
 		GIT_TRACE_PACKET=3D"$(pwd)/log" \
 		GIT_TEST_PROTOCOL_BAD_LS_REFS=3Dtrue \
 		git -c protocol.version=3D2 \
-		ls-remote "$GIT_DAEMON_URL/parent" >actual 2>err &&
+		ls-remote "$GIT_DAEMON_URL/parent" main >out.actual 2>err.actual &&
=20
-	test_must_be_empty err &&
-	test_cmp expect actual &&
-	grep "git> test-bad-client$" log
+	test_must_be_empty out.actual &&
+	grep "unexpected argument.*test-bad-client" err.actual &&
+	grep "ERR ls-refs: unexpected argument.*test-bad-client" log
+'
+
+test_expect_failure  'ls-remote ERR and die() is racy under file:// protoc=
ol v2' '
+	test_cmp err.expect err.actual
 '
=20
 test_expect_success 'clone with git:// using protocol v2' '
diff --git a/t/t5705-protocol-v2-http.sh b/t/t5705-protocol-v2-http.sh
index 5982c38743e..6f526e0829f 100755
--- a/t/t5705-protocol-v2-http.sh
+++ b/t/t5705-protocol-v2-http.sh
@@ -192,16 +192,29 @@ test_expect_success 'fetch from namespaced repo respe=
cts namespaces' '
 test_expect_success 'ls-remote handling a bad client using http:// protoco=
l v2' '
 	test_when_finished "rm -f log" &&
=20
-	git ls-remote "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" >expect &&
-	env \
+	cat >log.expect <<-\EOF &&
+	packet:  upload-pack> ERR ls-refs: unexpected argument: '"'"'test-bad-cli=
ent'"'"'
+	packet:          git< ERR ls-refs: unexpected argument: '"'"'test-bad-cli=
ent'"'"'
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: ls-refs: unexpected argument: '"'"'test-bad-client'"'"'
+	fatal: remote error: ls-refs: unexpected argument: '"'"'test-bad-client'"=
'"'
+	EOF
+	test_must_fail env \
 		GIT_TRACE_PACKET=3D"$(pwd)/log" \
 		GIT_TEST_PROTOCOL_BAD_LS_REFS=3Dtrue \
 		git -c protocol.version=3D2 \
-		ls-remote "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" >actual 2>err &&
+		ls-remote "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" >out 2>err.actual &&
=20
-	test_must_be_empty err &&
-	test_cmp expect actual &&
-	grep "git> test-bad-client$" log
+	grep "unexpected argument.*test-bad-client" err.actual &&
+	test_must_be_empty out &&
+	grep ERR log >log.actual &&
+	test_cmp log.expect log.actual
+'
+
+test_expect_failure  'ls-remote ERR and die() is racy under http:// protoc=
ol v2' '
+	test_cmp err.expect err.actual
 '
=20
 test_expect_success 'ls-remote with v2 http sends only one POST' '
diff --git a/t/t5710-protocol-violations.sh b/t/t5710-protocol-violations.sh
index 44e2c0d3ded..75a457d39ca 100755
--- a/t/t5710-protocol-violations.sh
+++ b/t/t5710-protocol-violations.sh
@@ -16,7 +16,7 @@ test_expect_success 'extra delim packet in v2 ls-refs arg=
s' '
 	EOF
=20
 	cat >err.expect <<-\EOF &&
-	fatal: expected flush after ls-refs arguments
+	fatal: ls-refs: expected flush after arguments
 	EOF
 	test_must_fail env GIT_PROTOCOL=3Dversion=3D2 \
 		git upload-pack . <input 2>err.actual &&
--=20
2.33.0.1013.ge8323766266

