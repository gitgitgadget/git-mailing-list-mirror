Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEDC7618B
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 14:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjCOOOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjCOONu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 10:13:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C2EF96
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:13:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd5so42236146edb.7
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678889597;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nB5ltIGJNJtdxOmuqkl6xGJM9rgwsU8kCE31gNBcjtQ=;
        b=Zwiklra3NxV05dLlQ91DbBnVqBHSYJ8qDJ6yh1lbu1pse/UUU3D2z9tYt6JllYjEkV
         K3+3o62Kn1vv1J4qKN/JSWoeZ8WV4UpXCi7zuD4uF7cRRd0mrkB4GaHl9xYbj+QGIxXw
         SS2hTopkci1TYka/0+bEg3WrTB2ePOHT4TkpLefQ3/9PwMGfKeWBw/z3g14b1x2HEIYH
         sgtgj9NE8tZb335J3RP6fPZAQq+RWSYQn92axWBvNDRuW+3ALZDVH5bjCV2vfwWsA3Km
         KVGw2dl+66eY/gaI5U4qrZPBKn6+igi4crW0WbeU+Rl3Oa6up+PWAFGVrBBAeSj/7NJk
         Tvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889597;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB5ltIGJNJtdxOmuqkl6xGJM9rgwsU8kCE31gNBcjtQ=;
        b=w4XDt8Z6k1BJNVDCqgE2s6oaVaiYQsxhA+sSy6EtJQPyg2z9vA/tI4G3bVVgcTcsnd
         vTAITcNoNklUudo2U9WvA6csc5VF/U9WiZ903ICLbcBZQldXq+V7iifAq8jmcjiJVoyI
         HdL+LpewIb6P2oStNhHnVOLTyzFaCAuHIrTQ23utFR6oRuhaNGqH3E5hJkSCFSKMys31
         JNeytr6leixtxpuWfNyQmX3kGSoKIiOb7pgOF4OwxEXgVvgFgfZgBnD2zrb1JZaFmGch
         b6RTiQbg56/61JMeVBs+DoTeDGYnOju7T8Uo7yodUM1tI4u/RIeC41ua6roO5Rc7I/iu
         X7xA==
X-Gm-Message-State: AO0yUKUwB5D/qRRJfcXbK/HqKdDmx/VBkY8u+nJMSByhG47FyCcDk0nK
        4KJMcZYGuKNWUWcSwfdu1jQ=
X-Google-Smtp-Source: AK7set8KRs+SxTT2a77pBz2T01TCJ70n75A3JbV/XWbJwiWg4D8G4EQpfA1HY0Bi+sSviH/M3Mgdsw==
X-Received: by 2002:a17:906:e0d8:b0:870:58ae:842e with SMTP id gl24-20020a170906e0d800b0087058ae842emr6553958ejb.24.1678889596520;
        Wed, 15 Mar 2023 07:13:16 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id vs4-20020a170907a58400b0092f5e46f3c4sm566731ejc.137.2023.03.15.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:13:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pcRsR-002y6s-1g;
        Wed, 15 Mar 2023 15:13:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 7/8] for-each-ref: add ahead-behind format atom
Date:   Wed, 15 Mar 2023 14:57:20 +0100
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <82dd6f44a33279551bb638357df4bc82253283e5.1678468864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <82dd6f44a33279551bb638357df4bc82253283e5.1678468864.git.gitgitgadget@gmail.com>
Message-ID: <230315.868rfyxfus.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> +ahead-behind:<ref>::
> +	Two integers, separated by a space, demonstrating the number of
> +	commits ahead and behind, respectively, when comparing the output
> +	ref to the `<ref>` specified in the format.
> +

As a potential (expert) user who hasn't read the code yet I'd think the
the "<ref>" here would be the same as "update-ref", but glancing ahead
at your tests it seems that it does ref matching, so "refs/heads/master"
and "master" are both accepted?

Since nothing else uses "<ref>" here I think we should clearly define
the matching rules somehow, or maybe we do, and I missed it.

Is there a reason we couldn't use the same "<pattern>" as for-each-ref's
top-level accepts, with the limitation that if it matches more than one
we'll die?

Later you have e.g. ahead-behind:HEAD, but do we have test coverage for
e.g. the edge cases where a refs/heads/HEAD exists?

> @@ -645,6 +656,7 @@ static struct {
>  	[ATOM_THEN] = { "then", SOURCE_NONE },
>  	[ATOM_ELSE] = { "else", SOURCE_NONE },
>  	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
> +	[ATOM_AHEADBEHIND] = { "ahead-behind", SOURCE_OTHER, FIELD_STR, ahead_behind_atom_parser },
>  	/*
>  	 * Please update $__git_ref_fieldlist in git-completion.bash
>  	 * when you add new atoms
> @@ -1848,6 +1860,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  	struct object *obj;
>  	int i;
>  	struct object_info empty = OBJECT_INFO_INIT;
> +	int ahead_behind_atoms = 0;
>  
>  	CALLOC_ARRAY(ref->value, used_atom_cnt);
>  
> @@ -1978,6 +1991,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			else
>  				v->s = xstrdup("");
>  			continue;
> +		} else if (atom_type == ATOM_AHEADBEHIND) {
> +			if (ref->counts) {
> +				const struct ahead_behind_count *count;
> +				count = ref->counts[ahead_behind_atoms++];
> +				v->s = xstrfmt("%d %d", count->ahead, count->behind);
> +			} else {
> +				/* Not a commit. */
> +				v->s = xstrdup("");
> +			}
> +			continue;
>  		} else
>  			continue;

