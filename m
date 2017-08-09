Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D831F991
	for <e@80x24.org>; Wed,  9 Aug 2017 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbdHIPy7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 11:54:59 -0400
Received: from mout.web.de ([212.227.17.12]:56689 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbdHIPy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 11:54:59 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRnJ-1dH5w90Ooz-00p0h1; Wed, 09
 Aug 2017 17:54:48 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] apply: remove prefix_length member from apply_state
Message-ID: <24fb9d9c-0b1c-4aaa-7d89-12d322066cff@web.de>
Date:   Wed, 9 Aug 2017 17:54:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:y3SZ1RSN9WFZF57ehhLOLfqXmOWK0iWuqSd6cQv71VXTlR2ydpm
 6yFbq96Rdn5T3xp6bkT4AmKUrz8y1fRKG+PZnb3dqPHOgrpGmKXuEzucSxo922SPwMOlKvt
 gCyjKdnb6pPqpnRbKSD4uDOpQ4s7nhq0HfDSLVI3KO1fm0XTAmu6KkGmU5lcOuxeDQZmzpr
 JHESn8i3Z5OCkUb5qP0eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uO/Y1QFfzhs=:S4bg0gow+u8KlZAHyvJazZ
 5l+VADR92uxfUy297kp6+6HtEISb1bdDj2tEYwqNrGGUn+anP5F4euE8ppvs+RYTXXe9ZG3F8
 4KCeG6K0b95qjNbs8YyH1iIpcxHygp3ifBtQ5XAsjlOJ1d0gJN9qlWpo992XoPHxQPB7lkDVp
 s1TOJtJ+VTcFIM8KhShM/gbELZisSHcDYJFjvbNAj2UyFq/5lzOwmLuMLA1FAL9eyNpwUK6zZ
 UKB/GJhDu50g5vUfTvJjqnTGFSi2T7l1I6Zyb2FdzBac8/2fADAe+0W8yC0zVXCiNK7+oGnF9
 m17GZRimvbTCfZ7J8YsGUC9GP5qH1gTbbTKv4t8aT/qJ0DTeSDDkEa4crGC+WrSfeWeL+/k02
 ObsfnjybZfMVdB66cFlmY+BX0DNX3R9PUcp1xnt4gRRY5N4TFh4uWCCzjo4rcpADP4yZ1vwGH
 dLvessSh5UC+IB6pO0GCh3hfTmL5hugiP807eIQbxgKuPmOBwuLS46XDpoGnEh2xuzX0M3c94
 fklAgMQ4Ew4klUxP5qZLkfdEpgRfyuw78xshZMYGpPV+Eu4Z5G2tVbb+u/VdnJSfkRA6SQjRR
 AljoJoDvW29NKVnOWFhuevn48yUFd4Tw5YeI/Bk6p/ljCznUMdPvzlOARkvBiB9CzYKQw0Q6m
 4HuV9JFEoa4X+L3UYUuhPHfUsdnF5zSifOBZ/KSEHFL2KERrUdULXTQgLcYYtLrVH5oLu9S54
 6qWBok+1ykPFewp1JYfC8lgsiQFRqr5cQ4R0iDIjxFZ17oP124QIIlljhYT2HzXrbAHSlKsSY
 6fygC1E98nZwBzHiPtN4NB5ByB2E3+fa51LdVBCzEYldY7aRk8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a NULL-and-NUL check to see if we have a prefix and consistently use
C string functions on it instead of storing its length in a member of
struct apply_state.  This avoids strlen() calls and simplifies the code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c | 12 +++++-------
 apply.h |  1 -
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 970bed6d41..168dfe3d16 100644
--- a/apply.c
+++ b/apply.c
@@ -80,7 +80,6 @@ int init_apply_state(struct apply_state *state,
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
-	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->lock_file = lock_file;
 	state->newfd = -1;
 	state->apply = 1;
@@ -786,11 +785,11 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
 		 * Does it begin with "a/$our-prefix" and such?  Then this is
 		 * very likely to apply to our directory.
 		 */
-		if (!strncmp(name, state->prefix, state->prefix_length))
+		if (starts_with(name, state->prefix))
 			val = count_slashes(state->prefix);
 		else {
 			cp++;
-			if (!strncmp(cp, state->prefix, state->prefix_length))
+			if (starts_with(cp, state->prefix))
 				val = count_slashes(state->prefix) + 1;
 		}
 	}
@@ -2088,10 +2087,9 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	int i;
 
 	/* Paths outside are not touched regardless of "--include" */
-	if (0 < state->prefix_length) {
-		int pathlen = strlen(pathname);
-		if (pathlen <= state->prefix_length ||
-		    memcmp(state->prefix, pathname, state->prefix_length))
+	if (state->prefix && *state->prefix) {
+		const char *rest;
+		if (!skip_prefix(pathname, state->prefix, &rest) || !*rest)
 			return 0;
 	}
 
diff --git a/apply.h b/apply.h
index b3d6783d55..d9b3957703 100644
--- a/apply.h
+++ b/apply.h
@@ -35,7 +35,6 @@ enum apply_verbosity {
 
 struct apply_state {
 	const char *prefix;
-	int prefix_length;
 
 	/* These are lock_file related */
 	struct lock_file *lock_file;
-- 
2.14.0
