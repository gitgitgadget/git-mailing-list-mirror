Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB711F464
	for <e@80x24.org>; Wed, 18 Sep 2019 08:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfIRInU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 04:43:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39379 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfIRInT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 04:43:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so5059596lfh.6
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4wnm/cmHQV4ZGr3hnOACxcnK27bIfO8Ahsyg540CfC0=;
        b=IUcXlcMe/g2WjtGi5yWCVhiqOePYwf7YY6FbzAiMnHpa9N3LiOEDZuEJjg2kH7skSK
         cI8wu3XqbEiwghM7s/art82qN0U/so7xWoMdY3bQqgJl7saUuCw6cp4tC15PKu56DIr/
         3iLRdZZQa2re17FsZKQcZZBoszmqTZFRE9vu1A8BQWXolNbnYeGS1rdhIIDZ9t5o+jXK
         BY5TTo53yEeJ+wEEnMhlSCK4wq53wPPaEJd48Pdhr6VIidRWp+J0LEX+IL4eJ2C6fshl
         kgYrzEXMcWandLapOlzDTI/icZMW8QyFmANhe8bZfDWE2ICfSuOuVCMoiCw71a6vZC7A
         YU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=4wnm/cmHQV4ZGr3hnOACxcnK27bIfO8Ahsyg540CfC0=;
        b=aMFZZXaXlSPTvvH60ldOuX1BQtQ8kTiv5vY+2bxc1P+PBi86dKrd5ZKc+MQuB0tdHT
         ozwID2WZu6EIjRLwQ1RMqzSBdDC160fag7hDeAqol0bo5jzSumcKDCoVYc6ljtMH/C34
         ylqbZ4OGAXdMmXM2uZfT6ZacPXi9LDbDSIxdrhAUDAqzZAPXAYnqcRlpWTiPJc/Z4mTl
         7gkSxpwOek6PCmYHl2JqQQAyzpAJQwQzf33ekJ4lYKKFqf+3Yk5uOpbk45od4gHUB8uC
         OoS4gf7j0sKpoOj0UFK7jMsZ1eSXxtrmcH9cjFRywoWX8geVD2p29w2EK0djmQzr38cd
         XuCg==
X-Gm-Message-State: APjAAAXkzkji4R7ABaAIo7H/Qf4xyjvQ5T//Qugg3JEkjZCLsCS152kE
        BIN1AiGZqULpDsY2qdBl4V8ZMvF5oAo=
X-Google-Smtp-Source: APXvYqyZAYWmFDimOod8OpC+PBqE8rktm4+RPQGg50PkqM+V0+dEq4ihEjoBM6ArbJ1MNMnqkBx5yg==
X-Received: by 2002:ac2:43b8:: with SMTP id t24mr1491132lfl.24.1568796196528;
        Wed, 18 Sep 2019 01:43:16 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.110])
        by smtp.gmail.com with ESMTPSA id i142sm887540lfi.5.2019.09.18.01.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 01:43:15 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: [RFC/PATCH] commit-graph: generation v5 (backward compatible date ceiling)
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
        <20190518015005.GA951@szeder.dev>
        <20190518035828.pjaqfrkkvldhri6v@glandium.org>
        <20190518041706.ct6ie5trvxgdhjar@glandium.org>
        <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
        <86mujhpewj.fsf@gmail.com>
        <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com>
        <86ftp9p7i8.fsf@gmail.com> <86mui63xwr.fsf@gmail.com>
        <55fad895-2c18-5a91-79b9-7b958fe280c6@gmail.com>
