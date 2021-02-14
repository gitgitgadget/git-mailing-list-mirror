Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F879C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B439564D9D
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhBNKNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:13:06 -0500
Received: from mout.web.de ([212.227.15.14]:60285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhBNKMx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 05:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613297458;
        bh=KLib8yxFqrokA+z41UWccdctz8VbWeLPBXLNvNcINnE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=RsKYcbtz3c1U8qkWIJempAVG3+t9b2bajPzn39CS6+YlpBF5Mw35r5WhcrYlBP+CA
         QH23CQwJwqKsVOH3NjZPuWJncVKKb4zSHFkUcAe0ywLRnzmlsGDygsroov2mNgNgJv
         F7rKvcMDPbaIxXWv4Mxa5nhddqsTEcaP7cf4cYkM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MPowc-1lGA2i0AvS-0051L5; Sun, 14 Feb 2021 11:10:58 +0100
Subject: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
To:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
Message-ID: <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
Date:   Sun, 14 Feb 2021 11:10:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jZXS5j8IxL/SRFFcOjF7g5HtslSnAom9AEm6jUhZtNiDLbnnQNS
 bcYe6lERXlsRn2e3zlQ+kl03ACy2aqbLzdzjB536WZ/fYypAtbIWFOjI9/9nMQsLg8EV3vx
 TMRy15BtrZ9FIz3EGf6Os8/6lfB0J4q6BedWNzRUH88xapWhtffRuVRTWihT4VJ5SWDO8VT
 dw/qexYKW6CpW8oA9pAog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6wBkikSsX6w=:pOqDVs6hUyKg917BGTumnH
 Qnp08SYsr+PqtaqUfAVU7ANaNBbR/cQ7qEiKv89WeLhHScl7G/4GlHT9FIBZSBvf/U3UxYoLK
 NoBHgavzSaRUy1LXrjOtG2FklzsvRH9jxmYVpuvJ0PaVPOA/MQagygPo3gRMVVn5Z5kBXFZs1
 qNGY7ei5CpQ75tL00wiBf/sU6sgJ1zT2/Yr2J8dUWoqmNIK1ffI76VqipDwYCiBukQH/kpPBF
 bnFixMt7qXItNVCudVW+BnETg2tMAYHrvVQTVK5iTQ+w+DUgPTdOwS56fQiHaj1GfNHaZij4+
 /+F3WJFvf+ijX94lUL/kpAkyQ0FmTkjlG2JXcDV6HUcBrat2xIdJQ/Aa2jbrTp0UB9pZLeQB/
 feFdLaK0Y+M4TvEOCiYmPK+pRIQni/TV24DnZMmzqf4sm64OizvotZNNVJqv5RADLl3XYcVp5
 FDtrXLHjXUjx65hsKPurArONzrdWyl1TZ0hzO53x/6SE80djWJbNSWorkgfLoduw5Ux/6HiHq
 0nunKtSNw3UFbrlRzSf0KLnTg0lHn/W96uthaRjFf/ACgyuQ1cGTc408nSPx6SAuM5zZ7QmQk
 yol6z8mntVRWKBGQwCBk63ddb9oescDA5wEJshZZL2V1pqSBBa2yoIUOn99Oe5VlxVpbERGVL
 rHT4qadsrdoksT5+I4qRVV9aKIU0iZ0t3fmj0+Q6B13j/OHHZ/nus4evgQYrg/vNJibUqgAfB
 mA+2rc3BuR4X84VwslDQA08fMBUu/GyLSWCybVo9rFKkUMLdpMbFrwTOsghTZTbWDP6/MuHsB
 NhS066qo3fzYzaLB+WFPmr7DcpfnGGJ4WeRbWSZWRQq4BJUEotLeb/HN7iIhxlyosPgZuLvGW
 J0Oz09z3rVsd3ZAKXAgQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow restricting the tags used by the placeholder %(describe) with the
options match and exclude.  E.g. the following command describes the
current commit using official version tags, without those for release
candidates:

   $ git log -1 --format=3D'%(describe:match=3Dv[0-9]*,exclude=3D*rc*)'

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/pretty-formats.txt | 13 ++++++++--
 pretty.c                         | 43 ++++++++++++++++++++++++++++++--
 t/t4205-log-pretty-formats.sh    | 16 ++++++++++++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-forma=
ts.txt
index bb8c05bc21..231010e6ef 100644
=2D-- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -208,8 +208,17 @@ The placeholders are:
 '%cs':: committer date, short format (`YYYY-MM-DD`)
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
-'%(describe)':: human-readable name, like linkgit:git-describe[1];
-		empty string for undescribable commits
+'%(describe[:options])':: human-readable name, like
+			  linkgit:git-describe[1]; empty string for
+			  undescribable commits.  The `describe` string
+			  may be followed by a colon and zero or more
+			  comma-separated options.
++
+** 'match=3D<pattern>': Only consider tags matching the given
+   `glob(7)` pattern, excluding the "refs/tags/" prefix.
+** 'exclude=3D<pattern>': Do not consider tags matching the given
+   `glob(7)` pattern, excluding the "refs/tags/" prefix.
+
 '%S':: ref name given on the command line by which the commit was reached
        (like `git log --source`), only works with `git log`
 '%e':: encoding
diff --git a/pretty.c b/pretty.c
index a0c427fb61..c612d2ac9b 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1150,6 +1150,34 @@ static int format_trailer_match_cb(const struct str=
buf *key, void *ud)
 	return 0;
 }

