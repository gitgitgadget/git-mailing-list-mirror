From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/15] fetch --tags: fetch tags *in addition to* other stuff
Date: Thu, 24 Oct 2013 13:51:57 -0700
Message-ID: <xmqqob6emlxu.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 24 22:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZRt1-0007DA-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 22:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab3JXUwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 16:52:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665Ab3JXUwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 16:52:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3074DEF7;
	Thu, 24 Oct 2013 20:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3iEq2r/C/ULJsH8DU9mrkMpsKQU=; b=Vox+Td
	40lAec0xrEn86pQZmsKci37Ug+Njadkiup/Ms/IwNCya2If5CDDBK0uhzoF6Ny1j
	ZsMeZSQ55Wp1sYOd6GWGlWbxgPVybIHS1jbjrLCcOac6PeqpHqG3wLpBJKd4FSsj
	3d+0azkKG9URs96rYcNqskrgZ7BRX0L5+BGNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2ZIOZjhOb78puVfxMub927W2YPp0GL0
	gErfO6PMEc2QLWQ1Kl44vF7ZLHQr8k7ERe+Zmb9FUW8I9Amu+hXD6tyUtEK8qHkn
	rJBXXJn2ptop6sT6FktHG5Z2Z+vEUCMeBQaqCBOJobPQepbSTTLB5coOR0f5GEoc
	9qtBp2lIo+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9774DEF6;
	Thu, 24 Oct 2013 20:52:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6100A4DEF4;
	Thu, 24 Oct 2013 20:51:59 +0000 (UTC)
In-Reply-To: <1382543448-2586-11-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20678AB0-3CEE-11E3-BC7B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236619>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Previously, fetch's "--tags" option was considered equivalent to
> specifying the refspec "refs/tags/*:refs/tags/*" on the command line;
> in particular, it caused the remote.<name>.refspec configuration to be
> ignored.
>
> But it is not very useful to fetch tags without also fetching other
> references, whereas it *is* quite useful to be able to fetch tags *in
> addition to* other references.

True but when fetching other references, tags relevant to the
history being fetched by default should automatically follow, so the
above explains why "fetch --tags" is not a useful thing to do daily.

> So change the semantics of this option
> to do the latter.

And I am not opposed to that change in the semantics; it makes an
operation that is not so useful less annoying.

> If a user wants to fetch *only* tags, then it is still possible to
> specifying an explicit refspec:
>
>     git fetch <remote> 'refs/tags/*:refs/tags/*'
>
> Please note that the documentation prior to 1.8.0.3 was ambiguous
> about this aspect of "fetch --tags" behavior.  Commit
>
>     f0cb2f137c 2012-12-14 fetch --tags: clarify documentation
>
> made the documentation match the old behavior.  This commit changes
> the documentation to match the new behavior.

The "old behaviour as designed".  The documentation change was not
about refusing to fix a bug but the above makes it sound as if it
were a such commit.

> The change to builtin/fetch.c:get_ref_map() has the side effect of
> changing the order that the (struct ref) objects are listed in
> ref_map.  It seems to me that this could probably only matter in the
> case of duplicates.  But later ref_remove_duplicates() is called, so
> duplicates are eliminated.  However, ref_remove_duplicates() always
> retains the first instance of duplicates and discards the rest.  It is
> conceivable that the boolean flags (which are not inspected by
> ref_remove_duplicates()) could differ among the duplicates, and that
> therefore changing the order of the items in the original list has the
> effect of changing the flags on the items that are retained.
>
> I don't know this code well enough to judge whether this might be a
> problem.

> If it is, then the correct approach is probably either to teach
> ref_remove_duplicates() to ensure that the flags are also consistent
> across duplicates, or to somehow combine the flags from all duplicates
> into the one that is retained.  Please let me know if this is needed.

I do not think either of these two is sufficient if you want to fix
it; ref_remove_duplicates() needs to be taught to retain the first
one it encounters among the duplicates, not "ensure the flags are
consistent" by erroring out when they are not among duplicates, nor
"somehow combine" flags from later one to the first one.

