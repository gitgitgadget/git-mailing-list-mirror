Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BF3C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2782071A
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AeVmUf7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgJaMqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 08:46:13 -0400
Received: from mout.web.de ([217.72.192.78]:43037 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgJaMqN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 08:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604148369;
        bh=lktd1FNNjHP8W+MMQh7G02IaZ8uiB45UB07YMxt9Uxo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=AeVmUf7pV3agGHOpaQN1tZW3lHleusydujXmTn5vetwEL/E9TnItTgaAAYExVPl6/
         BlPBgu/QwcQ4EvUB9ESiBHoyOxjEvSBNITok6JK27YBXgV47j4HjzpPbP72dvOjOfW
         ecydqv3BoI6LpZ54GbF6PhnJw3F1nER0eXVsCUM0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6K1b-1kJFKi1Dmj-016g7z; Sat, 31
 Oct 2020 13:46:09 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 1/2] object: allow clear_commit_marks_all to handle any
 repo
Message-ID: <eaefaf80-d2da-7bd0-a85f-00dfd46b7754@web.de>
Date:   Sat, 31 Oct 2020 13:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mmT/ugrJWs1aoE4BJYsmmvrR1wSALbf246wXkCgqA9IoeyPV+1G
 q0dPhmh04B6X43dx35IQ9mWtKgQ/Zmp4IzM+pZEIP4gwMvI6QtJB4TKhuypcr0b+QnSnzeN
 +83pC3lf1Rnf+/zYbjLrEvkQaingA4CdEY6V8ZxJfRoAREJDa9vYOGob5y15I6sXGNBpwLX
 Z9K7evx06k2Fp0o/IDicQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qnHV1jrbGt4=:qG+G2KjfHseEGiCLCq/zMs
 LadFW6nJ3kS+YRRk8w3wgJ9rCF5WHrGLhAVHYPP2CLkAoVULMNIBoX/D963/AFKWvZAMcpg1o
 nrzlnFGkMC/z/t68cbp1XLw/MIDVnNKlt9oPTD4c/kzZdWjMVKQgI6kum03HA3JMwCRCAR4pG
 dqxNOA9IYNC2/cFO7/iChlApHgclUS7kTpAbAz+KK2drlrus3368n/M9CvHcaaTFsXJhMmWCd
 BJgKLm6hnCuVbJtD9Hcj1NuwR1YHP9BbXZ9dq40cDjSPyXEQ4sySAU2gN6/omZiqppUttyxHr
 TxsoQK13AUI5Jp572QGAgaqDpCbHenVLcVfNY5Trj/mxv1a+CNLCNjLmBeMsYhcC/OlqH4FXI
 I16pcvOVM3BFY6kZhfLVnucEL4zpFMWNgcZVc9Q6F5jQZPJZBsqb3T7fgWyQbPbDJiOz1hypI
 todIMm6Ez1H0DbheHYVzbjdOD2pWTpAWhjbyihOyxGF8pymlNdhigJ6BNg843kv7xHpwOslGu
 Y/s0TzOIVYqzcC4rruT7WII82QrBWCHFuk8BzEFAvPRkbpW0Z7uJEGGvwjYa79XKZPu9YKPGI
 uAJKP8jQmi5dBEuR6jjG8tKWuJkRZqsKuWGeeSaV9QanQYn10K1GWxwMXoKKHM9P6cE/wgoJ3
 0Bd8Z87B7RIeh8JFfoUVzgMF66aU4L/YOpvqv/NybrqjUBp9ykxPjTT/gyBYAwfe3XEHwWWsK
 jzZ3iI7HVlnEjMOQUM9zVQQ2qGhevWxQ4T5KvQI3mv3JQTAZRaoGHAz5DRj5HZqellhmtBGVF
 rx0o5ZbCBWSlp/AfHRTnROKIjh0cd6dwGsR69RQBp8DCfdwbZ/QiWDn4cUD9dA3Lvj+YlGcAG
 hcValqRml/NzyiHl8RZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow callers to specify the repository to use.  Rename the function to
repo_clear_commit_marks to document its new scope.  No functional change
intended.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes from v1: Renamed the function; the "_all" part became misleading
when it became possible to represent multiple repositories, but the
function was still only operating on one of them.

 bisect.c           | 2 +-
 builtin/checkout.c | 2 +-
 builtin/gc.c       | 2 +-
 object.c           | 6 +++---
 object.h           | 5 +++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index f5b1368128..3b763dab6b 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -1090,7 +1090,7 @@ enum bisect_error bisect_next_all(struct repository =
*r, const char *prefix)
 		  nr), nr, steps_msg);
 	free(steps_msg);
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_all(ALL_REV_FLAGS);
+	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);

 	return bisect_checkout(bisect_rev, no_checkout);
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7c311cecb3..9b82119129 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1042,7 +1042,7 @@ static void orphaned_commit_warning(struct commit *o=
ld_commit, struct commit *ne
 		describe_detached_head(_("Previous HEAD position was"), old_commit);

 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_all(ALL_REV_FLAGS);
+	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
 }

 static int switch_branches(const struct checkout_opts *opts,
diff --git a/builtin/gc.c b/builtin/gc.c
index 2b99596ec8..4ff1894810 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -788,7 +788,7 @@ static int should_write_commit_graph(void)

 	result =3D for_each_ref(dfs_on_ref, &data);

-	clear_commit_marks_all(SEEN);
+	repo_clear_commit_marks(the_repository, SEEN);

 	return result;
 }
diff --git a/object.c b/object.c
index 3257518656..05544bc92b 100644
=2D-- a/object.c
+++ b/object.c
@@ -453,12 +453,12 @@ void clear_object_flags(unsigned flags)
 	}
 }

-void clear_commit_marks_all(unsigned int flags)
+void repo_clear_commit_marks(struct repository *r, unsigned int flags)
 {
 	int i;

-	for (i =3D 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
-		struct object *obj =3D the_repository->parsed_objects->obj_hash[i];
+	for (i =3D 0; i < r->parsed_objects->obj_hash_size; i++) {
+		struct object *obj =3D r->parsed_objects->obj_hash[i];
 		if (obj && obj->type =3D=3D OBJ_COMMIT)
 			obj->flags &=3D ~flags;
 	}
diff --git a/object.h b/object.h
index 20b18805f0..59daadce21 100644
=2D-- a/object.h
+++ b/object.h
@@ -191,8 +191,9 @@ void object_array_clear(struct object_array *array);
 void clear_object_flags(unsigned flags);

 /*
- * Clear the specified object flags from all in-core commit objects.
+ * Clear the specified object flags from all in-core commit objects from
+ * the specified repository.
  */
-void clear_commit_marks_all(unsigned int flags);
+void repo_clear_commit_marks(struct repository *r, unsigned int flags);

 #endif /* OBJECT_H */
=2D-
2.29.2

