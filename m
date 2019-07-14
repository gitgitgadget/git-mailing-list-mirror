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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3491F461
	for <e@80x24.org>; Sun, 14 Jul 2019 23:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfGNXQY (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 19:16:24 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:41188 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbfGNXQY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Jul 2019 19:16:24 -0400
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
        by resqmta-po-11v.sys.comcast.net with ESMTP
        id mnWNh19mPYn26mnjDhlQow; Sun, 14 Jul 2019 23:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1563146183;
        bh=pe1d+p2k5+cR7lkBR6xOaR2Yhf25EZmddnkIo96Z24s=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=FbEcBHI6KtuS/ZnQZuLI57GtceMyCt3utT+Rj+FRowuPNL/4CSljm/qj3KhuvdrkU
         3ZjtRUD5S1oJP6xNuLuWUA3FPFteN269yonAsRC3oahjeaIxb2CDasPhS+OWnChWXq
         C8P5FJ7yJDquSW7uLLKm411c+EvVsquSKyG7xZojW90mooQWDu3/rAbGgGJ9lWpZRK
         O4UCJqjgUpPg+f5mW7asjCiJ4hB4/stQ9JWIH+ZWl+WJTE84MYnKd9VfPKir1NqMAy
         HzJqg8o9324o1E3qyueu4aLqpvtj4ShkOosPxEHa+dO7Trj8jqrcNysO0Itd+vcuRA
         VZSJWrZFN+cBQ==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:490a:f9d5:5072:cf84])
        by resomta-po-02v.sys.comcast.net with ESMTPSA
        id mniphONpKobG3mnj2h4bPI; Sun, 14 Jul 2019 23:16:21 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Sun, 14 Jul 2019 16:15:58 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #03; Fri, 12)
Message-ID: <20190714231558.GA24609@comcast.net>
References: <xmqq8st3otj7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8st3otj7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 12, 2019 at 02:02:52PM -0700, Junio C Hamano wrote:
> * md/list-objects-filter-combo (2019-06-28) 10 commits
>  - list-objects-filter-options: make parser void
>  - list-objects-filter-options: clean up use of ALLOC_GROW
>  - list-objects-filter-options: allow mult. --filter
>  - strbuf: give URL-encoding API a char predicate fn
>  - list-objects-filter-options: make filter_spec a string_list
>  - list-objects-filter-options: move error check up
>  - list-objects-filter: implement composite filters
>  - list-objects-filter-options: always supply *errbuf
>  - list-objects-filter: put omits set in filter struct
>  - list-objects-filter: encapsulate filter components
> 
>  The list-objects-filter API (used to create a sparse/lazy clone)
>  learned to take a combined filter specification.
> 
>  There is a bit of interaction with cc/multi-promisor topic, whose
>  conflict resolution I have no confidence in X-<.  Extra sets of
>  eyes are appreciated.
> 

Sorry for the delay. I was on vacation and then catching up for a week after I
got back. I uploaded a merged commit here:

https://github.com/matvore/git/tree/filts

And the merged file itself (only this one had conflicts) is here:

https://github.com/matvore/git/blob/filts/list-objects-filter.c

I'll comment on the conflicts:

> diff --cc list-objects-filter-options.c
> index ba1425cb4a,28c571f922..0000000000
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@@ -1,25 -1,19 +1,30 @@@
>   #include "cache.h"
>   #include "commit.h"
>   #include "config.h"
>   #include "revision.h"
>   #include "argv-array.h"
>   #include "list-objects.h"
>   #include "list-objects-filter.h"
>   #include "list-objects-filter-options.h"
> ++<<<<<<< md/list-objects-filter-combo
>  +#include "trace.h"
>  +#include "url.h"
>  +
>  +static int parse_combine_filter(
>  +	struct list_objects_filter_options *filter_options,
>  +	const char *arg,
>  +	struct strbuf *errbuf);
> ++||||||| merged common ancestors
> ++=======
> + #include "promisor-remote.h"
> ++>>>>>>> cc/multi-promisor
>   

This portion is trivial to merge - just move the "promisor-remote.h" inclusion
to the correct spot.

