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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC9B1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 11:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfHGLPN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 07:15:13 -0400
Received: from mout.web.de ([212.227.15.14]:56651 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbfHGLPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 07:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565176503;
        bh=OEafdTQ1cE0xCTbzvJGXhXOAv0z7ngxvqhQHA/SvqUI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=nlTNnN601EMdYuc53wLsLpFGtr+U/qzacwHBJg/39N7h/rNrcvKcUISegjNuH6Njx
         IDzQZrkvEYgattnq+lFdHes1lvqnqgmIwwV591AuTaG4FcYIRxWKs0zhyh2rYCPuQS
         3wlenAiqaDragJvQj/WUUVGxbSw5eaZD/LX5VHHc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGzFy-1i7uoX1ykc-00Do8a; Wed, 07
 Aug 2019 13:15:03 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit-graph: release strbufs after use
Message-ID: <c3be25bf-6487-52ce-217d-d6ee93b3a16f@web.de>
Date:   Wed, 7 Aug 2019 13:15:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mYKR2rEnD/jeGLZvVg6GJ6pRGamJadfB7sf+NKWrA+4Z5Tp5mx4
 D0TIL89Tj4dMVgAIqdeShsQlaYm0alEbas1NR0BuH3BbVlwtoaeyI0W+Fh+e/F08J98J5pJ
 lP9Sg06eDUkc8cdzdKfabOk3wMZq9ymhQ+Tou9QdAvZHHHLBOZhSbohSlLCfSKvfsZ13QZC
 6gxiZgEsf9+z8qw+oG29Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XOoiyoX2ieU=:p9T6ROwWWO1jy6mAz11FCK
 b8dQuyrDoHhOn12dpMLVJ5Kj3t6H7PQXxnkW6pBxRNbZ0U3qJeetQoG7kHJPqmKzlkYJxqWHA
 xt85b8C1Bx4e+K7GbChFVfmmXmL3QD9Swv4a3CNzD68VVhTNPESfJQ3P57R1hcsf83BIxXUxA
 txpn0XymULBFFBfQZ5aRs2DnqoWPgEaY+++5jznZ/+A6iN+1EpCqYDaa+20jOAIzgx29oP5IK
 G9Y4eUw5p6cmXbORnhwgjctS9yequfoLjlFmH6vdc0/KTOyO3JzrTYV9lzedcppT4teEFCCjC
 wwWpo8CYw/tvbHwhcAf6vZbzolvtGUQI94NlMthZj81lvAkoN9K+DxK41l/iwsKOr0s6FZq3U
 8ZM3iueJgJHkDGHiV5jQDBKCBqPImzUNG7ygeeE3Kypa1V2Tfz3yatby/10+a7QjhfM7UcbXW
 s6cSwKoD3j5RsYm0bKTp8na2NomL2ihsy065KP7XGRQhoakKLZRbQzm7xhD6W8qO6NC72D/fp
 PjhbU94NFEjqSkZnWB4sbDHl9qtXNE0CVS7Tze1AooXcxoCGWkEB6QUiYxI1B+rYM1PAdCcE2
 51tm4pA6VF1la5b8qvXFe2BrD3cV9/G7D+KlxT6TJS06roQoSmLEJDXQXeXv2qVHYy/1pu2AR
 JFZU6ERMYYOlXGDJbKirchjuZrXJzcDzvLpLpETzW1y8mE5q26WFP4nv4X4HUbRU1VM/XEPVs
 pY8yv9ekJWEzpZ+rZn5j05g3WQA0D/9mg8jVki9tsj4RiAxfHSwgHKxXaGMPXmGFnBwRIuaAc
 dH4vczJG+qojrEMwa29FRUedBCTSNgu0qlUDsTlzH8JUiLMB2yaIMARJujcHgjYRNiCTxXzOd
 w5btvdsHi4V7mSAMxbbsDNn49ugWRkAHyFQLibygDH1yFUtnhWi+p65/vc46l0Yh5g1kAyKE/
 ylEaR4CEVLMEZ3fO1b8rYl/CKFcqeBnawfqwyPmLATeMlLf6YNL+6aa3H7+Yaw7ZZplDHI7e5
 vhX/aCyp/uXv2/EkRv2jHogd5tiMFucN5AC+UVz3D6Is16pBu8FbCGD0Z07kik96MhGMPMDnR
 UQJKbyfdi64BDB80GwNzbafHA1zZb0Uj4coPEJEOj3WZcwJ/JbrQMV1MeKx3/lkkRZwh/zNvh
 PiYmI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier review.  That makes
it look a lot bigger than it actually is, though.

The plugged leaks were added after v2.22.0 (2019-06-07) by the following
commits:

5c84b3396c 2019-06-18 commit-graph: load commit-graph chains
ef5b83f2cf 2019-06-12 commit-graph: extract fill_oids_from_packs()
8d84097f96 2019-06-18 commit-graph: expire commit-graph files

 commit-graph.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b3c4de79b6..680c549f0f 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -372,68 +372,69 @@ static int add_graph_to_chain(struct commit_graph *g=
,
 static struct commit_graph *load_commit_graph_chain(struct repository *r,=
 const char *obj_dir)
 {
 	struct commit_graph *graph_chain =3D NULL;
 	struct strbuf line =3D STRBUF_INIT;
 	struct stat st;
 	struct object_id *oids;
 	int i =3D 0, valid =3D 1, count;
 	char *chain_name =3D get_chain_filename(obj_dir);
 	FILE *fp;
 	int stat_res;

 	fp =3D fopen(chain_name, "r");
 	stat_res =3D stat(chain_name, &st);
 	free(chain_name);

 	if (!fp ||
 	    stat_res ||
 	    st.st_size <=3D the_hash_algo->hexsz)
 		return NULL;

 	count =3D st.st_size / (the_hash_algo->hexsz + 1);
 	oids =3D xcalloc(count, sizeof(struct object_id));

 	prepare_alt_odb(r);

 	for (i =3D 0; i < count; i++) {
 		struct object_directory *odb;

 		if (strbuf_getline_lf(&line, fp) =3D=3D EOF)
 			break;

 		if (get_oid_hex(line.buf, &oids[i])) {
 			warning(_("invalid commit-graph chain: line '%s' not a hash"),
 				line.buf);
 			valid =3D 0;
 			break;
 		}

 		valid =3D 0;
 		for (odb =3D r->objects->odb; odb; odb =3D odb->next) {
 			char *graph_name =3D get_split_graph_filename(odb->path, line.buf);
 			struct commit_graph *g =3D load_commit_graph_one(graph_name);

 			free(graph_name);

 			if (g) {
 				g->obj_dir =3D odb->path;

 				if (add_graph_to_chain(g, graph_chain, oids, i)) {
 					graph_chain =3D g;
 					valid =3D 1;
 				}

 				break;
 			}
 		}

 		if (!valid) {
 			warning(_("unable to find all commit-graph files"));
 			break;
 		}
 	}

 	free(oids);
 	fclose(fp);
+	strbuf_release(&line);

 	return graph_chain;
 }
@@ -1150,44 +1151,44 @@ int write_commit_graph_reachable(const char *obj_d=
ir, unsigned int flags,
 static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 				struct string_list *pack_indexes)
 {
 	uint32_t i;
 	struct strbuf progress_title =3D STRBUF_INIT;
 	struct strbuf packname =3D STRBUF_INIT;
 	int dirlen;

 	strbuf_addf(&packname, "%s/pack/", ctx->obj_dir);
 	dirlen =3D packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
 			    Q_("Finding commits for commit graph in %d pack",
 			       "Finding commits for commit graph in %d packs",
 			       pack_indexes->nr),
 			    pack_indexes->nr);
 		ctx->progress =3D start_delayed_progress(progress_title.buf, 0);
 		ctx->progress_done =3D 0;
 	}
 	for (i =3D 0; i < pack_indexes->nr; i++) {
 		struct packed_git *p;
 		strbuf_setlen(&packname, dirlen);
 		strbuf_addstr(&packname, pack_indexes->items[i].string);
 		p =3D add_packed_git(packname.buf, packname.len, 1);
 		if (!p) {
 			error(_("error adding pack %s"), packname.buf);
 			return -1;
 		}
 		if (open_pack_index(p)) {
 			error(_("error opening index for %s"), packname.buf);
 			return -1;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,
 					FOR_EACH_OBJECT_PACK_ORDER);
 		close_pack(p);
 		free(p);
 	}

 	stop_progress(&ctx->progress);
-	strbuf_reset(&progress_title);
+	strbuf_release(&progress_title);
 	strbuf_release(&packname);

 	return 0;
 }
