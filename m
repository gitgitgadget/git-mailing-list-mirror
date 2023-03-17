Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7620EC74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 01:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCQBJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 21:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQBJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 21:09:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6A21A2B
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 18:09:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so3645222ybw.13
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679015381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ua+otjMExyCjWX39GZyeq5/wgrmehLIJFB+BEFaagrc=;
        b=eyvbdK3sb2tMQrFohd7IYaRp1WIgGq05MyRY+VTJw0b4RFlCeiixFPIS73tS1vDuCj
         hSAGQcKz+hO/5tyzSALy0UDyziFkZ9S5/nTpnIIF4wJ2/ZMpasP+mvi7ERpBeTQXbrzT
         /BRrJ0G6AM7T/TSsZ2p7htI4RW5j4sZDjMzK0kSI7g3FSX5RCWQTqetejz2psFld5HG4
         XylCe32Ai/KbAjq7KjBgDAvS9UXsf8O7EVrVRgpsjVwRQeLbUwZ9UqvwGQPNUugowTs8
         jU3cdYt9F2TQZUlBEJG8rUD0fr63fE3noB0/FUdRmtFerkekCRJocsMs87Fw11QfewgS
         TkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679015381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua+otjMExyCjWX39GZyeq5/wgrmehLIJFB+BEFaagrc=;
        b=3tWVvU0C0z/Z4+lB1U/+epjISe6hUIbwPwOfYASCb1nUPOlo7W0efPC3xZYZs5kGIj
         3Gwe2ku6mU/5c8ApKRX2agx7rzxSVI457h5kcHfqAjof11MJ0/jILaTtex5Pb6I0NuZe
         Ha3+B/0WlrIa3PY2+3kznPVsbvliDqrwGXBCFk0oVALhdSJiDy0rYGf0VSBUuL+YdMHH
         ZQLsVOQjqLW8zn0QTiDkag/afwFuq996mC+CoyAhC1ewzi+5IpktinznnxDQsbAGHIb5
         2/tuFOrhEnRtsMMatJFFeiC0LCioqvVTXlAdWSmUe0CycClFKvRwyYiFyUcfvyA1KiRV
         L6SA==
X-Gm-Message-State: AO0yUKXZ3MvmkZ+TrIaYioDWxkPzdhOUum1i3krgbwq7Xuebm2pqxBhT
        1ShRvGlcUX6/YvbOgrpE9xeLJCq+TC2azQ==
X-Google-Smtp-Source: AK7set9XxaDUKGmSSdau46mG3vMgXUgtAoLH3dMuoFIE4HBWxFoe3uwAiBbuwoKgAr3sdOE62sbT4f2aXPdqDg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:188c:b0:b51:c4b2:3d73 with SMTP
 id cj12-20020a056902188c00b00b51c4b23d73mr4615007ybb.2.1679015381547; Thu, 16
 Mar 2023 18:09:41 -0700 (PDT)
Date:   Thu, 16 Mar 2023 18:09:39 -0700
In-Reply-To: <20230302220251.1474923-6-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com> <20230302220251.1474923-6-calvinwan@google.com>
Message-ID: <kl6ljzzguqss.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v9 6/6] diff-lib: parallelize run_diff_files for submodules
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I haven't verified if the code in this version is correct or not, as I
found it a bit difficult to follow through the churn. After reading this
series again, I've established a better mental model of the code, and I
think there are some renames and documentation changes we can make to
make this clearer.

Unfortunately, I think the biggest clarification would be _yet_ another
refactor, and I'm not sure if we actually want to bear so much churn. I
might do this refactor locally to see if it really is _much_ cleaner or
not.

If anyone has thoughts on the refactor, do chime in.