But I suspect that, if this behaviour change were a problem, such a
configuration was a problem before this change to most people; the
order of duplicated [remote "foo"] section would not be under
control of those who only use "git remote" without using an editor
to tweak .git/config file anyway. So I do not think this regression
is too big a deal; it is something you can fix later on top.

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index ba1fe49..0e6d2ac 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -61,11 +61,9 @@ endif::git-pull[]
>  ifndef::git-pull[]
>  -t::
>  --tags::
> -	This is a short-hand for giving `refs/tags/*:refs/tags/*`
> -	refspec from the command line, to ask all tags to be fetched
> -	and stored locally.  Because this acts as an explicit
> -	refspec, the default refspecs (configured with the
> -	remote.$name.fetch variable) are overridden and not used.
> +	This is a short-hand requesting that all tags be fetched from
> +	the remote in addition to whatever else is being fetched.  It
> +	is similar to using the refspec `refs/tags/*:refs/tags/*`.

This is no longer a short-hand, is it?  There is no other way to ask
"fetch the usual stuff, and then refs/tags/*:refs/tags/* as well".

It should be sufficient for me to locally do:

    s/This is a short-hand requesting/Request/;

I think.

> diff --git a/git-pull.sh b/git-pull.sh
> index b946fd9..dac7e1c 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -172,7 +172,7 @@ error_on_no_merge_candidates () {
>  	do
>  		case "$opt" in
>  		-t|--t|--ta|--tag|--tags)
> -			echo "Fetching tags only, you probably meant:"
> +			echo "It doesn't make sense to pull tags; you probably meant:"

s/pull tags/pull all tags/; perhaps?

>  			echo "  git fetch --tags"
>  			exit 1
>  		esac
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 8328be1..02e5901 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -113,7 +113,7 @@ test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
>  	git rev-parse origin/master
>  '
>  
> -test_expect_success 'fetch --prune --tags does not delete the remote-tracking branches' '
> +test_expect_success 'fetch --prune --tags prunes tags and branches' '
>  	cd "$D" &&
>  	git clone . prune-tags &&
>  	cd prune-tags &&
> @@ -124,7 +124,7 @@ test_expect_success 'fetch --prune --tags does not delete the remote-tracking br
>  
>  	git fetch --prune --tags origin &&
>  	git rev-parse origin/master &&
> -	git rev-parse origin/fake-remote &&
> +	test_must_fail git rev-parse origin/fake-remote &&

Nice.

>  	test_must_fail git rev-parse sometag
>  '
>  
> @@ -132,10 +132,26 @@ test_expect_success 'fetch --prune --tags with branch does not delete other remo
>  	cd "$D" &&
>  	git clone . prune-tags-branch &&
>  	cd prune-tags-branch &&
> +	git tag sometag master &&
>  	git update-ref refs/remotes/origin/extrabranch master &&
>  
>  	git fetch --prune --tags origin master &&
> -	git rev-parse origin/extrabranch
> +	git rev-parse origin/extrabranch &&
> +	test_must_fail git rev-parse sometag

OK, and I'd imagine this will be an issue for a later patch to
address...

> diff --git a/t/t5515/fetch.br-unconfig_--tags_.._.git b/t/t5515/fetch.br-unconfig_--tags_.._.git
> index 1669cc4..0f70f66 100644
> --- a/t/t5515/fetch.br-unconfig_--tags_.._.git
> +++ b/t/t5515/fetch.br-unconfig_--tags_.._.git
> @@ -1,4 +1,5 @@
>  # br-unconfig --tags ../.git
> +0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
>  6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
>  8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
>  22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
> diff --git a/t/t5515/fetch.master_--tags_.._.git b/t/t5515/fetch.master_--tags_.._.git
> index 8a74935..ab473a6 100644
> --- a/t/t5515/fetch.master_--tags_.._.git
> +++ b/t/t5515/fetch.master_--tags_.._.git
> @@ -1,4 +1,5 @@
>  # master --tags ../.git
> +0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
>  6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
>  8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
>  22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../

This shows us that the updated error message for "git pull --tags"
is much less likely to be given to the user, as we are much more
likely to be fetching something we would want to fetch and merge.
Good.

Thanks.