@@ -1695,56 +1696,57 @@ static void mark_commit_graphs(struct write_commit=
_graph_context *ctx)
 static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 {
 	struct strbuf path =3D STRBUF_INIT;
 	DIR *dir;
 	struct dirent *de;
 	size_t dirnamelen;
 	timestamp_t expire_time =3D time(NULL);

 	if (ctx->split_opts && ctx->split_opts->expire_time)
 		expire_time -=3D ctx->split_opts->expire_time;
 	if (!ctx->split) {
 		char *chain_file_name =3D get_chain_filename(ctx->obj_dir);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after =3D 0;
 	}

 	strbuf_addstr(&path, ctx->obj_dir);
 	strbuf_addstr(&path, "/info/commit-graphs");
 	dir =3D opendir(path.buf);

-	if (!dir) {
-		strbuf_release(&path);
-		return;
-	}
+	if (!dir)
+		goto out;

 	strbuf_addch(&path, '/');
 	dirnamelen =3D path.len;
 	while ((de =3D readdir(dir)) !=3D NULL) {
 		struct stat st;
 		uint32_t i, found =3D 0;

 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);

 		stat(path.buf, &st);

 		if (st.st_mtime > expire_time)
 			continue;
 		if (path.len < 6 || strcmp(path.buf + path.len - 6, ".graph"))
 			continue;

 		for (i =3D 0; i < ctx->num_commit_graphs_after; i++) {
 			if (!strcmp(ctx->commit_graph_filenames_after[i],
 				    path.buf)) {
 				found =3D 1;
 				break;
 			}
 		}

 		if (!found)
 			unlink(path.buf);
 	}
+
+out:
+	strbuf_release(&path);
 }

 int write_commit_graph(const char *obj_dir,
=2D-
2.22.0
