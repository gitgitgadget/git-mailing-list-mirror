Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E635C433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 00:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1A120675
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 00:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qK5ao3aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHPAwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:52:30 -0400
Received: from mout.web.de ([212.227.15.14]:36323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgHPAw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 20:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597539147;
        bh=tZxH/bZ8hdCGjIAQl97L+gJygOy4eidE72LmdQBkRJQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qK5ao3aV2WCaYnn33ym3/JxQ0utTxxguGp9qxJQlw17OIlXknaRzgPeGVxjRDFfqK
         1BDA05VX/v2DYWoaYHm57yU3ZNk3itt9ZTg08tPev9t0IJbWsWUGmPyrvjQDqFDh/Z
         GqRC6DQyu3FfRQHIeP7CR3r9YaVpoUejjK6Emd7k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxO2c-1km4121uo6-016wtB; Sat, 15
 Aug 2020 09:14:50 +0200
Subject: Re: [PATCH] fast-export: factor out print_oid()
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
 <20200813151856.GE2244@syl.lan> <3ddf0a14-77ac-7546-e03a-704432305bdb@web.de>
 <20200813172545.GB1597339@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d25987e5-df7e-d153-bbe4-a4e391ed4454@web.de>
Date:   Sat, 15 Aug 2020 09:14:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813172545.GB1597339@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7nYk2G8RUlJBOBSKtILSEw9JaCZgFi0qEIcAJHp9sT6W6YLpbKj
 yQBvs+kNNbrwUmPQUcZgJ4T7H8tr5MobefPIldDICRCK+usYDH3OQS65VylFehQGDDHifca
 1g08wnpOYjly6DMr6FT8MUs8kJ3oiy9dRfMbYNUJHAIEJrePqmjr/S/gSaQgNjRjPmkiseY
 U3Gvd4NQ8049dIY1XPhOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0GSSl4RHJIk=:fxCCILoGvN3mi+F2flX4fC
 fRiO7xcKvSrElLNl8RbZeGfz54vNSvo2vHYIGLpSeRegj8DJL0YZIsLbhCBHZ4GPox9H3jdPz
 uSdJ7bBMlkgOft6YOZxMhUs4XPh6fQdGjqXyd8TX8wDZw5GG98Vhj197rIDTwPgK42prQ1ubT
 MMLsdk/PhzJ0TYf76EUl8WNbOMViqBuLQkL7nBIuqRfnz9ieDvHOQ2XzOw2oMAeeQBlogaV6h
 kZSdvYN+APHoKuQMRrtx6XGH2TxOIy++KJobMkZTzLfkyB5x7IjXKvulJZQJrlOOcuXA/5qF6
 tE7CmcYCILnkgpmo7PpzvFQVK9ZzW38soBAJpG+IC4Sy0isAw3qNWGYeGhqxVTtf5bQYaawQ6
 TkGR/AFXr0QkWgDmNfPdzVKF7ErNnq2+OdbDRhgn/PsMnWn6IU7EerMiPWmdmhGpXrtLialFV
 W5GHX9lB3C1neXkFxz3iiJY1ElbSc7rsg7u3B7FeA0Vp7U6lberHlswPoCvV9c2cUmXghs3fb
 CmbrKkYih5KHabGLw//PTv3jz1qlMrcRN0gd6H+2VynrGsj9lLOIM6oyPzZLkkiUi5k0ykrpV
 zEpADJCxF8dGieZu8mMAajg7NKjHFnecdk8PtvWWHU4Mv2XKK0qgMsf9XCRpFQrh7EhsLH+Gw
 Si8Sd5+lx2x4LKbwdhDZ5dfebNYb04O3VFWD3wheRxYVlnaWwEP31fQrkPR2YGw521bTYHwSg
 Mt1W1zZibYD5mzNg3lwgU+WR7VZr18aB0br0abWzCvH+I1Tz+dE/N8R3WPzP26+D7fLrkcWh2
 ZVZZ9m8i4KlKuASB+c0+gg9JKxWJOIB+xy+AaaUG+MOVqKJdPinp5Z0FMo2gkzqR5QzCn7sjS
 FpoZ1QZTQp483IJtf+uJuvhTzpEuSj0NG+y+88zkywQpBsJ5IzV2XimEOiI+gaZAY1cPMIHmz
 9k1KGlP515EXVOpa9mVxV27ZCkAoDF/UaA/LREvvHvvoMpBkCOHTuSal9X/b5/9kHHCuO4sGU
 3yBBzgEAzvnZDESjTyW5GEayeWeWTfnPHjrv+OSTGH44qUHdy0eRsMOYFdT70i35+21lRdJEP
 or7yGwgAs2GvZ08qrMdyZ1FEUW7kD7nhDaDzK8rKTb6mONbk84vUkkjZFZmTZyrAyEJQwSoyg
 jIGvPBaMftGRfBcPhp5g/zbCZLdhEaOKpPQoXey5VA4YNqZDFdkhndbUG6dD8thQz0IeQ24AV
 CQP61qwiiKMZDqrUN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.20 um 19:25 schrieb Jeff King:
> On Thu, Aug 13, 2020 at 07:17:20PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> -- >8 --
>> Subject: [PATCH v2] fast-export: deduplicate anonymization handling
>>
>> Move the code for converting an object_id to a hexadecimal string and
>> for handling of the default (not anonymizing) case from its callers to
>> anonymize_oid() and consequently rename it to anonymize_oid_if_needed()=
.
>> This reduces code duplication.
>
> I think this is a bad direction unless you're going to do it for all of
> the other anonymize_*() functions, as well, for consistency. And there
> it gets tricky because the caller is able to use the anonymizing
> knowledge in more places.
>
> I actually liked your original version better.

OK, how about embracing the static and do something like this?

=2D- >8 --
Subject: [PATCH] fast-export: add format_oid() and format_path()

Add functions that handle anonymization, quoting and formatting of paths
and object IDs and return static buffers fit for use with printf().
Use them to generate each output line containing these components with a
single printf() format specification, which is easier to read.

format_oid() inherits the ability to be used for four different object
IDs in parallel from oid_to_hex() -- but here we only need one anyway.

format_path() has two sets of static buffers, which is just enough for
our purposes here.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fast-export.c | 86 ++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f37895d4cf..a9e36dccf9e 100644
=2D-- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -368,17 +368,6 @@ static int depth_first(const void *a_, const void *b_=
)
 	return (a->status =3D=3D 'R') - (b->status =3D=3D 'R');
 }

