Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480A01F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbeHPF0e (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:34 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:34635 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:34 -0400
Received: by mail-io0-f202.google.com with SMTP id f9-v6so2807698ioh.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=7IB5yAFTJfCW/ZcTFwbJ2Uz8NxgQxTExGHx+DCdLJXY=;
        b=dGz1rOCmjQrLe3F6nOoFnfqolsYtsilSARFFEUc5njq/ZBnNNlfjMvoGomRKAETwBU
         6hWGOMav2RlI54ec23naCWzDjukPJrxeTboXV98sJy9YhBNpvmYeDsSZZybMogc4lHHT
         x/wSWg7OfTA+aBDVlx/kt0mbMKOEUlxq6WnnEyS/HlrpTmtg+ABYCqcubo/WdomjhGxC
         gevEoyqRAw/jxIEGmqByeZ1vCKulEFGolvkR85KKQc3+Ou8Epr9C0XGtq6Ygyzmk65Ln
         LTXuiESqyZHuIWvmV5kM/lEqHGk71r4wg2BjqT7qHxYdFUH+DUH+EDPokWaGXNIDa5fg
         1Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=7IB5yAFTJfCW/ZcTFwbJ2Uz8NxgQxTExGHx+DCdLJXY=;
        b=tJASlmrjO1CIddP//kMx/RWnzHp7BKQFWqSG2wa8sZaFySjBPwuoOmxH7fw2aDXFhm
         P5zXrkzgPLvmuYHKD4TsuBKLweyL0H+YLwcUuuhhbl7E1EhAcvKggThOaFeQVVUWaww4
         J2vJIPBy0lUXWwO73k0gwByeEaH5jheSeP9bUrH8Op3YVrZ8sO6kL0PLZq4uUkUnIZox
         eKQ7fw4BuGqT/2Oq7RfvN1lQc7/2DF4fYgHEGVyD9GYkGhYz1wLUGO7ike9jRIP0Du/U
         uAsQHULPPkRinHU3WT3znDUHZse3iNI48r/a7xDAH+Y+ZdrKs4hVrbLxCV+1L34yEiEl
         Y2gA==
X-Gm-Message-State: AOUpUlFZpQSPJIp26o+CG9AIStywKToOqxw4SlISeNICBzysEXoooJ6k
        VVrb11SYtN0YLLHGbFRXG6ASXuz6N3n5G2Us4aOT6OUkMSExzeaOyEXAdyv1a7WTVLkUpiOG4Sm
        FHhpIyqiBhzofa8mwDszaNZQSdDPiiBfINXOhECAd2HufUngXxGTnjBKtAt0s
X-Google-Smtp-Source: AA+uWPynIK9iH9pwy4eK5w2I2EnRovpUYeYCuqZbz4mZl/RnK1vtQn27atUA9twc2/ejz7cvLeDJDDP1Zfcb
MIME-Version: 1.0
X-Received: by 2002:a24:4198:: with SMTP id b24-v6mr11406698itd.34.1534386686242;
 Wed, 15 Aug 2018 19:31:26 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:30:59 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com>
Message-Id: <20180816023100.161626-7-sbeller@google.com>
References: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 6/7] submodule--helper, update_clone: store index to
 update_clone instead of ce
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In update_submodules, we use the run_processes_parallel(get_task, finished)
API, which allows to pass around a task specific callback cookie from the
get_next function to the finish function. That finish function in turn may
alter generic callback cookie to have the next call of get_task come up
with another new task.

Up to now we passed around the index into a list of cache entries,
which was stored in the generic callback cookie which is a struct
submodule_update_clone.

Change this to an index into 'update_clone' array, which is the potential
output of this helper. This will allow for a future change to make
use of the data the update_clone_data struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1c9a12781fd..36de64902ec 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1511,8 +1511,10 @@ static int module_update_module_mode(int argc, const char **argv, const char *pr
 
 struct update_clone_data {
 	const struct submodule *sub;
+	const struct cache_entry *ce;
 	struct object_id oid;
 	unsigned just_cloned;
+	unsigned retried;
 };
 
 struct submodule_update_clone {
@@ -1541,8 +1543,8 @@ struct submodule_update_clone {
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
 
-	/* failed clones to be retried again */
-	const struct cache_entry **failed_clones;
+	/* failed clones to be retried again, indexes into update_clone */
+	int *failed_clones;
 	int failed_clones_nr, failed_clones_alloc;
 
 	int max_jobs;
@@ -1649,6 +1651,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	oidcpy(&suc->update_clone[suc->update_clone_nr].oid, &ce->oid);
 	suc->update_clone[suc->update_clone_nr].just_cloned = needs_cloning;
 	suc->update_clone[suc->update_clone_nr].sub = sub;
+	suc->update_clone[suc->update_clone_nr].retried = 0;
+	suc->update_clone[suc->update_clone_nr].ce = ce;
 	suc->update_clone_nr++;
 
 	if (!needs_cloning)
@@ -1707,7 +1711,8 @@ static int update_clone_get_next_task(struct child_process *child,
 	for (; suc->current < suc->list.nr; suc->current++) {
 		ce = suc->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
-			*idx_task_cb = update_clone_alloc_cb(suc->current);
+			*idx_task_cb = update_clone_alloc_cb(
+				suc->update_clone_nr - 1);
 			suc->current++;
 			return 1;
 		}
@@ -1720,7 +1725,9 @@ static int update_clone_get_next_task(struct child_process *child,
 	 */
 	index = suc->current - suc->list.nr;
 	if (index < suc->failed_clones_nr) {
-		ce = suc->failed_clones[index];
+		int ucd_index = suc->failed_clones[index];
+		struct update_clone_data *ucd = &suc->update_clone[ucd_index];
+		ce = ucd->ce;
 		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			suc->current ++;
 			strbuf_addstr(err, "BUG: submodule considered for "
@@ -1728,7 +1735,7 @@ static int update_clone_get_next_task(struct child_process *child,
 					   "any more?\n");
 			return 0;
 		}
-		*idx_task_cb = update_clone_alloc_cb(suc->current);
+		*idx_task_cb = update_clone_alloc_cb(ucd_index);
 		suc->current ++;
 		return 1;
 	}
@@ -1750,31 +1757,31 @@ static int update_clone_task_finished(int result,
 				      void *suc_cb,
 				      void *idx_task_cb)
 {
-	const struct cache_entry *ce;
 	struct submodule_update_clone *suc = suc_cb;
+	struct update_clone_data *ucd;
 
 	int *idxP = idx_task_cb;
 	int idx = *idxP;
+	ucd = &suc->update_clone[idx];
 	free(idxP);
 
 	if (!result)
 		return 0;
 
-	if (idx < suc->list.nr) {
-		ce  = suc->list.entries[idx];
+	if (!ucd->retried) {
+		ucd->retried = 1;
 		strbuf_addf(err, _("Failed to clone '%s'. Retry scheduled"),
-			    ce->name);
+			    ucd->ce->name);
 		strbuf_addch(err, '\n');
 		ALLOC_GROW(suc->failed_clones,
 			   suc->failed_clones_nr + 1,
 			   suc->failed_clones_alloc);
-		suc->failed_clones[suc->failed_clones_nr++] = ce;
+		suc->failed_clones[suc->failed_clones_nr++] = idx;
 		return 0;
 	} else {
 		idx -= suc->list.nr;
-		ce  = suc->failed_clones[idx];
 		strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
-			    ce->name);
+			    ucd->ce->name);
 		strbuf_addch(err, '\n');
 		suc->quickstop = 1;
 		return 1;
-- 
2.18.0.265.g16de1b435c9.dirty

