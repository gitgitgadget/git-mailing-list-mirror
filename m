Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2994D203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 16:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbcGVQzX (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 12:55:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752107AbcGVQzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 12:55:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA3FC2D45C;
	Fri, 22 Jul 2016 12:55:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hE72Qgngyf+7RAh5ZXFELd/HDs4=; b=cY/ozu
	W7RBCrHR5nMYYSooSRPDa6yvUUokyrOWs43CeFYzAmBs6sXBd6bcWkyzg2XQb7b/
	LvT6O44XO5hNd2ZWyQTDRkaDY0Hdmpw/p0sAiTLHe9E902ygg6lMlTTh1RKC85/c
	s86gomiXlaBf+fgbIqzf2B6Kd7Un847NLyfzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J0Jl3VpR9pvdipjGSt5U50DeP8+/RNmd
	nMgT05FBVeEOIlzHVpnGHhq+sjXashFUCWWiT7LTr/C7Rah1c3zijrify2hT6e/E
	ae/G/aM/X7aytzRnp05jD9wQCvX5pDe7wu+a8jkdmJGo8+u+HDku2sAmkN76E1pQ
	5by1L6Iv2zQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F7F32D45B;
	Fri, 22 Jul 2016 12:55:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 173AC2D45A;
	Fri, 22 Jul 2016 12:55:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
	<20160720172419.25473-1-pclouds@gmail.com>
	<20160720172419.25473-4-pclouds@gmail.com>
	<CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
Date:	Fri, 22 Jul 2016 09:55:17 -0700
In-Reply-To: <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 Jul 2016 16:22:29 -0700")
Message-ID: <xmqqmvl9boju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12DE810A-502D-11E6-B357-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From a users POV there are:
> * non existent submodules (no gitlink recorded, no config set,
>   no repo in place)
> * not initialized submodules (gitlink is recorded, no config set,
>   and an empty repo is put in the working tree as a place holder).

This is no different from what you later call "embedded".  The only
difference is that embedded thing hasn't seen its initial commit.

> * initialized submodules (gitlink is recorded, the config
>   submodule .<name>.url is copied from the .gitmodules file to .git/config.
>   an empty dir in the working tree as a place holder)
>   A user may change the configuration before the next step as the url in
>   the .gitmodules file may be wrong and the user doesn't want to
>   rewrite history

i.e. what "submodule init" gives you.

> * existing submodules (gitlink is recorded, the config option is set
>   and instead of an empty placeholder dir, we actually have a git
>   repo there.)

i.e. what "submodule update" after "submodule init" gives you.

> * matching submodules (the recorded git link matches
>   the actual checked out state of the repo!, config option and repo exist)

Is this any different from "existing" case for the purpose of
discussing the interaction between a submodule (and its checkout)
and having possibly multiple worktrees of its superproject?

I agree that when a top-level superproject has multiple worktrees
these multiple worktrees may want to have the same submodule in
different states, but I'd imagine that they want to share the same
physical repository (i.e. $GIT_DIR/modules/$name of the primary
worktree of the superproject)---is everybody involved in the
discussion share this assumption?

Assuming that everybody is on the same page, that means "do we have
the repository for that submodule, and if so where in our local
filesystem?" is a bit of information shared across the worktrees of
the superproject.  And the "name" used to identify the submodule is
also shared across these worktrees of the superproject, as it is
meant to be a unique (within the superproject) identifier for that
"other" project it uses, no matter where in the superproject's
working tree (note: this is "working tree", not "worktree") it would
be checked out, and where the upstream URL to get further updates to
the submodule is (i.e. that URL may change over time if they relocate,
or it may even change when the user who works on the superproject
decides to use a different mirror).

What can be different between the instantiation of the same
submodule in these multiple worktrees, and how they should be
recorded?

 * submodule.$name.URL?  I am not sure if we want to have different
   "upstreams" depending on the worktree of the superproject.  While
   there is no fundamental reason to forbid it, having to maintain a
   single local repository for a submodule would mean they would
   need to be treated as separate "remotes" in the submodule
   repository.

 * submodule.$name.path of course can be different depending on
   which commit of the superproject is checked out in the worktree,
   as the superproject may move the submodule binding site across
   its versions.

 * submodule.$name.update, submodule.$name.ignore,
   submodule.$name.branch, etc. would need to be all different among
   worktrees of the superproject, as that is the whole point of
   being able to work on separate branches of the superproject in
   separate worktrees.

Somewhere in this discussion thread, you present the conclusion of
your discussion with Jonathan Nieder that there needs a separate
"should the submodule directory be populated?" bit, which currently
is tied to submodule.$name.URL in $GIT_DIR/config.  I tend to agree
that knowing where you get other people's update of that submodule
repository should come from and wanting to have/keep a checkout of
that submodule in the working tree of a particular worktree are two
different things, so such a separate bit would be needed, and that
would belong to per-worktree configuration.