-static void print_path_1(const char *path)
-{
-	int need_quote =3D quote_c_style(path, NULL, NULL, 0);
-	if (need_quote)
-		quote_c_style(path, NULL, stdout, 0);
-	else if (strchr(path, ' '))
-		printf("\"%s\"", path);
-	else
-		printf("%s", path);
-}
-
 static char *anonymize_path_component(void *data)
 {
 	static int counter;
@@ -387,18 +376,34 @@ static char *anonymize_path_component(void *data)
 	return strbuf_detach(&out, NULL);
 }

-static void print_path(const char *path)
+static const char *format_path(const char *path)
 {
-	if (!anonymize)
-		print_path_1(path);
-	else {
-		static struct hashmap paths;
-		static struct strbuf anon =3D STRBUF_INIT;
-
-		anonymize_path(&anon, path, &paths, anonymize_path_component);
-		print_path_1(anon.buf);
-		strbuf_reset(&anon);
+	static struct hashmap paths;
+	static struct strbuf anon_buffers[] =3D { STRBUF_INIT, STRBUF_INIT };
+	static struct strbuf quoted_buffers[] =3D { STRBUF_INIT, STRBUF_INIT };
+	static int which_buffer;
+	struct strbuf *anon =3D &anon_buffers[which_buffer];
+	struct strbuf *quoted =3D &quoted_buffers[which_buffer];
+
+	which_buffer++;
+	which_buffer %=3D ARRAY_SIZE(anon_buffers) + BUILD_ASSERT_OR_ZERO(
+			ARRAY_SIZE(anon_buffers) =3D=3D ARRAY_SIZE(quoted_buffers));
+
+	if (anonymize) {
+		strbuf_reset(anon);
+		anonymize_path(anon, path, &paths, anonymize_path_component);
+		path =3D anon->buf;
+	}
+
+	strbuf_reset(quoted);
+	if (quote_c_style(path, quoted, NULL, 0))
+		return quoted->buf;
+	if (strchr(path, ' ')) {
+		strbuf_reset(quoted);
+		strbuf_addf(quoted, "\"%s\"", path);
+		return quoted->buf;
 	}
+	return path;
 }

 static char *generate_fake_oid(void *data)
@@ -420,6 +425,14 @@ static const char *anonymize_oid(const char *oid_hex)
 	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
 }

