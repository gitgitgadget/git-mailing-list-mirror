Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60593C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 14:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbiHROv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343719AbiHROvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 10:51:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B6FBCC10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:51:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so1050513wmb.4
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=kmqs9MUg25Bhjpr9RT1uKn46c/tW31vCxlFwFJMVokw=;
        b=NLu6Zz8E/0RJKAcRxDsmPHYYsbT/W9mtelC6fvKxZfOJiZ89WmI1BBO4ws/ESvvzEp
         IRYgrXu6qml3Lb0GGRqI7kFtxlZ6HL1f9nnBQQzdxwE2CMguXi2X2rqjIY4TyphYJ1Dd
         9lNhq+m8/yr8/k0gSRdhnxdu/XMDN0ksJVq5GAFspYmhKPN4A017ZaPzn1XsH6nW3WM+
         EwkmSPste/9IQnZjY0iZRWJ8ZLyGte1suq1E0oVLfHX7JO6UFwA4aMuCZHZwhR31lU0I
         oPkcTQSAEFrTDgIp0LfLzi6FmKjE9uE13QYO6imZjmcJByn5BpeKHIgNhYoyMGLUeGh9
         hbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kmqs9MUg25Bhjpr9RT1uKn46c/tW31vCxlFwFJMVokw=;
        b=OXQpAdO/yIIWLCiellnWCkgU2aEALWP2WOhcVqu0e0XL0vgadSGIBEdJNmk7GlOthH
         +FAajhlYjvX8rdn86jnDGFZLbZFve0+AxJ7uU+8rQvWSGM1Tuy70kAHu0uxzfOaRWlb/
         d9xtX6V/Z231L0L61qoSBSSpFSmT1b5HUvbDjXbnIXvh5I+C8QiW59gWj1gvcdxnawZz
         1AGYlJTelRP6/olf2GPowjHSd0xIRfBlghk8DHghWwdiJqMKDxbkFhtlthURU/OEZUDp
         oTk58LZkokpnqo0jQDpcmsfv2O+jHQDQnZtBXmThf0wpyQbIXhHpTo5e2lmFF0jCtPOP
         T51A==
X-Gm-Message-State: ACgBeo26QUfFEJ6aaUpNrTdEFwSGI5ajQM9X8zUv8EI/zhNN1xOvBsGw
        PFnR9wpIgORDUQvNxwdrrifb1rOsn9vDbA==
X-Google-Smtp-Source: AA6agR6+0krp7FU/hhsE7U96ZdhmEJI3xmjuD4VdLGI6huEIqLyX5eyfiKLd/HFrdq2wLxA0DN04zQ==
X-Received: by 2002:a1c:2981:0:b0:3a2:ffe9:945c with SMTP id p123-20020a1c2981000000b003a2ffe9945cmr5392524wmp.38.1660834281605;
        Thu, 18 Aug 2022 07:51:21 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id y3-20020adfee03000000b0021efc75914esm1570181wrn.79.2022.08.18.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:51:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOgrd-000Gwc-0P;
        Thu, 18 Aug 2022 16:51:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
Date:   Thu, 18 Aug 2022 16:43:20 +0200
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220809185429.20098-9-alban.gruin@gmail.com>
Message-ID: <220818.864jy9a9lm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 09 2022, Alban Gruin wrote:

> +int merge_strategies_resolve(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,
> +			     struct commit_list *remote);

It would be very nice to have this prototype declared as a:

	typedef int (*merge_strategy_fn_t)(...);

Or whatever, so that when you later use this in 12/14. Then the end
state of this series could have this on top:
	
	diff --git a/merge-strategies.h b/merge-strategies.h
	index 8de2249ee6b..79b828105ba 100644
	--- a/merge-strategies.h
	+++ b/merge-strategies.h
	@@ -29,6 +29,9 @@ int merge_index_path(struct index_state *istate, int oneshot, int quiet,
	 int merge_all_index(struct index_state *istate, int oneshot, int quiet,
	 		    merge_fn fn, void *data);
	 
	+typedef int (*merge_strategy_fn_t)(struct repository *r,
	+			     struct commit_list *bases, const char *head_arg,
	+			     struct commit_list *remote);
	 int merge_strategies_resolve(struct repository *r,
	 			     struct commit_list *bases, const char *head_arg,
	 			     struct commit_list *remote);
	diff --git a/sequencer.c b/sequencer.c
	index 00a36205848..d5ef12dda27 100644
	--- a/sequencer.c
	+++ b/sequencer.c
	@@ -2309,6 +2309,7 @@ static int do_pick_commit(struct repository *r,
	 	} else {
	 		struct commit_list *common = NULL;
	 		struct commit_list *remotes = NULL;
	+		merge_strategy_fn_t fn = NULL;
	 
	 		res = write_message(msgbuf.buf, msgbuf.len,
	 				    git_path_merge_msg(r), 0);
	@@ -2316,12 +2317,14 @@ static int do_pick_commit(struct repository *r,
	 		commit_list_insert(base, &common);
	 		commit_list_insert(next, &remotes);
	 
	-		if (!strcmp(opts->strategy, "resolve")) {
	-			repo_read_index(r);
	-			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
	-		} else if (!strcmp(opts->strategy, "octopus")) {
	+		if (!strcmp(opts->strategy, "resolve"))
	+			fn = merge_strategies_resolve;
	+		else if (!strcmp(opts->strategy, "resolve"))
	+			fn = merge_strategies_octopus;
	+
	+		if (fn) {
	 			repo_read_index(r);
	-			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
	+			res |= fn(r, common, oid_to_hex(&head), remotes);
	 		} else {
	 			res |= try_merge_command(r, opts->strategy,
	 						 opts->xopts_nr, (const char **)opts->xopts,

We could replace that if/else if with a static array, and loop over it
to find the "fn" (if any), but I though it wasn't worth it just for
this.

This would also make my suggestion on top at
https://lore.kernel.org/git/220818.868rnlaa0h.gmgdl@evledraar.gmail.com/
nicer. I.e. we could just make that:

	if (git_env_bool("GIT_TEST_MERGE_COMMANDS", 0))
		fn = NULL;

And not need to add the "are we in the test mode" to the if/else if
branch for all of the internal strategies.
