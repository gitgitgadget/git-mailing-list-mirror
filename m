Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E11C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 10:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhKWLBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhKWLBx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:01:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADBAC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:58:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so90305533edd.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Rlb6VZuzzLxe0gtVfbbGuwrfHTn+q3KgPftPamI9NeU=;
        b=c6LeC5p/3DtAm5/O2rccbR8mk7tjzD1dth/Z1pOMjL+D1Pn776kpB40vm18w9jJfJW
         zlTeA0x63JBC6mxhUWLZKruJqPliCaSFRfE3OOMGLW623Iu6B3D9ljKqzdO6Z6uW3zwN
         zZpJZog9N8IGd0NjLz4LZ1QPFc/oQxMGkSJGMpjyKAQ82mODm6eFBinncH00SbOkx8Dx
         2vqISu6ZVOvv3Bj2ToWBp17wVvF5XPZe0AGyhB6B0rLg2jdPMWlc8Ax8vxJiE27fNUR7
         XsqnHyCUkB8YP+6XWe+eU0bTTCzzUzk3mOAS5Aetf0ltkCDrapvLNCfFEY20bRHY2TvF
         vYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Rlb6VZuzzLxe0gtVfbbGuwrfHTn+q3KgPftPamI9NeU=;
        b=dIctBrkSPhk//nIqa157xYswCN+EoScpvpumm0Z7CTGIlwwIfJLr/0r4pDiCb4P6QV
         ea1VqUwpjjDY2m9U635B1VZ92pWJytc4NRCXaqXy+ml7oa3bReEkF1DyejiHgdq6EebE
         XG6B/SOu/HalN9rZwSiFqm7u+GYPLvfpFvwH0Hwc6MkyKUajQM8YX3EfB/q3GTBYN6yx
         YtDCAnz74LMoE4S40Q0rSZ0IAU0xtmcIlSb9ziFF7Ej0bnZwpfjOM3p1YCTFSomeZIdA
         Nm5FSMzeMrb7+1RK1hw2rCvk6l6gLSa0FmKH0IVpZ3Slnc9Ktq0EDcwdaO/Sqpbm7hn1
         OYAw==
X-Gm-Message-State: AOAM531ZN0vNNRzKa2aRNxWf9Fz0YDtnjrBMBBX0PeZPkJi+/L2572CR
        tuqm0NxKCasYlaGn5agGMqWGqpiVgQ5Fkw==
X-Google-Smtp-Source: ABdhPJwyOaNOE20Gcvb66xVbtKpCR5K/yi7HXQ5FgFTk1DmKgh1RSvoHsQW6MoGJ/mHkcw11nO33qw==
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr7852930ede.390.1637665123222;
        Tue, 23 Nov 2021 02:58:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hv13sm5253966ejc.75.2021.11.23.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:58:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpTVa-001KFT-G4;
        Tue, 23 Nov 2021 11:58:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/4] submodule-config: add submodules_of_tree() helper
Date:   Tue, 23 Nov 2021 11:53:15 +0100
References: <20211122223252.19922-1-chooglen@google.com>
 <20211122223252.19922-2-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211122223252.19922-2-chooglen@google.com>
Message-ID: <211123.86r1b7uoil.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Glen Choo wrote:

> As we introduce a submodule UX with branches, we would like to be able
> to get the submodule commit ids in a superproject tree because those ids
> are the source of truth e.g. "git branch --recurse-submodules topic
> start-point" should create branches based off the commit ids recorded in
> the superproject's 'start-point' tree.
>
> To make this easy, introduce a submodules_of_tree() helper function that
> iterates through a tree and returns the tree's gitlink entries as a
> list.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  submodule-config.c | 19 +++++++++++++++++++
>  submodule-config.h | 13 +++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index f95344028b..97da373301 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -7,6 +7,7 @@
>  #include "strbuf.h"
>  #include "object-store.h"
>  #include "parse-options.h"
> +#include "tree-walk.h"
>  
>  /*
>   * submodule cache lookup structure
> @@ -726,6 +727,24 @@ const struct submodule *submodule_from_path(struct repository *r,
>  	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
>  }
>  
> +struct submodule_entry_list *
> +submodules_of_tree(struct repository *r, const struct object_id *treeish_name)
> +{
> +	struct tree_desc tree;
> +	struct name_entry entry;
> +	struct submodule_entry_list *ret;
> +
> +	CALLOC_ARRAY(ret, 1);
> +	fill_tree_descriptor(r, &tree, treeish_name);
> +	while (tree_entry(&tree, &entry)) {
> +		if (!S_ISGITLINK(entry.mode))
> +			continue;
> +		ALLOC_GROW(ret->name_entries, ret->entry_nr + 1, ret->entry_alloc);
> +		ret->name_entries[ret->entry_nr++] = entry;
> +	}
> +	return ret;
> +}
> +
>  void submodule_free(struct repository *r)
>  {
>  	if (r->submodule_cache)
> diff --git a/submodule-config.h b/submodule-config.h
> index 65875b94ea..4379ec77e3 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -6,6 +6,7 @@
>  #include "hashmap.h"
>  #include "submodule.h"
>  #include "strbuf.h"
> +#include "tree-walk.h"
>  
>  /**
>   * The submodule config cache API allows to read submodule
> @@ -67,6 +68,18 @@ const struct submodule *submodule_from_name(struct repository *r,
>  					    const struct object_id *commit_or_tree,
>  					    const char *name);
>  
> +struct submodule_entry_list {
> +	struct name_entry *name_entries;
> +	int entry_nr;
> +	int entry_alloc;
> +};
> +
> +/**
> + * Given a tree-ish, return all submodules in the tree.
> + */
> +struct submodule_entry_list *
> +submodules_of_tree(struct repository *r, const struct object_id *treeish_name);
> +
>  /**
>   * Given a tree-ish in the superproject and a path, return the submodule that
>   * is bound at the path in the named tree.

Having skimmed through this topic isn't this in 4/4 the only resulting caller:
	
	+void create_submodule_branches(struct repository *r, const char *name,
	+			       const char *start_name, int force, int reflog,
	+			       int quiet, enum branch_track track)
	+{
	+	int i = 0;
	+	char *branch_point = NULL;
	+	struct repository *subrepos;
	+	struct submodule *submodules;
	+	struct object_id super_oid;
	+	struct submodule_entry_list *submodule_entry_list;
	+	char *err_msg = NULL;
	+
	+	validate_branch_start(r, start_name, track, &super_oid, &branch_point);
	+
	+	submodule_entry_list = submodules_of_tree(r, &super_oid);
	+	CALLOC_ARRAY(subrepos, submodule_entry_list->entry_nr);
	+	CALLOC_ARRAY(submodules, submodule_entry_list->entry_nr);
	+
	+	for (i = 0; i < submodule_entry_list->entry_nr; i++) {

I think it would be better to just intorduce this function at the same
time as its (only?) user, which also makes it clear how it's used.

In this case this seems like quite a bit of over-allocation. I.e. we
return a malloc'd pointer, and iterate with tree_entry(), the caller
then needs to loop over that and do its own allocations of "struct
repository *" and "struct submodule *".

Wouldn't it be better just to have this new submodule_entry_list contain
a list of not "struct name_entry", but:

    struct new_thingy {
        struct name_entry *entry;
        struct repository *repo;
        struct submodule *submodule;
    }

Then have the caller allocate the container on the stack, pass it to
this function.

Maybe not, just musings while doing some light reading. I was surprised
at what are effectively two loops over the same data, first allocating
1/3, then the other doing the other 2/3...
