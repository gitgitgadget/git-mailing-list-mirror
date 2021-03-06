Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5833C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F06465015
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCFL0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:26:38 -0500
Received: from mout.web.de ([212.227.15.14]:44551 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhCFL0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615029980;
        bh=UayHtWAMVaPeVggxKYZTawMeQruPQZdhcuG+VUklkls=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QodFjsVbO11Lf1YcfNgOFQG4sFvrLouYcbEXZgKL5V1iZw9cU6+X4K9OagOJYq6zL
         2fL+RX4/1lJ/IP4PnGfWjO5TJoJtmkYKBLFzlyAaJFfjgYReDKczpSaHpy8Y2n/wvA
         5Ig4afS+U1K0WJTl1l+gTvQootSPoxo0Epx+uH3k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MHpKH-1lLWwT2Xhl-003cyG; Sat, 06 Mar 2021 12:26:20 +0100
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-1-avarab@gmail.com>
 <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
 <xmqqim659u57.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <0742554d-7d3e-3f92-57d6-1339e5ce1450@web.de>
Date:   Sat, 6 Mar 2021 12:26:19 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqim659u57.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yviAKfXsnAABZjpQuuI9dMpcqtrZlnLHDzogbJNTDqUxFbjEIX7
 U0KX6aE77VlvM1H6kb4hqVC+VEqzzhoIfMdD6Td6OIrLaLxOrVHeC+u/Dwwg4zycG8EO0jD
 ibmJIFawZEBMoceenHFQAAL8JemhFdb+wemOOd/LIqRAI/nEUEabp+eeKZ+hVIsUzveYl25
 NDYjLA0lzwxXQlxt72BLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZmdBMEEX+9k=:NCVp95JNfBE1s6lbszYOAj
 K8mA1mPaJ3UAPJAdmcZTcda6kpF5/71IZODXJ4tsx4DL2/smE0ajdjJZ8tSSQcsHBS1IHaA57
 MGH2whozm/ikegY+THKQkCnJuJzgx8B5vx+6TU0J6nmOJsxAxY93RWY7FTJ+G0c6Ba8GzTxA5
 ACJUr7wEloSMCZqzvQTvlAgz3s/65JEgVzueFsX24QP2ijs6E2nRd0+5qNPwBC37ErW+DPWU5
 J+iK5Gfw6An20ATVAeN1+dAAj/Pl8198enjephcnAr56HRnb2jJo27vtgOD00MsiLHBDNc/5l
 UsuWNKU7hOeodPAxQqjun/7SeMh2doWA5WQeUgjCEaNLsrVPDc6D0UzyIFFG2keVYHOqHXDon
 ZvgOFy1gDwTpcBlsHY6gb/n6zycdl3bG3n78zuO2kppsHQesJfyF/+NaBzLsgxGGEjfPZO1YE
 RWE4ol1CtY39EMNKRSFNqMc1vwO19839Zs4fB3f2MGCMGmqnPqRuZViqBVLjpocBA8Ms9xrWY
 3iwJ3y/iTV0i9yJw+pJnagEVTJoOk0nls0f+7FSjHDLIcXS/jTeM5Vgbhlg6U9ffGC3ROcrjE
 HTlnLWYSb7/BfbK0Iz+FMy2HZ/VB+bkrAyFEuanv0dTq3HpsF3hq2g4eNTezlKbdxWB8RyUcT
 +GDuGImT3mldCdrbs48YVN4ah2KtzUH8htkcdo1q7dMiHV6AgxFfG6EP16L7i6rXfPR98KcnL
 EbOzlzoxLjv38ghz/SJzOE/BkAu07Xih9hWI7+SLJSzqEYR6uScN9KywgPQ7dP+MxLVP7Wzx0
 epP4TswB4/LqUbDh+f1vF4g6Hfpr5VTBiAc+zgJ/6jy2UgIFdrp5UFT1kiffK5DFOsus9mG5t
 i1YVGVWE7Wv7B/GwAbWw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.21 um 22:18 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe. <l.s.r@web.de> writes:
>
>> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.=
cocci
>> index 46b8d2ee11..1f26da007a 100644
>> --- a/contrib/coccinelle/array.cocci
>> +++ b/contrib/coccinelle/array.cocci
>> @@ -88,3 +88,16 @@ expression n;
>>  @@
>>  - ptr =3D xmalloc((n) * sizeof(T));
>>  + ALLOC_ARRAY(ptr, n);
>> +
>> +@@
>> +type T;
>> +T *ptr;
>> +expression n !=3D 1;
>> +@@
>> +(
>> +- ptr =3D xcalloc(n, \( sizeof(*ptr) \| sizeof(T) \));
>> ++ CALLOC_ARRAY(ptr, n);
>> +|
>> +- ptr =3D xcalloc(\( sizeof(*ptr) \| sizeof(T) \), n);
>> ++ CALLOC_ARRAY(ptr, n);
>> +)
>
> Not about correctness of =C3=86var's changes to the Makefile, but the
> latter half of the above conversion may be a bugfix, no?  The first
> parameter to calloc is the number of elements, and the second one is
> the size of each element.

Not if both calloc parameters are sizeof(T) or sizeof(*ptr). ;)

