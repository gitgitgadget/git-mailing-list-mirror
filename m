From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] format-patch: add '--base' option to record base tree info
Date: Tue, 12 Apr 2016 12:08:33 -0700
Message-ID: <xmqq7fg2r6fi.fsf@gitster.mtv.corp.google.com>
References: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
	<1460342873-28900-3-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 21:08:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq3g2-0001tq-OX
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 21:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965450AbcDLTIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 15:08:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964907AbcDLTIh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 15:08:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5DEA55795;
	Tue, 12 Apr 2016 15:08:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+O0xQ56AAeR0uP6TAWwlplR37Ds=; b=ZWvn7k
	ojRNX0N9tUw6BeKcFScv4EVq3dZ9IyckcQOShj44XtqqiTvmTQml4OluZZ0TaCna
	2MnxgWEI7AAvDeQyxe6UaGhS2XRqctOfmbVZiXT2+loGpYPi/sEm/MaHP66DrnMI
	+krkoSjBNe+gKibBFRbwE+h0I/23bWyazoPRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HsFcvf2iicFymDPpF5wRWf/Fm53sGEX4
	1BkaB9Vt/qapzsSokvRD3fvZWK7naqSOml4d/mJ8YYRqoOcEg3voUB/1sfA6HErJ
	+WU2gssFgx5vbwTIN693ve55OzEmuVzAu3Q8GizM9bbBu+vMDbFFqk4JqqANFXsL
	pX76XmxLZtw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD36F55793;
	Tue, 12 Apr 2016 15:08:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E863455791;
	Tue, 12 Apr 2016 15:08:34 -0400 (EDT)
In-Reply-To: <1460342873-28900-3-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Mon, 11 Apr 2016 10:47:51 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4751C64-00E1-11E6-BB02-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291288>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> Maintainers or third party testers may want to know the exact base tree
> the patch series applies to. Teach git format-patch a '--base' option
> to record the base tree info and append it at the end of the_first_

It probably was a good idea to add stress during the discussion to
compare various possibilities, but there no longer is a need to
italicise "first" like this, I think.

> message(either the cover letter or the first patch in the series).

Please have space before "(" (also found elsewhere in this message)
to make this readable.

>
> The base tree info consists of the "base commit", which is a well-known
> commit that is part of the stable part of the project history everybody
> else works off of, and zero or more "prerequisite patches", which are
> well-known patches in flight that is not yet part of the "base commit"
> that need to be applied on top of "base commit" in topological order
> before the patches can be applied.
>
> The "base commit" is shown as "base-commit: " followed by the 40-hex of
> the commit object name.  A "prerequisite patch" is shown as
> "prerequisite-patch-id: " followed by the 40-hex "patch id", which is a
> sum of SHA-1 of the file diffs associated with a patch, with whitespace
> and line numbers ignored, it's reasonably stable and unique.

Let's be more helpful to end users.  They do not need to know the
exact formula, especially when there is a command to generate or
check the id for themselves:

    "patch id", which can be obtained by passing the patch through the
    "git patch-id --stable" command

or something?  

> For example, we have history where base is Z, with three prerequisites
> X-Y-Z, before the patch series A-B-C, i.e.

base is Z???

	Imagine that on top of the public commit P, you applied
	well-known patches X, Y and Z from somebody else, and then
	built your three-patch series A, B, C.

perhaps?

>
> 	P---X---Y---Z---A---B---C
>
> We could say "git format-patch --base=P -3 C"(or variants thereof, e.g.
> with "--cover-letter" of using "Z..C" instead of "-3 C" to specify the
> range), then we could get base tree information block showing at the
> end of _first_ message as below:

Again, if "first" is _so_ important to stress, it probably is worth
saying that by "first" you mean either patch 1/n or patch 0/n when
the cover letter exists.

Also "could" may have made sense while we were having discussion on
possible design of the hypothetical feature, but with the patch
applied, the feature becomes a reality, so you can and should stop
living in the hypothetical world and do s/could/can/ the above.

	With "git format-patch --base=P -3 C" (or variants...), the
	base tree information block is shown at the end of the first
	message the command outputs (either the first patch, or the
	cover letter), like this:

perhaps?

I assume that the patch to the documentation has the same text I
commented on the above, so I won't repeat my comments to them.

> 	base-commit: P
> 	prerequisite-patch-id: X
> 	prerequisite-patch-id: Y
> 	prerequisite-patch-id: Z
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Wu Fengguang <fengguang.wu@intel.com>
> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
> ---
>  Documentation/git-format-patch.txt | 56 +++++++++++++++++++++++
>  builtin/log.c                      | 92 ++++++++++++++++++++++++++++++++++++++
>  t/t4014-format-patch.sh            | 15 +++++++
>  3 files changed, 163 insertions(+)
> ...
> +static void prepare_bases(struct base_tree_info *bases,
> +			  const char *base_commit,
> +			  struct commit **list,
> +			  int total)
> +{
> +	struct commit *base = NULL, *commit;
> +	struct rev_info revs;
> +	struct diff_options diffopt;
> +	unsigned char sha1[20];
> +	int i;
> +
> +	diff_setup(&diffopt);
> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
> +	diff_setup_done(&diffopt);
> +
> +	base = lookup_commit_reference_by_name(base_commit);
> +	if (!base)
> +		die(_("Unknown commit %s"), base_commit);
> +	oidcpy(&bases->base_commit, &base->object.oid);
> +
> +	init_revisions(&revs, NULL);
> +	revs.max_parents = 1;
> +	revs.topo_order = 1;
> +	for (i = 0; i < total; i++) {
> +		if (!in_merge_bases(base, list[i]) || base == list[i])
> +			die(_("base commit should be the ancestor of revision list"));

This check looks overly expensive, but I do not think of a more
efficient way to do this, given that "All the commits from our
series must reach the specified base" is what you seem to want.

My understanding is that if base=P is given and you are doing
"format-patch Z..C" in this picture:

    Q---P---Z---B---*---C
     \             /
      .-----------A

your list would become A, B and C, and you want to detect that P is
not an ancestor of A.  merge_bases_many() computes a wrong thing for
this use case, and you'd need to go one-by-one.

Unless there is some clever trick to take advantage of the previous
traversal you made in order to find out A, B and C are the commits
that are part of your series somehow.

Anybody with clever ideas?
