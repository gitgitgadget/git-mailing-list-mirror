Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A2220899
	for <e@80x24.org>; Thu, 27 Jul 2017 18:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdG0Szz (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:55:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60573 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751458AbdG0Szy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:55:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFF459F8D5;
        Thu, 27 Jul 2017 14:55:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2v9C/BQC3vBAvYPRX3UJtFP/A8M=; b=JVd19g
        Za8/8QxFdRSlB+fNUl/2yhk7vbPkXQbELdPED/pzmicu36jLDcfrE2pf13lCYYFT
        danDpgEeQWwyfy1mxdRUcfwKJIWbfDV/4PsLB/lSAHnrU8vIN+xGGsfj3X8zK6XM
        gWxWVyyXQ74Hd0YWDbaXXlwET/vm1TlAioZMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s5k/+pXxggNJxBj4TgunKmTvBPWvG4kS
        16l0BSy2wXe2Cyfv/hx/fpJUoOskJ3chT17uOlvMwGtpInaV5VrpdZ4AT7nJmHZC
        NmbDkXjhuAxHvc33nlbpM+ZXQv69UCeYTJiBtJ+sRnbOmSMF9e0Ulb5t7MO0xTP5
        nsvdKia367w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A81B29F8D4;
        Thu, 27 Jul 2017 14:55:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E39F19F8D3;
        Thu, 27 Jul 2017 14:55:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 1/4] environment, fsck: introduce lazyobject extension
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <75766ee26264e50b7fcb3c7a8cc5808907586799.1501111615.git.jonathantanmy@google.com>
Date:   Thu, 27 Jul 2017 11:55:46 -0700
In-Reply-To: <75766ee26264e50b7fcb3c7a8cc5808907586799.1501111615.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 26 Jul 2017 16:29:59 -0700")
Message-ID: <xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33CDA3B6-72FD-11E7-82D8-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, Git does not support repos with very large numbers of objects
> or repos that wish to minimize manipulation of certain blobs (for
> example, because they are very large) very well, even if the user
> operates mostly on part of the repo, because Git is designed on the
> assumption that every referenced object is available somewhere in the
> repo storage.
>
> Introduce a new repository extension option "extensions.lazyobject", of
> data type string. If this is set in a repository, Git will tolerate
> objects being missing in that repository.  When Git needs those objects,
> it will invoke the command in that option.

My reading hiccupped after the first sentence, as the problem
description made it sound like this was a boolean ("are we using
lazy object feature?"), after reading "data type string".  And then
"the command in that option" made me hiccup one more time, as it did
not "click" that "in that option" was trying to say that the string
is used as the command name (or is it a whole command line?  The
leading part of the command line to which some arguments are
appended before it gets invoked as a command? or what?).

Logically, I think it is more like

 - extensions.lazyobject can be set to tell Git to consider missing
   objects in certain cases are not errors;

 - the value of extensions.lazyobject variable must be a string,
   which is used to name the command to lazily make the object
   "appear" in the repository on demand.

> Teach fsck about the new state of affairs. In this commit, teach fsck
> that missing objects referenced from the reflog are not an error case;
> in future commits, fsck will be taught about other cases.

In any case, sounds like a small and good first step.

> +
> +`lazyObject`
> +~~~~~~~~~~~~~~~~~
> +
> +When the config key `extensions.lazyObject` is set to a string, Git
> +tolerates objects being missing in the repository. This string contains
> +the command to be run whenever a missing object is needed.

This has the same issue but to a lessor degree as there is "string
contains".  What the command will do (e.g. "makes the object
magically appear in the object store" or "emits the contents of the
object to its standard output, so that Git can hash it to make it
appear in the object store"), and how it is used (e.g. "this is a
single command name and nothing else", "this is a leading part of
command line and arguments are appended at the end, before the whole
thing is passed to the shell to be executed", etc.) will need to be
clarified in the final version of the series (not necessarily at
this step---the series can elaborate in the later patches).

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index fb0947009..1cfb8d98c 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -402,7 +402,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
>  					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
>  			obj->flags |= USED;
>  			mark_object_reachable(obj);
> -		} else {
> +		} else if (!repository_format_lazy_object) {
>  			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
>  			errors_found |= ERROR_REACHABLE;
>  		}
> diff --git a/cache.h b/cache.h
> index 6c8242340..9e6bc0a21 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -853,10 +853,12 @@ extern int grafts_replace_parents;
>  #define GIT_REPO_VERSION 0
>  #define GIT_REPO_VERSION_READ 1
>  extern int repository_format_precious_objects;
> +extern char *repository_format_lazy_object;

This is not a new problem, but I think these two should be
called repository_extension_$NAME not repository_format_$NAME.

> diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
> new file mode 100755
> index 000000000..36442531f
> --- /dev/null
> +++ b/t/t0410-lazy-object.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +test_description='lazy object'
> +
> +. ./test-lib.sh
> +
> +delete_object () {
> +	rm $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
> +}
> +
> +test_expect_success 'fsck fails on lazy object in reflog' '
> +	test_create_repo repo &&
> +	test_commit -C repo 1 &&
> +
> +	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> +	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
> +
> +	# Reference $A only from reflog, and delete it
> +	git -C repo branch mybranch "$A" &&
> +	git -C repo branch -f mybranch "$B" &&
> +	delete_object repo "$A" &&
> +
> +	test_must_fail git -C repo fsck
> +'
> +test_expect_success '...but succeeds if lazyobject is set' '
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.lazyobject "arbitrary string" &&
> +	git -C repo fsck
> +'
> +
> +test_done