> Why should we refrain from doing the conversion when dealing with an
> array with a single element, by the way?

I find single-element arrays somehow awkward, and there are enough of
these cases to have a separate CALLOC macro with just the size
parameter.  But adding yet another one when the existing similar one
is underutilized is a hard sell.

Anyway, what about this more targeted approach:

=2D- >8 --
Subject: [PATCH] fix xcalloc() argument order

Pass the number of elements first and ther size second, as expected by
xcalloc().  Provide a semantic patch, which was actually used to
generate the rest of this patch.

The semantic patch would generate flip-flop diffs if both arguments are
equivalent sizeofs.  We don't have such a case, and it's hard to imagine
the usefulness of such an allocation.  If it ever occurs then we could
deal with it by duplicating the rule in the semantic patch to make it
cancel itself out, or we could change the code to use CALLOC_ARRAY.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-interactive.c                |  6 +++---
 blame.c                          | 14 +++++++-------
 contrib/coccinelle/xcalloc.cocci | 10 ++++++++++
 range-diff.c                     |  2 +-
 ref-filter.c                     |  5 +++--
 trailer.c                        |  8 ++++----
 6 files changed, 28 insertions(+), 17 deletions(-)
 create mode 100644 contrib/coccinelle/xcalloc.cocci

diff --git a/add-interactive.c b/add-interactive.c
index 9b8cdb4a31..09faee0e8f 100644
=2D-- a/add-interactive.c
+++ b/add-interactive.c
@@ -413,7 +413,7 @@ struct file_item {

 static void add_file_item(struct string_list *files, const char *name)
 {
-	struct file_item *item =3D xcalloc(sizeof(*item), 1);
+	struct file_item *item =3D xcalloc(1, sizeof(*item));

 	string_list_append(files, name)->util =3D item;
 }
@@ -476,7 +476,7 @@ static void collect_changes_cb(struct diff_queue_struc=
t *q,

 			add_file_item(s->files, name);

-			entry =3D xcalloc(sizeof(*entry), 1);
+			entry =3D xcalloc(1, sizeof(*entry));
 			hashmap_entry_init(&entry->ent, hash);
 			entry->name =3D s->files->items[s->files->nr - 1].string;
 			entry->item =3D s->files->items[s->files->nr - 1].util;
@@ -1120,7 +1120,7 @@ int run_add_i(struct repository *r, const struct pat=
hspec *ps)
 	int res =3D 0;

 	for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
-		struct command_item *util =3D xcalloc(sizeof(*util), 1);
+		struct command_item *util =3D xcalloc(1, sizeof(*util));
 		util->command =3D command_list[i].command;
 		string_list_append(&commands.items, command_list[i].string)
 			->util =3D util;
diff --git a/blame.c b/blame.c
index a5044fcfaa..d6a3f5b70b 100644
=2D-- a/blame.c
+++ b/blame.c
@@ -951,13 +951,13 @@ static int *fuzzy_find_matching_lines(struct blame_o=
rigin *parent,
 	max_search_distance_b =3D ((2 * max_search_distance_a + 1) * length_b
 				 - 1) / length_a;

-	result =3D xcalloc(sizeof(int), length_b);
-	second_best_result =3D xcalloc(sizeof(int), length_b);
-	certainties =3D xcalloc(sizeof(int), length_b);
+	result =3D xcalloc(length_b, sizeof(int));
+	second_best_result =3D xcalloc(length_b, sizeof(int));
+	certainties =3D xcalloc(length_b, sizeof(int));

 	/* See get_similarity() for details of similarities. */
 	similarity_count =3D length_b * (max_search_distance_a * 2 + 1);
-	similarities =3D xcalloc(sizeof(int), similarity_count);
+	similarities =3D xcalloc(similarity_count, sizeof(int));

 	for (i =3D 0; i < length_b; ++i) {
 		result[i] =3D -1;
@@ -995,7 +995,7 @@ static void fill_origin_fingerprints(struct blame_orig=
in *o)
 		return;
 	o->num_lines =3D find_line_starts(&line_starts, o->file.ptr,
 					o->file.size);
-	o->fingerprints =3D xcalloc(sizeof(struct fingerprint), o->num_lines);
+	o->fingerprints =3D xcalloc(o->num_lines, sizeof(struct fingerprint));
 	get_line_fingerprints(o->fingerprints, o->file.ptr, line_starts,
 			      0, o->num_lines);
 	free(line_starts);
@@ -1853,8 +1853,8 @@ static void blame_chunk(struct blame_entry ***dstq, =
struct blame_entry ***srcq,
 	diffp =3D NULL;

 	if (ignore_diffs && same - tlno > 0) {
-		line_blames =3D xcalloc(sizeof(struct blame_line_tracker),
-				      same - tlno);
+		line_blames =3D xcalloc(same - tlno,
+				      sizeof(struct blame_line_tracker));
 		guess_line_blames(parent, target, tlno, offset, same,
 				  parent_len, line_blames);
 	}
diff --git a/contrib/coccinelle/xcalloc.cocci b/contrib/coccinelle/xcalloc=
.cocci
new file mode 100644
index 0000000000..c291011607
=2D-- /dev/null
+++ b/contrib/coccinelle/xcalloc.cocci
@@ -0,0 +1,10 @@
+@@
+type T;
+T *ptr;
+expression n;
+@@
+  xcalloc(
++ n,
+  \( sizeof(T) \| sizeof(*ptr) \)
+- , n
+  )
diff --git a/range-diff.c b/range-diff.c
index a3cc7c94a3..f617426474 100644
=2D-- a/range-diff.c
+++ b/range-diff.c
@@ -96,7 +96,7 @@ static int read_patches(const char *range, struct string=
_list *list,
 				string_list_append(list, buf.buf)->util =3D util;
 				strbuf_reset(&buf);
 			}
-			util =3D xcalloc(sizeof(*util), 1);
+			util =3D xcalloc(1, sizeof(*util));
 			if (get_oid(p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
 				free(util);
diff --git a/ref-filter.c b/ref-filter.c
index e84efb53db..33b5e68056 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -772,7 +772,8 @@ static int if_atom_handler(struct atom_value *atomv, s=
truct ref_formatting_state
 			   struct strbuf *unused_err)
 {
 	struct ref_formatting_stack *new_stack;
-	struct if_then_else *if_then_else =3D xcalloc(sizeof(struct if_then_else=
), 1);
+	struct if_then_else *if_then_else =3D xcalloc(1,
+						    sizeof(struct if_then_else));

 	if_then_else->str =3D atomv->atom->u.if_then_else.str;
 	if_then_else->cmp_status =3D atomv->atom->u.if_then_else.cmp_status;
@@ -2185,7 +2186,7 @@ static void reach_filter(struct ref_array *array,
 	if (!check_reachable)
 		return;

-	to_clear =3D xcalloc(sizeof(struct commit *), array->nr);
+	to_clear =3D xcalloc(array->nr, sizeof(struct commit *));

 	repo_init_revisions(the_repository, &revs, NULL);

diff --git a/trailer.c b/trailer.c
index 249ed618ed..35b58357cb 100644
=2D-- a/trailer.c
+++ b/trailer.c
@@ -174,7 +174,7 @@ static void print_all(FILE *outfile, struct list_head =
*head,

 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
-	struct trailer_item *new_item =3D xcalloc(sizeof(*new_item), 1);
+	struct trailer_item *new_item =3D xcalloc(1, sizeof(*new_item));
 	new_item->token =3D arg_tok->token;
 	new_item->value =3D arg_tok->value;
 	arg_tok->token =3D arg_tok->value =3D NULL;
@@ -445,7 +445,7 @@ static struct arg_item *get_conf_item(const char *name=
)
 	}

 	/* Item does not already exists, create it */
-	item =3D xcalloc(sizeof(*item), 1);
+	item =3D xcalloc(1, sizeof(*item));
 	duplicate_conf(&item->conf, &default_conf_info);
 	item->conf.name =3D xstrdup(name);

@@ -664,7 +664,7 @@ static void parse_trailer(struct strbuf *tok, struct s=
trbuf *val,
 static struct trailer_item *add_trailer_item(struct list_head *head, char=
 *tok,
 					     char *val)
 {
-	struct trailer_item *new_item =3D xcalloc(sizeof(*new_item), 1);
+	struct trailer_item *new_item =3D xcalloc(1, sizeof(*new_item));
 	new_item->token =3D tok;
 	new_item->value =3D val;
 	list_add_tail(&new_item->list, head);
@@ -675,7 +675,7 @@ static void add_arg_item(struct list_head *arg_head, c=
har *tok, char *val,
 			 const struct conf_info *conf,
 			 const struct new_trailer_item *new_trailer_item)
 {
-	struct arg_item *new_item =3D xcalloc(sizeof(*new_item), 1);
+	struct arg_item *new_item =3D xcalloc(1, sizeof(*new_item));
 	new_item->token =3D tok;
 	new_item->value =3D val;
 	duplicate_conf(&new_item->conf, conf);
=2D-
2.30.1
