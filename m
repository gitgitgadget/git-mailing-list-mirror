Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC889C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAECF22CB8
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbhAEQlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbhAEQle (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 11:41:34 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DBDC061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 08:40:54 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b24so286316otj.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 08:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VXBko1TcuxmvPFXpiw5oU0aaFd21evTUZBDBEXzDtmA=;
        b=DZuPMcQeKDmA61bOXL8M4MkHU4oucN1EiW4g5aVQY3tEaDouR4j6+3oEjFsY4GJxyC
         ZX1DIy712xVnL9J5shWciDDKtUuPekA/Vo/HcTboMs28zNzHTcyNgWuh947LrAlzM71j
         TOM5USalCDMsn6i9QXjN9nMKreBDrX/eJa4UnYvRPlGgRjx+gq17vHS7I9p9FZnwO8uL
         asP67wjgqtVqyXifnuNwonpopztcDuXrfMvYBDmddsAIUH1vT7sphclbG+Bgx+2q78MS
         O7A2VxePpL/MGEcocZNmkOJEoZq37906C3PZR+6JcFTGOW9mbK2pPkvG+lEfZCsU0Wqf
         CUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VXBko1TcuxmvPFXpiw5oU0aaFd21evTUZBDBEXzDtmA=;
        b=cidyv1WMbCFV56PJOxM3LkNV4PJ9oIfPjr267w5h5hCyQR8iajvv3OnCGEvkEMiSd3
         6QqEro8DtwMeHI9UwWT8XYO+YHIRh88pouHV3h0O1xLvhGZew+hmphvRxj4CjmPZnf6B
         9jc/Z6+uumAvm+qHc0xOpl6+vkvArQVURSSZfewX9SggCka6iNPeeiKo79VF94QJqy1K
         gWpUxJwoaFu8mxAybtP9x2WZyci3FSBbTDq9nXKDVlMPPH9qJBPx6AYDnv94fgg/J9BK
         INY3/78qhzfXriVODHRsQNGDiQ6c9EaQIHuNewHXmKR/EyRo/7zBV0rlWaMYnh31C5Qa
         Vasw==
X-Gm-Message-State: AOAM532JensM7W9THflqcGU3Ln2Uac9Xg0wlLlJTx90kswCRk08l4znr
        jpta/IijrSzv931zxVuxztM=
X-Google-Smtp-Source: ABdhPJwEgtPoZJboFFp5NuyZ0icdSrE/nMfaJcGO8iRqhExAugeUw2QmvCfjkkj7cCI7KuvWyF+Fmg==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr171033oti.219.1609864853304;
        Tue, 05 Jan 2021 08:40:53 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id b188sm62033oif.49.2021.01.05.08.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:40:52 -0800 (PST)
Subject: Re: [PATCH v6 09/13] merge-octopus: rewrite in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-10-alban.gruin@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <53b6ca2a-771a-dd6a-ce17-b2cb8d60ec65@gmail.com>
Date:   Tue, 5 Jan 2021 11:40:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20201124115315.13311-10-alban.gruin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 6:53 AM, Alban Gruin wrote:
> This rewrites `git merge-octopus' from shell to C.  As for the two last
> conversions, this port removes calls to external processes to avoid
> reading and writing the index over and over again.

...

> diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
> new file mode 100644
> index 0000000000..ca8f9f345d
> --- /dev/null
> +++ b/builtin/merge-octopus.c
> @@ -0,0 +1,69 @@
> +/*
> + * Builtin "git merge-octopus"
> + *
> + * Copyright (c) 2020 Alban Gruin
> + *
> + * Based on git-merge-octopus.sh, written by Junio C Hamano.
> + *
> + * Resolve two or more trees.
> + */
> +
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS

Hm. It would be best if this was not added to any new code. Please
squash in changes that avoid these macros.

> +#include "cache.h"
> +#include "builtin.h"
> +#include "commit.h"
> +#include "merge-strategies.h"
> +
> +static const char builtin_merge_octopus_usage[] =
> +	"git merge-octopus [<bases>...] -- <head> <remote1> <remote2> [<remotes>...]";
> +
> +int cmd_merge_octopus(int argc, const char **argv, const char *prefix)
> +{
> +	int i, sep_seen = 0;

One strategy I've been trying to do, when I remember, is to start each
builtin with

	struct repository *repo = the_repository;

then use 'repo' over 'the_repository' and other macros. This gets us
closer to the state where the builtin cmd_*() methods could take a
repository pointer as a parameter. (We are a ways off, but every little
bit helps, right?)

> +	/*
> +	 * Reject if this is not an octopus -- resolve should be used
> +	 * instead.
> +	 */
> +	if (commit_list_count(remotes) < 2)
> +		return 2;

This caused me to pause, since it might be nice to have a warning message
here. However, it is identical behavior to the script, including the
comment.

It appears that there is no Documentation/git-merge-octopus.txt, but such
a doc file would want to include the meaning of exit code 2.

> diff --git a/merge-strategies.c b/merge-strategies.c
> index 9aa07e91b5..4d9dd55296 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "cache-tree.h"
> +#include "commit-reach.h"

You had my curiosity, but now you have my attention. ;)

> +int merge_strategies_octopus(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,
> +			     struct commit_list *remotes)
> +{
> +	int ff_merge = 1, ret = 0, references = 1;
> +	struct commit **reference_commit, *head_commit;

'reference_commit' might be clearer if it was plural, right?

> +	struct tree *reference_tree, *head_tree;
> +	struct commit_list *i;
> +	struct object_id head;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	get_oid(head_arg, &head);
> +	head_commit = lookup_commit_reference(r, &head);
> +	head_tree = repo_get_commit_tree(r, head_commit);
> +
> +	if (parse_tree(head_tree))
> +		return 2;
> +
> +	if (repo_index_has_changes(r, head_tree, &sb)) {
> +		error(_("Your local changes to the following files "
> +			"would be overwritten by merge:\n  %s"),
> +		      sb.buf);
> +		strbuf_release(&sb);
> +		return 2;
> +	}
> +
> +	reference_commit = xcalloc(commit_list_count(remotes) + 1,
> +				   sizeof(struct commit *));
> +	reference_commit[0] = head_commit;
> +	reference_tree = head_tree;
> +
> +	for (i = remotes; i && i->item; i = i->next) {
> +		struct commit *c = i->item;
> +		struct object_id *oid = &c->object.oid;
> +		struct tree *current_tree = repo_get_commit_tree(r, c);
> +		struct commit_list *common, *j;
> +		char *branch_name;
> +		int k = 0, up_to_date = 0;
> +
> +		if (ret) {
> +			/*
> +			 * We allow only last one to have a
> +			 * hand-resolvable conflicts.  Last round failed
> +			 * and we still had a head to merge.
> +			 */
> +			puts(_("Automated merge did not work."));
> +			puts(_("Should not be doing an octopus."));
> +
> +			free(reference_commit);
> +			return 2;
> +		}
> +
> +		branch_name = merge_get_better_branch_name(oid_to_hex(oid));
> +		common = get_merge_bases_many(c, references, reference_commit);

Here we are. You should probably use repo_get_merge_bases_many().

'references' is not a list, but instead a count. Could
it be renamed nr_references or something?

> +
> +		if (!common) {
> +			error(_("Unable to find common commit with %s"), branch_name);
> +
> +			free(branch_name);
> +			free_commit_list(common);
> +			free(reference_commit);
> +
> +			return 2;

hm. we are getting into magic constant territory. Perhaps this should
be marked with a macro in merge-strategies.h? It could be used in the
case of "only two heads" as well.

> +		}
> +
> +		for (j = common; j && !(up_to_date || !ff_merge); j = j->next) {
> +			up_to_date |= oideq(&j->item->object.oid, oid);
> +
> +			if (k < references)
> +				ff_merge &= oideq(&j->item->object.oid, &reference_commit[k++]->object.oid);

I'm confused about this line. Shouldn't we care only about
reference_commit[references]? If we _do_ care about all possible
reference_commit[k] values, then shouldn't this be a loop over the
k values, not a single check per k (and advancing as we iterate
through the results from common)?

Seems we could use some test cases around criss-cross octopus
merges (i.e. multiple merge bases).

> +		}
> +
> +		if (up_to_date) {
> +			printf(_("Already up to date with %s\n"), branch_name);
> +
> +			free(branch_name);
> +			free_commit_list(common);
> +			continue;
> +		}
> +
> +		if (ff_merge) {
> +			ret = octopus_fast_forward(r, branch_name, head_tree,
> +						   current_tree, &reference_tree);
> +			references = 0;
> +		} else {
> +			ret = octopus_do_merge(r, branch_name, common,
> +					       current_tree, &reference_tree);
> +		}
> +
> +		free(branch_name);
> +		free_commit_list(common);
> +
> +		if (ret == -1)
> +			break;
> +
> +		reference_commit[references++] = c;
> +	}
> +
> +	free(reference_commit);
> +	return ret;
> +}

This patch could use a little work, but it's a good start.

Thanks,
-Stolee