Calvin Wan <calvinwan@google.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 744ae98a69..7fe6ced950 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -65,26 +66,41 @@ static int check_removed(const struct index_state *istate, const struct cache_en
>   * Return 1 when changes are detected, 0 otherwise. If the DIRTY_SUBMODULES
>   * option is set, the caller does not only want to know if a submodule is
>   * modified at all but wants to know all the conditions that are met (new
> - * commits, untracked content and/or modified content).
> + * commits, untracked content and/or modified content). If
> + * defer_submodule_status bit is set, dirty_submodule will be left to the
> + * caller to set. defer_submodule_status can also be set to 0 in this
> + * function if there is no need to check if the submodule is modified.
>   */
>  static int match_stat_with_submodule(struct diff_options *diffopt,
>  				     const struct cache_entry *ce,
>  				     struct stat *st, unsigned ce_option,
> -				     unsigned *dirty_submodule)
> +				     unsigned *dirty_submodule, int *defer_submodule_status,
> +				     unsigned *ignore_untracked)
>  {
>  	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> +	int defer = 0;
> +
>  	if (S_ISGITLINK(ce->ce_mode)) {
>  		struct diff_flags orig_flags = diffopt->flags;
>  		if (!diffopt->flags.override_submodule_config)
>  			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> -		if (diffopt->flags.ignore_submodules)
> +		if (diffopt->flags.ignore_submodules) {
>  			changed = 0;
> -		else if (!diffopt->flags.ignore_dirty_submodules &&
> -			 (!changed || diffopt->flags.dirty_submodules))
> -			*dirty_submodule = is_submodule_modified(ce->name,
> -								 diffopt->flags.ignore_untracked_in_submodules);
> +		} else if (!diffopt->flags.ignore_dirty_submodules &&
> +			   (!changed || diffopt->flags.dirty_submodules)) {
> +			if (defer_submodule_status && *defer_submodule_status) {
> +				defer = 1;
> +				*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
> +			} else {
> +				*dirty_submodule = is_submodule_modified(ce->name,
> +					 diffopt->flags.ignore_untracked_in_submodules);
> +			}
> +		}
>  		diffopt->flags = orig_flags;
>  	}
> +
> +	if (defer_submodule_status)
> +		*defer_submodule_status = defer;

The crux of this patch is that we are replacing some serial operation
with a parallel operation. The replacement happens here, where we are
replacing is_submodule_modified() by 'deferring' it.

So to verify if the parallel implementation is correct, we should
compare the "setup" and "finish" steps in is_submodule_modified() and
get_submodules_status(). Eyeballing it, it looks correct, especially
because we made sure to refactor out the shared logic in previous
patches.

To reflect this, I think it would be clearer to rename
get_submodules_status() to something similar (e.g.
are_submodules_modified_parallel()), with an explicit comment saying
that it is meant to be a parallel implementation of
is_submodule_modified().

Except, I told a little white lie in the previous paragraph, because
get_submodules_status() isn't _just_ a parallel implementation of
is_submodule_modified()...

> @@ -268,13 +286,52 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			}
>  
>  			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
> -							    ce_option, &dirty_submodule);
> +							    ce_option, NULL,
> +							    &defer_submodule_status,
> +							    &ignore_untracked);
>  			newmode = ce_mode_from_stat(ce, st.st_mode);
> +			if (defer_submodule_status) {
> +				struct submodule_status_util tmp = {
> +					.changed = changed,
> +					.dirty_submodule = 0,
> +					.ignore_untracked = ignore_untracked,
> +					.newmode = newmode,
> +					.ce = ce,
> +					.path = ce->name,
> +				};
> +				struct string_list_item *item;
> +
> +				item = string_list_append(&submodules, ce->name);
> +				item->util = xmalloc(sizeof(tmp));
> +				memcpy(item->util, &tmp, sizeof(tmp));
> +				continue;
> +			}

because get_submodules_status() doesn't just contain the results of
the parallel processes, it is _also_ shuttling "changed" and
"ignore_untracked" from match_stat_with_submodule(), as well as
.newmode, .ce and .path from run_diff_files() (basically everything
except .dirty_submodule)...