+static const char *format_oid(const struct object_id *oid)
+{
+	const char *oid_hex =3D oid_to_hex(oid);
+	if (anonymize)
+		oid_hex =3D anonymize_oid(oid_hex);
+	return oid_hex;
+}
+
 static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options, void *data)
 {
@@ -438,10 +451,8 @@ static void show_filemodify(struct diff_queue_struct =
*q,

 		switch (q->queue[i]->status) {
 		case DIFF_STATUS_DELETED:
-			printf("D ");
-			print_path(spec->path);
+			printf("D %s\n", format_path(spec->path));
 			string_list_insert(changed, spec->path);
-			putchar('\n');
 			break;

 		case DIFF_STATUS_COPIED:
@@ -454,12 +465,10 @@ static void show_filemodify(struct diff_queue_struct=
 *q,
 			 * copy or rename only if there was no change observed.
 			 */
 			if (!string_list_has_string(changed, ospec->path)) {
-				printf("%c ", q->queue[i]->status);
-				print_path(ospec->path);
-				putchar(' ');
-				print_path(spec->path);
+				printf("%c %s %s\n", q->queue[i]->status,
+				       format_path(ospec->path),
+				       format_path(spec->path));
 				string_list_insert(changed, spec->path);
-				putchar('\n');

 				if (oideq(&ospec->oid, &spec->oid) &&
 				    ospec->mode =3D=3D spec->mode)
@@ -475,19 +484,17 @@ static void show_filemodify(struct diff_queue_struct=
 *q,
 			 * output the SHA-1 verbatim.
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
-				printf("M %06o %s ", spec->mode,
-				       anonymize ?
-				       anonymize_oid(oid_to_hex(&spec->oid)) :
-				       oid_to_hex(&spec->oid));
+				printf("M %06o %s %s\n", spec->mode,
+				       format_oid(&spec->oid),
+				       format_path(spec->path));
 			else {
 				struct object *object =3D lookup_object(the_repository,
 								      &spec->oid);
-				printf("M %06o :%d ", spec->mode,
-				       get_object_mark(object));
+				printf("M %06o :%d %s\n", spec->mode,
+				       get_object_mark(object),
+				       format_path(spec->path));
 			}
-			print_path(spec->path);
 			string_list_insert(changed, spec->path);
-			putchar('\n');
 			break;

 		default:
@@ -726,10 +733,7 @@ static void handle_commit(struct commit *commit, stru=
ct rev_info *rev,
 		if (mark)
 			printf(":%d\n", mark);
 		else
-			printf("%s\n",
-			       anonymize ?
-			       anonymize_oid(oid_to_hex(&obj->oid)) :
-			       oid_to_hex(&obj->oid));
+			printf("%s\n", format_oid(&obj->oid));
 		i++;
 	}

=2D-
2.28.0
