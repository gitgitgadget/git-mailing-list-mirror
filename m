Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6EC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiK3SFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK3SFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:05:01 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0817062A
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669831494; bh=GbaZqUO7BxbnE5U9vbbLW7jnKic9TqCT9vIdVMTxECI=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=poU40zJgHXESUpsOCMdoaoqjs2/tufdK35o5cd9Qxo6LVmlqkGfvW15vP4hEf9D3V
         YQomh5suTU7pxauTvpxjaVmQl7MDsYctxP/5fDMBQS7XMmks0pgx7znTcGT9oEEZ16
         QIVfBE3/X6Q79zh3hThWy9lO4MfLOC7dGTcqPtvr1Z3wCPu+Pzm29nJMhdo4bZfWFM
         pMc6ceBwPVawbjyp89kZnwC9SGQUTpJN1bSw19OsR4vWKqrVGWqAzXku+2/1ua6JCj
         GZrN6ZcebceKz/wmzqpRQ7qHgYjgPwIsbedJpLv2l3Rp2iygsthuLce4WY5voSHpno
         vRDo8GZBJ6y6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7elj-1p5dzH0gUn-0087vD; Wed, 30
 Nov 2022 19:04:54 +0100
Message-ID: <d226d3bc-fb15-58a4-f516-bda51a912228@web.de>
Date:   Wed, 30 Nov 2022 19:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH 3/3] diff: remove parseopts member of struct diff_options
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
In-Reply-To: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zu14KmhSd1U+C5hkuHFzSSxvksdaMXeK2zRV/6qSril/TpHttPd
 utO3pZ5o8R8K8HPGhaA0/m5e4FblepSLaJ0c9WfVfFk8NVAP1XqUutX1yAx4mJP/tPGktkO
 kPD0ktoiinq2LjjLNdDLj1uWTrUMCtZ5ounnfdRr/vwTSWuxdMrgMUTKA3TAgr/vm48ntAN
 sslPAYEOh5SqvoZbjl5gQ==
UI-OutboundReport: notjunk:1;M01:P0:764HnfZ1WYA=;zvpoBzBt27TNDzNPZqOJ1n8mdpJ
 gWrix8s/PCedo+QP8+Y7pKG6kWcQilnVaQWOGobKVMLd1d602Fqk/f4fEAwCW73PZf1uNGwoc
 iCajzfhA4BL1PihDC6fHzPLLA3vC/dDqQ5vOuczNQgAYsfsdpK4ErmRxKwZ43vs5RcjhuCCwl
 LekeNvpEEmbXffSgMjONwCj/My5U4MFNKYOc9mPZBUt5MonN2FalnTV0IqnIlGd4RBbl5vE8I
 dduQiI2TaP4Ir4+4IBUIYnH4MnCnVPXiRzNhVqNYPS+FTIthZ3W3hD7Sd8ZOy+ZXGeos0nrPo
 edRefUs+Y+iO2iqdmpPrgL9gN4bC3U9s+4B9h3gOiddsXJOKQol7vQeEiEgbe8jN6FqBNewhf
 RVWSbJs3WwbuSfmHh3qdMIbUsdMiPfHQqglpFu9/O0H0QKlb8+VcCOp+VxeFq0GWRfvryZ9qa
 /3w8/66ohKOu6qPvebB95aTwc+pPsA6mgEjwpkvY4UXyWmJXLpAZfe0hxxGi62dbD5EtdMpGY
 JmwvSzfahFAKSYbqJc6Eby8VqUHNL96qiuMoJFFEW0r6nS1uRuUHxWvsB35a3FekhbgkK0CNT
 DPH9eZbJ2Kmb95n/YOscDsIkyy39WWh0m2bfIjHu/gxe0FNDKHsASvq9heKzKqOe+weGlxX96
 GAa98j4GLQ7oVMLa873KJjDTcQUUcuRfVUfxLgC6pUa0LmbwOSv8NdysWutbIbOP9wASARnwd
 0CGaImNlLK1fXXpDna7m4y/pSbqMm8ccSvEu2XuELUolWiemT5ML8MtiC/wiQjw/AtF1yCGiL
 UggM+QGcCi4vidAe7Ro78mTsa02u95bC/W+O7nEegGEOSGIUVklpos2KnS7DpIA2zsvUevFdF
 GUEZpkD9IRdCDKdIkMnLNbm8hhXBYux6O0bMdNgVgD3GuBa7/Q8DVFJobSp6mu5u8n+HHFeRk
 pv2CzwYjpETMnNA0mbpOmH7c6fQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

repo_diff_setup() builds the struct option array with git diff's command
line options and stores a pointer to it in the parseopts member of
struct diff_options.  The array is freed by diff_setup_done(), but not
by release_revisions().  repo_init_revisions() calls repo_diff_setup(),
thus calling repo_init_revisions() then release_revisions() leaks it.

We could free the array in release_revisions() as well to plug that
leak, but there is a better way: Only build it when needed.  Move the
get_diff_parseopts() calls to the two places that use the array, free it
after use and get rid of the parseopts member.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index e469d5d2a0..6415c4dc2d 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4615,8 +4615,6 @@ static void run_checkdiff(struct diff_filepair *p, s=
truct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }

-static struct option *get_diff_parseopts(struct diff_options *options);
-
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4662,8 +4660,6 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)

 	options->color_moved =3D diff_color_moved_default;
 	options->color_moved_ws_handling =3D diff_color_moved_ws_default;
-
-	options->parseopts =3D get_diff_parseopts(options);
 }

 static const char diff_status_letters[] =3D {
@@ -4821,8 +4817,6 @@ void diff_setup_done(struct diff_options *options)
 			options->filter =3D ~filter_bit[DIFF_STATUS_FILTER_AON];
 		options->filter &=3D ~options->filter_not;
 	}
-
-	FREE_AND_NULL(options->parseopts);
 }

 int parse_long_opt(const char *opt, const char **argv,
@@ -5695,21 +5689,27 @@ static struct option *get_diff_parseopts(struct di=
ff_options *options)
 struct option *add_diff_options(const struct option *parseopts,
 				struct diff_options *options)
 {
-	return parse_options_concat(parseopts, options->parseopts);
+	struct option *diff_parseopts =3D get_diff_parseopts(options);
+	struct option *result =3D parse_options_concat(parseopts, diff_parseopts=
);
+	free(diff_parseopts);
+	return result;
 }

 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
+	struct option *diff_parseopts =3D get_diff_parseopts(options);
+
 	if (!prefix)
 		prefix =3D "";

-	ac =3D parse_options(ac, av, prefix, options->parseopts, NULL,
+	ac =3D parse_options(ac, av, prefix, diff_parseopts, NULL,
 			   PARSE_OPT_KEEP_DASHDASH |
 			   PARSE_OPT_KEEP_UNKNOWN_OPT |
 			   PARSE_OPT_NO_INTERNAL_HELP |
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
+	free(diff_parseopts);

 	return ac;
 }
@@ -6518,7 +6518,6 @@ void diff_free(struct diff_options *options)
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
-	FREE_AND_NULL(options->parseopts);
 }

 void diff_flush(struct diff_options *options)
=2D-
2.38.1
