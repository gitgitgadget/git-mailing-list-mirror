Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CEC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135102166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="haByjRRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBDVZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:25:39 -0500
Received: from mout.web.de ([212.227.15.4]:33067 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDVZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580851535;
        bh=BJsBSpW611sD9eUxzu0eJTtNDf9J/bJ1qXmW28W5Gns=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=haByjRRsz+HnSwgx4Sioo6S//BsSzhv/If0qRi4TgN5KWZVBZYMgcgXLnVkhocbun
         9vVUfZ88S5O20vrLjvJaUViK/KSSJ2rOvIuo9XimRcs5OSB5seKAXpFiKn7dDT0ufm
         ke3x7O9ISx+yBe22hsYQrd/lNkCVphNC0YbaSsQI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LcgYZ-1jQhM80CMZ-00k89v; Tue, 04
 Feb 2020 22:25:35 +0100
Subject: [PATCH 09/10] name-rev: generate name strings only if they are better
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <77d1d053-8680-5cbe-9182-b6aec9e9b446@web.de>
Date:   Tue, 4 Feb 2020 22:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LXo0WO379o7q4PAhSL9IHZ6gr4oNTzLWZ6S8FdKLme3oK9q3yKd
 oZ92wMH2sP9a8DkeGHrcMsmfXPjOobEWTHfgxtOJhBrbpOyLRMMc6m0RcQDs6mSTO+ZHpGS
 cwAgWYeuKXXJBlMTV40c4x8Dxj/5S0UG2BvpgEINb+teGrH+2WXsgsmkSHHoySTrY3uAMV0
 UjUT405ib9nNjkAfEguMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJM3S5/NY/k=:ewv9SnbYTAq/YaY+xJrHiU
 t0/5pxhcssWfu9mQlzyEpYZwvn5Cs94tuotJOEX++t3lKnnUsODe8O3RjGckHYCGn+AVjNeiV
 C8VRO3rSvseJqn3M+JabvVix4P1DK8wMNfCG4Dg0fL+Sa2Sc2omBxWBONWXU7/BdXkGnHSZ/e
 yJWm1Ok08RBw//d6KONNDghco6JnA048MxGBbgTybQMngP2cxWUreygML6nCnJQZKp6/PcDZM
 3Wwt4fllKvf8YO6vwS6+45qp1zVbbuNhZzJyfLXc+lE4hQPkxp7VMfMZk1urCK44HuOMhORqS
 WW3QPXo3eyrQ30kg0mGgaYonW3fu5TrF5CX2Blb1zJJOFsPAeY/bAvGZ5wbomOP1CHOWkS7HT
 z9J7rZbIKoe5dpedyVBEPgkmW+zsvXCS3a5Rr9cxgBPtiXtTRD+OkmzUiXe4l6FD57vS2Afyw
 dZiQWIxCflPX8NOdkf+c/6KACD/9Vq7PFppepWCxfRp1r3DNrtwgQJOJJMNRakM6QQf1gAeSx
 D5rTbQGmFTVXlizemWylZrlmrfNuZ8cRDWWGE3mh1bIo2kWRMVpLSgxLK5vn9myXCuhyRzmS2
 mL9oBYtRq6yJd3lVCpgHLXoEE+70wpZ6ktTb5XPPnOB6UB8CASbATA8egDw45M30iiXCL4h6y
 /USm+mXK7UbppVmp/8OkfrHIedV2fw09Q2NJayDlvOgCiXzOX+DypAnEcvhe4zVKXnaXKlZip
 T+/EJ8VLhFmg56qxDvDJspI0B+SsWUD6X6+fdZRYmZ05Cp4rEYwCx7Z9GRrSgIGMezN0kjjc4
 kc9Xhxq6hbmROBhJGDqGOLP1emGmf/payNZss8si9TOGcVYvoq7O/M5a0jvcc08UjwpIKbuBS
 THF7mDYmxHUmOqvvwIlatBpoBCv+HFWD7rLFkQxTdETVbVjWj7ulbzgDx5ot2Wg/12ppziHV2
 uD/z7hUDLlltjwiXeh+ZF3Uq6EJRBpj2s/MiO/G2gtdq7SvA2tcYXSqSff8Ev7MV9N5AZ65Sf
 a+j+NrlUyJ+Llso+Unsv3Z3fFZz2e8aIdDGxq5GtCJjVhl5kpM9Z8NRfzybYTyHeGgFH1XUxq
 vBkeOLxy0Ws0sZdgxbM7gSo2dn/lj7S8t8ktGEsef/JmVUtwfflp9vwSyW98jDYAz4pWt775B
 XJc4UwlOvwAr7JukcYK8BGaml/w5dCIxV81gziHVHoOdQ9Fa13967iYhmc1qVNTZ4en4FXsYo
 3RKd2BOYyDV9RU91J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leave setting the tip_name member of struct rev_name to callers of
create_or_update_name().  This avoids allocations for names that are
rejected by that function.  Here's how this affects the runtime when
working with a fresh clone of Git's own repository; performance numbers
by hyperfine before:

Benchmark #1: ./git -C ../git-pristine/ name-rev --all
  Time (mean =C2=B1 =CF=83):     437.8 ms =C2=B1   4.0 ms    [User: 422.5 =
ms, System: 15.2 ms]
  Range (min =E2=80=A6 max):   432.8 ms =E2=80=A6 446.3 ms    10 runs

... and with this patch:

Benchmark #1: ./git -C ../git-pristine/ name-rev --all
  Time (mean =C2=B1 =CF=83):     408.5 ms =C2=B1   1.4 ms    [User: 387.2 =
ms, System: 21.2 ms]
  Range (min =E2=80=A6 max):   407.1 ms =E2=80=A6 411.7 ms    10 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 793356edd1..98f55bcea9 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -81,7 +81,6 @@ static int is_better_name(struct rev_name *name,
 }

 static struct rev_name *create_or_update_name(struct commit *commit,
-					      const char *tip_name,
 					      timestamp_t taggerdate,
 					      int generation, int distance,
 					      int from_tag)
@@ -92,7 +91,6 @@ static struct rev_name *create_or_update_name(struct com=
mit *commit,
 	    !is_better_name(name, taggerdate, distance, from_tag))
 		return NULL;

-	name->tip_name =3D tip_name;
 	name->taggerdate =3D taggerdate;
 	name->generation =3D generation;
 	name->distance =3D distance;
@@ -130,22 +128,20 @@ static void name_rev(struct commit *start_commit,
 	struct commit *commit;
 	struct commit **parents_to_queue =3D NULL;
 	size_t parents_to_queue_nr, parents_to_queue_alloc =3D 0;
-	char *to_free =3D NULL;
+	struct rev_name *start_name;

 	parse_commit(start_commit);
 	if (start_commit->date < cutoff)
 		return;

+	start_name =3D create_or_update_name(start_commit, taggerdate, 0, 0,
+					   from_tag);
+	if (!start_name)
+		return;
 	if (deref)
-		tip_name =3D to_free =3D xstrfmt("%s^0", tip_name);
+		start_name->tip_name =3D xstrfmt("%s^0", tip_name);
 	else
-		tip_name =3D to_free =3D xstrdup(tip_name);
-
-	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
-				   from_tag)) {
-		free(to_free);
-		return;
-	}
+		start_name->tip_name =3D xstrdup(tip_name);

 	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
 	prio_queue_put(&queue, start_commit);
