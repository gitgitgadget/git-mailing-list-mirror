Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13CEC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0020885
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Omii4KTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHMLLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:11:34 -0400
Received: from mout.web.de ([212.227.17.12]:60599 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgHMLLc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 07:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597317079;
        bh=k+sdXzSVL5Jw94O2qLYIxO/yPD4bsbn9DWVfG8VIEKE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Omii4KTRz+y8kYXCoPbpAISIFEQ1npeXty5FEY0/2VJq5C5AjLKtnbGeOpZB3F+JW
         v2aR8DtliKlZaNljFF8A++ZdKilLoNDfpw7r+fqhocGFlRSM9LqayOOtwUjgTNF7Qn
         yR4MQPpkPcyQufLaB0vKZIsSD9K9+xlig2xCq4k4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cLf-1kicPS2b1p-015D34; Thu, 13
 Aug 2020 13:11:19 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fast-export: factor out print_oid()
Message-ID: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
Date:   Thu, 13 Aug 2020 13:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bYjzGj7NE1+igfGJX3eezm0MU637GqwignUw1sR8qZlCL+L/BDP
 UuRrgyLCesavHSaCX7TtR5UTc8mQ7bwOD7gL9exAhOQ6OvCdmBhXmuPjap0l/nt6ZgPeYzs
 kO8RRsc7SN0y/DMwvwbLvJaxb1zaoHMOAg4Q4wnLDh9bZqIKuEncylIIvMQ20i9pnDWo066
 BkYLP3/YnAk73qB74dHDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M5+92nt4UHw=:wNBvp2jhk5sSFzVP042xqm
 JUbilflGiPP3pqmEvmVa0iwZPq/ffUFqUnTrl22lAHru/SuKZFwvtma/+rc4NRnZOcnBcqiYM
 45dDUpDdHSze4bM8GJQggkYeBuc1jp8g3Q9AzMd0TgxBCAgy3MWC/rgssqVWuRP7i3GHmab+q
 A/QhIo5378EpexcjUl63iW1+2DgIciWZhKD81vb5/O2ST8N4Fm94vaus0uvopuJLRB5rrIV9o
 UlY6JW1re9nQI7Ftq5txiptPgphYO5ZFuVulYhYH7hqLVcSU96IYO6Rc3MLWyVPy3pXIweF5s
 kxQb7n9rQAxHFnl+gu/edXkhmyQ7jOcKV4hTKOdGxVQMs5X9b/0h+C9QkqUzEddqqotlXHjTb
 jVz3QKutwx+78rc85Wvsqfi2B3cpE+/h/vGWO/KacPIhYae1qmwPF6GYnmYDi8oTMrBXoikJ/
 WV+ACe4reP9Lzs7Zsw5lGQWtd3ORspp32weYV1o4JIDsiX0GbSJpkC/mfs0yvFrGTXz1ZVCJ8
 EHfi8LZSn4qVx/A4xBnpTW0DP5BlI2mueQWegM8HzgrZAU3+8AeQoY8c1qGR4OIF+TjlzhcFW
 ru1fnNXwX/Ud9bLrLR4ZZi00kq4OM6+FtiZfGLl0yV+b/3UeKuCGe0D3QxBpPh7iuplFccAeF
 5pj69QcEwUUiz7o3NS5pZpt+LUwbA9iCy9RFkQCJDtUu/CgvhJicwxShFHEwrfc+akem24wJQ
 6IvxIsJzJH7Rrb21dHTnPgTc8C1HjO8xzDS9aDuHlIsha/SlqFZDfUPeBujtVQLTe55V7q/U9
 Y5IF1cMhhgM4/PFyirD2lNshwYTD+rxUDSiu/HZEXIB2PKLDq0rbPIL5luOVdRRf3ZwwmYwTc
 J+J4wKMcCmbiYmAyW0sKpM7e5NRmTBqteWRy0IN/gFmr8I61Ci+rNCnFRrQMi7KL0UWVM3C1W
 rSuGyzzrX/tBDpHVDSfTgye6ZVaySQNp450pirEHgBJpZ1gD8qSV9MfIqw3qHq/FwpEv/t38P
 HGDps8TZ/wabwYpG/cNhdD0Xdk4nKmm/BVWbmxxU4eYrA8iD608n9pafLhe6hXDe992hs6m36
 OO5ouysYFZ5uWzbZk3TKNLKcDlZITHHLYmau0VekxhNm5ffRvtJ0qFBWNCnIwuEwRmj40x8t7
 +Ul04iwdm1K8lnZ7WFar/vUujL7F0o17jSburFZJVScojw/R40RXgOg9e5jZwlLRWq3UYJ5AC
 ygnO9AgNw8lyLa/Ut
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the output code by splitting it up and reducing duplication.
Reuse the logic for printing object IDs -- anonymized if needed -- by
moving it to its own function, print_oid().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fast-export.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f37895d4cf..49bb50634ab 100644
=2D-- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -420,6 +420,14 @@ static const char *anonymize_oid(const char *oid_hex)
 	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
 }

+static void print_oid(const struct object_id *oid, int anonymize)
+{
+	const char *oid_hex =3D oid_to_hex(oid);
+	if (anonymize)
+		oid_hex =3D anonymize_oid(oid_hex);
+	fputs(oid_hex, stdout);
+}
+
 static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options, void *data)
 {
@@ -470,21 +478,19 @@ static void show_filemodify(struct diff_queue_struct=
 *q,
 		case DIFF_STATUS_TYPE_CHANGED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_ADDED:
+			printf("M %06o ", spec->mode);
 			/*
 			 * Links refer to objects in another repositories;
 			 * output the SHA-1 verbatim.
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
-				printf("M %06o %s ", spec->mode,
-				       anonymize ?
-				       anonymize_oid(oid_to_hex(&spec->oid)) :
-				       oid_to_hex(&spec->oid));
+				print_oid(&spec->oid, anonymize);
 			else {
 				struct object *object =3D lookup_object(the_repository,
 								      &spec->oid);
-				printf("M %06o :%d ", spec->mode,
-				       get_object_mark(object));
+				printf(":%d", get_object_mark(object));
 			}
+			putchar(' ');
 			print_path(spec->path);
 			string_list_insert(changed, spec->path);
 			putchar('\n');
@@ -724,12 +730,10 @@ static void handle_commit(struct commit *commit, str=
uct rev_info *rev,
 		else
 			printf("merge ");
 		if (mark)
-			printf(":%d\n", mark);
+			printf(":%d", mark);
 		else
-			printf("%s\n",
-			       anonymize ?
-			       anonymize_oid(oid_to_hex(&obj->oid)) :
-			       oid_to_hex(&obj->oid));
+			print_oid(&obj->oid, anonymize);
+		putchar('\n');
 		i++;
 	}

=2D-
2.28.0