>   /*
>    * Parse value of the argument to the "filter" keyword.
>    * On the command line this looks like:
>    *       --filter=<arg>
>    * and in the pack protocol as:
>    *       "filter" SP <arg>
>    *
>    * The filter keyword will be used by many commands.
>    * See Documentation/rev-list-options.txt for allowed values for <arg>.
> @@@ -29,22 -23,33 +34,49 @@@
>    * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
>    * convenience of the current command.
>    */
>   static int gently_parse_list_objects_filter(
>   	struct list_objects_filter_options *filter_options,
>   	const char *arg,
>   	struct strbuf *errbuf)
>   {
>   	const char *v0;
>   
> ++<<<<<<< md/list-objects-filter-combo
>  +	if (filter_options->choice)
>  +		BUG("filter_options already populated");
> ++||||||| merged common ancestors
> ++	if (filter_options->choice) {
> ++		if (errbuf) {
> ++			strbuf_addstr(
> ++				errbuf,
> ++				_("multiple filter-specs cannot be combined"));
> ++		}
> ++		return 1;
> ++	}
> ++
> ++	filter_options->filter_spec = strdup(arg);
> ++=======
> + 	if (!arg)
> + 		return 0;
> + 
> + 	if (filter_options->choice) {
> + 		if (errbuf) {
> + 			strbuf_addstr(
> + 				errbuf,
> + 				_("multiple filter-specs cannot be combined"));
> + 		}
> + 		return 1;
> + 	}
> + 
> + 	filter_options->filter_spec = strdup(arg);
> ++>>>>>>> cc/multi-promisor
  
The cc/multi-promisor branch allowed gently_parse_list_objects_filter to accept
a NULL filter spec, in which case it does nothing. So the merged branch keeps
this behavior.

md/list-objects-filter-combo changed the contract of this function such that an
attempt to combine filter specs will terminate with BUG rather than return an
error. All the callers already check filter_options.choice, so this is still
fine (it particular, I double-checked partial_clone_get_default_filter_spec and
its call site at builtin/fetch.c:1524)

>   	/*
>   	 * Record the initial filter-spec in the config as
>   	 * the default for subsequent fetches from this remote.
>   	 */
> ++<<<<<<< md/list-objects-filter-combo
>  +	core_partial_clone_filter_default =
>  +		xstrdup(expand_list_objects_filter_spec(filter_options));
>  +	git_config_set("core.partialclonefilter",
>  +		       core_partial_clone_filter_default);
> ++||||||| merged common ancestors
> ++	core_partial_clone_filter_default =
> ++		xstrdup(filter_options->filter_spec);
> ++	git_config_set("core.partialclonefilter",
> ++		       core_partial_clone_filter_default);
> ++=======
> + 	filter_name = xstrfmt("remote.%s.partialclonefilter", remote);
> + 	git_config_set(filter_name, filter_options->filter_spec);
> + 	free(filter_name);
> + 
> + 	/* Make sure the config info are reset */
> + 	promisor_remote_reinit();
> ++>>>>>>> cc/multi-promisor
>   }
>   
>   void partial_clone_get_default_filter_spec(

md/list-objects-filter-combo used the expand_list_objects_filter_spec function
to expand the filter spec string rather than get it directly. So the merged
result simply applies that alteration to cc/multi-promisor.

I checked whether callers to this function (partial_clone_register) would ever
give a null filter_options (or a non-null with a NULL filter_spec) and both
calls are guarded by "if (filter_options.choice)" so filter_options.filter_spec
should also be set.

> - 	struct list_objects_filter_options *filter_options)
> + 	struct list_objects_filter_options *filter_options,
> + 	const char *remote)
>   {
> ++<<<<<<< md/list-objects-filter-combo
>  +	struct strbuf errbuf = STRBUF_INIT;
>  +
> ++||||||| merged common ancestors
> ++=======
> + 	struct promisor_remote *promisor = promisor_remote_find(remote);
> + 
> ++>>>>>>> cc/multi-promisor

This part of the conflict is trivial to merge - just use both the variable
declarations.

  	/*
  	 * Parse default value, but silently ignore it if it is invalid.
  	 */
> ++<<<<<<< md/list-objects-filter-combo
>  +	if (!core_partial_clone_filter_default)
>  +		return;
>  +
>  +	string_list_append(&filter_options->filter_spec,
>  +			   core_partial_clone_filter_default);
>  +	gently_parse_list_objects_filter(filter_options,
>  +					 core_partial_clone_filter_default,
>  +					 &errbuf);
>  +	strbuf_release(&errbuf);
> ++||||||| merged common ancestors
> ++	if (!core_partial_clone_filter_default)
> ++		return;
> ++	gently_parse_list_objects_filter(filter_options,
> ++					 core_partial_clone_filter_default,
> ++					 NULL);
> ++=======
> + 	if (promisor)
> + 		gently_parse_list_objects_filter(filter_options,
> + 						 promisor->partial_clone_filter,
> + 						 NULL);
> ++>>>>>>> cc/multi-promisor
  }

This is a confusing conflict because cc/multi-promisor (understandably) turned
the if-guard inside-out, removing "return", since it's only guarding against
one line anyway. When I merged it, I swtiched it back (if (!promisor) return)
since creating and freeing the strbuf requires multiple lines.

I would be fine with rebasing my or Christian's change on top of the other, or
doing it as a merge.