>  		}
>  
> -		record_file_diff(&revs->diffopt, newmode, dirty_submodule,
> -				 changed, istate, ce);
> +		if (!defer_submodule_status)
> +			record_file_diff(&revs->diffopt, newmode, 0,
> +					   changed,istate, ce);
> +	}
> +	if (submodules.nr) {
> +		unsigned long parallel_jobs;
> +		struct string_list_item *item;
> +
> +		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
> +			parallel_jobs = 1;
> +		else if (!parallel_jobs)
> +			parallel_jobs = online_cpus();
> +
> +		if (get_submodules_status(&submodules, parallel_jobs))
> +			die(_("submodule status failed"));
> +		for_each_string_list_item(item, &submodules) {
> +			struct submodule_status_util *util = item->util;
> +
> +			record_file_diff(&revs->diffopt, util->newmode,
> +					 util->dirty_submodule, util->changed,
> +					 istate, util->ce);
> +		}

so that we can pass all of this back into record_file_diff(). The only
member that is changed by the parallel process is .dirty_submodule,
which is exactly what we would expect from a parallel version of
is_submodule_modified().

If we don't want to do a bigger refactor, I think we should also add
comments to members of "struct submodule_status_util" to document where
they come from and what they are used for.

The rest of the comments are refactor-related.

It would be good if we could avoid mixing unrelated information sources
in "struct submodule_status_util", since a) this makes it very tightly
coupled to run_diff_files() and b) it causes us to repeat ourselves in
the same function (.changed = changed, record_file_diff()).

The only reason why the code looks this way right now is that
match_stat_with_submodule() sets defer_submodule_status based on whether
or not we should ignore the submodule, and this eventually tells
get_submodule_status() what submodules it needs to care about. But,
deciding whether to spawn a subprocess for which submodule is exactly
what the .get_next_task member is for.

> diff --git a/submodule.c b/submodule.c
> index 426074cebb..6f6e150a3f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1981,6 +1994,121 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  	return dirty_submodule;
>  }
>  
> +static struct status_task *
> +get_status_task_from_index(struct submodule_parallel_status *sps,
> +			   struct strbuf *err)
> +{
> +	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
> +		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
> +		struct status_task *task;
> +
> +		if (!verify_submodule_git_directory(util->path))
> +			continue;

So right here, we could use the "check if this submodule should be
ignored" logic form match_stat_with_submodule() to decide whether or not
to spawn the subprocess. IOW, I am advocating for
get_submodules_status() to be a parallel version of
match_stat_with_submodule() (not a parallel version of
is_submodule_modified() that shuttles extra information).

Another sign that this refactor is a good idea is that it lets us
simplify _existing_ submodule logic in run_diff_files(). Prior to this
patch, we have:

      unsigned dirty_submodule = 0;
      ...
			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
							    ce_option, NULL,
							    &defer_submodule_status,
							    &ignore_untracked);
      // If submodule was deferred, shuttle a bunch of information
      // If not, call record_file_diff()

but the body of match_stat_with_submodule() is just ie_match_stat() +
some additional submodule logic. Post refactor, this would look
something like:

    struct string_list submodules;
    ...
    // For any submodule, just append it to a list and let the
    // parallel thing take care of it.
    if (S_ISGITLINK(ce->ce_mode) {
      // Probably pass .newmode and .ce to the util too...
      string_list_append(submodules, ce->name);
    } else {
      changed = ie_match_stat(foo, bar, baz);
      record_file_diff();
    }
    ...
    if (submodules.nr) {
      parallel_match_stat_with_submodule_wip_name(&submodules);
      for_each_string_list_item(item, &submodules) {
        record_file_diff(&item);
      }
    }

Which I think is easier to follow, since we won't need
defer_submodule_status any more, and we don't shuttle information from
match_stat_with_submodule(). Though I'm a bit unhappy that it's still
pretty coupled to run_diff_files() (it still has to shuttle .newmode,
.ce). Also, I don't think this refactor lets us avoid the refactors we
did in the previous patches.

> +
> +		task = xmalloc(sizeof(*task));
> +		task->path = util->path;
> +		task->ignore_untracked = util->ignore_untracked;
> +		strbuf_init(&task->out, 0);
> +		sps->index_count++;
> +		return task;
> +	}
> +	return NULL;
> +}
> +
> +static int get_next_submodule_status(struct child_process *cp,
> +				     struct strbuf *err, void *data,
> +				     void **task_cb)
> +{
> +	struct submodule_parallel_status *sps = data;
> +	struct status_task *task = get_status_task_from_index(sps, err);

As an aside, I think we can inline get_status_task_from_index(). I
suspect this pattern was copied from get_next_submodule(), which
gets fetch tasks from two different places (hence _from_index and
_from_changed), but here I don't think we will ever get status tasks
from more than one place.