Date:   Wed, 18 Sep 2019 10:43:13 +0200
In-Reply-To: <55fad895-2c18-5a91-79b9-7b958fe280c6@gmail.com> (Derrick
        Stolee's message of "Tue, 25 Jun 2019 06:54:29 -0400")
Message-ID: <86o8ziatb2.fsf_-_@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 6/25/2019 3:51 AM, Jakub Narebski wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> Derrick Stolee <stolee@gmail.com> writes:
[...]
>>> O.K., so the "generation number v2 (legacy)" would be incremental and
>>> backward-compatibile in use (though not in generation and validation).
[...]
>>> Do you have benchmark for this "monotonically offset corrected commit
>>> date" generation number in https://github.com/derrickstolee/git/commits=
/reach-perf
>>> and https://github.com/derrickstolee/gen-test ?
>>=20
>> I guess this will have to wait...
>
> I have not had time to revisit this topic and re-run performance
> numbers, sorry.

I have created pull requests against `reach-perf` branch of
derrickstolee/git repository[1], and companion pull request against
gen-test repository[2] with proposed prototype of backward-compatible
corrected commit date (with monotonic offsets).

Could you please run the tests for this generation number v5?  I was not
able to do so.  It was my first time trying to compile Git on MS
Windows, and while there were no problems compiling `master` (well,
except for compilation taking a long time), I was unable to do it for
`reach-perf` branch because of independent of change compilation errors.

It would be good to test also the legacy mode, i.e. old Git (using
generation number v0, i.e. topological levels (shortest path from node
to sink, plus one) with all backward-compatible generation numbers, or
at least generation number v5.


Do I understand it correctly that for the time being because of
backward-compatibility concerns instead of incrementing the version
number there would be used some kind of "metadata" chunk (at least until
version of Git that fails hard, instead of turning off commit-graph
feature softly, on unknown version numbers dies out).  Is there some
proposal how such chunk should look like?

[1]: https://github.com/derrickstolee/git/pull/10
[2]: https://github.com/derrickstolee/gen-test/pull/1

--- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ----
From: Jakub Nar=C4=99bski <jnareb@gmail.com>
Subject: [PATCH] commit-graph: generation v5 (backward compatible date ceil=
ing)

This generation number option is backward-compatible (with
reachability index v0) version of the generation number v3, that is
the corrected commit date.  It takes the simple approach of faking
"commit dates" being in the right order by adding an offset to the
commit date (which is stored in the generation number column), so the
modified commit date is always at least one more than the maximum
modified commit date of all ancestors.  Additionally the offset itself
is adjusted in such way that the offset of a commit is always at least
one more than the offsets of all ancestors.

Two following conditions are satisfied on the offset of a commit C for
every parent P:

 1. committer_date(C) + offset(C) > committer_date(P) + offset(P)
 2. offset(C) > offset(P)

This reachability index is locally computable, which means it is
compatible with incremental commit graph feature.

It has the same problem as v3, namely that we have a "maximum clock
skew" based on the maximum generation number we can store, only more
so.

Note: it includes incidental whitespace cleanups for v3 code.

Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
Note that the diff looks a bit strange in the part adding the code for
the new compute_generation_numbers_5() subroutine, because it got
entangled in whitespace cleanup (which I shouldn't do, I'm sorry).

Relevant part of README.md from `gen-test` repository:

--------
**V5: Corrected Commit Date with Strictly Monotonic Offset.**
For a commit C, let its _offset commit date_ (denoted by odate(C))
be a commit date plus some offset, i.e. odate(C) =3D date(C) + offset(C),
such that:

1. Offset commit date is greater than the maximum of the commit date
   of C and the offset commit dates of its parents.

     If odate(A) < odate(B), then A cannot reach B.

2. Offset of a commit is one more than the maximum offset of a parent,
   or more

     If offset(A) < offset(B), then A cannot reach B.

This is backward-compatible version of V3: Corrected Commit Date.

### Comparing Reachability Index Versions Viability
[...]
| Index                     | Compatible? | Immutable? | Local? |
|---------------------------|-------------|------------|--------|
| Minimum Generation Number | Yes         | Yes        | Yes    |
| (Epoch, Date) pairs       | Yes         | Yes        | Yes    |
| Maximum Generation Number | Yes         | No         | No     |
| Corrected Commit Date     | No          | Yes        | Yes    |
| FELINE index              | Yes         | No         | No     |
| Offset Commit Date *NEW*  | Yes         | Yes        | Yes    |

_Note:_ The corrected commit date uses the generation number column
to store an offset of "how much do I need to add to my commit date
to get my corrected commit date?" The values stored in that column
are then not backwards-compatible.

_Note:_ The corrected commit date with strictly monotonic offset also
uses the generation number column to store the date offset, but the
offset alone can be used as generation number (as reachability index)
itself.


 commit-graph.c | 126 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 95 insertions(+), 31 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 91863d4895..633b4b24f8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -99,10 +99,9 @@ int compare_generations(struct generation *a, struct gen=
eration *b)
 			return 1;
 		return 0;
=20
-	case 3:
-		ta =3D a->date + a->value1;
-		tb =3D b->date + b->value1;
-
+	case 3: /* V3: Corrected Commit Date */
+	case 5: /* V5: Strictly Monotonic Corrected Commit Date */
+		/* handle special cases, i.e. commits outside commit graph */
 		if (a->value1 =3D=3D GENERATION_NUMBER_INFINITY) {
 			if (b->value1 =3D=3D GENERATION_NUMBER_INFINITY)
 				return 0;
@@ -112,6 +111,10 @@ int compare_generations(struct generation *a, struct g=
eneration *b)
 			return -1;
 		}
=20
+		/* corrected commit date =3D date + offset (correction) */
+		ta =3D a->date + a->value1;
+		tb =3D b->date + b->value1;
+
 		if (ta < tb)
 			return -1;
 		if (ta > tb)
@@ -162,6 +165,7 @@ void get_generation_version_from_commit(const struct co=
mmit *c,
=20
 		case 1:
 		case 3:
+		case 5:
 			gen->value1 =3D c->generation;
 			gen->date =3D c->date;
 			break;
@@ -212,9 +216,10 @@ void set_generation_below_commit(const struct commit *=
c, struct generation *g)
 			break;
=20
 		case 3:
+		case 5: /* ??? */
 			if (g->value1 + g->date >=3D gc.value1 + gc.date) {
 				g->value1 =3D 0;
-				g->date =3D gc.value1 + gc.date;=09=09=09
+				g->date =3D gc.value1 + gc.date;
 			}
 			break;
=20
@@ -363,7 +368,7 @@ struct commit_graph *load_commit_graph_one(const char *=
graph_file)
 			else
 				graph->chunk_large_edges =3D data + chunk_offset;
 			break;
-=09=09
+
 		case GRAPH_CHUNKID_FELINE:
 			if (graph->chunk_feline_gen)
 				chunk_repeated =3D 1;
@@ -971,27 +976,27 @@ static void compute_generation_numbers_3(struct packe=
d_commit_list *commits)
 	int i;
 	struct commit_list *list =3D NULL;
=20
-        for (i =3D 0; i < commits->nr; i++) {
-                if (commits->list[i]->generation !=3D GENERATION_NUMBER_IN=
FINITY &&
-                    commits->list[i]->generation !=3D GENERATION_NUMBER_ZE=
RO)
-                        continue;
+	for (i =3D 0; i < commits->nr; i++) {
+		if (commits->list[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
+			commits->list[i]->generation !=3D GENERATION_NUMBER_ZERO)
+			continue;
=20
-                commit_list_insert(commits->list[i], &list);
+		commit_list_insert(commits->list[i], &list);
=20
-                while (list) {
-                        struct commit *current =3D list->item;
-                        struct commit_list *parent;
-                        int all_parents_computed =3D 1;
+		while (list) {
+			struct commit *current =3D list->item;
+			struct commit_list *parent;
+			int all_parents_computed =3D 1;
=20
-                        timestamp_t max_timestamp =3D current->date;
+			timestamp_t max_timestamp =3D current->date;
=20
-                        for (parent =3D current->parents; parent; parent =
=3D parent->next) {
-                                if (parent->item->generation =3D=3D GENERA=
TION_NUMBER_INFINITY ||
-                                    parent->item->generation =3D=3D GENERA=
TION_NUMBER_ZERO) {
-                                        all_parents_computed =3D 0;
-                                        commit_list_insert(parent->item, &=
list);
-                                        break;
-                                } else {
+			for (parent =3D current->parents; parent; parent =3D parent->next) {
+				if (parent->item->generation =3D=3D GENERATION_NUMBER_INFINITY ||
+					parent->item->generation =3D=3D GENERATION_NUMBER_ZERO) {
+					all_parents_computed =3D 0;
+					commit_list_insert(parent->item, &list);
+					break;
+				} else {
 					struct generation pg;
 					timestamp_t pt;
 					get_generation_version_from_commit(parent->item, 3, &pg);
@@ -1001,19 +1006,75 @@ static void compute_generation_numbers_3(struct pac=
ked_commit_list *commits)
 					if (pt > max_timestamp)
 						max_timestamp =3D pt + 1;
 				}
-                        }
+			}
+
+			if (all_parents_computed) {
+				current->generation =3D (uint32_t)(max_timestamp - current->date) + 1;
+				pop_commit(&list);
+
+				if (current->generation > GENERATION_NUMBER_MAX)
+					die(_("generation number gap is too high!"));
+			}
+		}
+	}
+}
+
+static void compute_generation_numbers_5(struct packed_commit_list *commit=
s)
+{
+	int i;
+	struct commit_list *list =3D NULL;
+
+	for (i =3D 0; i < commits->nr; i++) {
+		/* skip already computed generation numbers */
+		if (commits->list[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
+			commits->list[i]->generation !=3D GENERATION_NUMBER_ZERO)
+			continue;
+
+		commit_list_insert(commits->list[i], &list);
+
+		while (list) {
+			struct commit *current =3D list->item;
+			struct commit_list *parent;
+			int all_parents_computed =3D 1;
+
+			timestamp_t max_timestamp =3D current->date;
+			uint32_t max_generation =3D 0;
+
+			for (parent =3D current->parents; parent; parent =3D parent->next) {
+				if (parent->item->generation =3D=3D GENERATION_NUMBER_INFINITY ||
+				    parent->item->generation =3D=3D GENERATION_NUMBER_ZERO) {
+					all_parents_computed =3D 0;
+					commit_list_insert(parent->item, &list);
+					break;
+
+				} else {
+					struct generation pg;
+					timestamp_t pt;
+					get_generation_version_from_commit(parent->item, 5, &pg);
+
+					pt =3D pg.value1 + pg.date;
+
+					if (pt > max_timestamp)
+						max_timestamp =3D pt + 1;
+					if (pg.value1 > max_generation)
+						max_generation =3D pg.value1;
+				}
+			}
=20
-                        if (all_parents_computed) {
+			if (all_parents_computed) {
 				current->generation =3D (uint32_t)(max_timestamp - current->date) + 1;
-                                pop_commit(&list);
+				if (current->generation < max_generation + 1)
+					current->generation =3D max_generation + 1;
+				pop_commit(&list);
=20
-                                if (current->generation > GENERATION_NUMBE=
R_MAX)
-                                        die(_("generation number gap is to=
o high!"));
-                        }
-                }
-        }
+				if (current->generation > GENERATION_NUMBER_MAX)
+					die(_("generation number gap is too high!"));
+			}
+		}
+	}
 }
=20
+
 static void compute_generation_numbers(struct packed_commit_list *commits,
 				       int generation_version)
 {
@@ -1038,6 +1099,9 @@ static void compute_generation_numbers(struct packed_=
commit_list *commits,
 	case 4:
 		/* compute at write time */
 		return;
+	case 5:
+		compute_generation_numbers_5(commits);
+		return;
 	}
 }
=20
--=20
2.23.0.windows.1