Hrm, so despite by earlier suggestion of using "size_t" it seems we
really are limited to "int" in the end, as our "used_atom_cnt" is an
"int".

But anyway, better to implement that limitation here, so we only need to
fix ref-filter.c to move beyond "int".

>  
> @@ -2328,6 +2351,7 @@ static void free_array_item(struct ref_array_item *item)
>  			free((char *)item->value[i].s);
>  		free(item->value);
>  	}
> +	free(item->counts);
>  	free(item);
>  }
>  
> @@ -2356,6 +2380,8 @@ void ref_array_clear(struct ref_array *array)
>  		free_worktrees(ref_to_worktree_map.worktrees);
>  		ref_to_worktree_map.worktrees = NULL;
>  	}
> +
> +	FREE_AND_NULL(array->counts);
>  }
>  

Follows the exsiting pattern, so good, but FWIW I think we could do away
with all this "and NULL", it looks like the only users are built-ins
which never look at this data again, but then we should probably rename
it to ref_array_release() or something...

>  #define EXCLUDE_REACHED 0
> @@ -2418,6 +2444,50 @@ static void reach_filter(struct ref_array *array,
>  	free(to_clear);
>  }
>  
> +void filter_ahead_behind(struct ref_format *format,
> +			 struct ref_array *array)
> +{
> +	struct commit **commits;
> +	size_t commits_nr = format->bases.nr + array->nr;
> +
> +	if (!format->bases.nr || !array->nr)
> +		return;
> +
> +	ALLOC_ARRAY(commits, commits_nr);
> +	for (size_t i = 0; i < format->bases.nr; i++) {

Eariler I suggested using this "size_t" in a "for", which is used here,
good, newer code than the other commit, presumably...

> +		const char *name = format->bases.items[i].string;
> +		commits[i] = lookup_commit_reference_by_name(name);
> +		if (!commits[i])
> +			die("failed to find '%s'", name);
> +	}
> +
> +	ALLOC_ARRAY(array->counts, st_mult(format->bases.nr, array->nr));
> +
> +	commits_nr = format->bases.nr;
> +	array->counts_nr = 0;

Not being very familiar with ref-filter.c, it seems odd that the API is
taking pains to clear things elsewhere, but we need to set "counts_nr"
to 0 here before an iteration.

If I comment this assignment out all the tests pass, is this redundant,
or left here for some future potential API use?

> diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
> new file mode 100755
> index 00000000000..439a448c2e6
> --- /dev/null
> +++ b/t/perf/p1500-graph-walks.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +
> +test_description='Commit walk performance tests'
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +
> +test_expect_success 'setup' '
> +	git for-each-ref --format="%(refname)" "refs/heads/*" "refs/tags/*" >allrefs &&
> +	sort -r allrefs | head -n 50 >refs &&

Some of the point of test_perf_large_repo is being able to point the
test to an arbitrary sized repo, why "head -n 50" here, instead of just
doing that filtering when preparing the test repo?

> +test_expect_success 'ahead-behind requires an argument' '
> +	test_must_fail git for-each-ref \
> +		--format="%(ahead-behind)" 2>err &&
> +	grep "expected format: %(ahead-behind:<ref>)" err
> +'
> +
> +test_expect_success 'missing ahead-behind base' '
> +	test_must_fail git for-each-ref \
> +		--format="%(ahead-behind:refs/heads/missing)" 2>err &&
> +	grep "failed to find '\''refs/heads/missing'\''" err
> +'
> +

Is this grep instead of test_cmp for brevity, or because we'll catch
this late and spew out other output as well?

I'd think it would be worth testing that we only emit an error. Even if
you don't want a full test_cmp we could check the line count too to
assert that...

> +# Run this before doing any signing, so the test has the same results
> +# regardless of the GPG prereq.
> +test_expect_success 'git tag --format with ahead-behind' '
> +	test_when_finished git reset --hard tag-one-line &&
> +	git commit --allow-empty -m "left" &&
> +	git tag -a -m left tag-left &&
> +	git reset --hard HEAD~1 &&
> +	git commit --allow-empty -m "right" &&
> +	git tag -a -m left tag-right &&

Do we really need this --allow-empty insted of just using "test_commit"?
I.e. is being TREESAME here important?

> +
> +	# Use " !" at the end to demonstrate whitepsace
> +	# around empty ahead-behind token for tag-blob.
> +	cat >expect <<-EOF &&
> +	refs/tags/tag-blob  !
> +	refs/tags/tag-left 1 1 !
> +	refs/tags/tag-lines 0 1 !
> +	refs/tags/tag-one-line 0 1 !
> +	refs/tags/tag-right 0 0 !
> +	refs/tags/tag-zero-lines 0 1 !
> +	EOF
> +	git tag -l --format="%(refname) %(ahead-behind:HEAD) !" >actual 2>err &&
> +	grep "refs/tags/tag" actual >actual.focus &&
> +	test_cmp expect actual.focus &&
> +
> +	# Error reported for tags that point to non-commits.
> +	grep "error: object [0-9a-f]* is a blob, not a commit" err

Maybe, but at a glance it doesn't seem so, but maybe I'm missing something...