+static size_t parse_describe_args(const char *start, struct strvec *args)
+{
+	const char *options[] =3D { "match", "exclude" };
+	const char *arg =3D start;
+
+	for (;;) {
+		const char *matched =3D NULL;
+		const char *argval;
+		size_t arglen =3D 0;
+		int i;
+
+		for (i =3D 0; i < ARRAY_SIZE(options); i++) {
+			if (match_placeholder_arg_value(arg, options[i], &arg,
+							&argval, &arglen)) {
+				matched =3D options[i];
+				break;
+			}
+		}
+		if (!matched)
+			break;
+
+		if (!arglen)
+			return 0;
+		strvec_pushf(args, "--%s=3D%.*s", matched, (int)arglen, argval);
+	}
+	return arg - start;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1215,20 +1243,31 @@ static size_t format_commit_one(struct strbuf *sb,=
 /* in UTF-8 */
 		return parse_padding_placeholder(placeholder, c);
 	}

-	if (skip_prefix(placeholder, "(describe)", &arg)) {
+	if (skip_prefix(placeholder, "(describe", &arg)) {
 		struct child_process cmd =3D CHILD_PROCESS_INIT;
 		struct strbuf out =3D STRBUF_INIT;
 		struct strbuf err =3D STRBUF_INIT;

 		cmd.git_cmd =3D 1;
 		strvec_push(&cmd.args, "describe");
+
+		if (*arg =3D=3D ':') {
+			arg++;
+			arg +=3D parse_describe_args(arg, &cmd.args);
+		}
+
+		if (*arg !=3D ')') {
+			child_process_clear(&cmd);
+			return 0;
+		}
+
 		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
 		pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);
 		strbuf_rtrim(&out);
 		strbuf_addbuf(sb, &out);
 		strbuf_release(&out);
 		strbuf_release(&err);
-		return arg - placeholder;
+		return arg - placeholder + 1;
 	}

 	/* these depend on the commit */
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5a44fa447d..7e36706212 100755
=2D-- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -972,4 +972,20 @@ test_expect_success '%(describe) vs git describe' '
 	test_must_be_empty err
 '

+test_expect_success '%(describe:match=3D...) vs git describe --match ...'=
 '
+	test_when_finished "git tag -d tag-match" &&
+	git tag -a -m tagged tag-match&&
+	git describe --match "*-match" >expect &&
+	git log -1 --format=3D"%(describe:match=3D*-match)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(describe:exclude=3D...) vs git describe --exclude =
...' '
+	test_when_finished "git tag -d tag-exclude" &&
+	git tag -a -m tagged tag-exclude &&
+	git describe --exclude "*-exclude" >expect &&
+	git log -1 --format=3D"%(describe:exclude=3D*-exclude)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-
2.30.1
