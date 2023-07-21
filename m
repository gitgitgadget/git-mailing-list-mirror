Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B5EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 13:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGUNlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGUNlk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 09:41:40 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7B4E53
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689946894; x=1690551694; i=l.s.r@web.de;
 bh=jTVWpOlA6iakxuSgg/GerHaGm0sl00hnj0Lhg8qZ54M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Z9IOZ7C+33Z6jcP7zThGb9Qk/fweYSu6H+ERwxd5FJOkFZlAw52QFKxeFvckWu0clE1OPN7
 LieFVRnm2mgYrqg3lAQ3+5yDsB8Z14885CfmqDKYA3XNRVAwI/Obk0YRJ4qw8v+oyndJ5sRVS
 IwKwDYhOpOQOlMhZM1Opj4ARmrb+BroDv0HG0/OhrU+hKUxfIK+1YdaHM0gPw+xj6sMER7Qp3
 oIz2gTHUu34u3asB8lVZO+AWgUcCXbzzxDl/TAvnIOzlA1FKKY/fgidtL9BsOPo5vu01bjxsL
 Si+oygRrEfi7PSEscpqmFAjTN4E8zyywj+uynHKvv5TLo2AiYUwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxiW-1pcXHZ3yBc-00kipP; Fri, 21
 Jul 2023 15:41:33 +0200
Message-ID: <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
Date:   Fri, 21 Jul 2023 15:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] describe: fix --no-exact-match
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fXFein69cS3fDckeosCmf3ODi9Pj7NkeumLo5l7PaIOoHRFBw8/
 9tUzoh7m0nVE0M7fCnjPDO0U/u2PlT0iLE3jiLmM3i+MrMv3ZlZJP6ubKwZf3bpNUQCKAfR
 NbRjwYJQQda2DAaEdTLAjx6eEu4fcbe2eEPmC5u++SeSy83UsEISJe2hjTK+MXkC5qcyTPw
 LMI1cuWDQZvhpHRnF8hEQ==
UI-OutboundReport: notjunk:1;M01:P0:WkO7je1+rhI=;SGg6lyeArQLTfY0cdKn3JhEudti
 1DBwxWv30o1W52tsmKqiNVaKMheHA13uPLFhAG4DcgAqNQVjK/KACS4r5XuIJ8X1OdJ7+x/Jp
 5Yxj3EWumllF1bChEkvZBl/XRObQizqKp3KUS6L6UrMIm/AUSIU9PvjTG+wXDe7zMPEKvct2L
 hJ25jnwyTOO+eqoIJXmkHAQnxQarlDJ5cSQqEHFTA99S4n9TN4xLJegrhM8SR/jlbUdbjL7LH
 tod1F67LAt8WOCgBba2vUZQDiCO/kkXE4zd7rxU0oXnr6wyVmQ5nnD5KjWlHavr04EkRQKqzs
 xWmquPwz/Vvpeg/VSbkQimkh4gLWHUIo7lPkfLFbm0R23yXGXzzCdOnklUe0hxxnDRxj8/QuY
 Dq4FCPMf5h8ud1cy6sRS8vGupXQVEclQJGKsxhag35/XZbFyUZ51tENUCm+PChfEcCPqLUcGy
 uxV6K19IdOMKE3mX0APMP5rc9ggWxMYg0j79avQzeybM0tedtqc7cx3Tt6ZAbPydZaQlPelJ1
 NRczIGh7aVDB33xvUb+VJBawteoeug3TE05kfVIoXUiITg2XkPxX8HzcTPHuhwkEhI0/NSLgx
 KpXzV6LAzhYsqYXtF84k59B8lk3nl63S6kvPwYL+gTnybDzkS2Pbbgg41c4ALocI9EWgd590N
 9fe6qqzQTnckhuXN8c/dhE1PkOCDfJCLZf+JQeHjO1bcu0FMqcAxPChNyhoFz3eJXBRUwZ0W0
 0fJaUWUTDwcMgXOkjTrFjpeyKYrgtLIEFLCVQ0XHZkaxMQss0ikXZdU2H3Emj3/a7TLbiw6Kd
 FJoQoleRlepijK8WzQVG8Z7zrG2id2I1Jxr2Nx4nYHg8ErMeDgEnfFTpByaQt7q6dwXpVzpyV
 nQuceU8UVm2qv0A287vjGI2f2HKBmVf0DCJ+H534JiAVezLH2/fPukzbuocsgBZjGLIvjFErd
 vhKJr8DTHWRIgQFqr3qERJvK+IM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 2c33f75754 (Teach git-describe --exact-match to avoid expensive
tag searches, 2008-02-24) git describe accepts --no-exact-match, but it
does the same as --exact-match, an alias for --candidates=3D0.  That's
because it's defined using OPT_SET_INT with a value of 0, which sets 0
when negated as well.

Let --no-exact-match set the number of candidates to the default value
instead.  Users that need a more specific lack of exactitude can specify
their preferred value using --candidates, as before.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Or should we just forbid --no-exact-match?

 builtin/describe.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7ce23e1b8e..b28a4a1f82 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -25,6 +25,7 @@
 #include "wildmatch.h"

 #define MAX_TAGS	(FLAG_BITS - 1)
+#define DEFAULT_CANDIDATES 10

 define_commit_slab(commit_names, struct commit_name *);

@@ -41,7 +42,7 @@ static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int first_parent;
 static int abbrev =3D -1; /* unspecified */
-static int max_candidates =3D 10;
+static int max_candidates =3D DEFAULT_CANDIDATES;
 static struct hashmap names;
 static int have_util;
 static struct string_list patterns =3D STRING_LIST_INIT_NODUP;
@@ -557,6 +558,15 @@ static void describe(const char *arg, int last_one)
 	strbuf_release(&sb);
 }

+static int option_parse_exact_match(const struct option *opt, const char =
*arg,
+				    int unset)
+{
+	BUG_ON_OPT_ARG(arg);
+
+	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
+	return 0;
+}
+
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains =3D 0;
@@ -568,8 +578,9 @@ int cmd_describe(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent=
")),
 		OPT__ABBREV(&abbrev),
-		OPT_SET_INT(0, "exact-match", &max_candidates,
-			    N_("only output exact matches"), 0),
+		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
+			       N_("only output exact matches"),
+			       PARSE_OPT_NOARG, option_parse_exact_match),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
=2D-
2.41.0