@@ -161,7 +157,7 @@ static void name_rev(struct commit *start_commit,
 				parents;
 				parents =3D parents->next, parent_number++) {
 			struct commit *parent =3D parents->item;
-			const char *new_name;
+			struct rev_name *parent_name;
 			int generation, distance;

 			parse_commit(parent);
@@ -169,18 +165,23 @@ static void name_rev(struct commit *start_commit,
 				continue;

 			if (parent_number > 1) {
-				new_name =3D get_parent_name(name, parent_number);
 				generation =3D 0;
 				distance =3D name->distance + MERGE_TRAVERSAL_WEIGHT;
 			} else {
-				new_name =3D name->tip_name;
 				generation =3D name->generation + 1;
 				distance =3D name->distance + 1;
 			}

-			if (create_or_update_name(parent, new_name, taggerdate,
-						  generation, distance,
-						  from_tag)) {
+			parent_name =3D create_or_update_name(parent, taggerdate,
+							    generation,
+							    distance, from_tag);
+			if (parent_name) {
+				if (parent_number > 1)
+					parent_name->tip_name =3D
+						get_parent_name(name,
+								parent_number);
+				else
+					parent_name->tip_name =3D name->tip_name;
 				ALLOC_GROW(parents_to_queue,
 					   parents_to_queue_nr + 1,
 					   parents_to_queue_alloc);
=2D-
2.25.0
